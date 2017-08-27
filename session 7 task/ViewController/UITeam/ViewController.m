//
//  ViewController.m
//  session 7 task
//
//  Created by MOMO on 5/2/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//


#import "ViewController.h"
#import "teamMemberTableViewCell.h"
#import "HttpClient.h"

//#import "webService.h"
//#import "teamMembers.h"

#import "MBProgressHUD.h"
#import "navigationBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    teammembersList=[NSMutableArray new];

    
    [MBProgressHUD showHUDAddedTo:_listTeamView animated:YES];
    
    NSString* apiURL=@"http://209.126.105.42:8001/iosapi/getAllTeamMembers";
    
    HttpClient *httpClient = [HttpClient sharedInstance];

    
    [httpClient invokeAPI:apiURL method:HTTPRequestGET parameters:nil paramterFormat:paramterStructureTypeFormData contentTypeValue:ContentTypeValue_None customContentTypeValueForHTTPHeaderField:nil onSuccess:^(NSData * _Nullable data){
        
        [MBProgressHUD hideHUDForView:_listTeamView animated:YES];
        
        NSError *error;
        NSDictionary *DictionaryOfData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        NSArray * values = [DictionaryOfData allValues];
        
        NSMutableArray *dataArray= [NSMutableArray new];
        
        for(NSArray *array in values){
            
            [dataArray addObject: array];
            
        }
        teammembersList =[teamMembers getAllTeamMembers: dataArray];
        
        NSLog(@"List: %lu",[teammembersList count]);
        if([teammembersList count] != 0){
            
            [_listTeamView reloadData];
        }
        
    } andFailure:^(NSString * _Nonnull error) {
        [MBProgressHUD hideHUDForView:_listTeamView animated:YES];
    } ];
    
    //---------
    
    navigationBarViewController *navigationBar = [navigationBarViewController new];
    
    
    UIColor *navigationBarColorBlue = [UIColor colorWithRed:1.0/255 green:125.0/255 blue:214.0/255 alpha:1.0];
    
    [navigationBar customSetup:_sideBarButton :self];
    [navigationBar customizeNavigation:_sideBarButton :self :navigationBarColorBlue :@"Our Team"];
    
    [navigationBar makeImageBlur:_blurBackground];
    
    
    
  
    
    
    [_listTeamView setDelegate:self];
    [_listTeamView setDataSource:self];
    
  
    
    
}

-(void)viewDidAppear:(BOOL)animated{

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"cell";
    
    NSInteger position=indexPath.row;
    teamMembers *teamMemberOBJ=[teamMembers new];
    teamMemberOBJ=[teammembersList objectAtIndex:position];
    
    
    
     static NSString *CellIdentifier = @"teamMemberCell";
     
     
     
     
    teamMemberTableViewCell *cella = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     
     
     cella.NameLbl.text=teamMemberOBJ.memberName;
     cella.titleLbl.text=teamMemberOBJ.memberPosition;
     
     NSString* imagePath=@"";
     if(teamMemberOBJ.imagePath )
     {
     
		 imagePath=teamMemberOBJ.imagePath ;
		 NSURL* imageURL=[[NSURL alloc] initWithString:imagePath];
     
		 NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
		 UIImage *image = [[UIImage alloc] initWithData:imageData];
	

		 cella.cellImage.image=image;
		 
		 
		 
		 cella.cellImage.layer.cornerRadius = cella.cellImage.frame.size.height / 2 ;
		 cella.cellImage.clipsToBounds = true;
		 
         cella.cellImage.contentMode = UIViewContentModeScaleAspectFill;
		 
		 
		 cella.background.layer.cornerRadius = 10;
         cella.background.layer.shadowOpacity = 0.6f;
         cella.background.layer.opacity= 0.6f;
    
    }
     
     
    
    /*
    teamMemberTableViewCell *cella = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cella){
    
    teamMemberTableViewCell *cella =[[teamMemberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cella.textLabel.text=teamMemberOBJ.memberName;
    
    NSString* imagePath=@"";
    if(teamMemberOBJ.imagePath )
    {
        
        imagePath=teamMemberOBJ.imagePath ;
        NSURL* imageURL=[[NSURL alloc] initWithString:imagePath];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        

        
        [cella.cellImage setImage:image];
        
        cella.cellImage.contentMode = UIViewContentModeScaleAspectFit;

        
        }
    }*/
    return  cella;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [teammembersList count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSInteger position=indexPath.row;
    _selectedteamMemberOBJ=[teamMembers new];
    _selectedteamMemberOBJ=[teammembersList objectAtIndex:position];
    
    /*
     UITeamMemberDetail *viewTeamDetail=[[UITeamMemberDetail alloc] initWithNibName:@"UITeamMemberDetail" bundle:nil];
     viewTeamDetail.teamMemberOBJ=teamMemberOBJ;
     
     
     [self.navigationController pushViewController:viewTeamDetail animated:YES];
     */
    
    
    [self performSegueWithIdentifier:@"teamMemberDetail" sender:self];
    
    /*  Change Storyboard Active View
     [self performSegueWithIdentifier:@"teamMemberDetail" sender:self];
     */
    
    // [self performSegueWithIdentifier:@"teamMemberDetail" sender:self];
    
    //[self pushViewController:viewTeamDetail animated:YES];
    
    
    NSLog(@" clicked : ");
}


@end
