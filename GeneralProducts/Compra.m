//
//  Compra.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/28/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Compra.h"

@implementation Compra

@synthesize proveedor,toneladasMaderaPedida,precioTonelada,compraBaseImponible,compraIVA,compraPrecioFinal,fechaCompra;

- (id)init
{
    self = [super init];
    if (self) {
        self=[self initWithData:@"-\t0\t0\t0\t0\t0\t-"];
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
        proveedor=fields[0];
        temp=fields[1];
        toneladasMaderaPedida=[temp intValue];
        temp=fields[2];
        precioTonelada=[temp floatValue];
        temp=fields[3];
        compraBaseImponible=[temp floatValue];
        temp=fields[4];
        compraIVA=[temp floatValue];
        temp=fields[5];
        compraPrecioFinal=[temp floatValue];
        fechaCompra=fields[6];
    }
    return self;
}

#pragma mark Implementación de NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        proveedor = [decoder decodeObjectForKey:@"proveedor"];
        toneladasMaderaPedida= [decoder decodeFloatForKey:@"toneladasMaderaPedida"];
        precioTonelada = [decoder decodeFloatForKey:@"precioTonelada"];
        compraBaseImponible= [decoder decodeFloatForKey:@"compraBaseImponible"];
        compraIVA = [decoder decodeFloatForKey:@"compraIVA"];
        compraPrecioFinal = [decoder decodeFloatForKey:@"compraPrecioFinal"];
        fechaCompra = [decoder decodeObjectForKey:@"fechaCompra"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:proveedor forKey:@"proveedor"];
    [encoder encodeFloat:toneladasMaderaPedida forKey:@"toneladasMaderaPedida"];
    [encoder encodeFloat:precioTonelada forKey:@"precioTonelada"];
    [encoder encodeFloat:compraBaseImponible forKey:@"compraBaseImponible"];
    [encoder encodeFloat:compraIVA forKey:@"compraIVA"];
    [encoder encodeFloat:compraPrecioFinal forKey:@"compraPrecioFinal"];
    [encoder encodeObject:fechaCompra forKey:@"fechaCompra"];
}

-(NSString *)description
{
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    [temp appendFormat:@"%@\t%f\t%f\t%f\t%f\t%f\t%@",proveedor,toneladasMaderaPedida,precioTonelada,compraBaseImponible,compraIVA,compraPrecioFinal,fechaCompra];
    return temp;
    
}

@end
