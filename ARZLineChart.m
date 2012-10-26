//
//  ARZCharlLine.m
//
//  Created by Arash Zeinoddini on 10/14/12.
//  Copyright (c) 2012 Arash Zeinoddini. All rights reserved.
//

#import "ARZLineChart.h"

@interface ARZLineChart ()

- (void)getYAxisValue:(CGPoint)pos;
- (void)checkNilParameters;

@end

@implementation ARZLineChart
@synthesize backgroundValue;
@synthesize numberValue;
@synthesize dynamicIndicator;

- (id)initWithFrame:(CGRect)frame andDelegate:(id<ARZLineChartDelegate>)delegateObject
{
    self = [super initWithFrame:frame];
    frameM=frame;
    if (self) {
        
        UIPinchGestureRecognizer *pinch   =  [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(twoFingerPinch:)];
        pinch.delegate    =   (id)self;
        [self addGestureRecognizer:pinch];
        
        self.multipleTouchEnabled=true;
        
        backgroundValue=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0 )];
        backgroundValue.backgroundColor=[UIColor blackColor];
        backgroundValue.alpha=0.5;
        backgroundValue.hidden=true;
        [self addSubview:backgroundValue];

        numberValue=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0 )];
        numberValue.backgroundColor=[UIColor clearColor];
        numberValue.hidden=true;
        numberValue.textColor=[UIColor whiteColor];
        [self addSubview:numberValue];

        self.ARZDelegate = delegateObject;
        self.opaque=YES;
        
        [self setNeedsDisplay];
        
        }
    return self;
}
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"Pinch scale: %f", recognizer.scale);
    
    dynamicIndicator=false;
    
	if([recognizer state] == UIGestureRecognizerStateEnded) {
        
        [self setNeedsDisplay];
		return;
        
	}
    
    if ([recognizer scale]<1) {

        if (self.bounds.size.width>=frameM.size.width) {
            
            self.frame= CGRectMake(0, 0, self.bounds.size.width-([recognizer scale]*7),  self.bounds.size.height-([recognizer scale]*7));
            [[self ARZDelegate] widthLineChartChanged:self.bounds.size.width-([recognizer scale]*7) Height:self.bounds.size.height-([recognizer scale]*7)];
            
        }
        
    }
    else {

        self.frame= CGRectMake(0,0, self.bounds.size.width+([recognizer scale]*2), self.bounds.size.height+([recognizer scale]*2));
        [[self ARZDelegate] widthLineChartChanged:self.bounds.size.width+([recognizer scale]*2) Height:self.bounds.size.height+([recognizer scale]*2)];

    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
    
    [self checkNilParameters];
    
    ctx = UIGraphicsGetCurrentContext();
    max=[[drawArray valueForKeyPath:@"@max.self"] floatValue];
    
    TOP=1;
    LEFT=1;
    
    pathGraph=[UIBezierPath bezierPath];
    pathUnderGraph = [UIBezierPath bezierPath];
    
    [pathUnderGraph setLineWidth:1];
    [pathGraph setLineWidth:LineWidth];
    
    [pathUnderGraph moveToPoint:CGPointMake(0,self.frame.size.height)];
    [pathGraph moveToPoint:CGPointMake(((0*(self.bounds.size.width/drawArray.count))+LEFT), (self.bounds.size.height+TOP-([[drawArray objectAtIndex:0] floatValue]*self.bounds.size.height+TOP)/max))];

    for(int i=0;i<drawArray.count;i++)
    {
        
        [pathUnderGraph addLineToPoint:CGPointMake((((i*(self.bounds.size.width/drawArray.count))+LEFT))+posXDis, self.bounds.size.height+TOP-([[drawArray objectAtIndex:i] floatValue]*self.bounds.size.height+TOP)/max)];
        
        [pathGraph addLineToPoint:CGPointMake(((i*(self.bounds.size.width/drawArray.count))+LEFT), (self.bounds.size.height+TOP-([[drawArray objectAtIndex:i] floatValue]*self.bounds.size.height+TOP)/max))];
        
    }
    
    [pathUnderGraph addLineToPoint:CGPointMake((((drawArray.count-1)*(self.bounds.size.width/drawArray.count))+LEFT),self.bounds.size.height)];
    [pathUnderGraph closePath];
   
    [[UIColor colorWithRed:underGraphRed green:underGraphGreen blue:underGraphBlue alpha:underGraphAlpha] set];
    
    [pathUnderGraph fill];
    [[UIColor colorWithRed:lineRed green:lineGreen blue:lineBlue alpha:lineAlpha] set];
    [pathGraph stroke];
    
   
    
    if (drawArray.count<self.bounds.size.width) {
        
        for(int i=0;i<drawArray.count;i++)
        {
            
            CGContextSetRGBFillColor(ctx, (float)222/255, (float)150/255, (float)64/255, 0.9);
            CGContextFillEllipseInRect(ctx, CGRectMake(((i*(self.bounds.size.width/drawArray.count))+LEFT-2.5),(self.bounds.size.height+TOP-([[drawArray objectAtIndex:i] floatValue]*self.bounds.size.height+TOP)/max)-2.5 , 5, 5));
            
        }
    }
    
	CGContextSetRGBFillColor(ctx, 1.0, 0, 0, 1.0);
    CGContextFillRect(ctx,lineIndicator);
    CGContextSetRGBFillColor(ctx, circleIndicatorCenterRed, circleIndicatorCenterGreen, circleIndicatorCenterBlue, circleIndicatorCenterAlpha);
	CGContextFillEllipseInRect(ctx, circleIndicatorCenter);

    CGPathRef pathRef=pathGraph.CGPath;;
    bezierPoints = [NSMutableArray array];
    CGPathApply(pathRef, (__bridge void *)(bezierPoints), MyCGPathApplierFunc);
    
}

