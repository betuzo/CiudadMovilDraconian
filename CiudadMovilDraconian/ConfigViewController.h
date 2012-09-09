//
//  ConfigViewController.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaxiSiService.h"

@interface ConfigViewController : UIViewController


@property (retain, nonatomic) IBOutlet UILabel *lblNick;
@property (retain, nonatomic) IBOutlet UILabel *lblApellidos;
@property (retain, nonatomic) IBOutlet UILabel *lblNombre;
@property (retain, nonatomic) IBOutlet UILabel *lblEmail;
@property (retain, nonatomic) IBOutlet UILabel *lblPassword;

@end
