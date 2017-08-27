//
//  ContactUsViewController.m
//  session 7 task
//
//  Created by GreenRoot on 5/3/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "ContactUsViewController.h"
#import "SWRevealViewController.h"
#import "navigationBarViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//----------


-(void)navigationBarMethod{

    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    UIColor *navigationBarColorBlue = [UIColor colorWithRed:1.0/255 green:125.0/255 blue:214.0/255 alpha:1.0];
    
    [navigationBar customSetup:_sideBarButton :self];
    [navigationBar customizeNavigation:_sideBarButton :self :navigationBarColorBlue :@"Contact Us"];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    _mapbutton.userInteractionEnabled=NO;
    _clockbutton.userInteractionEnabled=NO;
    _contacttext.userInteractionEnabled=NO;     // Do any additional setup after loading the view, typically from a nib.
    
    [self navigationBarMethod];
    [self loadmap];
    _map.delegate = self;
    [self getCurrentLocation];
    
    locationManager =[CLLocationManager new];
}


-(void)loadmap{
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(30.0458556519, 31.236029311562);
    
    [annotation setCoordinate:coord];
    
    [annotation setTitle:@"Tahrir Lounge"]; //You can set the subtitle too
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001, 0.001);
    MKCoordinateRegion region = {coord, span};
    [self.map setRegion:region];
    
    [self.map addAnnotation:annotation];

}

-(void)getCurrentLocation{

    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    
    currentLocation = [locations lastObject]; //to assign the current location

}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    CLLocationCoordinate2D destinationLocation = CLLocationCoordinate2DMake(30.0458556519, 31.236029311562);
    
    
    
    NSURL *url =[[NSURL alloc]initWithString:[NSString stringWithFormat: @"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",
     currentLocation.coordinate.latitude, currentLocation.coordinate.longitude,
     destinationLocation.latitude, destinationLocation.longitude]];

    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    

}


- (IBAction)call:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+201274333113"] options:@{} completionHandler:nil];
    
    
    //[NSURL URLWithString:@"tel:+20100100100"]];
    
    
}

- (IBAction)sendMail:(id)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Subject"];
        [mail setMessageBody:@"Email From Tahrir Lounge ios App" isHTML:NO];
        [mail setToRecipients:@[@"tahrirlounge@gmail.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}


- (IBAction)openUrl:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://tahrirlounge.net"] options:@{} completionHandler:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
