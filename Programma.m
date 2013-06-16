//
//  Programma.m
//  motivami
//
//  Created by claudio barbera on 14/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "Programma.h"

@implementation Programma
@synthesize  attivo, ripetizione, tipoProgramma, frasiLibere;

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    
    [encoder encodeObject:self.attivo forKey:@"attivo"];
    [encoder encodeObject:self.ripetizione forKey:@"ripetizione"];
    [encoder encodeObject:self.tipoProgramma forKey:@"tipoProgramma"];
    [encoder encodeObject:self.frasiLibere forKey:@"frasiLibere"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.tipoProgramma = [decoder decodeObjectForKey:@"tipoProgramma"];
        self.attivo = [decoder decodeObjectForKey:@"attivo"];
        self.ripetizione = [decoder decodeObjectForKey:@"ripetizione"];
        self.frasiLibere = [decoder decodeObjectForKey:@"frasiLibere"];
        
    }
    return self;
}
@end
