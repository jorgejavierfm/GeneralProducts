//
//  ComprasSheet.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "ComprasSheet.h"

@interface ComprasSheet ()

@end

@implementation ComprasSheet

-(id)initWithProveedoresLogs:(NSArray*)info andAlmacen:(Almacen *)_mainAlmacen;
{
    self=[super initWithWindowNibName:@"ComprasSheet" owner:self];
    if(self)
    {
        newCompra=[[Compra alloc] init];
        mainAlmacen=_mainAlmacen;
        data=info;
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(IBAction)okAction:(id)sender
{
    if([[proveedor stringValue] length]==0 || [[toneladasMaderaPedir stringValue] length]==0 || [[precioPorTonelada stringValue] length]==0 || [[baseImponible stringValue] length]==0 || [[IVA stringValue] length]==0 || [[precioConIVA stringValue] length]==0)
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"FillFields", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else if(![self checkExistingNIF:[proveedor stringValue]])
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"ProviderDontExist", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else
    {
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        
        [newCompra setProveedor:[proveedor stringValue]];
        [newCompra setToneladasMaderaPedida:[toneladasMaderaPedir floatValue]];
        [newCompra setPrecioTonelada:[precioPorTonelada floatValue]];
        [newCompra setCompraBaseImponible:[baseImponible floatValue]];
        [newCompra setCompraIVA:[IVA floatValue]];
        [newCompra setCompraPrecioFinal:[precioConIVA floatValue]];
        [newCompra setFechaCompra:[dateFormatter stringFromDate:[NSDate date]]];
        
        [mainAlmacen setToneladasMaderaDisponible:[mainAlmacen toneladasMaderaDisponible]+[newCompra toneladasMaderaPedida]];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setValue:newCompra forKey:@"compra"];
        
        NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
        [board postNotificationName:@"NuevaCompra" object:self userInfo:dict];
        
        [NSApp endSheet:[self window]];
        [[self window] orderOut:sender];
    }
}

-(IBAction)cancelAction:(id)sender
{
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
    if([[toneladasMaderaPedir stringValue] length]==0 || [[precioPorTonelada stringValue] length]==0 || [[IVA stringValue] length]==0)
        [precioConIVA setStringValue:@""];
       
    if([[precioPorTonelada stringValue]length]!=0 && [[toneladasMaderaPedir stringValue] length]!=0 && [[IVA stringValue] length]!=0)
    {
        float tempIVA=([precioPorTonelada floatValue]*[toneladasMaderaPedir floatValue]*[IVA floatValue])/100;
        [precioConIVA setFloatValue:tempIVA+[precioPorTonelada floatValue]*[toneladasMaderaPedir floatValue]];
    }
}

-(BOOL)checkExistingNIF:(NSString *)NIFtoCheck
{
    Proveedores *tempProveedor;
    for (int i=0; i<[data count]; i++)
    {
        tempProveedor=[data objectAtIndex:i];
        if([NIFtoCheck isEqual:[tempProveedor NIF]])
            return TRUE;
    }
    
    return FALSE;
}

@end
