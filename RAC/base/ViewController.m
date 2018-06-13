//
//  ViewController.m
//  RAC
//
//  Created by shujucn on 10/03/2018.
//  Copyright © 2018 shuju. All rights reserved.
//

#import "ViewController.h"
#import "RACBaseUseViewController.h"

static NSString *cellReuseID = @"RAC_DEMO_BASE_CELL";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *source;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.source = [self prepareSource];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"RAC";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray<NSString *> *)prepareSource {
    return @[
             @"base",
             @"rac",
             @"NSString + rac",
             @"NSSDictionary + rac",
             ];
}


#pragma MARk datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.source.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseID];
    }
    cell.textLabel.text = [self.source objectAtIndex:indexPath.row];
    return cell;
}

#pragma MARK delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RACBaseUseViewController *baeseVc = [[RACBaseUseViewController alloc] init];
        [self.navigationController pushViewController:baeseVc animated:YES];
    } 
    
}



@end
