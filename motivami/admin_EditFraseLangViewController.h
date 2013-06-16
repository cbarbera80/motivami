//
//  EditFraseLangViewController.h
//  motivami
//
//  Created by claudio barbera on 16/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FraseDelegate <NSObject>

-(void)didChangeFrase:(int)index andObject:(PFObject *)obj;
-(void)didAddFrase:(PFObject *)frase;

@end


@interface admin_EditFraseLangViewController : UITableViewController

@property (nonatomic, strong) PFObject *fraseSelezionata;
@property (nonatomic, strong) PFObject *tipoProgrammaSelezionato;

@property (weak, nonatomic) IBOutlet UITextView *txtDescrizioneEN;
@property (weak, nonatomic) IBOutlet UITextView *txtDescrizioneIT;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) id<FraseDelegate> delegate;


@end
