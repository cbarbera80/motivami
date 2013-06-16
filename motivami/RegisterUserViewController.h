//
//  RegisterUserViewController.h
//  OrderList
//
//  Created by claudio barbera on 10/04/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UserDelegate <NSObject>

-(void)didAddUser:(PFUser *)user;
-(void)didUpdateUser:(PFObject *)customer;

@end

@interface RegisterUserViewController : UITableViewController <UITextFieldDelegate>

- (IBAction)saveUser:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtCognome;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfermaPassword;
@property (nonatomic,retain) id<UserDelegate> delegate;
@property (nonatomic, retain) PFUser *selectedUser;

@end
