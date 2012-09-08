//
//  CiudadPinAnotation.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CiudadPinAnotation : NSObject<MKAnnotation>

@property (nonatomic ,assign) CLLocationCoordinate2D coordinate;

@property (nonatomic ,strong) NSString * type;

@property (nonatomic ,strong) NSString * description;

@property (nonatomic ,strong) UIImage * icon;

@end
