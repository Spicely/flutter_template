# flutter 模板

### 前置

```
    flutter pub global activate get_cli # 安装get_cli
    flutter pub global activate intl_utils

    dart pub global activate spider

    /// 资源处理
    spider build

    /// 监视给定目录中的文件更改并自动重建 dart 代码。使用以下命令监视更改：
    spider build --watch

    /// 生成平台文件
    flutter create . --org com.muka

    /// 依据env生成
    dart run build_runner build

    /// 图标生成
    dart run flutter_launcher_icons

    /// 启动页图片
    dart run flutter_native_splash:create
```

### 打包

```
    /// 打包测试
    flutter_distributor release --name dev

    /// 打包测试android
    flutter_distributor release --name dev --jobs release-dev-android --skip-clean

    /// 打包测试ios
    flutter_distributor release --name dev --jobs release-dev-ios --skip-clean

    /// 打包正式
    flutter_distributor release --name prod --skip-clean

    /// 打包正式android
    flutter_distributor release --name prod --jobs release-android --skip-clean

    /// 打包正式ios
    flutter_distributor release --name prod --jobs release-ios --skip-clean

    /// 打包正式windows
    flutter_distributor release --name prod --jobs release-windows --skip-clean

```
