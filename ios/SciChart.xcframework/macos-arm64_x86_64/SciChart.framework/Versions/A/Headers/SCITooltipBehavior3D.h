//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCITooltipBehavior3D.h is part of SCICHART®, High Performance Scientific Charts
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

#import "SCITooltipBehaviorBase3D.h"
#import "ISCISeriesTooltipCallback.h"
#import "ISCITooltipContainer.h"
#import "SCITooltipPosition.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Provides a tooltip behavior for `ISCIChartModifier3D` implementors.
 * @note `T` is the type of modifier to which this behavior will be attached.
 */
@interface SCITooltipBehavior3D<T : id<ISCIChartModifier3D>>: SCITooltipBehaviorBase3D<T><ISCISeriesTooltipCallback>

/**
 * Creates a new instance of `SCITooltipBehavior3D` class.
 * @param modifierType The type of the associated `ISCIChartModifier3D`.
 * @param tooltipContainer The tooltip container.
 */
- (instancetype)initWithModifierType:(Class)modifierType tooltipContainer:(id<ISCITooltipContainer>)tooltipContainer;

/**
 * Defines the position of the tooltip related to the current touch point.
 */
@property (nonatomic) SCITooltipPosition tooltipPosition;

@end

NS_ASSUME_NONNULL_END
