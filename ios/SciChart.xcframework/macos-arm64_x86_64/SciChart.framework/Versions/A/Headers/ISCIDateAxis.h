//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// ISCIDateAxis.h is part of SCICHART®, High Performance Scientific Charts
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

#import "ISCIAxisCore.h"

/**
 * Defines a base interface for all date axes used throughout the SciChart SDK.
 */
@protocol ISCIDateAxis <ISCIAxisCore>

/**
 * Gets or sets the Text Formatting String used for Axis Tick Labels when the range of the axis is sub-day.
 */
@property (strong, nonatomic, nonnull) NSString *subDayTextFormatting;

@end