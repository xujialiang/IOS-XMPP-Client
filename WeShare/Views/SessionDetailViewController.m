//
//  SessionDetailViewController.m
//  WeShare
//
//  Created by Elliott on 13-5-15.
//  Copyright (c) 2013年 Elliott. All rights reserved.
//

#import "SessionDetailViewController.h"
#import "SessionViewController.h"
#import "Message.h"
#import "SessionDetailCell1.h"
#import "SessionDetailCell2.h"
#import "AppDelegate.h"
#import "XMPPvCardTemp.h"
#import "XMPPHelper.h"
#import "AppDelegate.h"
#import "DefaultViewController.h"
@interface SessionDetailViewController ()

@property (nonatomic,strong) NSMutableArray *messages;
@property (nonatomic,strong) XMPPvCardTemp *mycard;
@end

@implementation SessionDetailViewController

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
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    self.navbaritem.title=self.from;
    self.sessionViewController=appdel.defaultViewController.sessioncontroller;
    //KVO监视
    if(self.sessionViewController.chatsession==nil){
        self.sessionViewController.chatsession=[[NSMutableDictionary alloc]init];
    }
    [self.sessionViewController.chatsession addObserver:self forKeyPath:self.from options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    XMPPvCardTemp *card=[appdel.xmppHelper getvcard:self.from ];
    self.photo=[[UIImage alloc] initWithData:card.photo];
    self.mycard=[appdel.xmppHelper getmyvcard];
    self.myphoto=[[UIImage alloc] initWithData:self.mycard.photo];
    
    // Do any additional setup after loading the view from its nib.
    self.messages=[self.sessionViewController.chatsession objectForKey:self.from];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    //监听键盘
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    // Register notification when the keyboard will be show
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillShow:)
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillHide:)
                          name:UIKeyboardWillHideNotification
                        object:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:self.from])
    {
        [self reloadmessage];
    }
}

-(void)reloadmessage{
     self.messages=[self.sessionViewController.chatsession objectForKey:self.from];
    [self.chatlisttableview reloadData];
    [self scrollTableToFoot:YES];
}

- (void)scrollTableToFoot:(BOOL)animated {
    NSInteger s = [self.chatlisttableview numberOfSections];
    if (s<1) return;
    NSInteger r = [self.chatlisttableview numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [self.chatlisttableview scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Message *message=[self.messages objectAtIndex:[indexPath row]];
    
    if([message.from isEqualToString:self.from]){
        static NSString *identifier = @"userCell2";
        SessionDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"SessionDetailCell1" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        //文本
        cell.message.text=message.message;
        cell.photo.image=self.photo;
        return cell;
    }else{
        static NSString *identifier2 = @"userCell";
        SessionDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"SessionDetailCell2" owner:self options:nil];
            cell=[nib objectAtIndex:0];

        }
        cell.message.text=message.message;
        cell.photo.image=self.myphoto;
        //标记
        return cell;
    }
}

-(void)keyboardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘的大小
    CGSize keyboardRect = [aValue CGRectValue].size;
    
    //设置chatlisttableview的高度=view的高度-navbar高度-toolbar高度-键盘高度
    CGFloat ht=self.view.frame.size.height-self.navbar.frame.size.height-self.toolbar.frame.size.height-keyboardRect.height;
    
    self.chatlisttableview.frame=CGRectMake(0, self.chatlisttableview.frame.origin.y, self.chatlisttableview.frame.size.width, ht);
    //toolbar的高度=navbar高度+chatlisttableview高度
    CGFloat tbht=self.navbar.frame.size.height+ht;
    self.toolbar.frame=CGRectMake(0,tbht, self.toolbar.frame.size.width, self.toolbar.frame.size.height);

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)keyboardWillHide:(NSNotification*)aNotification{
    
    //设置chatlisttableview的高度=view的高度-navbar高度-toolbar高度
    CGFloat ht=self.view.frame.size.height-self.navbar.frame.size.height-self.toolbar.frame.size.height;
    
    self.chatlisttableview.frame=CGRectMake(0, self.chatlisttableview.frame.origin.y, self.chatlisttableview.frame.size.width, ht);
    //toolbar的高度=navbar高度+chatlisttableview高度
    CGFloat tbht=self.navbar.frame.size.height+ht;
    self.toolbar.frame=CGRectMake(0,tbht, self.toolbar.frame.size.width, self.toolbar.frame.size.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.textfield resignFirstResponder];
}

- (void)viewDidUnload {
    [self setTextfield:nil];
    [self setNavbar:nil];
    [self setNavbaritem:nil];
    [super viewDidUnload];
}
-(void)viewWillDisappear:(BOOL)animated{
    //窗体不显示的时候，注销监听，不然会报错。因为对象已经被释放，找不到这个方法了。
    [self.sessionViewController.chatsession removeObserver:self forKeyPath:self.from context:nil];
    
    //清空所有记录
    [self.sessionViewController.chatsession removeObjectForKey:self.from];
    [self.sessionViewController.table reloadData];
}

- (IBAction)sendmessagebtn:(id)sender {
    Message *message=[[Message alloc] init];
    message.from=self.mycard.jid.user ;
    message.to=[self.from stringByAppendingString:Domain];
    message.message=self.textfield.text;
    message.date=[NSDate date];
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    [appdel.xmppHelper sendMessageTo:message];
    
    if(self.messages==nil){
        self.messages=[[NSMutableArray alloc] init];
    }
    [self.messages addObject:message];
    
    [self.sessionViewController.chatsession setObject:self.messages forKey:self.from];
    [self reloadmessage];
    
    self.textfield.text=@"";
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
