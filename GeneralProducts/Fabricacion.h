//
//  Fabricacion.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/27/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Almacen.h"

@interface Fabricacion : NSObject <NSCoding>

@property (readwrite,assign) int palesFabricados;
@property (readwrite,copy) NSString *fechaFabricacion;
@property (readwrite,copy) Almacen *fabricacionAlmacen;

- (id)initWithAlmacen:(Almacen *) mainAlmacen;
-(id)initWithData:(NSString *)data;
-(NSString *)description;

@end
