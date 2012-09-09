//
//  RegistroController.h
//  CiudadMovilDraconian
//
//  Created by Adan Quintanilla on 08/09/12.
//
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "MainTabViewController.h"

@interface RegistroController : UIViewController<RKObjectLoaderDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtNombre;
@property (strong, nonatomic) IBOutlet UITextField *txtApellidos;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtNick;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIView *contentViewRegister;

-(IBAction)submitRegister:(id)sender;
-(void) moveToTopFields;
-(void) moveToTopOriginFields;
@end
