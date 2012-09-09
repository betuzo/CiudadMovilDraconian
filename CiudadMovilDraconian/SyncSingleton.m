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
    
    _isFinish = YES;
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
    
    objetoMapping = [RKObjectMapping mappingForClass:[TSTaxi class]];
    [objetoMapping mapKeyPath:@"id" toAttribute:@"id"];
    [objetoMapping mapKeyPath:@"nick" toAttribute:@"nickname"];
    [objetoMapping mapKeyPath:@"password" toAttribute:@"password"];
    [objetoMapping mapKeyPath:@"role" toAttribute:@"role"];
    
    respuesta = [RKObjectMapping mappingForClass:[TSResponse class]];
    [respuesta mapKeyPath:@"success" toAttribute:@"success"];
    [respuesta mapKeyPath:@"message" toAttribute:@"message"];
    [respuesta mapRelationship:@"data" withMapping:objetoMapping];
    
    [mappingsRest setValue:respuesta forKey:RESOURCE_GET_TAXIS];
    
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


@end
