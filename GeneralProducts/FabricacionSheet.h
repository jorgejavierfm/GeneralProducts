//
//  FabricacionSheet.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/29/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Fabricacion.h"
#import "Almacen.h"

@interface FabricacionSheet : NSWindowController
{
    Almacen *newAlmacen;
    Fabricacion *nuevaOrdenFabricacion;
    
    IBOutlet NSTextField *numeroPales;
}

-(IBAction)okAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(id)initWithDataToCheck:(Almacen*) info;

@end
