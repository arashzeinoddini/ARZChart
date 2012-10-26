//
//  ARZChartContainer.h
//  TestMyChart
//
//  Created by Arash Zeinoddini on 10/24/12.
//  Copyright (c) 2012 Arash Zeinoddini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARZLineChart.h"

@interface ARZChartContainer : UIScrollView <ARZLineChartDelegate>
{
    NSMutableArray *LineChartArray;
    ARZLineChart *chartLine;

}



- (void)setLineChartArray:(NSMutableArray *)array;
- (void)setLineChartWidth:(int)width;
- (void)setLineChartColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha;
- (void)setLineChartIndicatorWidth:(int) width;
- (void)setLineChartCircleIndicatorCenterSize:(int) size;
- (void)setLineChartCircleIndicatorCenterColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha;
- (void)setLineChartUnderGraphColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha;
- (void)setLineChartBackgroundColor:(UIColor *)color;
- (void)setLineChartDynamicIndicatorToShow:(BOOL)show;
- (id)initWithFrame:(CGRect)frame ChartType:(NSString *)chartType;

@end
