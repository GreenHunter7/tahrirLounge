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
    
    webServiceArray = [[NSArray alloc]initWithArray:[self getDataFromApi]];
    
    NSLog(@"webservice count: %lu",[webServiceArray count]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------
-(NSMutableArray*)getDataFromApi{

    NSURL *apiUrl =[NSURL URLWithString:@"http://tahrirlounge.net/event/api/events"];
    
    NSMutableArray *returnedData = [NSMutableArray new];
    
    dispatch_semaphore_t semaphore=dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *getData=[[NSURLSession sharedSession] dataTaskWithURL:apiUrl completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        if(!error){
        
            NSArray *arrayOfData=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                NSLog(@"Error: %@",error.localizedDescription);
            }else{
                for(NSDictionary *dictionary in arrayOfData){
                    [returnedData addObject: dictionary];
                }
                
                
                
                NSLog(@"returneddata: %@",returnedData);
            }
        }else{
            NSLog(@"Error: %@",error.localizedDescription);
        }
    
        dispatch_semaphore_signal(semaphore);
        
    }];
    
    [getData resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return returnedData;
}

-(NSMutableArray*)getCellItems: (NSIndexPath *)index{

    
    arrayOfCellObjects=[NSMutableArray new];
    
    //array=[eventImage,]
    NSDictionary *dictionary =[[NSDictionary alloc]initWithDictionary:[webServiceArray objectAtIndex:index.item]];
    
    
    NSURL *eventImageUrl =[NSURL URLWithString:[dictionary objectForKey:@"eventImage"]];
    NSData *imageData =[NSData dataWithContentsOfURL:eventImageUrl];
    UIImage *eventImageImage=[UIImage imageWithData:imageData];
    
    [arrayOfCellObjects setObject:eventImageImage atIndexedSubscript:0];
    
    return arrayOfCellObjects;
    
}

//---------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"EventsTableViewCell" forIndexPath:indexPath];
    
    [cell.eventImage setImage:[[self getCellItems:indexPath] objectAtIndex:0]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
  return [webServiceArray count];
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
