//
//  Document.m
//  GeneralProducts
//
//  Created by iTMiNus on 12/22/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import "Document.h"
#import "VentasSheet.h"
#import "ComprasSheet.h"
#import "ClientesSheet.h"
#import "ProveedorSheet.h"
#import "FabricacionSheet.h"

#import "ExportAndImportSheet.h"

@implementation Document

@synthesize mainAlmacen;
@synthesize ventas,compras,clientes,proveedores,fabricacion;
@synthesize controladorVentas,controladorCompras,controladorClientes,controladorProveedor,controladorFabricacion;

- (id)init
{
    self = [super init];
    if (self)
    {
        mainAlmacen=[[Almacen alloc] init];
        
        ventas=[[NSMutableArray alloc] init];
        compras=[[NSMutableArray alloc]init];
        clientes=[[NSMutableArray alloc] init];
        proveedores=[[NSMutableArray alloc]init];
        fabricacion=[[NSMutableArray alloc]init];
        
        NSNotificationCenter *board=[NSNotificationCenter defaultCenter];
        [board addObserver:self selector:@selector(addNewSell:) name:@"NuevaVenta" object:nil];
        [board addObserver:self selector:@selector(addNewBuy:) name:@"NuevaCompra" object:nil];
        [board addObserver:self selector:@selector(addNewClient:) name:@"NuevoCliente" object:nil];
        [board addObserver:self selector:@selector(addNewProveedor:) name:@"NuevoProveedor" object:nil];
        [board addObserver:self selector:@selector(addNewFabricationOrder:) name:@"NuevaOrdenFabricacion" object:nil];
        
        [board addObserver:self selector:@selector(updateExistingData:) name:@"ImportedData" object:nil];
        
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (BOOL)windowShouldClose:(id)sender
{
    [NSApp terminate:self];
    return YES;
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

#pragma mark Persistencia

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    NSMutableData *database=[NSMutableData data];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:database];
    [archiver encodeObject:mainAlmacen forKey:@"almacen"];
    [archiver encodeObject:ventas forKey:@"ventas"];
    [archiver encodeObject:compras forKey:@"compras"];
    [archiver encodeObject:clientes forKey:@"clientes"];
    [archiver encodeObject:proveedores forKey:@"proveedores"];
    [archiver encodeObject:fabricacion forKey:@"fabricacion"];
    [archiver finishEncoding];
    
    return database;
}
- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    NSKeyedUnarchiver *desarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    mainAlmacen=[desarchiver decodeObjectForKey:@"almacen"];
    ventas=[desarchiver decodeObjectForKey:@"ventas"];
    compras=[desarchiver decodeObjectForKey:@"compras"];
    clientes=[desarchiver decodeObjectForKey:@"clientes"];
    proveedores=[desarchiver decodeObjectForKey:@"proveedores"];
    fabricacion=[desarchiver decodeObjectForKey:@"fabricacion"];
    
    return YES;
}

#pragma mark Sheets Loaders

-(IBAction)nuevaVenta:(id)sender
{
    ventasSheetController=[[VentasSheet alloc]initWithClientesLogs:clientes andAlmacen:mainAlmacen];
    
    [NSApp beginSheet: [ventasSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}
-(IBAction)nuevaCompra:(id)sender
{
    comprasSheetController=[[ComprasSheet alloc]initWithProveedoresLogs:proveedores andAlmacen:mainAlmacen];
    
    [NSApp beginSheet: [comprasSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}
-(IBAction)nuevoCliente:(id)sender
{
    clientesSheetController=[[ClientesSheet alloc] initWithDataToCheck:clientes];

    [NSApp beginSheet: [clientesSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}
-(IBAction)nuevoProveedor:(id)sender
{
    proveedorSheetController=[[ProveedorSheet alloc] initWithDataToCheck:proveedores];
    
    [NSApp beginSheet: [proveedorSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}
-(IBAction)nuevaOrdenFabricacion:(id)sender
{
    fabricacionSheetController=[[FabricacionSheet alloc] initWithDataToCheck:mainAlmacen];
    
    [NSApp beginSheet: [fabricacionSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}

#pragma mark Notification Handlers

-(void)addNewSell:(NSNotification *)aNotification
{
    Ventas *newVenta;
    NSDictionary *dict=[aNotification userInfo];
    
    newVenta=[dict valueForKey:@"venta"];
    [controladorVentas addObject:newVenta];
}
-(void)addNewBuy:(NSNotification *)aNotification
{
    Compra *newCompra;
    NSDictionary *dict=[aNotification userInfo];
    
    newCompra=[dict valueForKey:@"compra"];
    [controladorCompras addObject:newCompra];
}
-(void)addNewClient:(NSNotification *)aNotification
{
    Cliente *newClient;
    NSDictionary *dict=[aNotification userInfo];
    
    newClient=[dict valueForKey:@"cliente"];
    [controladorClientes addObject:newClient];
}
-(void)addNewProveedor:(NSNotification *)aNotification
{
    Proveedores *newProveedor;
    NSDictionary *dict=[aNotification userInfo];
    
    newProveedor=[dict valueForKey:@"proveedor"];
    [controladorProveedor addObject:newProveedor];
}
-(void)addNewFabricationOrder:(NSNotification *)aNotification
{
    Fabricacion *newFabricationOrder;
    NSDictionary *dict=[aNotification userInfo];
    
    newFabricationOrder=[dict valueForKey:@"ordenFabricacion"];
    [mainAlmacen setToneladasMaderaDisponible:[[newFabricationOrder fabricacionAlmacen] toneladasMaderaDisponible]];
    [mainAlmacen setPalesDisponibles:[[newFabricationOrder fabricacionAlmacen] palesDisponibles]];
    
    [controladorFabricacion addObject:newFabricationOrder];
}

#pragma mark Export & Import

-(IBAction)exportData:(id)sender
{
    exAndinSheetController=[[ExportAndImportSheet alloc] initForExportVentas:ventas Compras:compras Clientes:clientes Proveedores:proveedores Fabricacion:fabricacion];
    
    [NSApp beginSheet: [exAndinSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}

-(IBAction)importData:(id)sender
{
    exAndinSheetController=[[ExportAndImportSheet alloc] initForImport];
    
    [NSApp beginSheet: [exAndinSheetController window]
       modalForWindow: [NSApp mainWindow]
        modalDelegate: self
       didEndSelector: nil
          contextInfo: nil];
}

-(void)updateExistingData:(NSNotification *)aNotification
{
    NSArray *temp=nil;
    NSDictionary *dict=[aNotification userInfo];
    
    temp=[dict valueForKey:@"ventasImported"];
    if(temp!=nil){
        [controladorVentas addObjects:temp];
        temp=nil;
    }
    temp=[dict valueForKey:@"comprasImported"];
    if(temp!=nil){
        [controladorCompras addObjects:temp];
        temp=nil;
    }
    temp=[dict valueForKey:@"clientesImported"];
    if(temp!=nil){
        [controladorClientes addObjects:temp];
        temp=nil;
    }
    temp=[dict valueForKey:@"proveedoresImported"];
    if(temp!=nil){
        [controladorProveedor addObjects:temp];
        temp=nil;
    }
    temp=[dict valueForKey:@"fabricacionImported"];
    if(temp!=nil){
        [controladorFabricacion addObjects:temp];
        temp=nil;
    }
}

@end







