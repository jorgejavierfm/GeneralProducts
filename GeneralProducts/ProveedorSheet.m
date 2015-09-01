//
//  ProveedorSheet.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/29/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "ProveedorSheet.h"

@interface ProveedorSheet ()

@end

@implementation ProveedorSheet


-(id)initWithDataToCheck:(NSArray*) info
{
    self=[super initWithWindowNibName:@"ProveedorSheet" owner:self];
    if(self)
    {
        nuevoProveedor=[[Proveedores alloc] init];
        dataToCheck=info;
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
    if([[nombre stringValue] length]==0 || [[razonSocial stringValue] length]==0 || [[NIF stringValue] length]==0 || [[email stringValue] length]==0 || [[telefono stringValue] length]==0 )
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"FillFields", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else if([self checkExistingNIF:[NIF stringValue]])
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"NIFexist", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else
    {
        [nuevoProveedor setNombre:[nombre stringValue]];
        [nuevoProveedor setRazonSocial:[razonSocial stringValue]];
        [nuevoProveedor setNIF:[NIF stringValue]];
        [nuevoProveedor setEmail:[email stringValue]];
        [nuevoProveedor setTelefono:[telefono stringValue]];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setValue:nuevoProveedor forKey:@"proveedor"];
        
        NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
        [board postNotificationName:@"NuevoProveedor" object:self userInfo:dict];
        
        [NSApp endSheet:[self window]];
        [[self window] orderOut:sender];
    }
}

-(IBAction)cancelAction:(id)sender
{
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}

-(BOOL)checkExistingNIF:(NSString *) NIFtoCheck
{
    Proveedores *tempProveedor;
    for (int i=0; i<[dataToCheck count]; i++)
    {
        tempProveedor=[dataToCheck objectAtIndex:i];
        if([NIFtoCheck isEqual:[tempProveedor NIF]])
            return TRUE;
    }
    
    return FALSE;
}
@end
