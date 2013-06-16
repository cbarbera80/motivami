//
//  UIAlertView+AdvancedUIAlertView.h
//  liveDeal
//
//  Created by claudio barbera on 27/01/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissiBlock) (int buttonIndex, NSString *responseText);
typedef void (^CancelBlock)();

static DismissiBlock _dismissBlock;
static CancelBlock _cancelBlock;


@interface UIAlertView (AdvancedUIAlertView) <UIAlertViewDelegate>


+(UIAlertView *)showAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                     cancelButtonTitle:(NSString *)cancelButtonTitle
                     otherButtonTitles:(NSArray *)otherButton
                         showTextField:(BOOL)showTextField
                             onDismiss:(DismissiBlock)dismissed
                              onCancel:(CancelBlock)cancelled;


+(UIAlertView*) showWithError:(NSError*) networkError;

@end
