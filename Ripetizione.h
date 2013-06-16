//
//  Ripetizione.h
//  appMotiv
//
//  Created by claudio barbera on 12/06/13.
//  Copyright (c) 2013 claudio barbera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ripetizione : NSObject <NSCoding>

@property (nonatomic, strong) NSString *descrizione;
@property (nonatomic,retain) NSNumber *intervalloTemporale;

-(id)initWithDescrizione:(NSString *)descr andIntervalloTemporale:(NSNumber *)intervallo;



@end
