//
//  VentasSheet.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/30/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "VentasSheet.h"

@interface VentasSheet ()

@end

@implementation VentasSheet

-(id)initWithClientesLogs:(NSArray*)info andAlmacen:(Almacen *)_mainAlmacen;
{
    self=[super initWithWindowNibName:@"VentasSheet" owner:self];
    if(self)
    {
        newVenta=[[Ventas alloc] init];
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
    int cantPales;
    
    if([[cliente stringValue] length]==0 || [[numeroDePales stringValue] length]==0 || [[precioUnitario stringValue] length]==0 || [[baseImponible stringValue] length]==0 || [[IVA stringValue] length]==0 || [[precioConIVA stringValue] length]==0)
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"FillFields", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else if(![self checkExistingDNI:[cliente stringValue]])
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"ClientDontExist", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else
    {
        cantPales=[numeroDePales intValue];
        if(cantPales > [mainAlmacen palesDisponibles])
        {
            NSString *alertMessage=[[NSString alloc] initWithFormat:@"%@ %d %@",NSLocalizedString(@"FabricarPales", @""),cantPales-[mainAlmacen palesDisponibles],NSLocalizedString(@"Pales", @"")];
            NSRunAlertPanel(NSLocalizedString(@"Information", @""),alertMessage,NSLocalizedString(@"OkButton", @""), nil, nil);
        }
        else
        {
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            
            [newVenta setNifCliente:[cliente stringValue]];
            [newVenta setNumeroPales:[numeroDePales intValue]];
            [newVenta setPrecioUnitario:[precioUnitario floatValue]];
            [newVenta setVentaBaseImponible:[baseImponible floatValue]];
            [newVenta setVentaIVA:[IVA floatValue]];
            [newVenta setVentaPrecioFinal:[precioConIVA floatValue]];
            [newVenta setFechaVentas:[dateFormatter stringFromDate:[NSDate date]]];
            
            [mainAlmacen setPalesDisponibles:[mainAlmacen palesDisponibles]-[newVenta numeroPales]];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setValue:newVenta forKey:@"venta"];
            
            NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
            [board postNotificationName:@"NuevaVenta" object:self userInfo:dict];
            
            [NSApp endSheet:[self window]];
            [[self window] orderOut:sender];
        }
    }
}

-(IBAction)cancelAction:(id)sender
{
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
    if([[numeroDePales stringValue] length]==0 || [[precioUnitario stringValue] length]==0 || [[IVA stringValue] length]==0)
        [precioConIVA setStringValue:@""];
    
    if([[numeroDePales stringValue]length]!=0 && [[precioUnitario stringValue] length]!=0 && [[IVA stringValue] length]!=0)
    {
        float tempIVA=([precioUnitario floatValue]*[numeroDePales floatValue]*[IVA floatValue])/100;
        [precioConIVA setFloatValue:tempIVA+[precioUnitario floatValue]*[numeroDePales floatValue]];
    }
}

-(BOOL)checkExistingDNI:(NSString *) DNItoCheck
{
    Cliente *tempCliente;
    for (int i=0; i<[data count]; i++)
    {
        tempCliente=[data objectAtIndex:i];
        if([DNItoCheck isEqual:[tempCliente DNI]])
            return TRUE;
    }
    
    return FALSE;
}
@end
