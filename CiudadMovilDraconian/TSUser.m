//
//  TSUser.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TSUser.h"

@implementation TSUser

@synthesize id = _id;
@synthesize type = _type;
@synthesize nickname = _nickname;
@synthesize password = _password;
@synthesize role = _role;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize compartir = _compartir;
@synthesize verIncidentes = _verIncidentes;
@synthesize verComprtidos = _verComprtidos;

- (NSString *) description
{
    return _nickname;
}

@end
