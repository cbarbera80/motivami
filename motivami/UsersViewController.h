//
//  UsersViewController.h
//  OrderList
//
//  Created by claudio barbera on 10/04/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterUserViewController.h"


@interface UsersViewController : UITableViewController <UserDelegate>

@property (nonatomic, strong) NSMutableArray *users;

@end
