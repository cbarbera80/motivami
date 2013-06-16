//
//  FirstTopViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"
#import "AppDelegate.h"
#import "Ripetizione.h"
#import "ProgrammaViewController.h"

@interface ProgrammaMotivazionaleViewController : UITableViewController <StatoProgrammaDelegate>

@property (nonatomic, strong) Programma *prg;

- (IBAction)revealMenu:(id)sender;


@end
