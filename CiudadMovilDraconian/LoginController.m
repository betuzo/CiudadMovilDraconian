//
//  LoginController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 07/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import <RestKit/RKJSONParserJSONKit.h>

@interface Producto : NSObject {
    NSString *_productId;
    NSString *_name;
    NSString *_description;
    NSString *_category;
    NSString *_subcategory;
    NSString *_info;
    NSData *_picture;
}

@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *subcategory;
@property (nonatomic, retain) NSString *info;
@property (nonatomic, retain) NSData *picture;

@end

@implementation Producto

@synthesize productId = _productId;
@synthesize name = _name;
@synthesize description = _description;
@synthesize category = _category;
@synthesize subcategory = _subcategory;
@synthesize info = _info;
@synthesize picture = _picture;

@end

@interface Catalog : NSObject {
    NSString *_idt;
    NSArray *_products;
}

@property (nonatomic, retain) NSString *idt;
@property (nonatomic, retain) NSArray *products;

@end

@implementation Catalog

@synthesize idt = _idt;
@synthesize products = _products;

@end

@interface PriceList : NSObject {
    NSString *_xmlns;
    NSArray *_catalogs;
}

@property (nonatomic, retain) NSString *xmlns;
@property (nonatomic, retain) NSArray *catalogs;

@end

@implementation PriceList

@synthesize xmlns = _xmlns;
@synthesize catalogs = _catalogs;

@end

@interface PeticionCatalogo : NSObject {
    PriceList *_priceList;
}

@property (nonatomic, retain) PriceList *priceList;

@end

@implementation PeticionCatalogo

@synthesize priceList = _priceList;

@end

@implementation LoginController
@synthesize txtUsuario = _txtUsuario;
@synthesize txtPassword = _txtPassword;
@synthesize contentView = _contentView;

- (void)loadTimeline
{
    // Load the object model via RestKit
    /*RKObjectMapping *productoMapping = [RKObjectMapping mappingForClass:[Producto class]];
    [productoMapping mapKeyPath:@"ProductId" toAttribute:@"productId"];
    [productoMapping mapKeyPath:@"name" toAttribute:@"name"];
    [productoMapping mapKeyPath:@"description" toAttribute:@"description"];
    [productoMapping mapKeyPath:@"category" toAttribute:@"category"];
    [productoMapping mapKeyPath:@"subcategory" toAttribute:@"subcategory"];
    [productoMapping mapKeyPath:@"Info" toAttribute:@"info"];
    [productoMapping mapKeyPath:@"Picture" toAttribute:@"picture"];
    
    RKObjectMapping *catalogMapping = [RKObjectMapping mappingForClass:[Catalog class]];
    [catalogMapping mapKeyPath:@"id" toAttribute:@"idt"];
    [catalogMapping mapRelationship:@"products" withMapping:productoMapping];
    
    RKObjectMapping *priceListMapping = [RKObjectMapping mappingForClass:[PriceList class]];
    [priceListMapping mapKeyPath:@"xmlns" toAttribute:@"xmlns"];
    [priceListMapping mapRelationship:@"catalogs" withMapping:catalogMapping];
    
    RKObjectMapping *peticionCatalogoMapping = [RKObjectMapping mappingForClass:[PeticionCatalogo class]];
    [peticionCatalogoMapping mapRelationship:@"priceList" withMapping:priceListMapping];
    
    NSLog(@"timeout %f", [[[RKObjectManager sharedManager] client] timeoutInterval]);
    
    [[[RKObjectManager sharedManager] client] setTimeoutInterval:800];
    [[RKObjectManager sharedManager] setSerializationMIMEType:RKMIMETypeJSON];
    [[RKParserRegistry 
      sharedRegistry] setParserClass:[RKJSONParserJSONKit class] 
     forMIMEType:@"text/html"];

    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    objectManager.client.baseURL = [RKURL URLWithString:@"http://localhost:8080"];
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:peticionCatalogoMapping forKeyPath:@"/json-iPad/shoppingCart/getCatalogProduct"];
    [objectManager loadObjectsAtResourcePath:@"/json-iPad/shoppingCart/getCatalogProduct" delegate:self];*/
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    PeticionCatalogo *peticion = [objects objectAtIndex:0];
    
    NSString *info = [NSString stringWithFormat:
                      @"peticion %@\n"
                      @"Total Productos %@\n",
                      [peticion priceList] ,
                      [[peticion priceList] catalogs]
                      ];
    
    for (Catalog *catl in [[peticion priceList] catalogs]) {
        NSLog(@"total productos: %d",[[catl products] count]);
    }
    NSLog(@"Loaded statuses: %@", info);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    NSLog(@"Hit error: %@", error);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTimeline];
    [_txtUsuario setDelegate:self];
	[_txtPassword setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTxtUsuario:nil];
    [self setTxtPassword:nil];
    [self setContentView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - View lifecycle
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == _txtUsuario ) {
		[_txtPassword becomeFirstResponder];
	}
	else if (textField == _txtPassword){
		[_txtPassword resignFirstResponder];
	}
	return NO;
}


-(IBAction)presentHomeView:(id)sender
{
    if (![[_txtUsuario text] isEqual:@""]
        && ![[_txtPassword text] isEqual:@""])
    {
        MainTabViewController *mainViewController = [[MainTabViewController alloc] initWithNibName:@"MainTabViewController" bundle:nil];
        [self presentModalViewController:mainViewController animated:YES];
    }
    else
    {
        NSString *message = @"Id user and password, please";
        UIAlertView *usageAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:message delegate:self cancelButtonTitle:@"Acept" otherButtonTitles:nil];
        [usageAlertView show];   
    }

}


#pragma mark - Touches Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_txtUsuario resignFirstResponder];
	[_txtPassword resignFirstResponder];
}

@end
