//
//  admin_editTitoloViewController.m
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "admin_editDescrizioneViewController.h"

@interface admin_editDescrizioneViewController ()

@end

@implementation admin_editDescrizioneViewController
@synthesize tipoProgrammaSelezionato, txtDescriptionEN, txtDescriptionIT;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [txtDescriptionEN setText:[tipoProgrammaSelezionato objectForKey:@"descrizione_en"]];
    [txtDescriptionIT setText:[tipoProgrammaSelezionato objectForKey:@"descrizione_it"]];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        
        [tipoProgrammaSelezionato setObject:txtDescriptionIT.text forKey:@"descrizione_it"];
        [tipoProgrammaSelezionato setObject:txtDescriptionEN.text forKey:@"descrizione_en"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notif_change_description" object:txtDescriptionIT.text];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
