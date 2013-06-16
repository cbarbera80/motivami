//
//  Ripetizione.m
//  appMotiv
//
//  Created by claudio barbera on 12/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import "Ripetizione.h"

@implementation Ripetizione

@synthesize descrizione, intervalloTemporale;

-(id)initWithDescrizione:(NSString *)descr andIntervalloTemporale:(NSNumber *)intervallo{

    self = [super init];
    
    if (self)
    {
        descrizione = descr;
        intervalloTemporale = intervallo;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.descrizione forKey:@"descrizione"];
    [encoder encodeObject:self.intervalloTemporale forKey:@"intervalloTemporale"];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.descrizione = [decoder decodeObjectForKey:@"descrizione"];
        self.intervalloTemporale = [decoder decodeObjectForKey:@"intervalloTemporale"];
        
    }
    return self;
}
@end
