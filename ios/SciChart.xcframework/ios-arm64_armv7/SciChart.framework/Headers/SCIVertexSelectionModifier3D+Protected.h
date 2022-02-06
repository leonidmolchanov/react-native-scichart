//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCIVertexSelectionModifier3D+Protected.h is part of SCICHART®, High Performance Scientific Charts
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

#import "SCIVertexSelectionModifier3D.h"
#import "SCIGestureModifierBase3D+Protected.h"
#import "SCIHitTestInfo3D.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The extensions in this header are to be used only by subclasses of `SCIVertexSelectionModifier3D`.
 */
@interface SCIVertexSelectionModifier3D (Protected)

/**
 * Try to perform point selection at specified coordinates.
 * @param point The coordinates of point to hit test.
 */
- (void)trySelectPointAt:(CGPoint)point;

/**
 * Deselects all selected `ISCIRenderableSeries3D` instance  except passed in `renderableSeries`.
 * @param renderableSeries The `ISCIRenderableSeries3D` which should remain selected.
 */
- (void)deselectAllBut:(id<ISCIRenderableSeries3D>)renderableSeries withVertexId:(unsigned int)vertexId;

/**
 * Deselects all selected `ISCIRenderableSeries3D` instances.
 */
- (void)deselectAll;

@end

NS_ASSUME_NONNULL_END
