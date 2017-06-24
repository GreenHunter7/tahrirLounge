//
//  GallerySecondeViewController.h
//  session 7 task
//
//  Created by MOMO on 5/14/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondCollectionViewCell.h"

@interface GallerySecondeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>{

    SecondCollectionViewCell *cell;
    
    
}



@property (strong, nonatomic) NSArray *arrayOfimagesUrls;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (weak, nonatomic) IBOutlet UICollectionView *galleryCollectionView;
@property (strong, nonatomic) IBOutlet UIView *popupContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *popupImageView;

@property (strong, nonatomic) IBOutlet UIButton *CloseButton;

- (IBAction)CloseImage:(id)sender;

@end
