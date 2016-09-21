//
//  WebPageViewController.m
//  Pin_Tel
//
//  Created by Veenus Chhabra on 06/10/14.
//  Copyright (c) 2014 mvn. All rights reserved.
//

#import "WebPageViewController.h"
#import "Constants.h"
#import "Utility.h"

@implementation WebPageViewController
{
    NSString *urlToOpen;
    NSString *title;
     Utility *utility;
   // UIButton *backButton;
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
   // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
  //  self.title=title;
   // self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat yVal = self.yCordinate;
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,yVal, [[UIScreen mainScreen]bounds].size.width, self.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height - yVal)];
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





@end
