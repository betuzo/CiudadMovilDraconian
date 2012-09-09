//
//  LoginController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 07/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import <RestKit/RKJSONParserJSONKit.h>
#import "WebLoad.h"
#import "SyncSingleton.h"

@implementation LoginController
@synthesize txtUsuario = _txtUsuario;
@synthesize txtPassword = _txtPassword;
@synthesize contentView = _contentView;
@synthesize webLoad = _webLoad;

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_txtUsuario setDelegate:self];
	[_txtPassword setDelegate:self];
    _webLoad = [[WebLoad alloc] init];

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
        NSArray *params = [NSArray arrayWithObjects:[_txtUsuario text], [_txtPassword text], nil];
        [_webLoad loadWithResource:RESOURCE_FOR_SECURE andMapping:[[SyncSingleton mappingsRest] valueForKeyPath:RESOURCE_FOR_SECURE] andDelegate:self andParameter:params];
    }
    else
    {
        NSString *message = @"Los campos son obligatorios.";
        UIAlertView *usageAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:message delegate:self cancelButtonTitle:@"Acept" otherButtonTitles:nil];
        [usageAlertView show];   
    }
}

-(IBAction)registerView:(id)sender
{
    RegistroController *registroView = [[RegistroController alloc] initWithNibName:nil bundle:nil];
    [self presentModalViewController:registroView animated:YES];
}


#pragma mark - Touches Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_txtUsuario resignFirstResponder];
	[_txtPassword resignFirstResponder];
}

- (void)modelLoadCompletedWithResponse:(TSResponse *)response
{
    if (response.success){
        [TaxiSiService userLogged:[response.data objectAtIndex:0]];
        principalViewController *viewController = [[principalViewController alloc] initWithNibName:@"principalViewController" bundle:nil];
        [self presentModalViewController:viewController animated:YES];
    }else{
        UIAlertView *usageAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:response.message delegate:self cancelButtonTitle:@"Acept" otherButtonTitles:nil];
        [usageAlertView show];  
    }
        
}

- (void)modelLoadCompletedWithError:(NSError *)error
{
    NSString *message = @"Usuario no valido.";
    UIAlertView *usageAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:message delegate:self cancelButtonTitle:@"Acept" otherButtonTitles:nil];
    [usageAlertView show];   
}

@end
