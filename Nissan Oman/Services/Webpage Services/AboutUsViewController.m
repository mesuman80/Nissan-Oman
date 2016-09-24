//
//  AboutUsViewController.m
//  Nissan Oman
//
//  Created by Tripta Garg on 22/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Constants.h"
#import "Utility.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
{
    NSString *urlToOpen;
    NSString *title;
    Utility *utility;
}
-(id)initWithWebString:(NSString *)str withUrl:(NSString *)url
{
    if(self =[super init])
    {
        NSLog(@"......INIT......");
        utility = [[Utility alloc]init];
        // webString=str;
        title = str;
        urlToOpen =url;
        
        return self;
    }
    return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    //  self.title=title;
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat yVal = 0;
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,yVal, [[UIScreen mainScreen]bounds].size.width, self.view.bounds.size.height - yVal)];
    
    webView.delegate=self;
    webView.delegate = self; // setup the delegate as the web view is shown
    
    NSURL *nsurl            =   [NSURL URLWithString:urlToOpen];
    NSURLRequest *nsrequest =   [NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [webView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:webView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    //    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, self.view.bounds.size.height)];
    //    webView.delegate=self;
    //    webView.delegate = self; // setup the delegate as the web view is shown
    //
    //    NSURL *nsurl            =   [NSURL URLWithString:urlToOpen];
    //    NSURLRequest *nsrequest =   [NSURLRequest requestWithURL:nsurl];
    //    [webView loadRequest:nsrequest];
    //    [webView setBackgroundColor:[UIColor clearColor]];
    //    [self.view addSubview:webView];
    
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [webView stopLoading]; // in case the web view is still loading its content
    webView.delegate = nil; // disconnect the delegate as the webview is hidden
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //  [webView stopLoading];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // we support rotation in this view controller
    return YES;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [utility showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [utility hideHUD];
}

- (void)webView:(UIWebView *)webView1 didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ERROR" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [utility hideHUD];
    
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