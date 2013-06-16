//
//  TipoProgramma.m
//  motivami
//
//  Created by claudio barbera on 14/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "TipoProgramma.h"

@implementation TipoProgramma
@synthesize descrizione, titolo, bloccato, parseObjectId;

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.titolo forKey:@"titolo"];
    [encoder encodeObject:self.descrizione forKey:@"descrizione"];
    [encoder encodeObject:self.bloccato forKey:@"bloccato"];
    [encoder encodeObject:self.parseObjectId forKey:@"parseObjectId"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.descrizione = [decoder decodeObjectForKey:@"descrizione"];
        self.titolo = [decoder decodeObjectForKey:@"titolo"];
        self.bloccato = [decoder decodeObjectForKey:@"bloccato"];
        self.parseObjectId = [decoder decodeObjectForKey:@"parseObjectId"];
    }
    return self;
}


@end
