//
//  MainTabViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

@synthesize mainTabBarController = _mainTabBarController;

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
    UIViewController *viewController1 = [[ParentTaxiSiViewController alloc] initWithNibName:@"ParentTaxiSiViewController" bundle:nil];
    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@"Taxi Si"
                                                       image:[UIImage imageNamed:@"destacados-on"] tag:1];
    [viewController1 setTabBarItem:tab1];
    
	UIViewController *viewController2 = [[ParentMiViajeViewController alloc] initWithNibName:@"ParentMiViajeViewController" bundle:nil];     
    UITabBarItem *tab2 = [[UITabBarItem alloc] initWithTitle:@"Mi Viaje"
                                                       image:[UIImage imageNamed:@"productos-on"] tag:2];
    [viewController2 setTabBarItem:tab2];      
    
	UIViewController *viewController3 = [[ParentConfigViewController alloc] initWithNibName:@"ParentConfigViewController" bundle:nil];
    UITabBarItem *tab3 = [[UITabBarItem alloc] initWithTitle:@"Configurar"
                                                       image:[UIImage imageNamed:@"tiendas-on"] tag:3];
    [viewController3 setTabBarItem:tab3];  
    
	
	_mainTabBarController = [[UITabBarController alloc] init];
    
	_mainTabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3,nil];
 	[_mainTabBarController.view setFrame:self.view.bounds];
	
	[self.view addSubview:_mainTabBarController.view];
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
