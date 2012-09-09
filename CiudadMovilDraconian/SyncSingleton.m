//
//  SyncSingleton.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyncSingleton.h"
#import <RestKit/RestKit.h>
#import "TaxiSiService.h"
#import "TSResponse.h"
#import "TSUser.h"
#import "TSTaxi.h"
#import "TSTarjeton.h"
#import "TSChofer.h"
#import "TSIncidente.h"
#import "TSObra.h"
#import "TSSitio.h"
#import "TSPasajero.h"

@implementation SyncSingleton

@synthesize isConnected = _isConnected;
@synthesize isFinish = _isFinish;
@synthesize webLoadTaxis = _webLoadTaxis;
@synthesize webLoadSitios = _webLoadSitios;
@synthesize webLoadPasajeros = _webLoadPasajeros;
@synthesize webLoadPasajerosCompartidos = _webLoadPasajerosCompartidos;
@synthesize webLoadIncidencias = _webLoadIncidencias;
@synthesize webLoadObras = _webLoadObras;
@synthesize iContSync = _iContSync;
@synthesize taxiSi = _taxiSi;

static SyncSingleton *instanciaHelper = nil;

static NSMutableDictionary * mappingsRest = nil;

+ (SyncSingleton*)getInstance
{
    @synchronized([SyncSingleton class])
    {
        if (!instanciaHelper) {
            instanciaHelper = [[self alloc] init];
            [instanciaHelper initNotification];
        }
        return instanciaHelper;
    }
    return nil;
}

- (void) initNotification
{
    syncTimer = [NSTimer scheduledTimerWithTimeInterval:[TaxiSiService timeForSync] target:self selector:@selector(syncGeneral) userInfo:nil repeats:YES];

    _webLoadTaxis = [[WebLoad alloc] init];
    _webLoadPasajeros = [[WebLoad alloc] init];
    _webLoadPasajerosCompartidos = [[WebLoad alloc] init];
    _webLoadIncidencias = [[WebLoad alloc] init];
    _webLoadObras = [[WebLoad alloc] init];
    _webLoadSitios = [[WebLoad alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:RKReachabilityDidChangeNotification
                                               object:_observer];
    
    if([self isWebServerReachable])
        self.isConnected = YES;
    else 
        self.isConnected = NO;
    
}

- (void) syncGeneral
{
    if (_isFinish == YES || _iContSync == 0) {
        if ([[TaxiSiService userLogged].role isEqualToString:@"USUARIO"]){
            NSArray *params = [NSArray arrayWithObjects:
                            [[NSNumber alloc] initWithDouble:[TaxiSiService userLogged].latitude], 
                            [[NSNumber alloc] initWithDouble:[TaxiSiService userLogged].longitude],
                            nil];
            [_webLoadTaxis loadWithResource:RESOURCE_GET_TAXIS andMapping:[[SyncSingleton mappingsRest] valueForKeyPath:RESOURCE_GET_TAXIS] andDelegate:self andParameter:params];
            _iContSync = _iContSync + 1;
            
            params = [NSArray arrayWithObjects:
                               [[NSNumber alloc] initWithDouble:[TaxiSiService userLogged].latitude], 
                               [[NSNumber alloc] initWithDouble:[TaxiSiService userLogged].longitude],
                               nil];
            [_webLoadSitios loadWithResource:RESOURCE_GET_SITIOS andMapping:[[SyncSingleton mappingsRest] valueForKeyPath:RESOURCE_GET_SITIOS] andDelegate:self andParameter:params];
            _iContSync = _iContSync + 1;
        }
        if ([[TaxiSiService userLogged].role isEqualToString:@"CHOFER"]){
            NSArray *params = [NSArray arrayWithObjects:
                               [[NSNumber alloc] initWithDouble:[TaxiSiService userLogged].latitude], 
                               [[NSNumber alloc] initWithDouble:[TaxiSiService userLogged].longitude],
                               nil];
            [_webLoadTaxis loadWithResource:RESOURCE_GET_PASAJEROS andMapping:[[SyncSingleton mappingsRest] valueForKeyPath:RESOURCE_GET_PASAJEROS] andDelegate:self andParameter:params];
            _iContSync = _iContSync + 1;
        }
    }
}

- (void)reachabilityChanged:(NSNotification*)notification {
    RKReachabilityObserver* observer = (RKReachabilityObserver*)[notification object];
    
    if ([observer isNetworkReachable]) {
        if ([observer isConnectionRequired]) {
            NSLog(@"Connection is available...");
            self.isConnected = NO;
            return;
        }
        self.isConnected = YES;
        if (RKReachabilityReachableViaWiFi == [observer networkStatus]) {
            [TaxiSiService timeForSync:CONFIG_SYNC_INTERVAL_WIFI];
            NSLog(@"Online via WiFi");
        } else if (RKReachabilityReachableViaWWAN == [observer networkStatus]) {
            [TaxiSiService timeForSync:CONFIG_SYNC_INTERVAL_WWAN];
            NSLog(@"Online via 3G o Edge");
        }
    } else {
        NSLog(@"No hay red!!!");
        self.isConnected = NO;
    }
}

- (BOOL)isWebServerReachable {
	
	Boolean isWebServerReachable;    
	
	const char * hostName = [@"www.google.com" UTF8String];
	
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, hostName);
	SCNetworkReachabilityFlags reachabilityFlags;
	
	isWebServerReachable = SCNetworkReachabilityGetFlags(reachability, &reachabilityFlags);
	isWebServerReachable = isWebServerReachable && (reachabilityFlags & kSCNetworkFlagsReachable) && !(reachabilityFlags & kSCNetworkFlagsConnectionRequired);
	CFRelease(reachability);
	
	return isWebServerReachable;
}

