#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *interactiveButton;
@property (nonatomic, strong) UIButton *tableViewButton;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, strong) UILabel *counterLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupConstraints];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Objective-C Demo";
    
    // 配置计数器
    self.counter = 0;
    
    // 配置标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"iOS开发技术栈演示 - Objective-C";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor labelColor];
    self.titleLabel.numberOfLines = 0;
    
    // 配置计数器标签
    self.counterLabel = [[UILabel alloc] init];
    [self updateCounterLabel];
    self.counterLabel.font = [UIFont boldSystemFontOfSize:18];
    self.counterLabel.textAlignment = NSTextAlignmentCenter;
    self.counterLabel.backgroundColor = [UIColor systemGray6Color];
    self.counterLabel.layer.cornerRadius = 10;
    self.counterLabel.layer.masksToBounds = YES;
    
    // 配置交互演示按钮
    self.interactiveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.interactiveButton setTitle:@"计数器 +1" forState:UIControlStateNormal];
    self.interactiveButton.backgroundColor = [UIColor systemBlueColor];
    [self.interactiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.interactiveButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.interactiveButton.layer.cornerRadius = 10;
    [self.interactiveButton addTarget:self action:@selector(incrementCounter) forControlEvents:UIControlEventTouchUpInside];
    
    // 配置TableView演示按钮
    self.tableViewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.tableViewButton setTitle:@"UITableView 演示" forState:UIControlStateNormal];
    self.tableViewButton.backgroundColor = [UIColor systemGreenColor];
    [self.tableViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tableViewButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.tableViewButton.layer.cornerRadius = 10;
    [self.tableViewButton addTarget:self action:@selector(showTableView) forControlEvents:UIControlEventTouchUpInside];
    
    // 配置描述文本
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.text = @"这个演示项目展示了Objective-C + UIKit的开发方式：\n\n• 传统的iOS开发语言\n• 强大的UIKit框架\n• MRC/ARC内存管理\n• 丰富的第三方库支持\n\n点击按钮查看具体功能";
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    self.descriptionLabel.textColor = [UIColor secondaryLabelColor];
    
    // 配置堆栈视图
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 20;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    
    // 添加子视图
    [self.stackView addArrangedSubview:self.titleLabel];
    [self.stackView addArrangedSubview:self.counterLabel];
    [self.stackView addArrangedSubview:self.interactiveButton];
    [self.stackView addArrangedSubview:self.tableViewButton];
    [self.stackView addArrangedSubview:self.descriptionLabel];
    
    [self.view addSubview:self.stackView];
}

- (void)setupConstraints {
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.stackView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.stackView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-40],
        
        [self.counterLabel.heightAnchor constraintEqualToConstant:50],
        [self.interactiveButton.heightAnchor constraintEqualToConstant:50],
        [self.tableViewButton.heightAnchor constraintEqualToConstant:50]
    ]];
}

- (void)incrementCounter {
    self.counter++;
    [self updateCounterLabel];
    [self animateButton:self.interactiveButton];
    
    // 展示Objective-C的消息传递机制
    [self performSelector:@selector(showCounterMessage) withObject:nil afterDelay:0.5];
}

- (void)updateCounterLabel {
    self.counterLabel.text = [NSString stringWithFormat:@"计数器: %ld", (long)self.counter];
}

- (void)showCounterMessage {
    if (self.counter % 5 == 0 && self.counter > 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Objective-C特性"
                                                                       message:[NSString stringWithFormat:@"计数器已达到%ld！\n这展示了Objective-C的动态消息传递机制。", (long)self.counter]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)showTableView {
    TableViewController *tableVC = [[TableViewController alloc] init];
    [self.navigationController pushViewController:tableVC animated:YES];
    [self animateButton:self.tableViewButton];
}

- (void)animateButton:(UIButton *)button {
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(0.95, 0.95);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end