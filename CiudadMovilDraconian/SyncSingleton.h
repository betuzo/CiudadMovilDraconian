//
//  SyncSingleton.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebLoad.h"
#import "TaxiSiViewController.h"

@class RKReachabilityObserver;
@interface SyncSingleton : NSObject<WebDelegate>
{
    RKReachabilityObserver* _observer;
    NSTimer * syncTimer;
}

@property(nonatomic, readwrite) BOOL isConnected;
@property(nonatomic, readwrite) BOOL isFinish;

@property(nonatomic) int iContSync;

@property(nonatomic, strong) WebLoad * webLoadTaxis;
@property(nonatomic, strong) WebLoad * webLoadSitios;
@property(nonatomic, strong) WebLoad * webLoadPasajeros;
@property(nonatomic, strong) WebLoad * webLoadPasajerosCompartidos;
@property(nonatomic, strong) WebLoad * webLoadIncidencias;
@property(nonatomic, strong) WebLoad * webLoadObras;
@property(nonatomic, strong) TaxiSiViewController * taxiSi;

- (BOOL) isWebServerReachable;
- (void) initNotification;
- (void) initSync;
- (void) endSync;

+ (void) dictionaryMappingByResource;

+ (SyncSingleton *) getInstance;
+ (NSDictionary *) mappingsRest;

@end
