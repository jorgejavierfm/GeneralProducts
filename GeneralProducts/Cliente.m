//
//  Cliente.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/26/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Cliente.h"

@implementation Cliente

@synthesize nombre,razonSocial,DNI,email,telefono;

- (id)init
{
    self = [super init];
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
        DNI=fields[2];
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
        DNI = [decoder decodeObjectForKey:@"DNI"];
        email = [decoder decodeObjectForKey:@"email"];
        telefono = [decoder decodeObjectForKey:@"telefono"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:nombre forKey:@"nombre"];
    [encoder encodeObject:razonSocial  forKey:@"razonSocial"];
    [encoder encodeObject:DNI forKey:@"DNI"];
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:telefono forKey:@"telefono"];
}

-(NSString *)description
{
    NSMutableString * temp = [[NSMutableString alloc] init];
    
    [temp appendFormat:@"%@\t%@\t%@\t%@\t%@",nombre,razonSocial,DNI,email,telefono];
    return temp;

}

@end
