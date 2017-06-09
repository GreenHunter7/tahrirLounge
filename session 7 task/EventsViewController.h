//
//  EventsViewController.h
//  session 7 task
//
//  Created by GreenRoot on 5/3/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsTableViewCell.h"
@interface EventsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *webServiceArray;
    EventsTableViewCell *cell;
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;

@end
