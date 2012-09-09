//
//  ConfigViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController

@synthesize lblNick = _lblNick;
@synthesize lblPassword = _lblPassword;
@synthesize lblNombre = _lblNombre;
@synthesize lblApellidos= _lblApellidos;
@synthesize lblEmail = _lblEmail;


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
    
    _lblNick.text = [TaxiSiService userLogged].nickname;
    _lblPassword.text = [TaxiSiService userLogged].password;
    _lblApellidos.text = @"Gomez Quintanilla";
    _lblNombre.text = @"Adan";
    _lblEmail.text = @"small_los@hotmail.com";
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

@end
