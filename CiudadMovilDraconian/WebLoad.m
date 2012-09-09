//
//  WebLoad.m
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebLoad.h"
#import "TSRequest.h"

@implementation WebLoad

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    TSRequest *peticion = [objects objectAtIndex:0];
    
    NSString *info = [NSString stringWithFormat:
                      @"peticion %c\n"
                      @"Total Productos %u\n",
                      [peticion success] ,
                      [[peticion data] count]
                      ];
    
    NSLog(@"Loaded statuses: %@", info);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    NSLog(@"Hit error: %@", error);
}

@end
