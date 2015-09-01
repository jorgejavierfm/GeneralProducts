//
//  ComprasSheet.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Compra.h"
#import "Almacen.h"
#import "Proveedores.h"

@interface ComprasSheet : NSWindowController
{
    Almacen *mainAlmacen;
    Compra *newCompra;
    NSArray *data;
    
    IBOutlet NSTextField *proveedor;
    IBOutlet NSTextField *toneladasMaderaPedir;
    IBOutlet NSTextField *precioPorTonelada;
    IBOutlet NSTextField *baseImponible;
    IBOutlet NSTextField *IVA;
    IBOutlet NSTextField *precioConIVA;
}

-(IBAction)okAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(id)initWithProveedoresLogs:(NSArray*)info andAlmacen:(Almacen *)mainAlmacen;
-(BOOL)checkExistingNIF:(NSString *) NIFtoCheck;

@end
