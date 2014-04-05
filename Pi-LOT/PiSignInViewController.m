//
//  PiSignInViewController.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//
#import "PiAppDelegate.h"
#import "PiSignInViewController.h"
#import "PiConnector.h"
#import "Pi-LotApp.h"
@interface PiSignInViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) PiWeibo*            weibo;
@end

@implementation PiSignInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    PiAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.weibo = appdelegate.weibo;

    [self.webView loadRequest:[self.weibo requestForAuthorize]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)             webView:(UIWebView *)webView
  shouldStartLoadWithRequest:(NSURLRequest *)request
              navigationType:(UIWebViewNavigationType)navigationType {
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    if (range.location!=NSNotFound) {
        NSString *code = [request.URL.absoluteString substringFromIndex:range.length+range.location];
        self.weibo.code = code;
        NSDictionary *retDict = [self.weibo dictionaryOfAccessToken];
        PiWeiboUser *user = [[PiWeiboUser alloc] init];
        if (retDict[@"uid"]) {
            user.userId = retDict[@"uid"];

            self.weibo.isAuthenticated = YES;
            self.weibo.accessToken = retDict[@"access_token"];

            [self.weibo userShow:user];

            PiAppDelegate  *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate performSelector:@selector(application:didFinishLaunchingWithOptions:) withObject:@{} afterDelay:0];
        }
        return NO;
    } else
        return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
