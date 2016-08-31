//
//  DrawView.m
//  draw
//
//  Created by tianXin on 16/8/31.
//  Copyright © 2016年 tianXin. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置画图相关样式参数
    
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    //设置画笔宽度
    CGContextSetLineWidth(ctx, 2);
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, [UIColor purpleColor].CGColor);
    
    //设置拐点样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    /**
     *  typedef CF_ENUM(int32_t, CGLineJoin) {
         kCGLineJoinMiter,
         kCGLineJoinRound,
         kCGLineJoinBevel
     };
     */
    CGContextSetLineCap(ctx, kCGLineCapRound);
    /**
     *  typedef CF_ENUM(int32_t, CGLineCap) {
         kCGLineCapButt,
         kCGLineCapRound,
         kCGLineCapSquare
     };
     */
    
    //画线
    [self drawLine:ctx];
    
    //画矩形、画椭圆、画多边形
    [self drawSharp:ctx];
    
    //画图片
    [self drawPicture:ctx];
    
    //画文字
    [self drawText:ctx];
    
    [self drawCircle:ctx];
}

//画线
- (void)drawLine:(CGContextRef)ctx{
    //画一条简单的线
    CGPoint points1[] = {CGPointMake(10, 30),CGPointMake(300, 30)};
    CGContextAddLines(ctx, points1, 2);
  
    //画线方法1，使用 CGContextAddLineToPoint(, , );画线，需要先设置一个起始点
    //设置起始点
    CGContextMoveToPoint(ctx, 50, 50);
    //添加一个点
    CGContextAddLineToPoint(ctx, 100, 50);
    //在添加一个点变成一个折线
    CGContextAddLineToPoint(ctx, 150, 100);
    
    //画线方法2
    //构造路径的点数组
    CGPoint points2[] = {CGPointMake(60, 60),CGPointMake(80, 120),CGPointMake(20, 300)};
    CGContextAddLines(ctx, points2, 3);
    
    //利用路径去画一组点（推荐使用路径的方法，逻辑清晰）
    //第一个路径
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, &CGAffineTransformIdentity, 0, 200);
    //CGAffineTransformIdentity 类似于初始化一些参数
    CGPathMoveToPoint(path1, &CGAffineTransformIdentity, 100, 250);
    CGPathMoveToPoint(path1, &CGAffineTransformIdentity, 310, 210);
    
    //给路径1添加context
    CGContextAddPath(ctx, path1);
    //描出笔触
    CGContextStrokePath(ctx);
}

//画矩形、画椭圆、画多边形
- (void)drawSharp:(CGContextRef)ctx{
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    //画椭圆如果长宽相等就是圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 150, 100, 150));
    
    //画矩形，长宽相等就是正方形
    CGContextAddRect(ctx, CGRectMake(70, 400, 100, 50));
    
    //画多边形，多边形就是通过path完成的
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 120, 250);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 200, 250);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 180, 300);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 100, 300);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    //填充
    CGContextFillPath(ctx);
}

//画图片
- (void)drawPicture:(CGContextRef)ctx{
   //图片
    UIImage *image = [UIImage imageNamed:@"dog.jpg"];
    [image drawInRect:CGRectMake(200, 400, 100, 100)];
}

//画文字
-(void)drawText:(CGContextRef)ctx{
 //文字样式
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *dict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor yellowColor]};
    [@"画文字" drawInRect:CGRectMake(20, 450, 100, 20) withAttributes:dict];
}

//画圆、圆弧
-(void)drawCircle:(CGContextRef)ctx{
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
    
    /* 绘制路径 方法一
     void CGContextAddArc (
     CGContextRef c,
     CGFloat x,             //圆心的x坐标
     CGFloat y,    //圆心的x坐标
     CGFloat radius,   //圆的半径
     CGFloat startAngle,    //开始弧度
     CGFloat endAngle,   //结束弧度
     int clockwise          //0表示顺时针，1表示逆时针
     );
     */
    
    //圆
    CGContextAddArc (ctx, 100, 100, 50, 0, M_PI* 2 , 0);
    CGContextStrokePath(ctx);
    
    //半圆
    CGContextAddArc (ctx, 100, 200, 50, 0, M_PI*2, 0);
    CGContextStrokePath(ctx);
    
    //绘制路径 方法二，这方法适合绘制弧度 ，端点p1和p2是弧线的控制点，类似photeshop中钢笔工具控制曲线，还不明白请去了解贝塞尔曲线
    //    void CGContextAddArcToPoint(
    //                                CGContextRef c,
    //                                CGFloat x1,  //端点1的x坐标
    //                                CGFloat y1,  //端点1的y坐标
    //                                CGFloat x2,  //端点2的x坐标
    //                                CGFloat y2,  //端点2的y坐标
    //                                CGFloat radius //半径
    //                                )；
    
    //1/4弧度 * 4
    CGContextMoveToPoint(ctx, 200, 200);
    CGContextAddArcToPoint(ctx, 200, 100,300, 100, 100);
    CGContextAddArcToPoint(ctx, 400, 100,400, 200, 100);
    CGContextAddArcToPoint(ctx, 400, 300,300, 300, 100);
    CGContextAddArcToPoint(ctx, 200, 300,200, 200, 100);
    CGContextStrokePath(ctx);
    
    //贝塞尔曲线
    CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
    
    //三次曲线函数
    //void CGContextAddCurveToPoint (
    //                               CGContextRef c,
    //                               CGFloat cp1x, //控制点1 x坐标
    //                               CGFloat cp1y, //控制点1 y坐标
    //                               CGFloat cp2x, //控制点2 x坐标
    //                               CGFloat cp2y, //控制点2 y坐标
    //                               CGFloat x,  //直线的终点 x坐标
    //                               CGFloat y  //直线的终点 y坐标
    //                               );
    
    CGContextMoveToPoint(ctx, 200, 200);
    CGContextAddCurveToPoint(ctx, 200, 0, 300, 200, 400, 100);
    CGContextStrokePath(ctx);
    
    //三次曲线可以画圆弧，比如这里画一条之前用CGContextAddArcToPoint构成的圆弧
    CGContextMoveToPoint(ctx, 200, 200);
    CGContextAddCurveToPoint(ctx, 200, 100, 300, 100, 300 ,100);
    CGContextStrokePath(ctx);
    //二次曲线函数
    //void CGContextAddQuadCurveToPoint (
    //                                   CGContextRef c,
    //                                   CGFloat cpx,  //控制点 x坐标
    //                                   CGFloat cpy,  //控制点 y坐标
    //                                   CGFloat x,  //直线的终点 x坐标
    //                                   CGFloat y  //直线的终点 y坐标
    //                                   );
    
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddQuadCurveToPoint(ctx, 200, 0, 300, 150);
    CGContextStrokePath(ctx);
    
}

@end
