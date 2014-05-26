//
//  ViewController.m
//  TrafficPredictor
//
//  Created by tqthanh on 5/25/14.
//  Copyright (c) 2014 JVN. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>

@end

@implementation ViewController
{
    CLLocationManager *mgr;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString * UDID;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mgr = [[CLLocationManager alloc] init ];
    geocoder = [[CLGeocoder alloc] init];
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
    UDID = [[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)];
    self.labelUDID.text = [NSString stringWithFormat:@"UDID: %@",UDID];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(CallInInterval) userInfo:nil repeats:YES];
    
}
// Call method update location with interval time 3.0 sec
-(void) CallInInterval
{
    mgr.delegate=self;
    //mgr.desiredAccuracy = kCLLocationAccuracyBest;
    [mgr startUpdatingLocation];
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
    CLLocation *curr=newLocation;
    NSString *MyString;
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
	MyString = [dateFormatter stringFromDate:now];
    NSLog(@"\nLat : %f \nLong: %f \nTime: %@.",curr.coordinate.latitude,curr.coordinate.longitude,MyString);
    if(curr!= nil)
    {
        self.labelLatitude.text= [NSString stringWithFormat:@"Latitude: %.8f",curr.coordinate.latitude];
        self.labelLongitude.text= [NSString stringWithFormat:@"Longtitude: %.8f",curr.coordinate.longitude];
        self.labelTime.text =[NSString stringWithFormat:@"Time: %@",MyString];
        
        
        
    }
    /*[geocoder reverseGeocodeLocation:curr completionHandler:^(NSArray *placemarks,NSError *error)
     {
         if (error==nil && [placemarks count]>0)
         {
             placemark = [placemarks lastObject];
             self.addr.text= [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n %@",placemark.subThoroughfare,placemark.thoroughfare
              ,placemark.postalCode,placemark.locality,
              placemark.administrativeArea,placemark.country];
             
             //self.addr.text = [NSString stringWithFormat:@"%@ \n",placemark.country];
             
             
             //NSLog(@"%@\n",placemark.subThoroughfare);
             //NSLog(@"%@\n",placemark.country);
         }else
         {
             NSLog(@"%@",error.debugDescription);
         }
     }];*/
    [mgr stopUpdatingLocation];
    NSLog(@"Stop Update!");
    
}
//===============================================================================================

@end
