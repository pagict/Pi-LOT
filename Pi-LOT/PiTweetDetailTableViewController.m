//
//  PiTweetDetailTableViewController.m
//  Pi-LOT
//
//  Created by Peng Pagict on 5/9/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTweetDetailTableViewController.h"
#import "PiTimeLineTableViewCell.h"
#import "PiWeiboDetailCommentTableViewCell.h"
#import "PiAppDelegate.h"

@interface PiTweetDetailTableViewController ()
@property (strong, atomic) PiWeibo* weibo;
@property (strong, nonatomic) NSArray* commentsArray;
@end

@implementation PiTweetDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    PiAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    self.weibo = delegate.weibo;

    [self.tableView registerClass:[PiTimeLineTableViewCell class]
           forCellReuseIdentifier:@"weiboCellInTweetDetailView"];
    [self.tableView registerClass:[PiWeiboDetailCommentTableViewCell class]
           forCellReuseIdentifier:@"commentCellInTweetDetailView"];

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateCommentsOfTweetWithNotification:)
     name:NOTIFICATION_COMMENTSOFTWEET_UPDATED
     object:nil];

    [self.weibo commentOfTweet:self.message];
}

- (void)updateCommentsOfTweetWithNotification:(NSNotification*)notif {
    self.commentsArray = notif.object;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }

    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* reuseIdentifier;
    UITableViewCell* cell;
    if (indexPath.section == 0) {
        reuseIdentifier = @"weiboCellInTweetDetailView";
        cell = [[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath] init];
        [(PiTimeLineTableViewCell *)cell setCellFromMessage:self.message];
    } else {
        reuseIdentifier = @"commentCellInTweetDetailView";
        cell = [(PiWeiboDetailCommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath] initWithMessage:self.commentsArray[indexPath.row]];
        [(PiWeiboDetailCommentTableViewCell *)cell setCell];
    }

    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"微博详情";
    }
    else {
        return @"评论";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PiTimeLineTableViewCell* cell = [[self.tableView dequeueReusableCellWithIdentifier:@"weiboCellInTweetDetailView"] init];
        [cell setCellFromMessage:self.message];
        return cell.height;
    } else {
        PiWeiboDetailCommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"commentCellInTweetDetailView"];
        cell = [cell initWithMessage:self.commentsArray[indexPath.row]];
        [cell setCell];
        return cell.height;
    }
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
