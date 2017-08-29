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
#import "constants.h"
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
    
    NSString* apiURL=OUR_TEAM_API;
    
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
     
     
    

    return  cella;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [teammembersList count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//       NSInteger position=indexPath.row;
//    _selectedteamMemberOBJ=[teammembersList objectAtIndex:position];
//    
//    [self performSegueWithIdentifier:@"teamMemberDetail" sender:_selectedteamMemberOBJ];

}




 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // segue.destinationViewController;
     
     
 }



@end
