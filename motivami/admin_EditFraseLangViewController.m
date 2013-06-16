//
//  EditFraseLangViewController.m
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "admin_EditFraseLangViewController.h"

@interface admin_EditFraseLangViewController ()

@end

@implementation admin_EditFraseLangViewController

@synthesize fraseSelezionata, txtDescrizioneEN, txtDescrizioneIT, delegate, index, tipoProgrammaSelezionato;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (fraseSelezionata!=nil){
    
        [txtDescrizioneEN setText:[fraseSelezionata objectForKey:@"descrizione_en"]];
        [txtDescrizioneIT setText:[fraseSelezionata objectForKey:@"descrizione_it"]];

    }
    else
    {
        fraseSelezionata = [PFObject objectWithClassName:@"Frasi"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController && txtDescrizioneIT.text.length > 0) {
        
        [fraseSelezionata setObject:txtDescrizioneIT.text forKey:@"descrizione_it"];
        [fraseSelezionata setObject:txtDescrizioneEN.text forKey:@"descrizione_en"];
        
        if (fraseSelezionata.objectId==nil)
            [fraseSelezionata setObject:tipoProgrammaSelezionato forKey:@"tipoProgramma"];
        
        [fraseSelezionata saveEventually];
        
        if (fraseSelezionata.objectId!=nil)
            [delegate didChangeFrase:index andObject:fraseSelezionata];
        else
            [delegate didAddFrase:fraseSelezionata];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
