//
//  admin_editTitoloViewController.m
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "admin_editTitoloViewController.h"

@interface admin_editTitoloViewController ()

@end

@implementation admin_editTitoloViewController
@synthesize tipoProgrammaSelezionato, lblTitleEN, lblTitleIT;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [lblTitleIT setText:[tipoProgrammaSelezionato objectForKey:@"titolo_it"]];
    [lblTitleEN setText:[tipoProgrammaSelezionato objectForKey:@"titolo_en"]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        
        [tipoProgrammaSelezionato setObject:lblTitleIT.text forKey:@"titolo_it"];
        [tipoProgrammaSelezionato setObject:lblTitleEN.text forKey:@"titolo_en"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notif_change_title" object:lblTitleIT.text];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
