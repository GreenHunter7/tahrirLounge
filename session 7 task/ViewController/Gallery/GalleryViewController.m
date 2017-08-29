//
//  GalleryViewController.m
//  session 7 task
//
//  Created by GreenRoot on 5/5/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "GalleryViewController.h"
#import "SWRevealViewController.h"
#import "navigationBarViewController.h"
#import "MBProgressHUD.h"
#import "GalleryCellCollectionViewCell.h"
#import "HttpClient.h"
#import "UIImage+Extension.h"
#import "GallerySecondeViewController.h"
#import "constants.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

@synthesize ImageArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_ImagesCollectionView setDelegate:self];
    [_ImagesCollectionView setDataSource:self];
    
    //[self.navigationController.navigationBar addSubview:containerForMenu];
    
    // Do any additional setup after loading the view.
    
    //ImageArry Contained the cells identifiers in row 0 and images identifiers in row 1 .
    [MBProgressHUD showHUDAddedTo:_ImagesCollectionView animated:YES];
    
	NSString *api = [[NSString alloc]initWithFormat:@"%@%@",API_URL,GALLERY];
    HttpClient *httpClient = [HttpClient sharedInstance];
    
    [httpClient invokeAPI:api method:HTTPRequestGET parameters:nil paramterFormat:paramterStructureTypeFormData contentTypeValue:ContentTypeValue_None customContentTypeValueForHTTPHeaderField:nil onSuccess:^(NSData * _Nullable data){
    
        [MBProgressHUD hideHUDForView:_ImagesCollectionView animated:YES];
        
        NSError *error;
        NSArray *arrayOfData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSMutableArray *dataArray= [NSMutableArray new];
        
        for(NSDictionary *dictionary in arrayOfData){
            
            [dataArray addObject: dictionary];
            
        }
        ImageArray = [dataArray copy];
        if([ImageArray count] != 0){
            [_ImagesCollectionView reloadData];
            [self SlideImageView];
        }
    
    } andFailure:^(NSString * _Nonnull error) {
        [MBProgressHUD hideHUDForView:_ImagesCollectionView animated:YES];
    } ];
    
    
    
    
    
    //--------------
    
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    [navigationBar customSetup:_sideBarButton :self];
    
    UIColor *navigationBarColorGreen = [UIColor colorWithRed:76.0/255 green:219.0/255 blue:125.0/255 alpha:1.0];
    
    [navigationBar customizeNavigation:_sideBarButton :self :navigationBarColorGreen : @"Gallery"];
    
    
    OffsetImages=0; //its for ontimer method to move images
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//------slid image-----
-(void) SlideImageView{
    
    [MBProgressHUD showHUDAddedTo:_bigImageView animated:YES];
    
    for (NSInteger i = 0; i < [ImageArray count]; i++) {
        
        NSDictionary *dictionary = [ImageArray objectAtIndex:i];
        
        NSArray *array = [[dictionary objectForKey:@"gallery"] copy];
        
        NSString *urlString = [array objectAtIndex:0];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        [MBProgressHUD hideHUDForView:_bigImageView animated:YES];
        
        _bigImageView=[[UIImageView alloc]initWithImage:image];
        
        _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGFloat xPostion =self.view.frame.size.width * (CGFloat)i;
        
        self.bigImageView.frame = CGRectMake(xPostion, 0, self.BigScrollView.frame.size.width, self.BigScrollView.frame.size.height);
        
        
        [_BigScrollView setContentSize:CGSizeMake(_BigScrollView.frame.size.width * (CGFloat)i+1, _BigScrollView.frame.size.height)];
        
        [_BigScrollView addSubview:_bigImageView];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    NSLog(@"imageArrayCount : %lu",[ImageArray count]);
}

//----------the timer----------
-(void) onTimer{
    
    
    if (OffsetImages == (_BigScrollView.frame.size.width*([ImageArray count]-1))){
        OffsetImages = 0;
        [_BigScrollView setContentOffset:CGPointMake(OffsetImages, 0) animated:NO];
            }else{
        OffsetImages+=_BigScrollView.frame.size.width;
        [_BigScrollView setContentOffset:CGPointMake(OffsetImages, 0) animated:YES];
        
    }
    
}


    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *cellIdeintifier = @"cellImage";
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdeintifier forIndexPath:indexPath];
    
    
    if(!cell){
        cell = [[GalleryCellCollectionViewCell alloc]init];
    }
    gallery = [GalleryModel new];
    NSArray *array = [gallery arrayOfImage:[ImageArray objectAtIndex:indexPath.item]];
    
    [UIImage downloadImageURL:[array objectAtIndex:0] onSuccess:^(UIImage * _Nullable image) {
        
        UIImageView *imageForCell =[[UIImageView alloc]initWithImage:image];
        
        imageForCell.contentMode = UIViewContentModeScaleAspectFit;
        
        [cell.viewContainer addSubview:imageForCell];
        
        imageForCell.frame = CGRectMake(0, 0,cell.frame.size.width,cell.frame.size.height);
        
        
    } andFailure:^(NSString * _Nonnull error) {
        
        NSLog(@"Error Cell");
    
    }];
    
    

    
    

    //cell.contentMode  = UIViewContentModeScaleToFill;
    
    
    [cell.viewContainer.layer setShadowOffset:CGSizeMake(0.0f,0.0f)];
    cell.viewContainer.layer.shadowOpacity=0.8;
    
    
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _arrayOfImagesUrls = [[NSMutableArray alloc]initWithArray:[gallery arrayOfImage:[ImageArray objectAtIndex:indexPath.item]]];

    
    [self performSegueWithIdentifier:@"goToSecondGallery" sender:self];

}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [ImageArray count];
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
   
    CGFloat screenWidth = self.view.frame.size.width;
    
    CGFloat cellWidth = screenWidth / 4;
    
    
    return CGSizeMake(cellWidth, cellWidth);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    GallerySecondeViewController *second = [segue destinationViewController];
    
    if ([segue.identifier isEqualToString:@"goToSecondGallery"]) {
        
        second.arrayOfimagesUrls = [NSArray arrayWithArray:_arrayOfImagesUrls];
        
    }
   
}


/*-(void)showAnimated {
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
    
}*/

@end
