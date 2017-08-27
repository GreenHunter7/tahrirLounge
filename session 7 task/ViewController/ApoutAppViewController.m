//
//  ApoutAppViewController.m
//  session 7 task
//
//  Created by MOMO on 8/27/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "ApoutAppViewController.h"
#import "navigationBarViewController.h"

@interface ApoutAppViewController ()

@end

@implementation ApoutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	navigationBarViewController *navBar = [navigationBarViewController new];
	[navBar customSetup:_menuButton :self ];
	[navBar customizeNavigation:_menuButton :self :[UIColor colorWithRed:41.0/255 green:77.0/255 blue:151.0/255 alpha:1] :@"Apout App"];
	
	_textView.layer.shadowOpacity = 0.6f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
