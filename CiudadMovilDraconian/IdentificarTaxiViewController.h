//
//  IdentificarTaxiViewController.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 09/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerfilTaxiViewController.h"

@interface IdentificarTaxiViewController : UIViewController

@property (nonatomic,strong) UINavigationController *identificaTaxiNavigationController;

@property (strong, nonatomic) IBOutlet UITextField *txtPlacas;
@property (strong, nonatomic) IBOutlet UITextField *txtTarjeton;

-(IBAction)perfilTaxi:(id)sender;

@end
