//
//  TipoProgramma.h
//  motivami
//
//  Created by claudio barbera on 14/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipoProgramma : NSObject
@property (nonatomic, strong) NSString *titolo;
@property (nonatomic, strong) NSString *descrizione;
@property (nonatomic, strong) NSNumber *bloccato;
@property (nonatomic, strong) NSString *parseObjectId;
@end
