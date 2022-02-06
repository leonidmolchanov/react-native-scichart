//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCILegendModifier+Protected.h is part of SCICHART®, High Performance Scientific Charts
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

#import "SCILegendModifier.h"
#import "ISCIRenderableSeries.h"

/**
 * The extensions in this header are to be used only by subclasses of `SCILegendModifier`.
 */
@interface SCILegendModifier ()

/**
 * When overridden in derived classes, should provide array of series which will be used as legend data source
 * @return Array of series for the legend data source.
 */
- (nonnull NSArray<id<ISCIRenderableSeries>> *)provideSeriesForLegend;

/**
 * When overridden in derived classes, indicates whether the series should be inspected in order to get seriesInfo
 * @param series The renderable series to check
 * @return True if renderable series is valid
 */
- (BOOL)isSeriesValid:(nonnull id<ISCIRenderableSeries>)series;

@end
