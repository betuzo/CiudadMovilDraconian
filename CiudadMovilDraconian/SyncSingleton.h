//
//  SyncSingleton.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKReachabilityObserver;
@interface SyncSingleton : NSObject
{
    RKReachabilityObserver* _observer;
    NSTimer * syncTimer;
}

@property(nonatomic, readwrite) BOOL isConnected;
@property(nonatomic, readwrite) BOOL isFinish;

- (BOOL) isWebServerReachable;
- (void) initNotification;
- (void) initSync;
- (void) endSync;

+ (void) dictionaryMappingByResource;

+ (SyncSingleton *) getInstance;
+ (NSDictionary *) mappingsRest;

@end
