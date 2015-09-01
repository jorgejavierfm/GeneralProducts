//
//  Almacen.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Almacen.h"

@implementation Almacen

@synthesize toneladasMaderaDisponible,palesDisponibles;

- (id)init
{
    self = [super init];
    if (self) {
        toneladasMaderaDisponible=0;
        palesDisponibles=0;
    }
    return self;
}

#pragma mark Implementación de NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        toneladasMaderaDisponible = [decoder decodeFloatForKey:@"toneladasMaderaDisponible"];
        palesDisponibles = [decoder decodeIntForKey:@"palesDisponibles"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeFloat:toneladasMaderaDisponible forKey:@"toneladasMaderaDisponible"];
    [encoder encodeInt:palesDisponibles forKey:@"palesDisponibles"];
}

-(NSString *)description
{
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    [temp appendFormat:@"%f\t%d",toneladasMaderaDisponible,palesDisponibles];
    return temp;
    
}

@end
