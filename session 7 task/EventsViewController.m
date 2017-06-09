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
#import "webService.h"

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
    [self returnDataFromAPI];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------
-(NSMutableArray*) returnDataFromAPI
{
    // 1
    
    NSURL *url = [NSURL URLWithString:@"http://tahrirlounge.net/event/api/events"];
    
    webServiceArray =[NSMutableArray new];
    // 2
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              
                                              if (!error)
                                              {
                                                  NSError *JSONError = nil;
                                                  
                                                  NSArray *dictionary =[NSJSONSerialization JSONObjectWithData:data
                                                                                                       options:0
                                                                                                         error:&JSONError];
                                                  if (JSONError)
                                                  {
                                                      NSLog(@"Serialization error: %@",JSONError.localizedDescription);
                                                  }
                                                  else
                                                  {
                                                      NSLog(@"Response: %@", dictionary);
                                                      
                                                      //                                                      NSArray * values = [dictionary allValues];
                                                      
                                                      for (NSArray *recipeArray in dictionary)
                                                      {
                                                          [webServiceArray addObject:recipeArray];
                                                      }
                                                      NSLog(@"Array: %@", webServiceArray);
                                                  }
                                              }
                                              else
                                              {
                                                  NSLog(@"Error: %@", error.localizedDescription);
                                              }
                                              
                                              
                                          }];
    
    // 3
    [downloadTask resume];
    return webServiceArray;
}
//---------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"EventsTableViewCell"];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"websrviceArray: %@",webServiceArray);
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
