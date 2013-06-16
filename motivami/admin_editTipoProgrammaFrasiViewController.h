//
//  admin_editTipoProgrammaFrasiViewController.h
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskCell.h"
#import "admin_EditFraseLangViewController.h"

@interface admin_editTipoProgrammaFrasiViewController : UITableViewController <FraseDelegate>

@property (nonatomic, strong) PFObject *tipoProgrammaSelezionato;

- (IBAction)setEditMode:(id)sender;


@end
