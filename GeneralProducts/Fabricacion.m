//
//  Fabricacion.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/27/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Fabricacion.h"

@implementation Fabricacion

@synthesize palesFabricados,fechaFabricacion,fabricacionAlmacen;

- (id)init
{
    if (self) {
        self=[self initWithData:@"0\t-\t0\t0"];
    }
    return self;
}

- (id)initWithAlmacen:(Almacen *) mainAlmacen
{
    self = [super init];
    if (self) {
        NSMutableString * temp = [[NSMutableString alloc] init];
        [temp appendFormat:@"0\t-\t%@",[mainAlmacen description]];
        self=[self initWithData:temp];
    }
    return self;
}

-(id)initWithData:(NSString *)data
{
    self=[super init];
    if(self)
    {
        NSNumber *temp;
        NSArray *fields=[data componentsSeparatedByString:@"\t"];
        temp=fields[0];
        palesFabricados=[temp intValue];
        fechaFabricacion=fields[1];
       
        fabricacionAlmacen=[[Almacen alloc] init];
        temp=fields[2];
        [fabricacionAlmacen setToneladasMaderaDisponible:[temp floatValue]];
        temp=fields[3];
        [fabricacionAlmacen setPalesDisponibles:[temp intValue]];

    }
    return self;
}

#pragma mark Implementación de NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        palesFabricados = [decoder decodeIntForKey:@"palesFabricados"];
        fechaFabricacion= [decoder decodeObjectForKey:@"fechaFabricacion"];
        fabricacionAlmacen = [decoder decodeObjectForKey:@"fabricacionAlmacen"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:palesFabricados forKey:@"palesFabricados"];
    [encoder encodeObject:fechaFabricacion  forKey:@"fechaFabricacion"];
    [encoder encodeObject:fabricacionAlmacen forKey:@"fabricacionAlmacen"];
}

-(NSString *)description
{
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    [temp appendFormat:@"%d\t%@\t%@",palesFabricados,fechaFabricacion,[fabricacionAlmacen description]];
    return temp;
    
}

@end
