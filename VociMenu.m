//
//  VociMenu.m
//  motivami
//
//  Created by claudio barbera on 13/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "VociMenu.h"

@implementation VociMenu
@synthesize chiave, descrizione;

-(id)initWithDescrizione:(NSString *)desc andChiave:(NSString *)chiav
{
    self = [super init];
    
    if (self)
    {
        descrizione = desc;
        chiave = chiav;
    }
    
    return self;
}
@end
