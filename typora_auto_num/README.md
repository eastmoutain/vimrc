# Typora 自动编号主题

为 Typora 的文档正文和大纲侧边栏同时添加章节自动编号。

## 效果

- **文档正文**：标题前自动添加编号，如 `1. 标题`、`1.1 子标题`、`1.1.1 小节`
- **大纲侧边栏**：同步显示相同格式的编号

## 安装方法

### macOS

1. 打开 Typora
2. 点击菜单：`偏好设置` → `外观` → `打开主题文件夹`
3. 将 `outline-numbering.css` 复制到主题文件夹
4. 重启 Typora
5. 点击 `主题` 菜单，选择 `outline-numbering`

### 主题文件夹位置

```bash
~/Library/Application Support/abnerworks.Typora/themes/
```

### 通过命令行安装

```bash
# 复制 CSS 文件到主题目录
cp outline-numbering.css ~/Library/Application\ Support/abnerworks.Typora/themes/

# 或创建符号链接（自动同步更新）
ln -s $(pwd)/outline-numbering.css ~/Library/Application\ Support/abnerworks.Typora/themes/outline-numbering.css
```

## 使用说明

安装后，在 Typora 中：

1. 点击菜单栏的 `主题`
2. 选择 `outline-numbering`
3. 文档正文和大纲将自动显示编号

## 编号格式

```
1. 第一章
   1.1 第一节
   1.2 第二节
2. 第二章
   2.1 第一节
      2.1.1 小节
      2.1.2 小节
```

## 自定义

如需修改编号格式，编辑 `outline-numbering.css` 中的 `content` 属性：

```css
/* 修改为 "第X章" 格式 */
#write h1:before {
    content: "第" counter(h1-content) "章 ";
}
```

## 技术实现

使用 CSS 计数器（CSS Counters）实现：

- `counter-reset`: 初始化计数器
- `counter-increment`: 递增计数器
- `counter()`: 输出计数器值
- `:before` 伪元素: 在标题前插入编号

## 兼容性

- Typora for macOS
- Typora for Windows
- Typora for Linux

## 许可

MIT License
