//
//  WebPageViewController.h
//  Pin_Tel
//
//  Created by Veenus Chhabra on 06/10/14.
//  Copyright (c) 2014 mvn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarBaseViewController.h"

@interface WebPageViewController : TabbarBaseViewController<UIWebViewDelegate>
{
    UIWebView *webView;
}
-(id)initWithWebString:(NSString *)str withUrl:(NSString *)url;
@end
