//
//  UIAlertView+AdvancedUIAlertView.m
//  liveDeal
//
//  Created by claudio barbera on 27/01/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "UIAlertView+AdvancedUIAlertView.h"

@implementation UIAlertView (AdvancedUIAlertView)

+(UIAlertView*) showWithError:(NSError*) networkError {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[networkError localizedDescription]
                                                    message:[networkError localizedRecoverySuggestion]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}

+(UIAlertView *)showAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                     cancelButtonTitle:(NSString *)cancelButtonTitle
                     otherButtonTitles:(NSArray *)otherButton
                        showTextField:(BOOL)showTextField
                             onDismiss:(DismissiBlock)dismissed
                              onCancel:(CancelBlock)cancelled
{
    _cancelBlock = [cancelled copy];
    _dismissBlock = [dismissed copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self self]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    for ( NSString *buttonTitle in otherButton)
    {
        [alert addButtonWithTitle:buttonTitle];
    }
    
    if (showTextField)
    {
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        // Change keyboard type
        [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeEmailAddress];

    }
    
    [alert show];
    return alert;
    
}

+(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == [alertView cancelButtonIndex]){
    
        _cancelBlock();
    }
    else{
    
        _dismissBlock(buttonIndex - 1, [[alertView textFieldAtIndex:0] text]);
    }
}

@end
