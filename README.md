# YWSlideMenuDemo

最终效果：

![YWmenu.gif](http://upload-images.jianshu.io/upload_images/988593-4a219265d97c8059.gif?imageMogr2/auto-orient/strip)



使用姿势：
```
   YWSlideMenu *slideMenu = [[YWSlideMenu alloc] initWithFrame:self.contentView.bounds];
    slideMenu.itemsTitle = @[@"头条", @"娱乐", @"体育", @"财经", @"科技", @"时尚", @"直播", @"热点", @"图片", @"新闻"];
    slideMenu.itemBarSize = CGSizeMake(60, 35); //
    slideMenu.ywSlideMenuDelegate = self;
    [self.contentView addSubview:slideMenu];
```

