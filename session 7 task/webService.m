//
//  webService.m
//  TahrirLounge
//
//  Created by Mohamed Ibrahim on 5/6/17.
//  Copyright © 2017 Mohamed Ibrahim. All rights reserved.
//

#import "webService.h"

@implementation webService



-(NSMutableArray*) returnDataFromAPI: (NSString*) apiURL
{
    // 1
    
    NSURL *url = [NSURL URLWithString:apiURL];
    
     NSMutableArray *returnData=[NSMutableArray new];
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
                                                          [returnData addObject:recipeArray];
                                                      }
                                                      NSLog(@"Array: %@", returnData);
                                                  }
                                              }
                                              else
                                              {
                                                  NSLog(@"Error: %@", error.localizedDescription);
                                              }
                                              
                                              
                                          }];
    
    // 3
    [downloadTask resume];
    
    return returnData;
}



@end
