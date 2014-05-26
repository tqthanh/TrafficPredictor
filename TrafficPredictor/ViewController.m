//
//  ViewController.m
//  TrafficPredictor
//
//  Created by tqthanh on 5/25/14.
//  Copyright (c) 2014 JVN. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WriteFile.h"
@interface ViewController ()<CLLocationManagerDelegate>

@end

@implementation ViewController
{
    CLLocationManager *mgr;
    NSString * UUID;
    NSString *myTime;
    NSTimer * Timer;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mgr = [[CLLocationManager alloc] init ];
    mgr.delegate=self;
    mgr.desiredAccuracy = kCLLocationAccuracyBest;

    NSLog(@"Init success");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//========================================Button Start Event=====================================
-(IBAction)btnStart:(id)sender
{
    UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
    NSLog(@"UDID:: %@", UUID);
    self.labelUDID.text = [NSString stringWithFormat:@"UUID: %@",UUID];
    Timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(CallInInterval) userInfo:nil repeats:YES];
    _btnStart.enabled= NO;
    
}
// Call method update location with interval time 5.0 sec
-(void) CallInInterval
{
    [mgr startUpdatingLocation];
}
- (IBAction)btnStop:(id)sender {
    [Timer invalidate];
    _btnStart.enabled=YES;
}





//===============================================================================================
//=================================OVERIDE UPDATE LOCATION=======================================

#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error);
    NSLog(@"Fail to get location");
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd' 'HH:mm:ss"];
	myTime = [dateFormatter stringFromDate:now];
    self.labelLatitude.text= [NSString stringWithFormat:@"Latitude: %.8f",newLocation.coordinate.latitude];
    self.labelLongitude.text= [NSString stringWithFormat:@"Longtitude: %.8f",newLocation.coordinate.longitude];
    self.labelTime.text =[NSString stringWithFormat:@"Time: %@",myTime];
    NSLog(@"\nLat : %f \nLong: %f \nTime: %@.",newLocation.coordinate.latitude,newLocation.coordinate.longitude,myTime);
    [WriteFile writeGPS:self.labelLatitude.text withLongitude:self.labelLongitude.text atTime:myTime address:UUID];

    [mgr stopUpdatingLocation];
    NSLog(@"Stop Update!");
    
}
//===============================================================================================

@end
