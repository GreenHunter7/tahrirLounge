//
//  GallerySecondeViewController.m
//  session 7 task
//
//  Created by MOMO on 5/14/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "GallerySecondeViewController.h"
#import "navigationBarViewController.h"
#import "GalleryViewController.h"
#import "UIImage+Extension.h"
#import "GalleryModel.h"

@interface GallerySecondeViewController ()

@end

@implementation GallerySecondeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _galleryCollectionView.delegate = self;
    _galleryCollectionView.dataSource = self;
    
    [_popupContainerView setHidden:YES];
    
    //-------
    
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    [navigationBar childNavigationBarCustom:_sideBarButton :self.navigationItem :self.navigationController.navigationBar :@"Gallery"];
   
    
    
    NSLog(@"arrayForSocend : %lu",[_arrayOfimagesUrls count]);
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [_arrayOfimagesUrls count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = [NSArray arrayWithArray:_arrayOfimagesUrls];
    
    cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellR" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[SecondCollectionViewCell alloc]init];
    }
    
    
    
    
    NSString *urlString = [array objectAtIndex:indexPath.item];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];

    UIImageView *imageForCell =[[UIImageView alloc]initWithImage:image];
    
    imageForCell.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell.viewContainer addSubview:imageForCell];
    
    imageForCell.frame = CGRectMake(0, 0,cell.frame.size.width,cell.frame.size.height);
            

    [cell.viewContainer.layer setShadowOffset:CGSizeMake(0.0f,0.0f)];
    cell.viewContainer.layer.shadowOpacity=0.8;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showAnimated];
    //[_popupContainerView setHidden:NO];
    
    
    NSString *urlString = [_arrayOfimagesUrls objectAtIndex:indexPath.item];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    
    
    
    _popupImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
    _popupImageView.contentMode = UIViewContentModeScaleAspectFit;
    _popupImageView.frame = CGRectMake(0, 0, _popupContainerView.frame.size.width, _popupContainerView.frame.size.height);
    
    
    //shadow for view
    UIImageView *containerBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Gallery-1"]];
    
    [_popupContainerView.layer setShadowOffset:CGSizeMake(0.0f,0.0f)];
    _popupContainerView.layer.shadowOpacity=0.8;
    
    [_popupContainerView addSubview:_popupImageView];
    [_popupContainerView addSubview:_CloseButton];
    
    _popupContainerView.layer.cornerRadius = 8.0f;
    containerBackground.layer.cornerRadius = 8.0f;
    _CloseButton.layer.cornerRadius=10;
    
    containerBackground.frame = CGRectMake(0, 0, _popupContainerView.frame.size.width, _popupContainerView.frame.size.height) ;
    [_popupContainerView insertSubview:containerBackground belowSubview:_popupImageView];
}

-(void)showAnimated {
    [_popupContainerView setHidden:NO];
    self.popupContainerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.popupContainerView.alpha = 0 ;
    
    [UIView animateWithDuration:.25 animations:^{
        self.popupContainerView.alpha = 1;
        self.popupContainerView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

-(void)removeAnimated{
    
    [UIView animateWithDuration:.25 animations:^{
        self.popupContainerView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.popupContainerView.alpha = 0;
    }completion:^(BOOL finished){
        if(finished){
            //[_popupContainerView setHidden:YES];
        }
    }];
    
    
}

- (IBAction)CloseImage:(id)sender {
    
    [self removeAnimated];
    
    [_popupImageView removeFromSuperview];
    
}



@end
