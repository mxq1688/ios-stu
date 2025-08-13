# iOS 开发学习项目

本项目包含两套完整的iOS应用演示，展示了不同的iOS开发技术栈。

## 项目结构

### 1. SwiftDemo - Swift + UIKit/SwiftUI 项目
- **技术栈**: Swift 5.0 + UIKit + SwiftUI
- **特点**: 现代化iOS开发方式
- **功能演示**:
  - UIKit 传统UI开发
  - SwiftUI 声明式UI开发
  - 交互式计数器
  - 文本输入处理
  - 动画效果
  - 响应式更新

### 2. ObjectiveCDemo - Objective-C + UIKit 项目
- **技术栈**: Objective-C + UIKit
- **特点**: 传统iOS开发方式
- **功能演示**:
  - UITableView 列表展示
  - 动态数据管理
  - 消息传递机制
  - 内存管理 (ARC)
  - 导航控制器

## 如何运行

### 方式1: 使用 Cursor
1. 在项目目录右键选择 "Open in Xcode"
2. 选择对应的 `.xcodeproj` 文件

### 方式2: 使用终端
```bash
# 进入对应项目目录
cd SwiftDemo
# 或
cd ObjectiveCDemo

# 打开 Xcode 项目
open SwiftDemo.xcodeproj
# 或
open ObjectiveCDemo.xcodeproj
```

## 项目特性对比

| 特性 | Swift + UIKit/SwiftUI | Objective-C + UIKit |
|------|----------------------|---------------------|
| 语言特点 | 现代化、类型安全 | 动态、运行时特性 |
| UI框架 | UIKit + SwiftUI | UIKit |
| 内存管理 | ARC自动管理 | ARC自动管理 |
| 开发效率 | 高，语法简洁 | 中等，语法详细 |
| 学习曲线 | 相对平缓 | 较陡峭 |
| 社区支持 | 现代化，活跃 | 成熟，稳定 |

## 学习建议

1. **初学者**: 建议从 Swift + UIKit 开始
2. **有经验开发者**: 可以同时学习两种方式
3. **维护老项目**: 需要掌握 Objective-C

## 技术要点

### Swift 项目亮点
- 声明式UI (SwiftUI)
- 响应式编程
- 类型安全
- 闭包和高阶函数
- 协议导向编程

### Objective-C 项目亮点
- 消息传递机制
- 运行时特性
- Category 扩展
- Protocol 协议
- 动态类型

## 系统要求

- Xcode 15.0+
- iOS 17.0+
- macOS 14.0+

## 作者

iOS学习项目 - 展示不同iOS开发技术栈的实现方式