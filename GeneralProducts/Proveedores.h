//
//  Proveedores.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/27/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proveedores : NSObject <NSCoding>

@property (readwrite,copy) NSString *nombre;
@property (readwrite,copy) NSString *razonSocial;
@property (readwrite,copy) NSString *NIF;
@property (readwrite,copy) NSString *email;
@property (readwrite,copy) NSString *telefono;

-(id)initWithData:(NSString *)data;
-(NSString *)description;

@end
