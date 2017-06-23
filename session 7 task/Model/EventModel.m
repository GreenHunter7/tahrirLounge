//
//  EventModel.m
//  session 7 task
//
//  Created by Amr Elghadban on 6/23/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel


-(instancetype)initWithDictionary:(NSDictionary *)Dictionary{
    
    self=[super init];
    if (self) {
        NSDictionary *JSONDictionary=Dictionary;
        
        if (JSONDictionary) {
            for (NSString *key in JSONDictionary) {
                if ([key isEqualToString:@"id"]) {
                    NSString *value=[JSONDictionary objectForKey:@"id"];
                    [self setValue:value forKey:@"event_id"];
                }else{
                    [self setValue:[JSONDictionary valueForKey:key] forKey:key];}
            }
            
        }
    }
    
    return self;
}


@end
