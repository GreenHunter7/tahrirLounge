//
//  GalleryModel.m
//  session 7 task
//
//  Created by MOMO on 6/24/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "GalleryModel.h"
#import "GalleryViewController.h"
#import "GallerySecondeViewController.h"

@implementation GalleryModel

@synthesize imagesUrlArray;

-(NSArray *)arrayOfImage:(NSDictionary *)Dictinary{
    
    imagesUrlArray = [NSArray new];
    
    imagesUrlArray = [[Dictinary valueForKey:@"gallery"]copy];
    
    return imagesUrlArray;
}


@end
