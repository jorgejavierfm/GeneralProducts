//
//  Ventas.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/28/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ventas : NSObject <NSCoding>

@property (readwrite,copy) NSString *nifCliente;
@property (readwrite,assign) int numeroPales;
@property (readwrite,assign) float precioUnitario;
@property (readwrite,assign) float ventaBaseImponible;
@property (readwrite,assign) float ventaIVA;
@property (readwrite,assign) float ventaPrecioFinal;
@property (readwrite,copy) NSString *fechaVentas;

-(id)initWithData:(NSString *)data;
-(NSString *)description;

@end
