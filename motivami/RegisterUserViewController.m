//
//  RegisterUserViewController.m
//  OrderList
//
//  Created by claudio barbera on 10/04/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "RegisterUserViewController.h"


@interface RegisterUserViewController ()
@property(nonatomic, strong) PFUser *user;
@property(nonatomic, strong) PFObject *selectedRole;
@end

@implementation RegisterUserViewController
@synthesize txtCognome, txtConfermaPassword, txtEmail, txtNome, txtPassword;


- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
   
}



- (IBAction)saveUser:(id)sender {
    
  
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSError *)isValid
{
    NSError *err;
    
    
    if ([self.txtNome.text isEqualToString:@""])
    {
        
    
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"Il nome è obbligatorio" forKey:NSLocalizedDescriptionKey];
        
        err = [NSError errorWithDomain:@"world" code:3 userInfo:details];
        return err;
    }
    
    if ([self.txtCognome.text isEqualToString:@""])
    {
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"Il cognome è obbligatorio" forKey:NSLocalizedDescriptionKey];
        
        err = [NSError errorWithDomain:@"world" code:5 userInfo:details];
        return err;
    }
    
    if ([self.txtEmail.text isEqualToString:@""])
    {
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"L'email è obbligatoria" forKey:NSLocalizedDescriptionKey];
        
        err = [NSError errorWithDomain:@"world" code:8 userInfo:details];
        return err;
    }
    
    if ([self.txtPassword.text isEqualToString:@""])
    {
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"La password è obbligatoria" forKey:NSLocalizedDescriptionKey];
        
        err = [NSError errorWithDomain:@"world" code:9 userInfo:details];
        return err;
    }
    
    if (![self.txtPassword.text isEqualToString:txtConfermaPassword.text])
    {
        
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"La password non corrisponde alla password di conferma" forKey:NSLocalizedDescriptionKey];
        
        err = [NSError errorWithDomain:@"world" code:9 userInfo:details];
        return err;
    }

    
    return nil;
}

#pragma mark - Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
