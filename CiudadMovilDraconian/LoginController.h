//
//  LoginController.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 07/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "principalViewController.h"
#import "RegistroController.h"
#import "WebDelegate.h"
#import "WebLoad.h"

@interface LoginController : UIViewController<UITextFieldDelegate, WebDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtUsuario;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) WebLoad * webLoad;

-(IBAction)presentHomeView:(id)sender;
-(IBAction)registerView:(id)sender;

@end
