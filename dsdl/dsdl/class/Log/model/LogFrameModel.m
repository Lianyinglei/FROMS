//
//  LogFrameModel.m
//  dsdl
//
//  Created by 廉英雷 on 16/11/28.
//  Copyright © 2016年 廉英雷. All rights reserved.
//

#import "LogFrameModel.h"
#import "LogDestailModel.h"
#import "NSString+Extension.h"

@implementation LogFrameModel

- (void)setLogDestailModel:(LogDestailModel *)logDestailModel{

      _logDestailModel = logDestailModel;
      
      CGFloat leftMar = 10;
      CGFloat cellW = _width - 10;
      CGFloat labW = 80;
      CGFloat labH = 30;
      self.numLabF = CGRectMake(leftMar, 0, labW, labH);
      self.numLabRF = CGRectMake(CGRectGetMaxX(self.numLabF), self.numLabF.origin.y, cellW-labW, labH);
      
    //  NSString *str = @"此地是描述内容此地是描述内容此地是描述内容此地是描述内容此地是描述内容此地是描述内容此地是描述内容";
      CGSize describSize = [logDestailModel.contentDescribe sizeWithFont:[UIFont systemFontOfSize:14] maxW:cellW - labW];
      self.describLabF = CGRectMake(leftMar, CGRectGetMaxY(self.numLabF), labW, describSize.height);
      self.describLabRF = CGRectMake(CGRectGetMaxX(self.describLabF), self.describLabF.origin.y, cellW-labW, describSize.height);
      
//      logDestailModel.executeExplain = @"";
      CGSize performSize = [logDestailModel.executeExplain sizeWithFont:[UIFont systemFontOfSize:14] maxW:cellW - labW];
      
      self.performF = CGRectMake(leftMar, CGRectGetMaxY(self.describLabF)+5, labW, performSize.height);
      self.performRF = CGRectMake(CGRectGetMaxX(self.performF), self.performF.origin.y, performSize.width, performSize.height);
      
      
      self.postLabF = CGRectMake(leftMar, CGRectGetMaxY(self.performRF), labW, labH);
      self.postLabRF = CGRectMake(CGRectGetMaxX(self.postLabF), self.postLabF.origin.y, cellW-labW, labH);
      
    //  NSString *postStr = @"这是顺延原因我也不知道这是顺延原因我也不知道这是顺延原因我也不知道这是顺延原因我也不知道这是顺延原因我也不知道";
      CGSize postSize = [logDestailModel.extendedReason sizeWithFont:[UIFont systemFontOfSize:14] maxW:cellW - labW];
      if (logDestailModel.extendedReason == nil) {
           
            self.pWhyLabF = CGRectMake(leftMar, CGRectGetMaxY(self.postLabF), labW,1);
            self.pWhyLabRF = CGRectMake(CGRectGetMaxX(self.pWhyLabF), self.pWhyLabF.origin.y, cellW -labW, 1);
      }else{
      
            self.pWhyLabF = CGRectMake(leftMar, CGRectGetMaxY(self.postLabF), labW, postSize.height+10);
            self.pWhyLabRF = CGRectMake(CGRectGetMaxX(self.pWhyLabF), self.pWhyLabF.origin.y, cellW -labW, postSize.height+10);
      }
     
      
      self.colorViewF = CGRectMake(0, CGRectGetMaxY(self.pWhyLabRF), _width, 10);
      
      self.cellHight = CGRectGetMaxY(self.colorViewF);
      


}
- (void)setLogModel:(LogDestailModel *)logModel{

      
      


//      
//      self.bianF = CGRectMake(leftMar, 0, _width - 80, 30);
//      
//      NSString *distaiStr = @" UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(leftMar, CGRectGetMaxY(lab2.frame), viewW, 200)];";
//      
//      
//      CGSize labSize = [distaiStr sizeWithFont:[UIFont systemFontOfSize:13] maxW:cellW -80];
//      self.miaoF = CGRectMake(leftMar, CGRectGetMaxY(self.bianF), cellW, labSize.height);
//      self.zhiF = CGRectMake(leftMar, CGRectGetMaxY(self.miaoF), cellW, 30);
//      
//      NSString *reasonStr = @"顺延的原因我也不知道，我也真不会到，顺延原因，测试自动换行哦";
//      
//      
//      CGSize reasonSize = [reasonStr sizeWithFont:[UIFont systemFontOfSize:13] maxW:cellW -80];
//      self.shunF = CGRectMake(leftMar, CGRectGetMaxY(self.zhiF), cellW, reasonSize.height);
//      
//      self.cellHight = CGRectGetMaxY(self.shunF)+10;
      
      
}
@end
