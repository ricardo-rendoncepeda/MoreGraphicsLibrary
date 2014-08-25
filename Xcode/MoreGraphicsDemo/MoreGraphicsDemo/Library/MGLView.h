//
//  MGLView.h
//  MoreGraphicsLibrary
//
//  Created by Ricardo on 8/23/14.
//  Copyright (c) 2014 Idean. All rights reserved.
//

@interface MGLView : UIView

@property (strong, nonatomic, readonly) CAEAGLLayer* MGLlayer;
@property (strong, nonatomic, readonly) EAGLContext* MGLcontext;

- (void)shadeRect:(CGRect)rect;
- (void)setNeedsShade;

@end
