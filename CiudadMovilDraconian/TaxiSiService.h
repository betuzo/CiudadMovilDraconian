//
//  TaxiSiService.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSUser.h"

@interface TaxiSiService : NSObject

+ (NSArray *) pasajeros;
+ (NSArray *) taxis;
+ (NSArray *) pasajerosCompartidos;
+ (NSArray *) incidentes;
+ (NSArray *) obras;
+ (NSArray *) sitios;
+ (TSUser *) userLogged;
+ (long) timeForSync;
+ (UIImage *) imageByTypeAnnotetion:(NSString *) type;

+ (void) pasajeros:(NSArray *) newPasajeros;
+ (void) taxis:(NSArray *) newTaxis;
+ (void) pasajerosCompartidos:(NSArray *) newPasajerosCompartidos;
+ (void) incidentes:(NSArray *) newIncidentes;
+ (void) obras:(NSArray *) newObras;
+ (void) sitios:(NSArray *) newSitios;
+ (void) userLogged:(TSUser *) newUserLogged;
+ (void) timeForSync:(long) newTimeForSyn;

@end
