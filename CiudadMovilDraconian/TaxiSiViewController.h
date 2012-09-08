//
//  TaxiSiViewController.h
//  CiudadMovilDraconian
//
//  Created by Mobiik on 08/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CiudadPinAnotation.h"

@interface TaxiSiViewController : UIViewController <MKMapViewDelegate, MKAnnotation>
{
	IBOutlet MKMapView *ciudadMapView;
}

@property (nonatomic , strong) IBOutlet MKMapView *ciudadMapView;

-(void)showUserLocation;

@end
