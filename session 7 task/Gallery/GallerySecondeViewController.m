//
//  GallerySecondeViewController.m
//  session 7 task
//
//  Created by MOMO on 5/14/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "GallerySecondeViewController.h"
#import "navigationBarViewController.h"


@interface GallerySecondeViewController ()

@end

@implementation GallerySecondeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    [navigationBar childNavigationBarCustom:_sideBarButton :self.navigationItem :self.navigationController.navigationBar :@"Gallery"];

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
