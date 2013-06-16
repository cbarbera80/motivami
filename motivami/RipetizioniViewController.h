//
//  RipetizioniViewController.h
//  appMotiv
//
//  Created by claudio barbera on 12/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Programma.h"

@interface RipetizioniViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id<SelectObjectDelegate> delegate;
@property (nonatomic, strong) Programma *programmaSelezionato;

@end
