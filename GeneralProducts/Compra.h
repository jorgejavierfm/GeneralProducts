//
//  Compra.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/28/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Compra : NSObject <NSCoding>

@property (readwrite,copy) NSString *proveedor;
@property (readwrite,assign) float toneladasMaderaPedida;
@property (readwrite,assign) float precioTonelada;
@property (readwrite,assign) float compraBaseImponible;
@property (readwrite,assign) float compraIVA;
@property (readwrite,assign) float compraPrecioFinal;
@property (readwrite,copy) NSString *fechaCompra;

-(id)initWithData:(NSString *)data;
-(NSString *)description;

@end
