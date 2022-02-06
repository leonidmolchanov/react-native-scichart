//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCIImage.h is part of SCICHART®, High Performance Scientific Charts
// For full terms and conditions of the license, see http://www.scichart.com/scichart-eula/
//
// This source code is protected by international copyright law. Unauthorized
// reproduction, reverse-engineering, or distribution of all or any portion of
// this source code is strictly prohibited.
//
// This source code contains confidential and proprietary trade secrets of
// SciChart Ltd., and should at no time be copied, transferred, sold,
// distributed or made available without express written permission.
//******************************************************************************

#import <TargetConditionals.h>

// -------------------- Imports ----------------------
#if TARGET_OS_OSX
    #import <AppKit/NSImage.h>
    #import <AppKit/NSImageView.h>
    #import "NSImage+UIImage.h"
#elif TARGET_OS_IOS
    #import <UIKit/UIImage.h>
    #import <UIKit/UIImageView.h>
    #import "UIImageView+NSImageView.h"
    #import "UIImage+NSImage.h"
#endif

// -------------------- SCIImage ---------------------
#if TARGET_OS_OSX
    #define SCIImage NSImage
    #define SCIImageView NSImageView
#elif TARGET_OS_IOS
    #define SCIImage UIImage
    #define SCIImageView UIImageView
#endif
