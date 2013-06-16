//
//  Programma.h
//  motivami
//
//  Created by claudio barbera on 14/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ripetizione.h"
#import "TipoProgramma.h"

@interface Programma : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *attivo;
@property (nonatomic, strong) Ripetizione *ripetizione;
@property (nonatomic, strong) TipoProgramma *tipoProgramma;
@property (nonatomic, strong) NSMutableArray *frasiLibere;

@end
