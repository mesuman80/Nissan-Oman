//
//  VehicleSubCategoryViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 12/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "VehicleSubCategoryViewController.h"
#import "CustomTableViewCell.h"
#import "WebService.h"
#import "SubTypeView.h"


@interface VehicleSubCategoryViewController ()<CustomWebServiceDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation VehicleSubCategoryViewController
{
    CGFloat yCordinate;
    NSMutableArray *dataArr;
    NSArray *carArray;
    UITableView *tableView;
    NSArray *arrOfDict;
    SubTypeView *subTypeView;

}

@synthesize dictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    dataArr = [[NSMutableArray alloc]init];
    carArray = @[@"passenger_cars.png",@"crossovers.png",@"suv.png",@"lcv.png"];
    [self addTitle];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getVehicleSubCategoryData];
    if(subTypeView)
    {
        [subTypeView removeFromSuperview];
    }
}
-(void)addTitle
{
    yCordinate = self.yCordinate + 10;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 200, 30)];
    NSString *name = [self.dictionary valueForKey:@"category"];
    label.text = name;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height +3;
}
-(void)getVehicleSubCategoryData
{
    WebService *webService = [[WebService alloc]init];
    webService.customWebServiceDelegate = self;
    webService.serviceName = @"vehicleSubCategory";
    [webService getVehicleSubCategeoryList:[self.dictionary valueForKey:@"category_id"]];
}

-(void)ConnectionDidFinishWithError:(NSDictionary *)dict
{
    
}

-(void)ConnectionDidFinishWithSuccess:(NSDictionary *)dict
{
    arrOfDict = nil;
    arrOfDict = [dict valueForKey:@"sub_category"];
    int i = 0;
    [dataArr removeAllObjects];
    for(NSDictionary *dict in arrOfDict)
    {
        NSString *name = [dict valueForKey:@"model_name"];
        
        NSDictionary *dictionary1 = @{
                                     @"text": name,
                                     @"image": self.imageName
                                     };
        i++;
        
        [dataArr addObject:dictionary1];
    }
    
    [self addTableView];
}
-(void)addTableView
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, .35*self.view.frame.size.height,self.view.frame.size.width - 20, .55*self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
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
    
    NSDictionary *dict = [arrOfDict objectAtIndex:indexPath.row];
    NSArray *arr = [dict valueForKey:@"type"];
    NSMutableArray *dictArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(NSDictionary *dict in arr)
    {
        NSString *name = [dict valueForKey:@"vehicle_name"];
        
        NSDictionary *dictionary1 = @{
                                      @"text": name,
                                      @"image": self.imageName
                                      };
        i++;
        
        [dictArray addObject:dictionary1];
    }
    
    subTypeView = [[SubTypeView alloc]initWithFrame:self.view.frame];
    subTypeView.dictionaryArray = dictArray;
    subTypeView.vehicleArr = [dict valueForKey:@"type"];
    subTypeView.parentViewController = self;
    [self.view addSubview:subTypeView];
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

@end
