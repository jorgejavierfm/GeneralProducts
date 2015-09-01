//
//  ProveedorSheet.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/29/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Proveedores.h"

@interface ProveedorSheet : NSWindowController
{
    Proveedores *nuevoProveedor;
    NSArray *dataToCheck;
    
    IBOutlet NSTextField *nombre;
    IBOutlet NSTextField *razonSocial;
    IBOutlet NSTextField *NIF;
    IBOutlet NSTextField *email;
    IBOutlet NSTextField *telefono;
}

-(IBAction)okAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(id)initWithDataToCheck:(NSArray *) info;
-(BOOL)checkExistingNIF:(NSString *) NIFtoCheck;

@end
