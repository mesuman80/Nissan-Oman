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
#import "GridView.h"


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
    BOOL isFirstTime;
    GridView *gridView;
    UIButton *menuButton;
    NSMutableArray *gridArray;
}

@synthesize dictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    isFirstTime = YES;

    dataArr = [[NSMutableArray alloc]init];
    carArray = @[@"passenger_cars.png",@"crossovers.png",@"suv.png",@"lcv.png"];
    [self addTitle];
    [self addButtons];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isFirstTime)
    {
        isFirstTime = NO;
        [self getVehicleSubCategoryData];

    }
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
-(void)addButtons
{
    UIButton *gridButton = [[UIButton alloc]initWithFrame:CGRectMake(.82*self.view.frame.size.width, yCordinate, 20, 20)];
    [gridButton setBackgroundImage:[UIImage imageNamed:@"gridview_icon.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:gridButton];
    gridButton.tag = 0;
    [gridButton addTarget:self action:@selector(displayTypeChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    menuButton = [[UIButton alloc]initWithFrame:CGRectMake(.89*self.view.frame.size.width, yCordinate - 2, 25, 25)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"listview_icon.png"] forState:UIControlStateNormal];
    [self.view addSubview:menuButton];
    menuButton.tag = 1;
    [menuButton addTarget:self action:@selector(displayTypeChanged:) forControlEvents:UIControlEventTouchUpInside];

    yCordinate += gridButton.frame.size.height + 9;
    
}

-(void)displayTypeChanged:(UIButton *)sender
{
    if(sender.tag == 0)
    {
        tableView.alpha = 0;
        if(!gridView)
        {
            [self addGridView];
        }
        else
        {
            for(GridView *view in gridArray)
            {
                view.alpha = 1;
            }
        }
    }
    else
    {
        if(gridView)
        {
            for(GridView *view in gridArray)
            {
                 view.alpha = 0;
            }
           
        }
        tableView.alpha = 1;
    }
}

-(void)addGridView
{
    gridArray = [[NSMutableArray alloc]init];
    NSMutableArray *carNameArray = [[NSMutableArray alloc]init];
     NSMutableArray *carImageArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dict in arrOfDict)
    {
         NSString *name = [dict valueForKey:@"model_name"];
        [carNameArray addObject:name];
        
        if([[self.dictionary valueForKey:@"category"] isEqualToString:@"PASSENGER CARS"])
        {
            [carImageArray addObject:@"micra.png"];
            [carImageArray addObject:@"sunny.png"];
            [carImageArray addObject:@"tiida.png"];
            [carImageArray addObject:@"sentra.png"];
            [carImageArray addObject:@"altima.png"];
            [carImageArray addObject:@"maxima.png"];
            [carImageArray addObject:@"threeseven.png"];
            [carImageArray addObject:@"gtr.png"];
            
        }
        else if([[self.dictionary valueForKey:@"category"] isEqualToString:@"CROSSOVERS"])
        {
            [carImageArray addObject:@"juke.png"];
            [carImageArray addObject:@"xtrail.png"];
            [carImageArray addObject:@"pathfinder.png"];
            
        }
        else if([[self.dictionary valueForKey:@"category"] isEqualToString:@"SUVs"])
        {
            [carImageArray addObject:@"xterra.png"];
            [carImageArray addObject:@"armada.png"];
            
        }
        else if([[self.dictionary valueForKey:@"category"] isEqualToString:@"LCVs"])
        {
            [carImageArray addObject:@"pickup.png"];
            [carImageArray addObject:@"navara.png"];
            [carImageArray addObject:@"nvurvan.png"];
            [carImageArray addObject:@"pickup.png"];
            
        }

    }
    CGFloat xPos = .05*self.view.frame.size.width;
    CGFloat yPos = menuButton.frame.size.height + menuButton.frame.origin.y + 7;
    for(int i=0; i<carNameArray.count; i++)
    {
        NSArray *arr = @[[carNameArray objectAtIndex:i],[carImageArray objectAtIndex:i]];
        gridView = [[GridView alloc]initWithFrame:CGRectMake(xPos, yPos, .28*self.view.frame.size.width, .20*self.view.frame.size.width) withData:arr];
        [gridView drawGridView];
        gridView.tag = i;
        gridView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClicked:)];
        [gridView addGestureRecognizer:gesture];
        
        [self.view addSubview:gridView];
        xPos += gridView.frame.size.width + 10;
        if(i %3 != 0 && i %3 != 1) {
            xPos = .05*self.view.frame.size.width;
            yPos += gridView.frame.size.height + 10;
            
        }
        
        [gridArray addObject:gridView];
    }
}

-(void)itemClicked:(UITapGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    NSDictionary *dict = [arrOfDict objectAtIndex:view.tag];
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
    
    subTypeView = [[SubTypeView alloc]initWithFrame:self.view.frame withDictionaryArray:dictArray];
    subTypeView.dictionaryArray = dictArray;
    subTypeView.vehicleArr = [dict valueForKey:@"type"];
    subTypeView.parentViewController = self;
    [self.view addSubview:subTypeView];

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
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, yCordinate,self.view.frame.size.width - 20, .55*self.view.frame.size.height) style:UITableViewStylePlain];
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
    static NSString *tableCellIdentifierForReadReceipt = @"cellIdentifier";
    CustomTableViewCell *tableCell = [tableView1 dequeueReusableCellWithIdentifier:tableCellIdentifierForReadReceipt];
    if(tableCell == nil) {
        tableCell = [[CustomTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:
                     tableCellIdentifierForReadReceipt];
    }
    [tableCell configureCell:[dataArr objectAtIndex:indexPath.row]  withWidth:tableView.frame.size.width];
    tableCell.backgroundColor = [UIColor clearColor];
    return tableCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}



-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView1 deselectRowAtIndexPath:indexPath animated:NO];
    
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
    
    subTypeView = [[SubTypeView alloc]initWithFrame:self.view.frame withDictionaryArray:dictArray];
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
