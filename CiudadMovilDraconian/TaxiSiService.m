//
//  TaxiSiService.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxiSiService.h"

@implementation TaxiSiService

static NSArray * pasajeros = nil;
static NSArray * taxis = nil;
static NSArray * pasajerosCompartidos = nil;
static NSArray * incidentes = nil;
static NSArray * obras = nil;
static NSArray * sitios = nil;
static long timeForSync = 20;

static TSUser * userLogged = nil;

+ (NSArray *) pasajeros
{
    return pasajeros;
}
+ (NSArray *) taxis
{
    return taxis;
}
+ (NSArray *) pasajerosCompartidos
{
    return pasajerosCompartidos;
}
+ (NSArray *) incidentes
{
    return incidentes;
}
+ (NSArray *) obras
{
    return obras;
}
+ (NSArray *) sitios
{
    return sitios;
}
+ (TSUser *) userLogged
{
    return userLogged;
}
+ (long) timeForSync
{
    return timeForSync;
}


+ (void) pasajero:(NSArray *) newPasajeros
{
    pasajeros = newPasajeros;
}
+ (void) taxis:(NSArray *) newTaxis
{
    taxis = newTaxis;
}
+ (void) pasajerosCompartidos:(NSArray *) newPasajerosCompartidos
{
    pasajerosCompartidos = newPasajerosCompartidos;
}
+ (void) incidentes:(NSArray *) newIncidentes
{
    incidentes = newIncidentes;
}   
+ (void) obras:(NSArray *) newObras
{
    obras = newObras;
}
+ (void) sitios:(NSArray *) newSitios
{
    sitios = newSitios;
}
+ (void) userLogged:(TSUser *)newUserLogged
{
    userLogged = newUserLogged;
}
+ (void) timeForSync:(long) newTimeForSyn
{
    timeForSync = newTimeForSyn;
}

@end