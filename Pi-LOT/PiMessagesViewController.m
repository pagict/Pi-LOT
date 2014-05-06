//
//  PiMessagesViewController.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/7/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiMessagesViewController.h"
#import "PiWeibo.h"
#import "PiAppDelegate.h"
#import "PiCommentTableViewCell.h"

//#define kCommentCellIdentifier          @"commentCellIdentifier"
#define kPrivateMessageCellIdentifier   @"privateMessageCellIdentifier"
#define kAtMeCellIdentifier             @"atMeCellIdentifier"
static NSString* kCommentCellIdentifier = @"commentCellIdentifier";

@interface PiMessagesViewController ()
@property (strong, nonatomic) PiWeibo* weibo;
@property (strong, nonatomic) NSString* cellIdentifier;
@property (strong, nonatomic) NSArray* messageArray;
@end

@implementation PiMessagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updateMessageArrayWithNotification:)
     name:NOTIFICATION_COMMENTS_UPDATED
     object:self.weibo];
    // local variable, singleton PiWeibo instance
    PiAppDelegate* appDelegate = (PiAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.weibo = appDelegate.weibo;
    [self.weibo comments];
    self.cellIdentifier = kCommentCellIdentifier;

    // table view customized cell register
    [self.tableView registerClass:[PiCommentTableViewCell class]
           forCellReuseIdentifier:kCommentCellIdentifier];
    self.tableView.rowHeight = 208;
    // table view delegate setting
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMessageArrayWithNotification:(NSNotification *)notif {
    self.messageArray = notif.object;
    [self.tableView reloadData];
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
    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PiCommentTableViewCell *cell = [[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath] init];
    [cell setCellFrom:self.messageArray[indexPath.row]];
    
    return cell;
}

#pragma mark - table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PiCommentTableViewCell* cell = [[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier] init];;
    [cell setCellFrom:self.messageArray[indexPath.row]];
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
