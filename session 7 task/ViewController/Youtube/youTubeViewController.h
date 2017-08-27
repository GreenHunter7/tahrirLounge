//
//  youTubeViewController.h
//  session 7 task
//
//  Created by MOMO on 6/24/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface youTubeViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic) IBOutlet UIWebView *YouTubeWebView;

@end
