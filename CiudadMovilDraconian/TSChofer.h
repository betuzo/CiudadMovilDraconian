//
//  TSChofer.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTaxi.h"
#import "TSTarjeton.h"

@interface TSChofer : NSObject

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) NSString *apellido;
@property (nonatomic, strong) NSString *licencia;
@property (nonatomic, strong) TSTarjeton *tarjeton;
@property (nonatomic, strong) TSTaxi *taxi;

@end
