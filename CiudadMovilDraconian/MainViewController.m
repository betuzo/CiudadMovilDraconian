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
    
    CGRect rectButton;
    
    rectButton.size.width = 50;
    rectButton.size.height = 40;
    
    rectButton.origin.x = 0;
    rectButton.origin.y = 0;
    
    UIButton *leftButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButtonItem addTarget:self action:@selector(pedirTaxi:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonItem setFrame:rectButton];
    [rightButtonItem setBackgroundImage:[UIImage imageNamed:@"toolbar-pedir-taxi.png"] forState:UIControlStateNormal];
    [leftButtonItem addTarget:self action:@selector(incidentesMap:) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonItem setFrame:rectButton];
    [leftButtonItem setBackgroundImage:[UIImage imageNamed:@"toolbar-incidentes.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButtonItem];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButtonItem];
    
    [self.view addSubview:_generalNavigationController.view];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
}

-(void)pedirTaxi:(id)sender{
    
}

-(void)incidentesMap:(id)sender{
    
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
