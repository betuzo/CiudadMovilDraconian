//
//  WebLoad.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebLoad.h"
#import "TSResponse.h"
#import <RestKit/RKJSONParserJSONKit.h>

@implementation WebLoad

@synthesize delegate = _delegate;

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
<<<<<<< HEAD
    TSRequest *peticion = [objects objectAtIndex:0];
    
    NSString *info = [NSString stringWithFormat:
                      @"peticion %c\n"
                      @"Total Productos %u\n",
                      [peticion success] ,
                      [[peticion data] count]
                      ];
    
    NSLog(@"Loaded statuses: %@", info);
=======
    TSResponse *respuesta = [objects objectAtIndex:0];
    [_delegate modelLoadCompletedWithResponse:respuesta];
>>>>>>> 89f92bb0118b83fe4040ee5b780533b624bd54b9
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [_delegate modelLoadCompletedWithError:error];
}

- (void) loadWithResource: (NSString *) resource andMapping: (RKObjectMapping *) mapping andDelegate: (id) newDelegate andParameter: (NSArray *) parameteres
{
    _delegate = newDelegate;
    NSLog(@"timeout %f", [[[RKObjectManager sharedManager] client] timeoutInterval]);
    
    [[[RKObjectManager sharedManager] client] setTimeoutInterval:800];
    [[RKObjectManager sharedManager] setSerializationMIMEType:RKMIMETypeJSON];
    /*[[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];*/
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
      
    objectManager.client.baseURL = [RKURL URLWithString:RESOURCE_BASE];
    
    NSString *resourceComplete = resource;
    
    for (id element in parameteres) {
        resourceComplete = [NSString stringWithFormat:@"%@%@/", resourceComplete, element];
    } 
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:mapping forKeyPath:resourceComplete];
    
    [objectManager loadObjectsAtResourcePath:resourceComplete delegate:self];
}

@end