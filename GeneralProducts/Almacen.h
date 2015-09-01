//
//  Almacen.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Almacen : NSObject <NSCoding>

@property (readwrite,assign) float toneladasMaderaDisponible;
@property (readwrite,assign) int palesDisponibles;

-(NSString *)description;

@end
