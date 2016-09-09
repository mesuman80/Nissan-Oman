//
//  BuyerSupportViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 09/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "BuyerSupportViewController.h"
#import "CustomTableViewCell.h"

@interface BuyerSupportViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BuyerSupportViewController
{
    CGFloat yCordinate;
    NSArray *dataArr;
    UITableView *tableView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict1 = @{
                            @"image": @"call.png",
                            @"text":   @"Call NISSAN Toll Free"
                            };
    
    NSDictionary *dict2 = @{
                            @"image": @"quote.png",
                            @"text":   @"Request a Quote"
                            };
    
    NSDictionary *dict3 = @{
                            @"image": @"brochure.png",
                            @"text":   @"Request a Brochure"
                            };
    
    NSDictionary *dict4 = @{
                            @"image": @"test_drive.png",
                            @"text":   @"Request a test Drive"
                            };
    
    dataArr = @[dict1,dict2, dict3, dict4];

    
    
    [self addTitle];
    [self addTableView];
    // Do any additional setup after loading the view.
}

-(void)addTitle
{
    yCordinate = .2*self.view.frame.size.height;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yCordinate, 200, 30)];
    label.text = @"VEHICLES";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    label.font = [UIFont systemFontOfSize:18.0f];
    [self.view addSubview:label];
    
    yCordinate += label.frame.size.height +3;
}


-(void)addTableView
{
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, .35*self.view.frame.size.height,self.view.frame.size.width - 20, .5*self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
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
