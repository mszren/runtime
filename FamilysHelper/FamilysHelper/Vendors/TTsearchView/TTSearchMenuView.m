//
//  HouseSearchMenuView.m
//  BeruiHouse
//
//  Created by Ting on 16/4/26.
//  Copyright © 2016年 wangyueyun. All rights reserved.
//

#import "TTSearchMenuView.h"
#import "UIView+Size.h"

@interface TTSearchMenuView ()

@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, strong) UIColor *indicatorColor;      // 三角指示器颜色
@property (nonatomic, strong) UIColor *textColor;           // 文字title颜色
@property (nonatomic, strong) UIColor *textSelectedColor;   // 文字title选中颜色
@property (nonatomic, strong) UIColor *separatorColor;      // 分割线颜色
@property (nonatomic, assign) NSInteger fontSize;           // 字体大小

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;  // 当前选中列

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) float contentViewHeight;

@end

@implementation TTSearchMenuView

- (instancetype)initWithOrigin:(CGPoint)origin height:(CGFloat)height{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _origin = origin;
        // _currentSelectedMenudIndex = -1;
        _show = NO;
        //设置标题的大小
        _fontSize = 14;
        _separatorColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
        _textColor = [UIColor darkGrayColor];
        _textSelectedColor = [UIColor colorWithRed:255/255.0 green:185/255.0 blue:80/255.0 alpha:1];
        _indicatorColor = [UIColor colorWithHex:0xaaaaaa];
        
        UIView *bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, screenSize.width, 0.5)];
        bottomShadow.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1];
        [self addSubview:bottomShadow];
        
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, screenSize.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        _numOfMenu = [self numberOfColumnsInMenu];
        CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
        CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
        CGFloat bgLayerInterval = self.frame.size.width / _numOfMenu;
        
        NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            //bgLayer
            CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, self.frame.size.height/2);
            CALayer *bgLayer = [self createBgLayerWithColor:[UIColor whiteColor] andPosition:bgLayerPosition];
            [self.layer addSublayer:bgLayer];
            [tempBgLayers addObject:bgLayer];
            //title
            CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
            
            NSString *titleString;
            
            titleString = [self titleForColumns:i];
            
            CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.textColor andPosition:titlePosition];
            [self.layer addSublayer:title];
            [tempTitles addObject:title];
            //indicator
            CAShapeLayer *indicator = [self createIndicatorWithColor:self.indicatorColor andPosition:CGPointMake((i + 1)*separatorLineInterval - 20, self.frame.size.height / 2)];
            [self.layer addSublayer:indicator];
            [tempIndicators addObject:indicator];
            
            //separator
            if (i != _numOfMenu - 1) {
                CGPoint separatorPosition = CGPointMake(ceilf((i + 1) * separatorLineInterval-1), self.frame.size.height / 2);
                CAShapeLayer *separator = [self createSeparatorLineWithColor:self.separatorColor andPosition:separatorPosition];
                [self.layer addSublayer:separator];
            }
        }
        
        _indicators = [tempIndicators copy];
        _titles     = [tempTitles copy];
        

        
    }
    return self;
}

//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    
//    
//}

#pragma mark - public method

- (void)reloadData{
    _numOfMenu = [self numberOfColumnsInMenu];
    for (int i = 0; i < _numOfMenu; i++) {
        CATextLayer *title = (CATextLayer *)_titles[i];
        title.string = [self titleForColumns:i];
    }
}

-(void)setString:(NSString *)titleStr
         atIndex:(NSInteger)index{
    
    CATextLayer *title = (CATextLayer *)_titles[index];
    title.string = titleStr;
}

- (void)dismiss{
    [self backgroundTapped:nil];
    
}

#pragma mark - gesture handle

- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    //先全部复位
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
        }
    }
    
    //收起
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView contentView:_contentView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
        }];
    } else {
        
        [self.contentView removeFromSuperview];
        
        //展开
        if ([self respondsToSelector:@selector(viewForColumns:)]) {
            
            self.contentView = [self viewForColumns:tapIndex];
            self.contentView.left = self.origin.x;
            self.contentView.top = self.frame.origin.y + self.frame.size.height;
        }
        
        _currentSelectedMenudIndex = tapIndex;
        self.contentViewHeight = self.contentView.height;
        
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView contentView:_contentView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
    }
}

#pragma mark - animation method

//背景
- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView contentView:_contentView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background contentView:(UIView *)contentView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    //第一次层三角形指示器先动
    [self animateIndicator:indicator Forward:forward complete:^{
        //标题动
        [self animateTitle:title show:forward complete:^{
            //背景动
            [self animateBackGroundView:background show:forward complete:^{
                //动次打次~
                [self animateContentView:contentView show:forward complete:^{
                    complete();
                }];
            }];
        }];
    }];
}

- (void)animateContentView:(UIView *)contentView show:(BOOL)show complete:(void(^)())complete {
    
    if (show) {
        [self.superview addSubview:self.contentView];
        contentView.height = 0;
        [UIView animateWithDuration:0.2 animations:^{
            contentView.height = self.contentViewHeight;
        } completion:^(BOOL finished) {
            complete();
        }];
        
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            contentView.height = 0;
        } completion:^(BOOL finished) {
            if (contentView.superview) {
                [contentView removeFromSuperview];
                contentView.height = self.contentViewHeight;
            }
            complete();
        }];
    }
}

//背景动画
- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

//箭头动画
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    if (forward) {
        // 展开
        indicator.fillColor = _textSelectedColor.CGColor;
    } else {
        // 收缩
        indicator.fillColor = _textColor.CGColor;
    }
    
    complete();
}

//文字动画
- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    if (!show) {
        title.foregroundColor = _textColor.CGColor;
    } else {
        title.foregroundColor = _textSelectedColor.CGColor;
    }
    complete();
}

#pragma mark - init support

- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
    layer.backgroundColor = color.CGColor;
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.8;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = _fontSize;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.truncationMode = kCATruncationEnd;
    layer.foregroundColor = color.CGColor;
    layer.contentsScale = [[UIScreen mainScreen] scale];
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string {
    //CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:_fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark -- required method  抽象方法,必须实现,否则~~~~~~BOOM!!!

/**
 *  返回 menu 有多少列 ，默认1列
 */
- (NSInteger)numberOfColumnsInMenu{
    
    NSAssert(NO, @"Subclass of HouseSearchMenuView must overide this method!");
    
    return 0;
}

/**
 *  返回 menu 第column列 每行title
 */

- (NSString *)titleForColumns:(NSInteger )columns{
    
    NSAssert(NO, @"Subclass of HouseSearchMenuView must overide this method!");
    
    return @"";
}


- (UIView *)viewForColumns:(NSInteger )columns{
    
    NSAssert(NO, @"Subclass of HouseSearchMenuView must overide this method!");
    
    return nil;
}

@end
