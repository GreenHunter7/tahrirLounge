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
#import "DataForCells.h"

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
    
    
//        webServiceArray = [[NSArray alloc]initWithArray:[webServiceData getDataFromApi]];
//        webServiceArray = [[[webServiceArray reverseObjectEnumerator] allObjects] mutableCopy];
    
    
    webServiceData.webServiceArray = [[NSArray alloc]initWithArray:[webServiceData getDataFromApi]];
    webServiceData.webServiceArray = [[[webServiceData.webServiceArray reverseObjectEnumerator] allObjects] mutableCopy];
    
    NSLog(@"webservice count: %lu",[webServiceData.webServiceArray count]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--------------------------

//-(NSMutableArray*)getCellItems: (NSIndexPath *)index{
//
//    
//    arrayOfCellObjects=[NSMutableArray new];
//    
//    //array=[eventImage,]
//    NSDictionary *dictionary =[[NSDictionary alloc]initWithDictionary:[webServiceArray objectAtIndex:index.item]];
//    
//    
//    NSURL *eventImageUrl =[NSURL URLWithString:[dictionary objectForKey:@"eventImage"]];
//    NSData *imageData =[NSData dataWithContentsOfURL:eventImageUrl];
//    UIImage *eventImageImage=[UIImage imageWithData:imageData];
//    [arrayOfCellObjects setObject:eventImageImage atIndexedSubscript:0];
//    
//    NSString *eventName = [dictionary objectForKey:@"eventName"];
//    [arrayOfCellObjects setObject:eventName atIndexedSubscript:1];
//    
//    NSString *eventInstractor = [dictionary objectForKey:@"eventInstractor"];
//    [arrayOfCellObjects setObject:eventInstractor atIndexedSubscript:2];
//    
//    NSString *eventDetials = [dictionary objectForKey:@"eventDetails"];
//    [arrayOfCellObjects setObject:eventDetials atIndexedSubscript:3];
//    
//    NSString *eventDate = [dictionary objectForKey:@"eventDate"];
//    [arrayOfCellObjects setObject:eventDate atIndexedSubscript:4];
//    
//    
////    NSURL *instractorImageUrl =[NSURL URLWithString:[dictionary objectForKey:@"instractorImage"]];
////    NSData *instractorImageData =[NSData dataWithContentsOfURL:instractorImageUrl];
////    UIImage *instractorImage=[UIImage imageWithData:instractorImageData];
////    [arrayOfCellObjects setObject:instractorImage atIndexedSubscript:5];
//    
//    return arrayOfCellObjects;
//    
//
//}

//---------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"EventsTableViewCell" forIndexPath:indexPath];
    
    [cell.eventImage setImage:[[webServiceData getCellItems:indexPath] objectAtIndex:0]];
    [cell.eventName setText:[[webServiceData getCellItems:indexPath] objectAtIndex:1]];
    [cell.eventInstractor setText:[[webServiceData getCellItems:indexPath] objectAtIndex:2]];
    [cell.details setText:[[webServiceData getCellItems:indexPath] objectAtIndex:3]];
    [cell.startDate setText:[[webServiceData getCellItems:indexPath] objectAtIndex:4]];
    
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
    
    
    
  return [webServiceData.webServiceArray count];
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
