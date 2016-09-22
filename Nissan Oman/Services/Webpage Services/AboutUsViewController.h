//
//  AboutUsViewController.h
//  Nissan Oman
//
//  Created by Tripta Garg on 22/09/16.
//  Copyright © 2016 Sakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
}
-(id)initWithWebString:(NSString *)str withUrl:(NSString *)url;
@end
