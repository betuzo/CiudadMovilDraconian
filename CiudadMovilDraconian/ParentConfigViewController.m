//
//  ParentConfigViewController.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParentConfigViewController.h"

@interface ParentConfigViewController ()

@end

@implementation ParentConfigViewController

@synthesize configutarionNavigationController = _configutarionNavigationController;

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
    
    ConfigViewController * confController = [[ConfigViewController alloc] initWithNibName:@"ConfigViewController" bundle:nil];
    
    _configutarionNavigationController =[[UINavigationController alloc] initWithRootViewController:confController];
    
    [_configutarionNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation-bar"] forBarMetrics:UIBarMetricsDefault];
     
    [self.view addSubview:_configutarionNavigationController.view];

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
