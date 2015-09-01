//
//  ClientesSheet.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/28/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "ClientesSheet.h"

@interface ClientesSheet ()

@end

@implementation ClientesSheet

-(id)initWithDataToCheck:(NSArray*) info
{
    self=[super initWithWindowNibName:@"ClientesSheet" owner:self];
    if(self)
    {
        nuevoCliente=[[Cliente alloc] init];
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
    if([[nombre stringValue] length]==0 || [[razonSocial stringValue] length]==0 || [[DNI stringValue] length]==0 || [[email stringValue] length]==0 || [[telefono stringValue] length]==0 )
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"FillFields", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else if([self checkExistingDNI:[DNI stringValue]])
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"DNIexist", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else
    {
        [nuevoCliente setNombre:[nombre stringValue]];
        [nuevoCliente setRazonSocial:[razonSocial stringValue]];
        [nuevoCliente setDNI:[DNI stringValue]];
        [nuevoCliente setEmail:[email stringValue]];
        [nuevoCliente setTelefono:[telefono stringValue]];
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setValue:nuevoCliente forKey:@"cliente"];
        
        NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
        [board postNotificationName:@"NuevoCliente" object:self userInfo:dict];
        
        [NSApp endSheet:[self window]];
        [[self window] orderOut:sender];
    }
}

-(IBAction)cancelAction:(id)sender
{
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}

-(BOOL)checkExistingDNI:(NSString *) DNItoCheck
{
    Cliente *tempCliente;
    for (int i=0; i<[dataToCheck count]; i++)
    {
        tempCliente=[dataToCheck objectAtIndex:i];
        if([DNItoCheck isEqual:[tempCliente DNI]])
            return TRUE;
    }
    
    return FALSE;
}

@end
