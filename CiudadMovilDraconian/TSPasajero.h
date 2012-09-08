//
//  TSPasajero.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSPasajero : NSObject

@property (nonatomic, strong) UIImage *type;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *apellido;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;

@end
