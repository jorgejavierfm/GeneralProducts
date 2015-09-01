//
//  Document.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/22/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Almacen.h"

@class VentasSheet;
@class ComprasSheet;
@class ClientesSheet;
@class ProveedorSheet;
@class FabricacionSheet;

@class ExportAndImportSheet;

@interface Document : NSDocument
{
    VentasSheet *ventasSheetController;
    ComprasSheet *comprasSheetController;
    ClientesSheet *clientesSheetController;
    ProveedorSheet *proveedorSheetController;
    FabricacionSheet *fabricacionSheetController;
    
    ExportAndImportSheet *exAndinSheetController;
}

@property (readwrite,copy) Almacen *mainAlmacen;

#pragma mark Array Controllers elements

@property (readwrite,copy) NSMutableArray *ventas;
@property (readwrite,copy) NSMutableArray *compras;
@property (readwrite,copy) NSMutableArray *clientes;
@property (readwrite,copy) NSMutableArray *proveedores;
@property (readwrite,copy) NSMutableArray *fabricacion;

#pragma  mark Array Controllers

@property (strong) IBOutlet NSArrayController *controladorVentas;
@property (strong) IBOutlet NSArrayController *controladorCompras;
@property (strong) IBOutlet NSArrayController *controladorClientes;
@property (strong) IBOutlet NSArrayController *controladorProveedor;
@property (strong) IBOutlet NSArrayController *controladorFabricacion;

#pragma mark Button Actions

-(IBAction)nuevaVenta:(id)sender;
-(IBAction)nuevaCompra:(id)sender;
-(IBAction)nuevoCliente:(id)sender;
-(IBAction)nuevoProveedor:(id)sender;
-(IBAction)nuevaOrdenFabricacion:(id)sender;

#pragma mark Export & Import Actions

-(IBAction)exportData:(id)sender;
-(IBAction)importData:(id)sender;

@end
