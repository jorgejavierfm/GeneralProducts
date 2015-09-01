//
//  ExportAndImportSheet.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/31/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "ExportAndImportSheet.h"

@interface ExportAndImportSheet ()

@end

@implementation ExportAndImportSheet

- (id)initForImport
{
    self = [super initWithWindowNibName:@"ExportAndImportSheet" owner:self];
    if (self)
    {
        action=@"import";
        
        ventasArray=[[NSMutableArray alloc] init];
        comprasArray=[[NSMutableArray alloc] init];
        clienteArray=[[NSMutableArray alloc] init];
        proveedoresArray=[[NSMutableArray alloc] init];
        fabricacionArray=[[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initForExportVentas:(NSMutableArray *)ventas Compras:(NSMutableArray *)compras Clientes:(NSMutableArray *)clientes Proveedores:(NSMutableArray *)proveedores Fabricacion:(NSMutableArray *)fabricacion
{
    self = [super initWithWindowNibName:@"ExportAndImportSheet" owner:self];
    if (self)
    {
        action=@"export";
        
        ventasArray=ventas;
        comprasArray=compras;
        clienteArray=clientes;
        proveedoresArray=proveedores;
        fabricacionArray=fabricacion;
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

- (IBAction)browseAction:(id)sender
{
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    [panel setExtensionHidden:NO];
    NSArray * fileTypes = [NSArray arrayWithObjects:@"txt", nil];
    [panel setAllowedFileTypes:fileTypes];
    if([action isEqual:@"export"])
        [panel setMessage:@"Export data to a text file."];
    else
        [panel setMessage:@"Import data from a text file"];
    
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result)
    {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL * url = [panel URL];
            switch ([sender tag])
            {
                case 0:
                    [ventasText setStringValue:[url path]];
                    break;
                case 1:
                    [comprasText setStringValue:[url path]];
                    break;
                case 2:
                    [clientesText setStringValue:[url path]];
                    break;
                case 3:
                    [proveedoresText setStringValue:[url path]];
                    break;
                case 4:
                    [fabricacionText setStringValue:[url path]];
                    break;
            }
        } else NSBeep();
        
    }];
}

-(IBAction)okAction:(id)sender
{
    BOOL correctExtension=TRUE;
    if([action isEqual:@"export"])
    {
        correctExtension=[self checkExtension:[ventasText stringValue]];
        if(correctExtension)
            [self writeData:[ventasText stringValue] ofClass:[Ventas alloc] from:ventasArray];
        
        correctExtension=[self checkExtension:[comprasText stringValue]];
        if(correctExtension)
            [self writeData:[comprasText stringValue] ofClass:[Compra alloc] from:comprasArray];
        
        correctExtension=[self checkExtension:[clientesText stringValue]];
        if(correctExtension)
            [self writeData:[clientesText stringValue] ofClass:[Cliente alloc] from:clienteArray];
        
        correctExtension=[self checkExtension:[proveedoresText stringValue]];
        if(correctExtension)
            [self writeData:[proveedoresText stringValue] ofClass:[Proveedores alloc] from:proveedoresArray];
        
        correctExtension=[self checkExtension:[fabricacionText stringValue]];
        if(correctExtension)
        [   self writeData:[fabricacionText stringValue] ofClass:[Fabricacion alloc] from:fabricacionArray];
    }
    else
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        
        [self loadData:[ventasText stringValue] ofClass:[Ventas alloc] into:ventasArray];
        [dict setValue:ventasArray forKey:@"ventasImported"];
        
        [self loadData:[comprasText stringValue] ofClass:[Compra alloc] into:comprasArray];
        [dict setValue:comprasArray forKey:@"comprasImported"];
        
        [self loadData:[clientesText stringValue] ofClass:[Cliente alloc] into:clienteArray];
        [dict setValue:clienteArray forKey:@"clientesImported"];
        
        [self loadData:[proveedoresText stringValue] ofClass:[Proveedores alloc] into:proveedoresArray];
        [dict setValue:proveedoresArray forKey:@"proveedoresImported"];
    
        [self loadData:[fabricacionText stringValue] ofClass:[Fabricacion alloc] into:fabricacionArray];
        [dict setValue:fabricacionArray forKey:@"fabricacionImported"];
        
        NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
        [board postNotificationName:@"ImportedData" object:self userInfo:dict];
    }
    
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}

-(IBAction)cancelAction:(id)sender
{
    [NSApp endSheet:[self window]];
    [[self window] orderOut:sender];
}

-(void)loadData:(NSString *)path ofClass:(id)object into:(NSMutableArray *)container
{
    if([path length]!=0)
    {
        NSError *error=nil;
        
        NSString * fileContents;
        fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (error)
            NSRunAlertPanel(NSLocalizedString(@"Error", @""),NSLocalizedString(@"ErrorImport", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
        else
        {
            NSArray * records = [fileContents componentsSeparatedByString:@"\n"];
            for (NSString * rec in records)
            {
                if ([rec length] == 0)
                    break;
                
                if([object isKindOfClass:[Ventas class]])
                    object = [[Ventas alloc] initWithData:rec];
                if([object isKindOfClass:[Compra class]])
                    object = [[Compra alloc] initWithData:rec];
                if([object isKindOfClass:[Cliente class]])
                    object = [[Cliente alloc] initWithData:rec];
                if([object isKindOfClass:[Proveedores class]])
                    object = [[Proveedores alloc] initWithData:rec];
                if([object isKindOfClass:[Fabricacion class]])
                    object = [[Fabricacion alloc] initWithData:rec];
                
                [container addObject:object];
            }
        }
    }
}

-(void)writeData:(NSString *)path ofClass:(id)object from:(NSMutableArray *)container
{
    if([path length]!=0)
    {
        NSError *error=nil;
        
        NSMutableString * temp = [[NSMutableString alloc] init];
        
        if([object isKindOfClass:[Ventas class]])
            object=[Ventas alloc];
        if([object isKindOfClass:[Compra class]])
            object = [Compra alloc];
        if([object isKindOfClass:[Cliente class]])
            object = [Cliente alloc];
        if([object isKindOfClass:[Proveedores class]])
            object =[Proveedores alloc];
        if([object isKindOfClass:[Fabricacion class]])
            object = [Fabricacion alloc];
        
        for (object in container)
        {
            [temp appendFormat:@"%@\n",[object description]];
            [temp writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&error];
            if (error){
                NSRunAlertPanel(NSLocalizedString(@"Error", @""),NSLocalizedString(@"ErrorExport", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
                break;
            }
        }
    }
}

-(BOOL)checkExtension:(NSString *)text
{
    if([text length]!=0)
    {
        NSArray *parts=[text componentsSeparatedByString:@"/"];
        NSArray *extension=[[parts lastObject] componentsSeparatedByString:@"."];
        
        if([extension count]!=2){
            NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"SaveTxt", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
            return FALSE;
        }
        else if(![[extension lastObject] isEqual:@"txt"]){
            NSRunAlertPanel(NSLocalizedString(@"Information", @""),NSLocalizedString(@"SaveTxt", @""),NSLocalizedString(@"OkButton", @""), nil, nil);
            return FALSE;
        }
        
        return TRUE;
    }
    else
        return FALSE;
}

@end
