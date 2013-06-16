//
//  SceltaFrasiViewController.h
//  appMotiv
//
//  Created by claudio barbera on 11/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceltaFrasiViewController.h"
#import "AppDelegate.h"
#import "Programma.h"
#import "TipoProgramma.h"

@interface SceltaTipoProgrammaViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id<SelectObjectDelegate> delegate;
@property (nonatomic, strong) Programma *programmaSelezionato;

@end
