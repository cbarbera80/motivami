//
//  Frase.h
//  motivami
//
//  Created by claudio barbera on 14/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frase : NSObject

@property (nonatomic, strong) NSString *descrizione;

-(id)initWithDescrizione:(NSString *)desc;

@end
