//
//  admin_editTitoloViewController.h
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface admin_editTitoloViewController : UITableViewController <UITextFieldDelegate>
@property (nonatomic, strong) PFObject *tipoProgrammaSelezionato;
@property (weak, nonatomic) IBOutlet UITextField *lblTitleEN;
@property (weak, nonatomic) IBOutlet UITextField *lblTitleIT;

@end
