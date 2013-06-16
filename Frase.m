//
//  Frase.m
//  motivami
//
//  Created by claudio barbera on 14/06/13.
//  Copyright (c) 2013 Riccardo Vieri. All rights reserved.
//

#import "Frase.h"

@implementation Frase

@synthesize descrizione;


-(id)initWithDescrizione:(NSString *)desc{

    self = [super init];
    
    if (self!=nil)
    {
        descrizione = desc;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    
    [encoder encodeObject:self.descrizione forKey:@"descrizioneFrase"];
    }

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.descrizione = [decoder decodeObjectForKey:@"descrizioneFrase"];
        
    
    }
    return self;
}
@end
