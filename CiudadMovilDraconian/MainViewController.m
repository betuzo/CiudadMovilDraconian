//
//  MainViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "TaxiSiViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize generalNavigationController = _generalNavigationController;

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
    TaxiSiViewController *controller = [[TaxiSiViewController alloc]initWithNibName:@"TaxiSiViewController" bundle:nil];
    
    _generalNavigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [_generalNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar"] forBarMetrics:UIBarMetricsDefault];
    
    [_generalNavigationController.view setFrame:self.view.bounds];

    [self.view addSubview:_generalNavigationController.view];
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
