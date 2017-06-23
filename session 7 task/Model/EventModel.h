//
//  EventModel.h
//  session 7 task
//
//  Created by Amr Elghadban on 6/23/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject


/*{
 eventDate = "30/06/2017";
 eventDetails = "test details";
 eventImage = "http://tahrirlounge.net/event/public/images/1496879988.43.jpg";
 eventInstractor = Name;
 eventName = "Event 1";
 id = 1;
 instractorImage = "http://tahrirlounge.net/event/public/images/1496880005.96.jpg";
 }*/

@property (nonatomic, strong) NSString * eventDate ;
@property (nonatomic, strong) NSString * eventDetails ;
@property (nonatomic, strong) NSString * eventImage ;
@property (nonatomic, strong) NSString * eventInstractor ;
@property (nonatomic, strong) NSString * eventName;
@property (nonatomic, strong) NSString * event_id;
@property (nonatomic, strong) NSString * instractorImage;

-(instancetype)initWithDictionary:(NSDictionary *)Dictionary;

@end
