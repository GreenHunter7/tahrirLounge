//
//  ViewController.h
//  session 7 task
//
//  Created by MOMO on 5/2/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "teamMembers.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* teammembersList;
    
}

@property (nonatomic)  teamMembers *selectedteamMemberOBJ;
@property (weak, nonatomic) IBOutlet UITableView *listTeamView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (weak, nonatomic) IBOutlet UIImageView *blurBackground;


@end

