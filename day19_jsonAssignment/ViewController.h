//
//  ViewController.h
//  day19_jsonAssignment
//
//  Created by Student 01 on 11/10/17.
//  Copyright © 2017 mohini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property NSMutableArray *myArray;
@property NSMutableArray *nameArray;
@property NSMutableData *mydata;


@end

