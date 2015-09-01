//
//  ExportAndImportSheet.h
//  GeneralProducts
//
//  Created by iTMiNus on 12/31/12.
//  Copyright (c) 2012 iTMiNus. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Ventas.h"
#import "Compra.h"
#import "Cliente.h"
#import "Proveedores.h"
#import "Fabricacion.h"

@interface ExportAndImportSheet : NSWindowController
{
    NSString *action;
    
    NSMutableArray *ventasArray;
    NSMutableArray *comprasArray;
    NSMutableArray *clienteArray;
    NSMutableArray *proveedoresArray;
    NSMutableArray *fabricacionArray;
    
    IBOutlet NSTextField *ventasText;
    IBOutlet NSTextField *comprasText;
    IBOutlet NSTextField *clientesText;
    IBOutlet NSTextField *proveedoresText;
    IBOutlet NSTextField *fabricacionText;
}

- (id)initForImport;
-(id)initForExportVentas:(NSMutableArray *)ventas
                 Compras:(NSMutableArray *)compras
                 Clientes:(NSMutableArray *)clientes
             Proveedores:(NSMutableArray *)proveedores
             Fabricacion:(NSMutableArray *)fabricacion;

-(IBAction)browseAction:(id)sender;
-(IBAction)okAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(void)loadData:(NSString *)path ofClass:(id)object into:(NSMutableArray *)container;
-(void)writeData:(NSString *)path ofClass:(id)object from:(NSMutableArray *)container;
-(BOOL)checkExtension:(NSString *)text;

@end
