#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITextField *inputTextField;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupConstraints];
    [self setupData];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"UITableView 演示";
    
    // 配置导航栏右侧添加按钮
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddItemAlert)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // 配置TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor systemBackgroundColor];
    
    // 注册Cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.tableView];
}

- (void)setupConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)setupData {
    self.dataSource = [NSMutableArray arrayWithArray:@[
        @"Objective-C特性演示",
        @"动态消息传递",
        @"运行时特性",
        @"Category扩展",
        @"Protocol协议",
        @"Block代码块",
        @"KVO键值观察",
        @"NSNotification通知",
        @"Core Data数据持久化",
        @"网络请求NSURLSession"
    ]];
}

- (void)showAddItemAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加新项目"
                                                                   message:@"请输入要添加的内容"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入内容...";
    }];
    
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (text.length > 0) {
            [self.dataSource addObject:text];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:addAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 配置Cell
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 根据索引设置不同的图标
    NSArray *systemImages = @[@"star.fill", @"heart.fill", @"bolt.fill", @"leaf.fill", @"flame.fill", @"drop.fill", @"snow", @"sun.max.fill", @"moon.fill", @"cloud.fill"];
    NSString *imageName = systemImages[indexPath.row % systemImages.count];
    cell.imageView.image = [UIImage systemImageNamed:imageName];
    cell.imageView.tintColor = [self colorForIndex:indexPath.row];
    
    return cell;
}

- (UIColor *)colorForIndex:(NSInteger)index {
    NSArray *colors = @[[UIColor systemBlueColor], [UIColor systemGreenColor], [UIColor systemRedColor], [UIColor systemOrangeColor], [UIColor systemPurpleColor], [UIColor systemTealColor], [UIColor systemIndigoColor], [UIColor systemPinkColor], [UIColor systemYellowColor], [UIColor systemBrownColor]];
    return colors[index % colors.count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectedItem = self.dataSource[indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"项目详情"
                                                                   message:[NSString stringWithFormat:@"您选择了: %@\n\n这展示了UITableView的delegate方法和Objective-C的字符串格式化。", selectedItem]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // 前几个固定项目不允许删除
    return indexPath.row >= 10;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end