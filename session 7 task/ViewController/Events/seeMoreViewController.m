//
//  seeMoreViewController.m
//  session 7 task
//
//  Created by MOMO on 6/30/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "seeMoreViewController.h"
#import "EventsViewController.h"
#import "UIImage+Extension.h"
#import "navigationBarViewController.h"

@interface seeMoreViewController ()

@end

@implementation seeMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self BuildSeeMorePage];
    
    //------
    
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    [navigationBar childNavigationBarCustom:_sideBarButton :self.navigationItem :self.navigationController.navigationBar :@"Events"];
    [navigationBar makeImageBlur:_blurBackground];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)BuildSeeMorePage{

    _eventName.text = _event.eventName;
    
    [UIImage downloadImageURL:_event.eventImage onSuccess:^(UIImage * _Nullable image) {
        
        _headerImageView.image = image;
        
        _InstractorImageView.image = image;
        _InstractorImageView.layer.shadowOpacity = 0.6f;
        _InstractorImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    } andFailure:^(NSString * _Nonnull error) {
        
    }];
    
    _details.text = _event.eventDetails;
    _eventDate.text = _event.eventDate;
    _instractorName.text = _event.eventInstractor;
    
    
    _background.layer.shadowOpacity = 0.6f;
    _background.layer.cornerRadius = 20;

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
