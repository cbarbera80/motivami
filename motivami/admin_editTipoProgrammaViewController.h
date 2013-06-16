//
//  admin_editTipoProgrammaViewController.h
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "admin_editTitoloViewController.h"
#import "admin_editDescrizioneViewController.h"
#import "admin_editTipoProgrammaFrasiViewController.h"

@protocol TipoProgrammaDelegate <NSObject>

-(void)didChangeTipoProgrammaWithIndex:(int)index andObject:(PFObject *)obj;
-(void)didAddTipoProgramma:(PFObject *)tipoProgramma;

@end

@interface admin_editTipoProgrammaViewController : UITableViewController

@property (nonatomic, strong) PFObject *tipoProgrammaSelezionato;
@property (assign, nonatomic) NSInteger tableIndex;
@property (nonatomic, strong) id<TipoProgrammaDelegate> delegate;

- (IBAction)changeLocked:(id)sender;

@end