- (void) endSync
{
    [syncTimer invalidate];
    _isFinish = NO;
}

- (void) initSync
{
    [syncTimer fire];
    _isFinish = YES;
}

+ (void) dictionaryMappingByResource
{    
    mappingsRest = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    RKObjectMapping *objetoMapping = [RKObjectMapping mappingForClass:[TSUser class]];
    [objetoMapping mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMapping mapKeyPath:@"nick" toAttribute:@"nickname"];
    [objetoMapping mapKeyPath:@"password" toAttribute:@"password"];
    [objetoMapping mapKeyPath:@"role" toAttribute:@"role"];
     
    RKObjectMapping *respuesta = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuesta mapKeyPath:@"success" toAttribute:@"success"];
    [respuesta mapKeyPath:@"message" toAttribute:@"message"];
    [respuesta mapRelationship:@"data" withMapping:objetoMapping];

    [mappingsRest setValue:respuesta forKey:RESOURCE_FOR_SECURE];
    
    RKObjectMapping *objetoMappingTaxi = [RKObjectMapping mappingForClass:[TSTaxi class]];
    [objetoMappingTaxi mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMappingTaxi mapKeyPath:@"latitude" toAttribute:@"latitude"];
    [objetoMappingTaxi mapKeyPath:@"longitude" toAttribute:@"longitude"];
    [objetoMappingTaxi mapKeyPath:@"placas" toAttribute:@"placas"];
    [objetoMappingTaxi mapKeyPath:@"vehiculo" toAttribute:@"vehiculo"];
    [objetoMappingTaxi mapKeyPath:@"tipo" toAttribute:@"tipo"];

    RKObjectMapping *respuestaTaxi = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuestaTaxi mapKeyPath:@"success" toAttribute:@"success"];
    [respuestaTaxi mapKeyPath:@"message" toAttribute:@"message"];
    [respuestaTaxi mapRelationship:@"data" withMapping:objetoMappingTaxi];
    
    [mappingsRest setValue:respuestaTaxi forKey:RESOURCE_GET_TAXIS];
    
    RKObjectMapping *objetoMappingSitio = [RKObjectMapping mappingForClass:[TSSitio class]];
    [objetoMappingSitio mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMappingSitio mapKeyPath:@"latitude" toAttribute:@"latitude"];
    [objetoMappingSitio mapKeyPath:@"longitude" toAttribute:@"longitude"];
    [objetoMappingSitio mapKeyPath:@"nombre" toAttribute:@"nombre"];
    [objetoMappingSitio mapKeyPath:@"telefono" toAttribute:@"telefono"];
    
    RKObjectMapping *respuestaSitio = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuestaSitio mapKeyPath:@"success" toAttribute:@"success"];
    [respuestaSitio mapKeyPath:@"message" toAttribute:@"message"];
    [respuestaSitio mapRelationship:@"data" withMapping:objetoMappingSitio];
    
    [mappingsRest setValue:respuestaSitio forKey:RESOURCE_GET_SITIOS];
    
    objetoMapping = [RKObjectMapping mappingForClass:[TSPasajero class]];
    [objetoMapping mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMapping mapKeyPath:@"nick" toAttribute:@"nickname"];
    [objetoMapping mapKeyPath:@"password" toAttribute:@"password"];
    [objetoMapping mapKeyPath:@"role" toAttribute:@"role"];
    
    respuesta = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuesta mapKeyPath:@"success" toAttribute:@"success"];
    [respuesta mapKeyPath:@"message" toAttribute:@"message"];
    [respuesta mapRelationship:@"data" withMapping:objetoMapping];
    
    [mappingsRest setValue:respuesta forKey:RESOURCE_GET_PASAJEROS];
    
    objetoMapping = [RKObjectMapping mappingForClass:[TSPasajero class]];
    [objetoMapping mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMapping mapKeyPath:@"nick" toAttribute:@"nickname"];
    [objetoMapping mapKeyPath:@"password" toAttribute:@"password"];
    [objetoMapping mapKeyPath:@"role" toAttribute:@"role"];
    
    respuesta = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuesta mapKeyPath:@"success" toAttribute:@"success"];
    [respuesta mapKeyPath:@"message" toAttribute:@"message"];
    [respuesta mapRelationship:@"data" withMapping:objetoMapping];
    
    [mappingsRest setValue:respuesta forKey:RESOURCE_GET_PASAJEROS_COMPARTIDOS];
    
    objetoMapping = [RKObjectMapping mappingForClass:[TSIncidente class]];
    [objetoMapping mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMapping mapKeyPath:@"nick" toAttribute:@"nickname"];
    [objetoMapping mapKeyPath:@"password" toAttribute:@"password"];
    [objetoMapping mapKeyPath:@"role" toAttribute:@"role"];
    
    respuesta = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuesta mapKeyPath:@"success" toAttribute:@"success"];
    [respuesta mapKeyPath:@"message" toAttribute:@"message"];
    [respuesta mapRelationship:@"data" withMapping:objetoMapping];
    
    [mappingsRest setValue:respuesta forKey:RESOURCE_GET_INCIDENTES];
    
    objetoMapping = [RKObjectMapping mappingForClass:[TSObra class]];
    [objetoMapping mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMapping mapKeyPath:@"nick" toAttribute:@"nickname"];
    [objetoMapping mapKeyPath:@"password" toAttribute:@"password"];
    [objetoMapping mapKeyPath:@"role" toAttribute:@"role"];
    
    respuesta = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuesta mapKeyPath:@"success" toAttribute:@"success"];
    [respuesta mapKeyPath:@"message" toAttribute:@"message"];
    [respuesta mapRelationship:@"data" withMapping:objetoMapping];
    
    [mappingsRest setValue:respuesta forKey:RESOURCE_GET_ORBRAS];
}

