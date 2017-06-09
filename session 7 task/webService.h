//
//  webService.h
//  TahrirLounge
//
//  Created by Mohamed Ibrahim on 5/6/17.
//  Copyright © 2017 Mohamed Ibrahim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface webService : NSObject  <NSURLConnectionDelegate>
{
    NSMutableData * _responseData;
}

-(NSMutableArray*) returnDataFromAPI : (NSString*) apiURL;

@end
