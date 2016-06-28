//
//  OrderCell.m
//  FamilysHelper
//
//  Created by zhouwengang on 15/6/6.
//  Copyright (c) 2015年 FamilyTree. All rights reserved.
//

#import "OrderCell.h"
#import "OrderModel.h"
#import "ShopsService.h"
@interface OrderCell () <EGOImageViewDelegate> {
    OrderModel* _orderModel;
}
@end
@implementation OrderCell
- (void)awakeFromNib
{
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.selected) {
        self.lbl_image.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// 自绘分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);

    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2 / 255.0f green:0xE2 / 255.0f blue:0xE2 / 255.0f alpha:0.75].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}
- (void)bindMsgModel:(OrderModel*)model index:(NSInteger)index isEdit:(BOOL)isEdit
{
    _orderModel = model;
    [_lbl_leaveWords setText:_orderModel.leaveWords];
    [_lbl_goodsname setText:_orderModel.goodsname];
    [_lbl_ordernum setText:[NSString stringWithFormat:@"%@", _orderModel.orderNum]];
    [_lbl_goodsPrice setText:[@"¥" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_orderModel.goodsPrice]]];
    [_lbl_originalPrice setText:[@"¥" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_orderModel.originalPrice]]];
    NSString* buyBbTotal = [@"使用了" stringByAppendingString:[NSString stringWithFormat:@"%.2f", _orderModel.buyBbTotal]];
    [_lbl_buyBbTotal setText:[buyBbTotal stringByAppendingString:@"帮币"]];
    [_lbl_totalPrice setText:[@"¥" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_orderModel.totalPrice]]];
    [_iv_imagename setImageURL:[AppImageUtil getImageURL:_orderModel.imagename Size:_iv_imagename.frame.size]];

    if (_orderModel.payStatus == 4 || _orderModel.payStatus == 5) {
        [_lbl_payStatus setText:@"待付款"];
        [_but_gopay setTitle:@"去支付" forState:UIControlStateNormal];
        _but_cancel.hidden = NO;
        _but_gopay.hidden = NO;
    }
    else if (_orderModel.payStatus == 6) {
        [_lbl_payStatus setText:@"待付款"];
        [_but_gopay setTitle:@"去支付" forState:UIControlStateNormal];
        [_lbl_buyBbTotal setText:[@"使用了" stringByAppendingString:@"0.00帮币"]];
        _but_cancel.hidden = NO;
        _but_gopay.hidden = NO;
    }
    else if (_orderModel.payStatus == 1) {
        [_lbl_payStatus setText:@"待消费"];
        [_but_gopay setTitle:@"申请退款" forState:UIControlStateNormal];
        _but_cancel.hidden = YES;
        _but_gopay.hidden = NO;
    }
    else if (_orderModel.payStatus == 7) {
        [_lbl_payStatus setText:@"已取消"];
        _but_gopay.hidden = YES;
        _but_cancel.hidden = YES;
    }
    else if (_orderModel.payStatus == 2) {
        [_lbl_payStatus setText:@"已发货"];
        [_but_gopay setTitle:@"申请退款" forState:UIControlStateNormal];
        _but_cancel.hidden = YES;
    }
    else if (_orderModel.payStatus == 3 || _orderModel.payStatus == 9 || _orderModel.payStatus == 8 || _orderModel.payStatus == 10) {
        [_lbl_payStatus setText:@"交易完成"];
        [_but_gopay setTitle:@"去评价" forState:UIControlStateNormal];
        [_but_cancel setTitle:@"申请退款" forState:UIControlStateNormal];
    }
    else if (_orderModel.payStatus == 11){
        [_lbl_payStatus setText:@"退款中"];
        _but_gopay.hidden = YES;
        _but_cancel.hidden = YES;
    }
    else if (_orderModel.payStatus == 12 || _orderModel.payStatus == 13 || _orderModel.payStatus == 14 || _orderModel.payStatus == 15) {
        [_lbl_payStatus setText:@"已退款"];
        [_but_gopay setTitle:@"退款详情" forState:UIControlStateNormal];
        _but_cancel.hidden = YES;
    }

    [_but_cancel.layer setCornerRadius:5];
    [_but_cancel.layer setBorderWidth:0.5f];
    [_but_cancel.layer setBorderColor:[UIColor grayColor].CGColor];
    [_but_cancel setBackgroundColor:[UIColor whiteColor]];
    [_but_gopay.layer setCornerRadius:5];
    [_but_gopay.layer setBorderWidth:0.5f];
    [_but_gopay.layer setBorderColor:[UIColor redColor].CGColor];
    [_but_gopay setBackgroundColor:[UIColor whiteColor]];
}
- (void)initView
{
    _iv_imagename.delegate = self;
    _iv_imagename.clipsToBounds = YES;
    _iv_imagename.tag = 0;
    
    
}

- (IBAction)gopay:(id)sender
{
    if (_orderModel.payStatus == 4 || _orderModel.payStatus == 5 || _orderModel.payStatus == 6) {
        [ToastManager showToast:@"去支付" withTime:Toast_Hide_TIME];
    }
    else if (_orderModel.payStatus == 3 || _orderModel.payStatus == 9 || _orderModel.payStatus == 8 || _orderModel.payStatus == 10) {
        [ToastManager showToast:@"去评价" withTime:Toast_Hide_TIME];
    }
}

- (IBAction)cancel:(id)sender
{
    if (_orderModel.payStatus == 3 || _orderModel.payStatus == 9 || _orderModel.payStatus == 8 || _orderModel.payStatus == 10) {
        [ToastManager showToast:@"申请退款" withTime:Toast_Hide_TIME];
    }
    else {

        [[ShopsService shareInstance] cancleOrderV2:_orderModel.orderNum
                                          onSuccess:^(DataModel* dataModel) {
                                              if (dataModel.code == 201) {
                                                  [ToastManager showToast:@"取消成功" withTime:Toast_Hide_TIME];
                                                  if (_bockcancel) {
                                                      _bockcancel();
                                                  }
                                              }

                                          }];
    }
}

@end
