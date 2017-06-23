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
#import "HttpClient.h"
#import "EventModel.h"
#import "UIImage+Extension.h"

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
   
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_eventsTableView animated:YES];
    hud.label.text=@"Loading";
    
    
    NSString *apiUrl =@"http://tahrirlounge.net/event/api/events";
    HttpClient *httpClient=[HttpClient sharedInstance];
    [httpClient invokeAPI:apiUrl method:HTTPRequestGET parameters:nil paramterFormat:paramterStructureTypeFormData contentTypeValue:ContentTypeValue_None customContentTypeValueForHTTPHeaderField:nil onSuccess:^(NSData * _Nullable data) {
        
         [MBProgressHUD hideHUDForView:_eventsTableView animated:YES];
        NSError *error;
        NSArray *arrayOfData=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSMutableArray *dataArray=[NSMutableArray new];
        for(NSDictionary *dictionary in arrayOfData){
            
            EventModel *event=[[EventModel alloc] initWithDictionary:dictionary];
            [dataArray addObject: event];
            
        }
        
        
        NSLog(@"returneddata: %@",dataArray);
        
        webServiceArray=[dataArray copy];
        
        if([webServiceArray count] != 0 ){
            [_eventsTableView reloadData];
        }else{
            NSLog(@"Error webServiceArray Empty");
        }
        
        
    } andFailure:^(NSString * _Nonnull error) {
         [MBProgressHUD hideHUDForView:_eventsTableView animated:YES];
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//--------------------------

//---------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"EventsTableViewCell";
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[EventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    EventModel *event=[webServiceArray objectAtIndex:indexPath.row];
   
    
    [UIImage downloadImageURL:event.eventImage onSuccess:^(UIImage * _Nullable image) {
        cell.eventImage.image=image;
    } andFailure:^(NSString * _Nonnull error) {
        
    }];
    
    [cell.imageLoader startAnimating];
    cell.imageLoader.hidden=NO;
    [cell.instractorImage setImage:[UIImage imageNamed:@"placeholder"]];
    [UIImage downloadImageURL:event.eventImage onSuccess:^(UIImage * _Nullable image) {
        
        [cell.imageLoader stopAnimating];
        cell.imageLoader.hidden=YES;
        [cell.instractorImage setImage:image];
    } andFailure:^(NSString * _Nonnull error) {
        [cell.imageLoader stopAnimating];
        cell.imageLoader.hidden=YES;
        [cell.instractorImage setImage:[UIImage imageNamed:@"placeholder"]];
    }];
    
    cell.eventName.text=event.eventName;
    
    cell.eventInstractor.text=event.eventInstractor;
    
    cell.details.text=event.eventDetails;
    cell.startDate.text=event.eventDate;
    
    
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




-(UIImage*) storingImages {
    
    NSData *data =UIImageJPEGRepresentation([webServiceArray objectAtIndex:0], 1);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirctory =[paths objectAtIndex:0];
    NSString *imagePath =[documentDirctory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@"cached"]];
    
    
    [data writeToFile:imagePath atomically: NO];
    
    return [UIImage imageWithContentsOfFile:imagePath];
    
}



@end
