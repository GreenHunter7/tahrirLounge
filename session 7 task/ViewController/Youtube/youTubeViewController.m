//
//  youTubeViewController.m
//  session 7 task
//
//  Created by MOMO on 6/24/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "youTubeViewController.h"
#import "MBProgressHUD.h"
#import "navigationBarViewController.h"
#import "SWRevealViewController.h"

@interface youTubeViewController ()

@end

@implementation youTubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _YouTubeWebView.delegate = self;
    // Do any additional setup after loading the view.
    
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    [navigationBar customSetup:_sideBarButton :self];
    
    UIColor *navigationBarColorGreen = [UIColor colorWithRed:76.0/255 green:219.0/255 blue:125.0/255 alpha:1.0];
    
    [navigationBar customizeNavigation:_sideBarButton :self :navigationBarColorGreen : @"YouTube"];
    
    //-----
    
    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/user/Tahrirlounge/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_YouTubeWebView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_YouTubeWebView animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeout) userInfo:nil repeats:YES];
    hud.label.text=@"Loading";
}
//-------
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:_YouTubeWebView animated:YES];
}
//---failLoad--------
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)erro{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_YouTubeWebView animated:NO];
    
    hud.label.text=@"Error";
    
}
//------timeout------
-(void)timeout{
    [MBProgressHUD hideHUDForView:_YouTubeWebView animated:YES];
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
