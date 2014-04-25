//
//  PiTimeLineViewController.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTimeLineViewController.h"
#import "PiTimeLineTableViewCell.h"
#import "PiAppDelegate.h"
#import "PiWeibo.h"
#import "PiPostTweetViewController.h"

@interface PiTimeLineViewController ()
@property (weak, nonatomic) PiWeibo *weibo;
@property (strong, nonatomic) NSArray *tweetArray;
@end

@implementation PiTimeLineViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // controller setting
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // self.navigationItem.title = @"微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                             target:self
                                             action:@selector(compose)];

    // table view cell setting
    [self.tableView registerClass:[PiTimeLineTableViewCell class]
           forCellReuseIdentifier:@"reuseIdentifier"];

    // class variables setting
    PiAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.weibo = appDelegate.weibo;

    self.tweetArray = [self.weibo updateTweets];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)compose {
    PiPostTweetViewController* postTweetViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                                    bundle:nil] instantiateViewControllerWithIdentifier:@"PiPostTweetViewController"];
    [self.navigationController pushViewController:postTweetViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tweetArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PiTimeLineTableViewCell *cell = [[tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath] init];
    [cell setCellFrom:self.tweetArray[indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PiTimeLineTableViewCell* cell = [[tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"] init];
    [cell setCellFrom:self.tweetArray[indexPath.row]];

    return cell.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

}


@end
