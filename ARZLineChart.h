//
//  ARZCharlLine.h
//
//  Created by Arash Zeinoddini on 10/14/12.
//  Copyright (c) 2012 Arash Zeinoddini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARZLineChart;
@protocol ARZLineChartDelegate <NSObject>

-(void) valueLineChartChangedWith:(NSString *)value;
-(void) widthLineChartChanged:(int)width Height:(int)height;

@end


@interface ARZLineChart: UIView
{
   
    bool dynamicIndicator;
    
    NSMutableArray *drawArray;
    int TOP;
    int LEFT;
    float max;
    CGRect frameM;
    

    //Circle Indicator Center Variable
    int circleIndicatorCenterSize;
    float circleIndicatorCenterRed;
    float circleIndicatorCenterGreen;
    float circleIndicatorCenterBlue;
    float circleIndicatorCenterAlpha;
    
    //Under Graph Variable
    float underGraphRed;
    float underGraphGreen;
    float underGraphBlue;
    float underGraphAlpha;
    
    //Line Graph Variable
    int LineWidth;
    float lineRed;
    float lineGreen;
    float lineBlue;
    float lineAlpha;
    CGFloat initialDistance;

    NSMutableArray *bezierPoints;
    
    UIBezierPath *pathGraph;
    UIBezierPath *pathUnderGraph;
    
    CGContextRef ctx;
    CGFloat lastScale;
    CGFloat scale;
    CGFloat posX1;
    CGFloat posX2;
    CGFloat posXDis;
    
    //Indicator
    int lineIndicatorWidth;
    CGRect lineIndicator;
    CGRect circleIndicatorCenter;
}

@property (strong, nonatomic) UILabel *backgroundValue;
@property (strong, nonatomic) UILabel *numberValue;
@property (nonatomic) bool dynamicIndicator;
@property (nonatomic, weak) id <ARZLineChartDelegate> ARZDelegate;

void MyCGPathApplierFunc (void *info, const CGPathElement *element);
- (void)setLineWidth:(int) width;
- (void)setLineIndicatorWidth:(int) width;
- (void)setLineColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha;
- (float)getYValueFromArray:(NSArray*)a atXValue:(float)x;
- (void)setCircleIndicatorCenterSize:(int) size;
- (void)setUnderGraphColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha;
- (void)setCircleIndicatorCenterColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha;
- (void)setDrawArray:(NSMutableArray *)array;
- (id)initWithFrame:(CGRect)frame andDelegate:(id<ARZLineChartDelegate>)delegateObject;
- (CGFloat)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer;


@end
