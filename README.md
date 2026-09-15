# 🪰 糖豆 Tangdou

A tiny fruit-fly family for your Mac desktop. / 住在 Mac 桌面的果蝇小家庭。

**An early macOS companion fork of [DesktopFly](https://github.com/DenisSergeevitch/desktop-fly).**
Real connectome-derived circuits meet explicitly designed pet mechanics.

## 可以玩什么

- **桌面散步**：停在窗口边缘，感知鼠标靠近、点击、输入活动、昼夜和电脑热状态。
- **照料面板**：中文菜单栏入口；关闭面板后，糖豆继续在桌面活动。
- **手喂糖水**：点击「喂一滴糖水」，橙色圈标出食物。主果蝇落地后花 5 秒吃完；受惊优先逃离。不会自动寻路找食物。
- **桌面食物**：糖豆饥饿时会自动在桌面生成糖水或花；它会根据距离自己转向、走过去，靠近后进食。食物是可见的橙色/粉色小标记，暂时每次只生成一份。
- **休息与定位**：「休息一下」让主果蝇休息；「找到糖豆」显示 6 秒薄荷色圆圈。
- **小家庭**：先「找个伴侣」，再「模拟繁育」。求偶 15 秒 → 卵 30 秒 → 幼虫 45 秒 → 蛹 45 秒 → 增加一只成虫。桌面显示简化的卵/幼虫/蛹标记。
- **神经观察**：打开原项目的大脑窗口，观察活动并刺激选定区域。
- **科研模式**：点击“同步 Zotero”读取本机 Zotero 题录；“读下一篇”显示摘要并增加科研成长积分。读取只走 Zotero 7 的本地只读 API，不上传文献。
- **暂停**：暂停桌面模拟、饱腹变化和繁育进度。

每次运行最多 **3 只成虫、1 胎**。照料状态与家庭状态暂不跨启动保存。

科研成长是本地可解释的积分系统：读一篇摘要 +20 分，100 分升一级；称号从“实验室新生”到“文献侦察员”“方法学助手”。下一步会加入阅读卡片、PDF 全文段落定位、研究主题技能树和可导出的阅读日志。
主果蝇有神经回路模型；伴侣和后代使用规则行为。喂食和繁育是游戏机制，
不表示神经模型已经学会进食、求偶或遗传。详见 [来源与科学边界](UPSTREAM.md)。

## 本机运行

需要 macOS 13+、Xcode Command Line Tools（Swift 5.9+）。

```sh
git clone https://github.com/syydaniel/tangdou.git
cd tangdou
./package.sh
```

在 Finder 打开 `dist/Tangdou.app`。菜单栏 **🪰 糖豆** 可以重新打开照料面板或退出。
打包脚本只作本地临时签名，不含 Apple Developer ID 签名或公证。
构建目标为当前 Mac 架构、最低 macOS 13；“macOS 13+”来自上游要求，
并不表示已在所有旧版系统测试。Windows 子目录是未改动的上游版本。

也可运行裸可执行文件（数据需留在旁边）：

```sh
./build.sh
./DesktopFly
```

## 检查

```sh
./DesktopFly --caretest
./DesktopFly --familytest
./DesktopFly --simtest
./DesktopFly --behaviortest
./DesktopFly --locomotortest
```

## 隐私与资源

桌宠运行代码无网络请求、无云模型、无 API key。构建/源码下载需要网络。
沿用上游窗口边界、鼠标和事件闲置时间接口，不采集屏幕图像或输入文字。
不注册开机启动，不修改系统安全设置；所有文件可以放在任意自选目录。
桌面默认 60 FPS；神经和机械积分仍使用上游固定时间步。
资源占用取决于显示器和硬件，尚未做长期功耗评估。

## 开源与数据许可

- **代码：MIT**，保留原作者 Denis Shiryaev 的版权与署名。
- **FlyWire 派生数据：CC BY-NC 4.0**，包含非商业限制。
- **MaleCNS 派生数据：CC BY 4.0**。

代码开源不意味着随附数据允许任意商业使用。
详见 [LICENSE](LICENSE)、[数据许可](data/DATA_LICENSE.md) 和 [上游记录](UPSTREAM.md)。

## 下一步

- 保存家庭进度与名字；支持把后代移入独立饲养盒。
- 加入食物位置和寻路，比较规则寻路与神经驱动寻路。
- 为伴侣/后代各自运行独立回路，再考虑明确标注的参数遗传实验。
- 增加完整英文界面和可选低功耗模式。

欢迎改进。反馈请附 macOS 版本、Mac 芯片、复现步骤；不要上传私人窗口内容。
