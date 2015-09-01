//
//  Ventas.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/28/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Ventas.h"

@implementation Ventas

@synthesize nifCliente,numeroPales,precioUnitario,ventaBaseImponible,ventaIVA,ventaPrecioFinal,fechaVentas;

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
        nifCliente=fields[0];
        temp=fields[1];
        numeroPales=[temp intValue];
        temp=fields[2];
        precioUnitario=[temp floatValue];
        temp=fields[3];
        ventaBaseImponible=[temp floatValue];
        temp=fields[4];
        ventaIVA=[temp floatValue];
        temp=fields[5];
        ventaPrecioFinal=[temp floatValue];
        fechaVentas=fields[6];
    }
    return self;
}

#pragma mark Implementación de NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        nifCliente = [decoder decodeObjectForKey:@"nifCliente"];
        numeroPales= [decoder decodeIntForKey:@"numeroPales"];
        precioUnitario = [decoder decodeFloatForKey:@"precioUnitario"];
        ventaBaseImponible= [decoder decodeFloatForKey:@"ventaBaseImponible"];
        ventaIVA = [decoder decodeFloatForKey:@"ventaIVA"];
        ventaPrecioFinal = [decoder decodeFloatForKey:@"ventaPrecioFinal"];
        fechaVentas= [decoder decodeObjectForKey:@"fechaVentas"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:nifCliente forKey:@"nifCliente"];
    [encoder encodeInt:numeroPales forKey:@"numeroPales"];
    [encoder encodeFloat:precioUnitario forKey:@"precioUnitario"];
    [encoder encodeFloat:ventaBaseImponible forKey:@"ventaBaseImponible"];
    [encoder encodeFloat:ventaIVA forKey:@"ventaIVA"];
    [encoder encodeFloat:ventaPrecioFinal forKey:@"ventaPrecioFinal"];
    [encoder encodeObject:fechaVentas forKey:@"fechaVentas"];
}

-(NSString *)description
{
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    [temp appendFormat:@"%@\t%d\t%f\t%f\t%f\t%f\t%@",nifCliente,numeroPales,precioUnitario,ventaBaseImponible,ventaIVA,ventaPrecioFinal,fechaVentas];
    return temp;
    
}

@end
