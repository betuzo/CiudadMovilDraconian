//
//  IdentificarTaxiViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 09/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IdentificarTaxiViewController.h"

@interface IdentificarTaxiViewController ()

@end

@implementation IdentificarTaxiViewController

@synthesize identificaTaxiNavigationController = _identificaTaxiNavigationController;

-(IBAction)identificarTaxi:(id)sender{
    //Falta metodo que envia a identificar placas 
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

@end
