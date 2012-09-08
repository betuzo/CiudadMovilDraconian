//
//  TaxiSiType.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxiSiType : NSObject

// Varibles de configuracion generales

extern long const CONFIG_SYNC_INTERVAL_WWAN; // Intervalos para Sync 3G

extern long const CONFIG_SYNC_INTERVAL_WIFI; // Intervalos para Sync WIFI



extern NSString *const RESOURCE_FOR_SECURE; // Servicio Rest para Seguridad

extern NSString *const RESOURCE_GET_TAXIS; // Servicio Rest para obtener Taxis

extern NSString *const RESOURCE_GET_PASAJEROS; // Servicio Rest para obtener Pasajeros

extern NSString *const RESOURCE_GET_PASAJEROS_COMPARTIDOS; // Servicio Rest para obtener Pasajeros Compartidos

extern NSString *const RESOURCE_GET_INCIDENTES; // Servicio Rest para obtener Incidentes

extern NSString *const RESOURCE_GET_ORBRAS; // Servicio Rest para obtener Ordenes

extern NSString *const RESOURCE_BASE; // Servicio Rest para obtener Ordenes

@end
