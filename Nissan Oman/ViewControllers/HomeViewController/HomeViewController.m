//
//  HomeViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 08/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomTableViewCell.h"
#import "VehicleCategeoryViewController.h"
#import "BuyerSupportViewController.h"
#import "OwningViewController.h"
#import "PromotionsViewController.h"
#import "ShowroomViewController.h"
#import "ServiceAppointmentViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController
{
    UITableView *tableView;         // tableview object
    NSArray *dataArr;               // array for tableview
    CGFloat yVal;                   // y position
    UIScrollView *horScrollView;    // horizontal scrollview for cars
    NSMutableArray *scrollArray;    // array for car images
}

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollArray = [[NSMutableArray alloc]init];
    [self addImageView];
    
    NSDictionary *dict1 = @{
                            @"image": @"passenger_cars.png",
                            @"text":   @"VEHICLES"
                            };
    
    NSDictionary *dict2 = @{
                            @"image": @"buyer_support.png",
                            @"text":   @"BUYER SUPPORT"
                            };
    
    NSDictionary *dict3 = @{
                            @"image": @"showroom.png",
                            @"text":   @"SHOWROOM LOCATOR"
                            };
    
    NSDictionary *dict4 = @{
                            @"image": @"owning.png",
                            @"text":   @"OWNING"
                            };
    
    NSDictionary *dict5 = @{
                            @"image": @"service.png",
                            @"text":   @"SERVICE APPOINTMENT"
                            };
    
    NSDictionary *dict6 = @{
                            @"image": @"promotions.png",
                            @"text":   @"PROMOTIONS"
                            };
    
    
    dataArr = @[dict1,dict2, dict3, dict4,dict5,dict6];

    
    [self addTableView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    if(self.settingView)
    {
        [self.settingView removeFromSuperview];
        for(UIImageView *imgView in scrollArray)
        {
            imgView.center = CGPointMake(imgView.center.x, horScrollView.frame.size.height/2 - 17*ScreenHeightFactor);
        }
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ui rendering

-(void)addImageView                 // scrollview implementation
{
    yVal = self.yCordinate;
    horScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,yVal, self.view.frame.size.width , .20f*self.view.frame.size.height)];
    [self.view addSubview:horScrollView];
    horScrollView.pagingEnabled = YES;
    NSArray *arr = @[@"vpone_1.jpg",@"vpone_2.jpg",@"vpone_3.jpg",@"vpone_4.jpg",@"vpone_5.png"];
    
    CGFloat xpos = 10;
    for(NSString *str in arr)
    {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(xpos,0, horScrollView.frame.size.width - 20, horScrollView.frame.size.height)];
        imgView.image = [UIImage imageNamed:str];
        imgView.center = CGPointMake(imgView.center.x, horScrollView.frame.size.height/2);
        [horScrollView addSubview: imgView];
        xpos += horScrollView.frame.size.width;
        horScrollView.showsHorizontalScrollIndicator = NO;
        [scrollArray addObject:imgView];
    }
    [horScrollView setContentSize:CGSizeMake(xpos, 0)];
    
     yVal += horScrollView.frame.size.height + 10;
    
   // yVal += imgView.frame.size.height + 10;
}

-(void)addTableView                     // adding tableview
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, yVal,screenWidth - 20, self.view.frame.size.height*.5f) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.center = CGPointMake(screenWidth/2, tableView.center.y);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
}

#pragma Mark tableView Delegaes implementation

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Value rows");
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifier = @"cellIdentifier";
    CustomTableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifier];
    if(tableCell == nil) {
        tableCell = [[CustomTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                tableCellIdentifier];
    }
    [tableCell configureCell:[dataArr objectAtIndex:indexPath.row] withWidth:tableView.frame.size.width ];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
         [self.navigationController setNavigationBarHidden:NO];
        VehicleCategeoryViewController *vehicleCategeoryViewController  = [[VehicleCategeoryViewController alloc]init];
        vehicleCategeoryViewController.isBarShown = YES;
        [self.navigationController pushViewController:vehicleCategeoryViewController animated:YES];
    }
    else if(indexPath.row == 1)
    {
        [self.navigationController setNavigationBarHidden:NO];
        BuyerSupportViewController *buyerSupportViewController  = [[BuyerSupportViewController alloc]init];
        [self.navigationController pushViewController:buyerSupportViewController animated:YES];
    }
    else if(indexPath.row == 2)
    {
        [self.navigationController setNavigationBarHidden:NO];
        ShowroomViewController *showroomViewController  = [[ShowroomViewController alloc]init];
        showroomViewController.arrVal = @[@"SHOWROOM LOCATOR",PlaceholderSelectBranch,@"showroomAddress"];
        showroomViewController.isBarShown = YES;
        [self.navigationController pushViewController:showroomViewController animated:YES];
    }

    else if(indexPath.row == 3)
    {
        [self.navigationController setNavigationBarHidden:NO];
        OwningViewController *owningViewController  = [[OwningViewController alloc]init];
        [self.navigationController pushViewController:owningViewController animated:YES];
    }
    else if(indexPath.row == 4)
    {
        [self.navigationController setNavigationBarHidden:NO];
        ServiceAppointmentViewController *serviceAppointmentViewController  = [[ServiceAppointmentViewController alloc]init];
        [self.navigationController pushViewController:serviceAppointmentViewController animated:YES];
    }
    else if(indexPath.row == 5)
    {
        [self.navigationController setNavigationBarHidden:NO];
        PromotionsViewController *promotionsViewController  = [[PromotionsViewController alloc]init];
        [self.navigationController pushViewController:promotionsViewController animated:YES];
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

@end
