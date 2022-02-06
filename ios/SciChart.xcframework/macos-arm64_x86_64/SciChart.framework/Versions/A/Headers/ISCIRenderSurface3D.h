//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// ISCIRenderSurface3D.h is part of SCICHART®, High Performance Scientific Charts
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

#import "ISCIRenderSurfaceBase.h"

@protocol ISCIViewport3D;
@protocol ISCIRenderSurface3DRenderer;

NS_ASSUME_NONNULL_BEGIN

/**
 * Common interface for a RenderSurface 3D.
 */
@protocol ISCIRenderSurface3D <ISCIRenderSurfaceBase>

/**
 * Gets the `ISCIViewport3D` associated with this render surface.
 */
@property (nonatomic, readonly) id<ISCIViewport3D> viewport;

/**
 * Gets or sets the `ISCIRenderSurface3DRenderer` which is used to render content of this `ISCIRenderSurface3D`.
 */
@property (weak, nonatomic, nullable) id<ISCIRenderSurface3DRenderer> renderer;

@end

NS_ASSUME_NONNULL_END