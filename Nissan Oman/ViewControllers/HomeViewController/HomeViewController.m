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

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController
{
    UITableView *tableView;
    NSArray *dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageView];

    
   
    
    NSDictionary *dict1 = @{
                            @"image": @"vehicles.png",
                            @"text":   @"Vehicles"
                            };
    
    NSDictionary *dict2 = @{
                            @"image": @"buyer_support.png",
                            @"text":   @"Buyer Support"
                            };
    
    NSDictionary *dict3 = @{
                            @"image": @"showroom.png",
                            @"text":   @"Showroom Locator"
                            };
    
    NSDictionary *dict4 = @{
                            @"image": @"owning.png",
                            @"text":   @"Owning"
                            };
    
    NSDictionary *dict5 = @{
                            @"image": @"service.png",
                            @"text":   @"Service Appointment"
                            };
    
    NSDictionary *dict6 = @{
                            @"image": @"promotions.png",
                            @"text":   @"Promotions"
                            };
    
    dataArr = @[dict1,dict2, dict3, dict4,dict5,dict6];

    
    [self addTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addImageView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, .20*self.view.frame.size.height, self.view.frame.size.width - 20, .20f*self.view.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"juke4.jpg"];
    [self.view addSubview: imgView];
}

-(void)addTableView
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, .42*self.view.frame.size.height,self.view.frame.size.width - 20, .5*self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    NSLog(@"Index pathn =%li" , indexPath.row);
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    CustomTableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[CustomTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                tableCellIdentifierForReadReceipt];
    }
    [tableCell configureCell:[dataArr objectAtIndex:indexPath.row] ];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected pathn =%li" , indexPath.row);
    [tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
        VehicleCategeoryViewController *vehicleCategeoryViewController  = [[VehicleCategeoryViewController alloc]init];
        [self.navigationController pushViewController:vehicleCategeoryViewController animated:YES];
    }
    else if(indexPath.row == 1)
    {
        BuyerSupportViewController *buyerSupportViewController  = [[BuyerSupportViewController alloc]init];
        [self.navigationController pushViewController:buyerSupportViewController animated:YES];
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
