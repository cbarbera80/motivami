//
//  VociMenu.h
//  motivami
//
//  Created by claudio barbera on 13/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VociMenu : NSObject
@property (nonatomic, strong) NSString *chiave;
@property (nonatomic, strong) NSString *descrizione;

-(id)initWithDescrizione:(NSString *)desc andChiave:(NSString *)chiav;
@end
