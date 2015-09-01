//
//  ClientesSheet.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/28/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cliente.h"

@interface ClientesSheet : NSWindowController
{
    Cliente *nuevoCliente;
    NSArray *dataToCheck;
    
    IBOutlet NSTextField *nombre;
    IBOutlet NSTextField *razonSocial;
    IBOutlet NSTextField *DNI;
    IBOutlet NSTextField *email;
    IBOutlet NSTextField *telefono;
    
}

-(IBAction)okAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(id)initWithDataToCheck:(NSArray *) info;
-(BOOL)checkExistingDNI:(NSString *) DNItoCheck;

@end
