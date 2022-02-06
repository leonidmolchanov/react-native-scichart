//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCIPieChartTooltipBehavior.h is part of SCICHART®, High Performance Scientific Charts
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

#import "SCIPieChartTooltipBehaviorBase.h"
#import "ISCIPieChartModifier.h"
#import "ISCISeriesTooltipCallback.h"
#import "ISCITooltipContainer.h"
#import "SCITooltipPosition.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Provides a tooltip behavior for `ISCIPieChartModifier` implementors.
 * @note <T> The modifier to which this behavior will be attached.
 */
@interface SCIPieChartTooltipBehavior<T : id<ISCIPieChartModifier>> : SCIPieChartTooltipBehaviorBase<T><ISCISeriesTooltipCallback>

/**
 * Defines the position of the tooltip related to the current touch point.
 */
@property (nonatomic) SCITooltipPosition tooltipPosition;

/// :nodoc:
- (instancetype)initWithModifierType:(Class)modifierType NS_UNAVAILABLE;

/**
 * Creates a new instance of `SCIPieTooltipBehavior` class.
 * @param modifierType The type of the associated `ISCIPieChartModifier`.
 * @param tooltipContainer The tooltip container.
 */
- (instancetype)initWithModifierType:(Class)modifierType tooltipContainer:(id<ISCITooltipContainer>)tooltipContainer NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
