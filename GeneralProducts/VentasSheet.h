//
//  VentasSheet.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Ventas.h"
#import "Almacen.h"
#import "Cliente.h"

@interface VentasSheet : NSWindowController
{
    Almacen *mainAlmacen;
    Ventas *newVenta;
    NSArray *data;
    
    IBOutlet NSTextField *cliente;
    IBOutlet NSTextField *numeroDePales;
    IBOutlet NSTextField *precioUnitario;
    IBOutlet NSTextField *baseImponible;
    IBOutlet NSTextField *IVA;
    IBOutlet NSTextField *precioConIVA;
}

-(IBAction)okAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(id)initWithClientesLogs:(NSArray*)info andAlmacen:(Almacen *)mainAlmacen;
-(BOOL)checkExistingDNI:(NSString *) DNItoCheck;

@end
