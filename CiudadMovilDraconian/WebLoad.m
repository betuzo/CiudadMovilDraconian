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
@synthesize resourceComplete = _resourceComplete;

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    [[RKObjectManager sharedManager].mappingProvider removeObjectMappingForKeyPath:_resourceComplete];
    TSResponse *respuesta = [objects objectAtIndex:0];
    [_delegate modelLoadCompletedWithResponse:respuesta];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    [[RKObjectManager sharedManager].mappingProvider removeObjectMappingForKeyPath:_resourceComplete];
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
    
    NSString *resourceWithParams = resource;
    
    for (id element in parameteres) {
        resourceWithParams = [NSString stringWithFormat:@"%@%@/", resourceWithParams, element];
    } 
    _resourceComplete = resourceWithParams;
    
    [[RKObjectManager sharedManager].mappingProvider objectMappingForKeyPath:resourceWithParams];
    
    [[RKObjectManager sharedManager].mappingProvider setObjectMapping:mapping forKeyPath:resourceWithParams];
        
    [objectManager loadObjectsAtResourcePath:resourceWithParams delegate:self];
}

@end
