//
//  UIListOfLevelsTVC.m
//  FootClub
//
//  Created by Павел Лахно on 15.08.18.
//  Copyright © 2018 Павел Лахно. All rights reserved.
//

#import "PLListOfLevelsTVC.h"
#import "PLCollectionVC.h"

@interface PLListOfLevelsTVC () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PLListOfLevelsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *celIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celIdentifier];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:celIdentifier forIndexPath:indexPath];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Level %ld", indexPath.row+1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 10) {
        [self performSegueWithIdentifier:@"PLCollectionVC" sender:nil];
        //[self presentViewController:vc animated:YES completion:nil];

    }
    if (indexPath.row == 20) {
        PLCollectionVC *vc = [[PLCollectionVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        //[vc release]
    }
    
    if (indexPath.row == 0) {
        PLCollectionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PLCollectionVC"];
        //[self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
