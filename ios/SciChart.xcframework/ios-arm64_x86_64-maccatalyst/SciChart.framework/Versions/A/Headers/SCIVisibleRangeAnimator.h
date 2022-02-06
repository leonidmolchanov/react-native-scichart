//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCIVisibleRangeAnimator.h is part of SCICHART®, High Performance Scientific Charts
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

#import "ISCIVisibleRangeAnimator.h"
#import "SCIVisibleRangeAnimatorListener.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Defines a class with methods for animating Axes VisibleRange.
 */
@interface SCIVisibleRangeAnimator : NSObject<ISCIVisibleRangeAnimator>

/**
 * Creates a new instance of `SCIVisibleRangeAnimator` class.
 * @param animatorListener The `SCIVisibleRangeAnimatorListener` instance used with this animator instance.
 */
- (instancetype)initWithAnimatorListener:(SCIVisibleRangeAnimatorListener *)animatorListener NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
