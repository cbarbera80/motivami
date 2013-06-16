//
//  ProgrammaViewController.h
//  appMotiv
//
//  Created by claudio barbera on 12/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Programma.h"
#import "Ripetizione.h"
#import "AppDelegate.h"
#import "MKLocalNotificationsScheduler.h"
#import "RipetizioniViewController.h"
#import "SceltaTipoProgrammaViewController.h"
#import "TipoProgramma.h"
#import "SceltaFrasiViewController.h"

@protocol StatoProgrammaDelegate <NSObject>

-(void)didChangeProgram:(Programma *)program;

@end

@interface ProgrammaViewController : UITableViewController <SelectObjectDelegate>


@property (nonatomic, strong) id<StatoProgrammaDelegate> delegate;
@property (strong, nonatomic) Programma *programma;





@end
