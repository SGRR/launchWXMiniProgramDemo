//
//  ExampleViewController.m
//  demo
//
//  Created by 韶光荏苒 on 2019/2/22.
//  Copyright © 2019 韶光荏苒. All rights reserved.
//

#import "ExampleViewController.h"
#import "WeChatSDK/WXApi.h"

@interface ExampleViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>{
    WXMiniProgramType selectedWXMiniProgramType;
    NSString *selectedSex;
}
@property (weak, nonatomic) IBOutlet UIButton *releaseBtn;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;

@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UIView *versionSelectView;
@property (weak, nonatomic) IBOutlet UIView *sexSelectView;

@property (weak, nonatomic) IBOutlet UITextField *mainPath;
@property (weak, nonatomic) IBOutlet UITextField *custName;
@property (weak, nonatomic) IBOutlet UITextField *custAge;
@property (weak, nonatomic) IBOutlet UITextField *custWeight;
@property (weak, nonatomic) IBOutlet UITextField *orderId;

@property (weak, nonatomic) IBOutlet UITextField *erpCode1;
@property (weak, nonatomic) IBOutlet UITextField *erpCode2;
@property (weak, nonatomic) IBOutlet UITextField *erpCode3;
@property (weak, nonatomic) IBOutlet UITextField *erpCode4;
@property (weak, nonatomic) IBOutlet UITextField *erpCode5;
@property (weak, nonatomic) IBOutlet UITextField *count1;
@property (weak, nonatomic) IBOutlet UITextField *count2;
@property (weak, nonatomic) IBOutlet UITextField *count3;
@property (weak, nonatomic) IBOutlet UITextField *count4;
@property (weak, nonatomic) IBOutlet UITextField *count5;

@property (weak, nonatomic) IBOutlet UIButton *openWXBtn;

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Demo";
    
    [self initBase];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWXResponse:) name:@"WXResponse" object:nil];
}

-(void)initBase{
    [self releaseTypeSelected];
    [self manTypeSelected];

    self.mainPath.delegate = self;
    self.custName.delegate = self;
    self.custAge.delegate = self;
    self.custWeight.delegate = self;
    self.orderId.delegate = self;
    self.erpCode1.delegate = self;
    self.erpCode2.delegate = self;
    self.erpCode3.delegate = self;
    self.erpCode4.delegate = self;
    self.erpCode5.delegate = self;
    self.count1.delegate = self;
    self.count2.delegate = self;
    self.count3.delegate = self;
    self.count4.delegate = self;
    self.count5.delegate = self;
    
    self.openWXBtn.layer.cornerRadius = 8;
    self.openWXBtn.layer.masksToBounds = true;
}

//展示微信回调通知
-(void)handleWXResponse:(NSNotification *)notification{
    NSString *str = [notification object];
    NSLog(@"receive wx response string:%@", str);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"小程序回调信息" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)releaseBtnAction:(id)sender {
    [self releaseTypeSelected];
}

- (IBAction)testBtnAction:(id)sender {
    [self testTypeSelected];
}

- (IBAction)previewBtnAction:(id)sender {
    [self previewTypeSelected];
}

- (IBAction)manBtnAction:(id)sender {
    [self manTypeSelected];
}

- (IBAction)womanBtnAction:(id)sender {
    [self womanTypeSelected];
}

- (IBAction)openWXBtnAction:(id)sender {
    [self.view endEditing:YES];
    [self openWXProgram];
}

//选中正式版
-(void)releaseTypeSelected{
    selectedWXMiniProgramType = WXMiniProgramTypeRelease;
    [self.releaseBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [self.testBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.previewBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
}

//选中开发版
-(void)testTypeSelected{
    selectedWXMiniProgramType = WXMiniProgramTypeTest;
    [self.releaseBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.testBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [self.previewBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
}

//选中体验版
-(void)previewTypeSelected{
    selectedWXMiniProgramType = WXMiniProgramTypePreview;
    [self.releaseBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.testBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.previewBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
}

//选中男性
-(void)manTypeSelected{
    selectedSex = @"S00030001";
    [self.manBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [self.womanBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
}

//选中女性
-(void)womanTypeSelected{
    selectedSex = @"S00030002";
    [self.manBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.womanBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
}

//打开微信小程序
-(void)openWXProgram{
    if (![WXApi isWXAppInstalled]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"您未安装微信，请先安装微信" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    WXLaunchMiniProgramReq *launchMini = [WXLaunchMiniProgramReq object];
    launchMini.userName = @"gh_7635c4e2620b";//小程序原始ID
    NSString *path = [NSString stringWithFormat:@"%@?%@",self.mainPath.text,[self combineParam]];
    launchMini.path = path;
    launchMini.miniProgramType = selectedWXMiniProgramType;
    [WXApi sendReq:launchMini];
}

//组合录入的参数
-(NSString *)combineParam{
    NSString *ftAppId = @"29aed970040162890318d40d35285bec";
    NSString *custName = self.custName.text;
    NSString *custAge = self.custAge.text;
    NSString *custWeight = self.custWeight.text;
    NSString *orderId = self.orderId.text;
    NSMutableArray *drugArray = [[NSMutableArray alloc]init];
    if (self.erpCode1.text.length > 0 && self.count1.text.length > 0) {
        [drugArray addObject:@{@"erpCode" : self.erpCode1.text, @"count" : self.count1.text}];
    }
    if (self.erpCode2.text.length > 0 && self.count2.text.length > 0) {
        [drugArray addObject:@{@"erpCode" : self.erpCode2.text, @"count" : self.count2.text}];
    }
    if (self.erpCode3.text.length > 0 && self.count3.text.length > 0) {
        [drugArray addObject:@{@"erpCode" : self.erpCode3.text, @"count" : self.count3.text}];
    }
    if (self.erpCode4.text.length > 0 && self.count4.text.length > 0) {
        [drugArray addObject:@{@"erpCode" : self.erpCode4.text, @"count" : self.count4.text}];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:drugArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *drugList = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"ftAppId=%@&custName=%@&custSex=%@&custAge=%@&custWeight=%@&orderId=%@&drugList=%@",ftAppId,custName,selectedSex,custAge,custWeight,orderId,drugList];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self keyboardResize];
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.orderId || textField == self.erpCode1 || textField == self.erpCode2 || textField == self.erpCode3
        || textField == self.erpCode4 || textField == self.erpCode5 || textField == self.count1 || textField == self.count2
        || textField == self.count3 || textField == self.count4 || textField == self.count5) {
        [self keyboardUp];
    }
    return YES;
}

//界面上升动画
-(void)keyboardUp{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移n个单位，按实际情况设置
    CGRect rect = CGRectMake(0.0f, -225, width, height);
    self.view.frame = rect;
     [UIView commitAnimations];
}

//界面还原动画
-(void)keyboardResize{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

//移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
