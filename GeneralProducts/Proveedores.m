//
//  Proveedores.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/27/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Proveedores.h"

@implementation Proveedores

@synthesize nombre,razonSocial,NIF,email,telefono;

- (id)init
{
    if (self) {
        self=[self initWithData:@"-\t-\t-\t-\t-"];
    }
    return self;
}

-(id)initWithData:(NSString *)data
{
    self=[super init];
    if(self)
    {
        NSArray *fields=[data componentsSeparatedByString:@"\t"];
        nombre=fields[0];
        razonSocial=fields[1];
        NIF=fields[2];
        email=fields[3];
        telefono=fields[4];
    }
    return self;
}

#pragma mark Implementación de NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        nombre = [decoder decodeObjectForKey:@"nombre"];
        razonSocial= [decoder decodeObjectForKey:@"razonSocial"];
        NIF = [decoder decodeObjectForKey:@"NIF"];
        email = [decoder decodeObjectForKey:@"email"];
        telefono = [decoder decodeObjectForKey:@"telefono"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:nombre forKey:@"nombre"];
    [encoder encodeObject:razonSocial  forKey:@"razonSocial"];
    [encoder encodeObject:NIF forKey:@"NIF"];
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:telefono forKey:@"telefono"];
}

-(NSString *)description
{
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    [temp appendFormat:@"%@\t%@\t%@\t%@\t%@",nombre,razonSocial,NIF,email,telefono];
    return temp;
    
}

@end
