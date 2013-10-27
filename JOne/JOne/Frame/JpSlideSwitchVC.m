//
//  JpSlideSwitchVC.m
//  JOne
//
//  Created by Johnny on 26/10/13.
//  Copyright (c) 2013 ganjp. All rights reserved.
//

#import "JpSlideSwitchVC.h"
#import "UIViewController+MMDrawerController.h"
#import "JpListVC.h"
#import "JpConst.h"

@interface JpSlideSwitchVC ()

@end

@implementation JpSlideSwitchVC
@synthesize mVCs,mArticleDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    mArticleDic = ARTICLES;
    
    self.slideSwitchView.tabItemNormalColor = [MMSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [MMSlideSwitchView colorFromHexRGB:@"008000"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"green_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    NSArray *aArticles = [[mArticleDic objectForKey:self.title] componentsSeparatedByString:@","];
    for (NSString *article in aArticles) {
        JpListVC *listVC = [[JpListVC alloc] init];
        listVC.title = article;
        if (mVCs) {
            [mVCs addObject:listVC];
        } else {
            mVCs = [[NSMutableArray alloc] initWithObjects:listVC, nil];
        }
        
    }
    
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_arrow_right"] forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"icon_arrow_right"] forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    [self.slideSwitchView mIsBuildUI];
}

#pragma mark - Slide tab view proxy method
- (NSUInteger)numberOfTab:(MMSlideSwitchView *)view
{
    return [self.mVCs count];
}
- (UIViewController *)slideSwitchView:(MMSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return self.mVCs[number];
}
- (void)slideSwitchView:(MMSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    JpDrawerVC *drawerController = (JpDrawerVC *)self.navigationController.mm_drawerController;
    [drawerController panGestureCallback:panParam];
}
- (void)slideSwitchView:(MMSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    JpListVC *vc = self.mVCs[number];
    [vc viewDidCurrentView];
}

#pragma mark - Destroy Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
