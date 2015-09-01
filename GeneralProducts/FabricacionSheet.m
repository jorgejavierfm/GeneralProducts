//
//  FabricacionSheet.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/29/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "FabricacionSheet.h"

@interface FabricacionSheet ()

@end

@implementation FabricacionSheet

-(id)initWithDataToCheck:(Almacen*) info
{
    self=[super initWithWindowNibName:@"FabricacionSheet" owner:self];
    if(self)
        nuevaOrdenFabricacion=[[Fabricacion alloc] initWithAlmacen:info];

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
    float kgMaderaDisponible=[[nuevaOrdenFabricacion fabricacionAlmacen]toneladasMaderaDisponible]*1000;
    
    if([[numeroPales stringValue] length]==0)
        NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"FillFields", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
    else
    {
        cantPales=[numeroPales intValue];
        if(kgMaderaDisponible < cantPales*20)
        {
            NSString *alertMessage=[[NSString alloc] initWithFormat:@"%@ %.2f %@",NSLocalizedString(@"Need", @""),(cantPales*20-kgMaderaDisponible)/1000,NSLocalizedString(@"TonsOfWood", @"")];
            NSRunAlertPanel(NSLocalizedString(@"Information", @""),alertMessage,NSLocalizedString(@"OkButton", @""), nil, nil);
        }
        else
        {
            NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            
            [nuevaOrdenFabricacion setPalesFabricados:cantPales];
            [nuevaOrdenFabricacion setFechaFabricacion:[dateFormatter stringFromDate:[NSDate date]]];
            [[nuevaOrdenFabricacion fabricacionAlmacen]setToneladasMaderaDisponible:(kgMaderaDisponible-cantPales*20)/1000];
            [[nuevaOrdenFabricacion fabricacionAlmacen]setPalesDisponibles:[[nuevaOrdenFabricacion fabricacionAlmacen] palesDisponibles]+cantPales];
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setValue:nuevaOrdenFabricacion forKey:@"ordenFabricacion"];
            
            NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
            [board postNotificationName:@"NuevaOrdenFabricacion" object:self userInfo:dict];
            
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

@end
