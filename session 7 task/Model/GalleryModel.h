//
//  GalleryModel.h
//  session 7 task
//
//  Created by MOMO on 6/24/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GalleryModel : NSObject

@property (strong,nonatomic) NSArray *imagesUrlArray;

-(NSArray *)arrayOfImage:(NSDictionary *)Dictinary;



@end
