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
#import "TSRequest.h"
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

- (void) initSync
{
    _isFinish = YES;
    [syncTimer fire];
}

- (void) endSync
{
    _isFinish = NO;
    [syncTimer invalidate];
}

- (void) dictionaryMappingByResource
{
    NSDictionary * dicByMapping = [[NSDictionary alloc] init];
    TSRequest * peticion = [[TSRequest alloc] init];
    
    [dicByMapping setValue:peticion forKey:RESOURCE_FOR_SECURE];
}


@end
