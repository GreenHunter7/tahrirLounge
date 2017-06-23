//
//  UIImage+Extension.h
//  WhereApp
//
//  Created by Amr Elghadban on 5/10/17.
//  Copyright © 2017 KarmaDam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreadHelper.h"

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;

+(void) downloadImageURL:(NSString *_Nonnull) imageUrl onSuccess:(void (^_Nullable)(UIImage * _Nullable image))success andFailure:(void (^_Nonnull)(NSString * _Nonnull error))failure;
@end
