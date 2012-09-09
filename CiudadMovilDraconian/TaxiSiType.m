//
//  TaxiSiType.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxiSiType.h"

@implementation TaxiSiType

long const CONFIG_SYNC_INTERVAL_WWAN = 40;

long const CONFIG_SYNC_INTERVAL_WIFI = 20;


NSString *const RESOURCE_FOR_SECURE = @"/taxisi-backend/api/usuario/login/";

NSString *const RESOURCE_GET_TAXIS = @"/taxisi-backend/api/taxi/ubicacion/";

NSString *const RESOURCE_GET_PASAJEROS = @"/taxisi-backend/api/pasajero/";

NSString *const RESOURCE_GET_PASAJEROS_COMPARTIDOS = @"/taxisi-backend/api/pasajero/";

NSString *const RESOURCE_GET_INCIDENTES = @"/taxisi-backend/api/incidenteVial/";

NSString *const RESOURCE_GET_ORBRAS = @"/taxisi-backend/api/obras/";

NSString *const RESOURCE_BASE = @"http://localhost:8080";

@end
