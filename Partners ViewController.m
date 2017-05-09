//
//  Partners ViewController.m
//  session 7 task
//
//  Created by MOMO on 5/9/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "Partners ViewController.h"
#import "navigationBarViewController.h"

@interface Partners_ViewController ()

@end

@implementation Partners_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    navigationBarViewController *PartnersBar = [navigationBarViewController new];
    UIColor *navigationBarColor =[UIColor colorWithRed:41.0/255 green:77.0/255 blue:151.0/255 alpha:1];
    [PartnersBar customSetup:_sideBarButton :self];
    [PartnersBar customizeNavigation:_sideBarButton :self :navigationBarColor :@"Partners"];
    [PartnersBar makeImageBlur:_backgrondImageView ];
    
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
