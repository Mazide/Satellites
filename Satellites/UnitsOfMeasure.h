//
//  UnitsOfMeasure.h
//  Satellites
//
//  Created by Nikita Demidov on 14/03/14.
//  Copyright (c) 2014 HORIS. All rights reserved.
//

#ifndef Satellites_UnitsOfMeasure_h
#define Satellites_UnitsOfMeasure_h

/*
 *  Elevation values are measured in degrees 0..90 (0 stands for the horizon, 90 fot the zenith)
 */
typedef double Elevation;

/*
 *  Azimuth values are measured in degrees 0..359 (clockwise counting from North)
 */
typedef double Azimuth;

struct SphericalCoord {
    Elevation elevation;
    Azimuth azimuth;
};
typedef struct SphericalCoord SphericalCoordSystem;

/*
 *  SNR values are measured in dB 0..99 (SNR_IS_EMPTY (-1) when not tracking)
 *
 */
typedef double SNR;

/*
 * Geometric Dilution of Precision (DOP)
 * values are measured in degrees 1.0..9.9
 */

typedef double DOP;

#endif
