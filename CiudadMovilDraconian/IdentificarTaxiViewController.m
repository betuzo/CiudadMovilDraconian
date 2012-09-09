//
//  IdentificarTaxiViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 09/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IdentificarTaxiViewController.h"
#import "TaxiSiViewController.h"
#import "ConfigViewController.h"

@interface IdentificarTaxiViewController ()

@end

@implementation IdentificarTaxiViewController

@synthesize identificaTaxiNavigationController = _identificaTaxiNavigationController;

-(IBAction)perfilTaxi:(id)sender{
    PerfilTaxiViewController *perfilTaxi = [[PerfilTaxiViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:perfilTaxi animated:YES];
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
    CGRect rectButton;
    
    rectButton.size.width = 40;
    rectButton.size.height = 40;
    
    rectButton.origin.x = 0;
    rectButton.origin.y = 0;
    
    UIButton *leftButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButtonItem addTarget:self action:@selector(irPedirTaxi:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonItem setFrame:rectButton];
    [rightButtonItem setBackgroundImage:[UIImage imageNamed:@"toolbar-pedir-taxi"] forState:UIControlStateNormal];
    
    [leftButtonItem addTarget:self action:@selector(irConfiguracion:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonItem setFrame:rectButton];
    [leftButtonItem setBackgroundImage:[UIImage imageNamed:@"toolbar-config"] forState:UIControlStateNormal];
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButtonItem];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButtonItem];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    // Do any additional setup after loading the view from its nib.
}

-(void)irConfiguracion:(id)sender
{
    ConfigViewController *configController = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:nil];
    [self.navigationController pushViewController:configController animated:YES];
}

-(void)irPedirTaxi:(id)sender
{
    TaxiSiViewController *taxiSiController = [[TaxiSiViewController alloc] initWithNibName:@"TaxiSiViewController" bundle:nil];
    [self.navigationController pushViewController:taxiSiController animated:YES];    
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
