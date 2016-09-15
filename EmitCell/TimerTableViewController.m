//
//  TimerTableViewController.m
//  EmitCell
//
//  Created by YI on 16/9/14.
//  Copyright © 2016年 Sandro. All rights reserved.
//



#import "TimerTableViewController.h"


@interface TimerTableViewController (){
    NSString *zongTimeStr;
    NSMutableArray *modelArr;
}

@end

@implementation TimerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timeArr = @[@55555,@44444,@33333,@22222,@11111,@66666];
    _trueArr = [_timeArr mutableCopy];

    NSLog(@"tttt-%@",_trueArr);
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _trueArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSString *rowStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%@",_trueArr[indexPath.row],@"倒计时"];

    dispatch_queue_t queue = dispatch_queue_create("tk.bourne.testQueue", DISPATCH_QUEUE_CONCURRENT);//DISPATCH_QUEUE_SERIAL  DISPATCH_QUEUE_CONCURRENT
    dispatch_async(queue, ^{
        //code here
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:rowStr repeats:YES];
        NSLog(@"%@", [NSThread currentThread]);
        [[NSRunLoop currentRunLoop] run];
    });
     
    

    
    
    
    // Configure the cell...
    
    return cell;
}


- (void)timerFireMethod:(NSTimer *)timer
{

    
    NSLog(@"====%@",(NSString *)[timer userInfo]);
    NSString *rowStr = (NSString *)[timer userInfo];
    NSString *timeStr;
    NSInteger row = [rowStr integerValue];
    
    NSInteger num = [_trueArr[row] integerValue];
    [_trueArr replaceObjectAtIndex:row withObject:@(num-1) ];
    NSInteger num2 = [_trueArr[row] integerValue];
    NSInteger h = num2/3600;
    NSInteger m = (num2-h*3600)/60;
    NSInteger d = num2-h*3600-m*60;
    NSLog(@"--%@",_trueArr);
    if (num2>0) {
        timeStr = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",  h, m, d];//倒计时显示
        NSLog(@"--%@",timeStr);
    } else {
        timeStr = @"00:00:00";
    }
    
 

    
    NSIndexPath *index = [NSIndexPath indexPathForItem:row inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
    cell.textLabel.text = timeStr;

    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
