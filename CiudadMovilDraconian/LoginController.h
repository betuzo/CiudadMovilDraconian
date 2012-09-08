//
//  LoginController.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 07/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "MainTabViewController.h"

@interface LoginController : UIViewController<RKObjectLoaderDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtUsuario;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIView *contentView;
-(IBAction)presentHomeView:(id)sender;

@end
