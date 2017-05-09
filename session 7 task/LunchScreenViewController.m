//
//  LunchScreenViewController.m
//  session 7 task
//
//  Created by MOMO on 5/9/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "LunchScreenViewController.h"
#import "navigationBarViewController.h"

@interface LunchScreenViewController ()

@end

@implementation LunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    navigationBarViewController *lunchScreen = [navigationBarViewController new];
    
    [lunchScreen makeImageBlur:_blurImageLunchScreen];
    
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
