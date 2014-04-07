//
//  PiPostTweetViewController.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/6/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiPostTweetViewController.h"
#import "PiAppDelegate.h"
#import "PiWeibo.h"

@interface PiPostTweetViewController () 
@property (strong, nonatomic) PiWeibo* weibo;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;
@end

@implementation PiPostTweetViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PiAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.weibo = appDelegate.weibo;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(cancelButtonTarget)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"发送"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(sendButtonTarget)];
    self.navigationItem.leftBarButtonItem = sendButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonTarget {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendButtonTarget {
    [self.weibo postTweet:self.tweetTextView.text];
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@YES afterDelay:0.5];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 140) {
        [textView deleteBackward];
    }
    self.characterCountLabel.text = [NSString stringWithFormat:@"%d/%d", textView.text.length, kTWEET_CHARACTER_LIMIT];
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
