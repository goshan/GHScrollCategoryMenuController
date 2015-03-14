# GScrollCategoryMenuController
> developed by goshan

**Destenition: make categoryMenu scroll automatically and smoothly with listPanel**


## Install 
`git clone git@github.com:goshan/GHScrollCategoryMenuController.git`

## Usage
1. config comstum setting in file: `UIColor+GHCategoryMenu` and `GHCategoryMenuUtility`
2. use following code to create a category menu  

	```objectivec
	GHCategoryMenuController *viewController = [[GHCategoryMenuController alloc] init];
	[viewController setupWithMenuList:menuList];
	[parentViewController.view addSubview: viewController.view]
	```

## Future work
1. 完成menu点击Action..[OK](OK)
2. 完成fromItem和toItem的查找，较工作中的开发更为准确！..[OK](OK)
3. 根据距离更新menuScrollView的contentOffset..[OK](OK)
4. 更新色块位置..[OK](OK)
5. 更新色块长度..[OK](OK)
6. 代码整理..[OK](OK)
7. 内容设定
8. 尺寸适配