+ (NSDictionary *) mappingsRest
{
    return mappingsRest;
}

- (void)modelLoadCompletedWithResponse:(TSResponse *)response
{
    _iContSync = _iContSync - 1;
    if ([response data]!=nil &&[[response data] count]>0) {
        id element = [[response data] objectAtIndex:0];
        NSLog(@"%@", element);
        if ([element isKindOfClass:[TSTaxi class]]){
            [TaxiSiService taxis:[response data]];
            [_taxiSi addAnnotationTaxis];
        }
        if ([element isKindOfClass:[TSSitio class]]){
            [TaxiSiService sitios:[response data]];
            [_taxiSi addAnnotationSitios];
        }
        if ([element isKindOfClass:[TSPasajero class]]) 
            [TaxiSiService pasajerosCompartidos:[response data]];
        if ([element isKindOfClass:[TSPasajero class]]) 
            [TaxiSiService pasajeros:[response data]];
        if ([element isKindOfClass:[TSIncidente class]]) 
            [TaxiSiService incidentes:[response data]];
        if ([element isKindOfClass:[TSObra class]]) 
            [TaxiSiService obras:[response data]];
    }
}

- (void)modelLoadCompletedWithError:(NSError *)error
{
    _iContSync = _iContSync - 1;
}

@end
