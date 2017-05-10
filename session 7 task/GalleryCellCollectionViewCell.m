//
//  GalleryCellCollectionViewCell.m
//  session 7 task
//
//  Created by Amr Elghadban on 5/7/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "GalleryCellCollectionViewCell.h"

@implementation GalleryCellCollectionViewCell

-(UIColor *)colorForCell :(NSInteger)index {
    
    UIColor *color1 = [UIColor colorWithRed:169/255.0 green:230/255.0 blue:207/255.0 alpha:1.0];
    
    UIColor *color2 = [UIColor colorWithRed:219/255.0 green:235/255.0 blue:193/255.0 alpha:1.0];
    
    UIColor *color3 = [UIColor colorWithRed:255/255.0 green:211/255.0 blue:182/255.0 alpha:1.0];
    
    UIColor *color4 = [UIColor colorWithRed:255/255.0 green:172/255.0 blue:165/255.0 alpha:1.0];
    
    UIColor *color5 = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:212/255.0 alpha:1.0];
    
    UIColor *color6 = [UIColor colorWithRed:176/255.0 green:235/255.0 blue:249/255.0 alpha:1.0];
    
    UIColor *color7 = [UIColor colorWithRed:174/255.0 green:164/255.0 blue:234/255.0 alpha:1.0];
    
    UIColor *color8 = [UIColor colorWithRed:141/255.0 green:89/255.0 blue:161/255.0 alpha:1.0];
    
    UIColor *color9 = [UIColor colorWithRed:247/255.0 green:243/255.0 blue:127/255.0 alpha:1.0];
    
   
    
    NSArray *colorArray = [NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6,color7,color8,color9, nil];
    
    return [colorArray objectAtIndex:index];
}

@end
