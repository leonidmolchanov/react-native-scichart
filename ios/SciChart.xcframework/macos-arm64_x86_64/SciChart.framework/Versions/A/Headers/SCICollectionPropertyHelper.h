//******************************************************************************
// SCICHART® Copyright SciChart Ltd. 2011-2020. All rights reserved.
//
// Web: http://www.scichart.com
// Support: support@scichart.com
// Sales:   sales@scichart.com
//
// SCICollectionPropertyHelper.h is part of SCICHART®, High Performance Scientific Charts
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

#import "ISCIPropertyHolder.h"
#import "SCIObservableCollection.h"
#import "SCICollectionChangedEventArgs.h"
#import "ISCIServiceContainer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Abstract base implementation for Collections property helper
 */
@interface SCICollectionPropertyHelper<E> : NSObject

@property (weak, nonatomic) id<ISCIPropertyHolder> propertyHolder;

- (instancetype)initWithPropertyHolder:(id<ISCIPropertyHolder>)propertyHolder propertyId:(int)propertyId;

- (void)onCollectionDrasticallyChanged:(nullable SCIObservableCollection<E> *)oldValue newValue:(nullable SCIObservableCollection<E> *)newValue;

- (void)onCollectionChanged:(SCIObservableCollection<E> *)collection args:(SCICollectionChangedEventArgs<E> *)args;

- (void)attach:(E)item to:(id<ISCIServiceContainer>)services;

- (void)detach:(E)item;

- (void)invalidatePropertyHolder;

@end

NS_ASSUME_NONNULL_END
