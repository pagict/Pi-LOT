//
//  PiSignInViewController.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//
#import "PiAppDelegate.h"
#import "PiSignInViewController.h"
#import "WeiboAPI.h"
#import "PiConnector.h"

@interface PiSignInViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PiSignInViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlString = @"https://api.weibo.com/oauth2/authorize";
    NSURLRequest *request = [PiConnector connectURL:urlString
                                         parameters:@{@"client_id": kAppKey,
                                                      @"reponse_type": @"code",
                                                      @"redirect_uri": kRedirectURL,
                                                      @"display": @"mobile"}];
//    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@&display=mobile",kAppKey,kRedirectURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];

    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
    if (range.location!=NSNotFound) {
        NSString *code = [request.URL.absoluteString substringFromIndex:range.length+range.location];

        NSMutableURLRequest *request = [[PiConnector connectURL:@"https://api.weibo.com/oauth2/access_token"
                                             parameters:@{@"client_id": kAppKey,
                                                          @"client_secret": kAppSecret,
                                                          @"grant_type": @"authorization_code",
                                                          @"code": code,
                                                          @"redirect_uri": kRedirectURL}] mutableCopy];
        [request setHTTPMethod:@"POST"];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
        NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:nil];
        PiWeiboUser *user = [[PiWeiboUser alloc] init];
        if (retDict[@"uid"]) {
            user.userId = retDict[@"uid"];
            PiAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            appDelegate.weibo.isAuthenticated = YES;
            appDelegate.weibo.code = code;
            appDelegate.weibo.accessToken = retDict[@"access_token"];

            [appDelegate.weibo userShow:user];

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
