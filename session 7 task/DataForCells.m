//
//  DataForCells.m
//  session 7 task
//
//  Created by MOMO on 6/9/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "DataForCells.h"
#import "EventsViewController.h"

@interface DataForCells ()

@end

@implementation DataForCells

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray*)getDataFromApi{
    
    NSURL *apiUrl =[NSURL URLWithString:@"http://tahrirlounge.net/event/api/events"];
    
    _DataArray = [NSMutableArray new];
    
    //dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
     NSURLSessionDataTask *getData=[session dataTaskWithURL:apiUrl completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
             
            if(!error){
            
            NSArray *arrayOfData=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                
                NSLog(@"Error: %@",error.localizedDescription);
                
            }else{
                
                
                    for(NSDictionary *dictionary in arrayOfData){
                    
                        [_DataArray addObject: dictionary];
                    
                    }
                
                
                    
                NSLog(@"returneddata: %@",_DataArray);
                
                
            }
            
        }else{
            
            NSLog(@"Error: %@",error.localizedDescription);
            
        }             
         
             
            //dispatch_semaphore_signal(semaphore);
    }];
    
    
    
    [getData resume];
    
    //dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    
    return _DataArray;
}

//--------------

-(NSMutableArray*)getCellItems: (NSIndexPath *)index :(NSArray *)array{
    
    
    NSMutableArray *arrayOfCellObjects=[NSMutableArray new];
    
    //array=[eventImage,]
    NSDictionary *dictionary =[[NSDictionary alloc]initWithDictionary:[array objectAtIndex:index.item]];
    
    
    NSURL *eventImageUrl =[NSURL URLWithString:[dictionary objectForKey:@"eventImage"]];
    NSData *imageData =[NSData dataWithContentsOfURL:eventImageUrl];
    UIImage *eventImageImage=[UIImage imageWithData:imageData];
    [arrayOfCellObjects setObject:eventImageImage atIndexedSubscript:0];
    
    NSString *eventName = [dictionary objectForKey:@"eventName"];
    [arrayOfCellObjects setObject:eventName atIndexedSubscript:1];
    
    NSString *eventInstractor = [dictionary objectForKey:@"eventInstractor"];
    [arrayOfCellObjects setObject:eventInstractor atIndexedSubscript:2];
    
    NSString *eventDetials = [dictionary objectForKey:@"eventDetails"];
    [arrayOfCellObjects setObject:eventDetials atIndexedSubscript:3];
    
    NSString *eventDate = [dictionary objectForKey:@"eventDate"];
    [arrayOfCellObjects setObject:eventDate atIndexedSubscript:4];
    
    
    //    NSURL *instractorImageUrl =[NSURL URLWithString:[dictionary objectForKey:@"instractorImage"]];
    //    NSData *instractorImageData =[NSData dataWithContentsOfURL:instractorImageUrl];
    //    UIImage *instractorImage=[UIImage imageWithData:instractorImageData];
    //    [arrayOfCellObjects setObject:instractorImage atIndexedSubscript:5];
    
    return arrayOfCellObjects;
    
}

//-(void)getCellItems: (NSIndexPath *)index{
//    
//    NSDictionary *dictionary =[[NSDictionary alloc]initWithDictionary:[webServiceArray objectAtIndex:index.item]];
//    
//    
//    NSURL *eventImageUrl =[NSURL URLWithString:[dictionary objectForKey:@"eventImage"]];
//    NSData *imageData =[NSData dataWithContentsOfURL:eventImageUrl];
//    UIImage *eventImageImage=[UIImage imageWithData:imageData];
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