void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type) {
        case kCGPathElementMoveToPoint:
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint:
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: 
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: 
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: 
            break;
    }
}

- (float)getYValueFromArray:(NSArray*)a atXValue:(float)x
{
    NSValue *v1, *v2;
    float x1, x2, y1, y2;
    
    for(int i=0; i<([a count]-1); i++)
    {
        v1 = [a objectAtIndex:i];
        v2 = [a objectAtIndex:i+1];
        
        if(x==[v1 CGPointValue].x) return [v1 CGPointValue].y;
        if(x==[v2 CGPointValue].x) return [v2 CGPointValue].y;
        
        if((x>[v1 CGPointValue].x) && (x<[v2 CGPointValue].x))
        {
            x1 = [v1 CGPointValue].x;
            x2 = [v2 CGPointValue].x;
            y1 = [v1 CGPointValue].y;
            y2 = [v2 CGPointValue].y;
            return (x-x1)/(x2-x1)*(y2-y1) + y1;
        }
    }
    
    return -1;
}

- (void)setLineWidth:(int) width{
    
    LineWidth=width;
    [self setNeedsDisplay];
    
}


- (void)setCircleIndicatorCenterSize:(int) size{
    
    circleIndicatorCenterSize=size;
    [self setNeedsDisplay];
    
}

- (void)setLineColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha{
    
    lineRed=red;
    lineGreen=green;
    lineBlue=blue;
    lineAlpha=alpha;
    [self setNeedsDisplay];
    
}



- (void)setCircleIndicatorCenterColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha{
    
    circleIndicatorCenterRed=red;
    circleIndicatorCenterGreen=green;
    circleIndicatorCenterBlue=blue;
    circleIndicatorCenterAlpha=alpha;
    [self setNeedsDisplay];
    
}

- (void)setUnderGraphColor:(float)red Green:(float) green Blue:(float) blue Alpha:(float) alpha{
    
    underGraphRed=red;
    underGraphGreen=green;
    underGraphBlue=blue;
    underGraphAlpha=alpha;
    [self setNeedsDisplay];
    
}

- (void)setDrawArray:(NSMutableArray *)array{
    
    drawArray=array;
    [self setNeedsDisplay];
    
}




- (CGFloat)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    float x = toPoint.x - fromPoint.x;
    float y = toPoint.y - fromPoint.y;
    
    return sqrt(x * x + y * y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    if (dynamicIndicator) {
        [self getYAxisValue:pos];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    
    if (self.frame.size.width==frameM.size.width) {
        dynamicIndicator=true;
    }
    
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    if (dynamicIndicator) {
        [self getYAxisValue:pos];
    }

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    initialDistance = 0;

    
    backgroundValue.hidden=true;
    numberValue.hidden=true;
    lineIndicator=CGRectMake(0, 0, 0,0);
    circleIndicatorCenter=CGRectMake(0, 0, 0, 0);
    [self setNeedsDisplay];
    
}

- (void)setLineIndicatorWidth:(int) width{
    
    lineIndicatorWidth=width;
    [self setNeedsDisplay];
}

- (void)checkNilParameters{
    
    if (LineWidth==0) {
        LineWidth=2;
    }
    
    if (lineIndicatorWidth==0) {
        lineIndicatorWidth=2;
    }
    if (scale<1) {
        scale=1;
    }
    if (scale==0) {
    scale=1;
    }
    
}

#pragma mark -
#pragma mark Private Methods
- (void)getYAxisValue:(CGPoint)pos{
    
    float y = [self getYValueFromArray:bezierPoints atXValue:pos.x];
    
    if (y>0) {
        float yReal= -((float)((max * (y -(self.bounds.size.height+TOP))+TOP)/self.bounds.size.height));
        NSLog(@"Y value at X=%.2f is %.2f",pos.x, yReal);
        
        
        [[self ARZDelegate] valueLineChartChangedWith:[NSString stringWithFormat:@"%.2f",yReal]];
        circleIndicatorCenter=CGRectMake(pos.x-((float)circleIndicatorCenterSize/2), y-((float)circleIndicatorCenterSize/2), circleIndicatorCenterSize, circleIndicatorCenterSize);
        lineIndicator=CGRectMake(pos.x, 0, lineIndicatorWidth, self.bounds.size.height);
        
        if (lineIndicator.origin.x+backgroundValue.frame.size.width>=self.bounds.size.width) {
         
            numberValue.frame= CGRectMake(self.bounds.size.width-numberValue.bounds.size.width-5, self.bounds.size.height-40, [[NSString stringWithFormat:@"%.2f",yReal] length]*10, 30);
            numberValue.hidden=false;
            numberValue.text=[NSString stringWithFormat:@"%.2f",yReal];
            backgroundValue.frame= CGRectMake(self.bounds.size.width-backgroundValue.bounds.size.width, self.bounds.size.height-40, numberValue.frame.size.width+15, 30);
            backgroundValue.hidden=false;
            
        }
        else
        {
        
            numberValue.frame= CGRectMake(pos.x+10, self.bounds.size.height-40, [[NSString stringWithFormat:@"%.2f",yReal] length]*10, 30);
            numberValue.hidden=false;
            numberValue.text=[NSString stringWithFormat:@"%.2f",yReal];
            backgroundValue.frame= CGRectMake(pos.x, self.bounds.size.height-40, numberValue.frame.size.width+15, 30);
            backgroundValue.hidden=false;
               
        }
    
        [self setNeedsDisplay];
      
    }

}



@end
