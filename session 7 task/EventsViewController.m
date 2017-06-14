//
//  EventsViewController.m
//  session 7 task
//
//  Created by GreenRoot on 5/3/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "EventsViewController.h"
#import "SWRevealViewController.h"
#import "navigationBarViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface EventsViewController ()

@end

@implementation EventsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _eventsTableView.delegate = self;
    _eventsTableView.dataSource = self;
    
    
    //-----
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    UIColor *navigationBarColorBlue = [UIColor colorWithRed:1.0/255 green:125.0/255 blue:214.0/255 alpha:1.0];
    
    [navigationBar customSetup:_sideBarButton :self];
    [navigationBar customizeNavigation:_sideBarButton :self :navigationBarColorBlue :@"Events"];
   //-----------
    webServiceData = [DataForCells new];
    
    delegateApp=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_eventsTableView animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeout) userInfo:nil repeats:YES];
    hud.label.text=@"Loading";
    
    NSLog(@"dataArrray : %lu",[[delegateApp.webServiceData DataArray] count]);

    UDSavedData=[NSUserDefaults new];
    
    
        //add NSUserDefaults for faster response
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    double delaySec = 0.5;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySec *NSEC_PER_SEC));
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        webServiceArray = [NSArray arrayWithArray:[delegateApp.webServiceData DataArray]];
        webServiceArray = [[[webServiceArray reverseObjectEnumerator] allObjects] mutableCopy];
        [MBProgressHUD hideHUDForView:_eventsTableView animated:YES];
        
        NSLog(@"webservice count: %lu",[webServiceArray count]);
        
        
        if([webServiceArray count] != 0 ){
            [_eventsTableView reloadData];
        }else{
            NSLog(@"Error webServiceArray Empty");
        }
    });

}


//--------------------------

//---------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"EventsTableViewCell" forIndexPath:indexPath];
    
    
    [cell.eventImage setImage:[[webServiceData getCellItems:indexPath:webServiceArray] objectAtIndex:0]];
    [cell.eventName setText:[[webServiceData getCellItems:indexPath:webServiceArray] objectAtIndex:1]];
    [cell.eventInstractor setText:[[webServiceData getCellItems:indexPath:webServiceArray] objectAtIndex:2]];
    [cell.details setText:[[webServiceData getCellItems:indexPath:webServiceArray] objectAtIndex:3]];
    [cell.startDate setText:[[webServiceData getCellItems:indexPath:webServiceArray] objectAtIndex:4]];
    
    //[cell.instractorImage setImage:[[self getCellItems:indexPath] objectAtIndex:5]];
    
    cell.eventName.layer.shadowOpacity = 0.6f;
    cell.eventInstractor.layer.shadowOpacity = 0.6f;
    cell.startDate.layer.shadowOpacity = 0.6f;
    cell.details.layer.shadowOpacity = 0.6f;
    cell.background.layer.cornerRadius = 20;
    cell.seeMore.layer.cornerRadius = 10;
    
    
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
  return [webServiceArray count];
}

-(void)timeout{
    [MBProgressHUD hideHUDForView:_eventsTableView animated:YES];
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
