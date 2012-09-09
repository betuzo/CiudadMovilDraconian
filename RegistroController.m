//
//  RegistroController.m
//  CiudadMovilDraconian
//
//  Created by Adan Quintanilla on 08/09/12.
//
//

#import "RegistroController.h"
#import <RestKit/RKJSONParserJSONKit.h>

@interface RegistroController ()

@end

@implementation RegistroController

@synthesize txtNombre = _nombre;
@synthesize txtApellidos = _apellidos;
@synthesize txtEmail = _email;
@synthesize txtNick = _nick;
@synthesize txtPassword = _password;
@synthesize contentViewRegister = _contentviewRegister;

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == _nombre ) {
		[_apellidos becomeFirstResponder];
	}
    else if(textField == _apellidos){
        [_email becomeFirstResponder];
    }
    else if(textField == _email){
        [_nick becomeFirstResponder];
    }
    else if(textField == _nick){
        [_password resignFirstResponder];
    }
    
	return NO;
}

#pragma mark - Touches Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_nombre resignFirstResponder];
	[_apellidos resignFirstResponder];
    [_email resignFirstResponder];
    [_nick resignFirstResponder];
    [_password resignFirstResponder];
    
    
}

-(IBAction)submitRegister:(id)sender{
    if (![[_nombre text] isEqual:@""] && ![[_apellidos text] isEqual:@""] && ![[_email text] isEqual:@""] && ![[_nick text] isEqual:@""] && ![[_password text] isEqual:@""])
    {
        principalViewController *mainViewController = [[principalViewController alloc] initWithNibName:@"principalViewController" bundle:nil];
        [self presentModalViewController:mainViewController animated:YES];
    }
    else
    {
        NSString *message = @"Los campos son obligatorios.";
        UIAlertView *usageAlertView = [[UIAlertView alloc] initWithTitle:@"Registro" message:message delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [usageAlertView show];
    }
}

-(IBAction)backLogin:(id)sender{
    LoginController *login = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    [self presentModalViewController:login animated:YES];

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    NSLog(@"Hit error: %@", error);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) moveToTopFields
{
    [UIView animateWithDuration:1.5
        delay:0.05
        options: UIViewAnimationOptionCurveLinear
        animations:^{
            [_contentviewRegister setFrame:CGRectMake(111,10, _contentviewRegister.bounds.size.width, _contentviewRegister.bounds.size.height)];
        }
        completion:^(BOOL finished){
    }];
}

-(void) moveToTopOriginFields
{
    [UIView animateWithDuration:1.5
        delay:0.05
        options: UIViewAnimationOptionCurveLinear
        animations:^{
        [_contentviewRegister setFrame:CGRectMake(111,10, _contentviewRegister.bounds.size.width,_contentviewRegister.bounds.size.height)];
        }
        completion:^(BOOL finished){
    }];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(IBAction)editingEnded:(id)sender
{
    [sender resignFirstResponder];
}



@end
