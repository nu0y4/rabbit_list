# rabbit_list
rabbit 兔子，谐音同志，用于避嫌，因为这个工具最初想法是：”像一个强权者一样记录肃清的名单，然后用强力的手段处理。“，但那样会引起不必要的麻烦，虽然这个比喻对于开源情报调查人员来说很恰当，一些搞情报的人员使用的工具，比这个脚本集强大太多，即便是10^9个可能的号码中找出一个与目标所使用的邮箱高度关联的号码，他们也可以在几分钟之内完成，利用数据清洗，空号检测，用户画像对比，最后再话单分析等等，这可不是非常强力而且高效的手段吗？
此版本为第一个公开演示版本！并非最终开源版本。
针对中国开发者，黑客的最佳开源情报脚本工具集，持续更新，分为4大模块：用户名，手机号，邮箱，ip和域名。目前仅公开了最基本功能和部分用户名开源情报工具，这个是一个演示版本，正式版本大概还需要3个月左右才会完整发布.
当前版本用户名模块运行展示。
改用户写了一篇不错的OSINT文章。
![image](https://user-images.githubusercontent.com/43908812/216779842-a0ca1090-c129-42a8-ba16-92fabf96b40a.png)
更多功能集成中..敬请期待
# 免责声明
名单是一个开源情报工具，所获取的数据都是公开的，甚至不需要任何凭证就可以访问获取，能被搜索引擎检索到的，名单只是提取了其中与开发者相关的部分，并且整合为一个脚本工具集，它不是用来获取隐私的数据，即便包含隐私，也是你自己公开的。名单获取的数据大都与开发者，黑客相关，能危害到普通人的模块大都被取缔，违法的数据获取行为，比如遍历身份证二要素，名单不会集成，也不推荐你去尝试。如果使用名单产生了法律纠纷，我概不负责，它本是一个维护网络空间安全的工具集，仅作为分享学习参考的目的公开，我不以此获取任何利益，并且如果其中一些爬虫相关的模块威胁到了您的企业或者个人的合法权利，欢迎留言，我会主动删除相关代码。

# 谁需要这个 ‘名单’ 工具？
# 蓝队： 
可以用来溯源，尽管当前版本并未集成ip，域名等溯源相关的功能，但是它依旧可以监视一批用户名，获取它们的ip地址，帮助蓝队判断可能的红队的地理位置，代理服务器等信息
将用户名添加到 list 文件 ，设置计划任务 每天运行一次 ./main.sh 或者仅仅是测试:
eg: ./chase.sh lidazhi
结果会保存在 ./bak/log
# 红队： 
做社工钓鱼也可以使用这个工具，它可以获取对应用户名的招聘等信息，后续还会有用户名枚举邮箱，电话号码开源情报等功能（针对开发者定制，可以识别一些威胁情报平台注册等等），帮助完善钓鱼目标的画像，增加成功的可能性，当然用来找到蓝队成员的地理位置信息，知己知彼也是可以的。
# 开源情报人员：
可以测绘某个关键词的地理位置信息
eg: 
$ ./chase.sh 实验室
$ ./rabbit_list.sh --find 实验室,北京,
每个关键词需要半角逗号隔开
当然需要更加精确的ip定位和反查，就需要付费api，当前版本并未集成这些工具，但我之前展示过了，等到ip域名溯源的模块更新的时候会做得更加详细，包含免费的网络类型识别（必答多数api都更加精确识别网络类型，设备统计，蜜罐识别等等，但是api是纯真的白嫖接口，没办法大量爬取，有必要还是买api）
# 执法人员：
名单本是内部工具集，所有的脚本都是最近一两年我参与的溯源相关任务时所开发，其中一些模块在执法过程中起到了一定的积极影响。
案例：某国内挖坑木马团伙通过ssh爆破，手动ssh连接登录了甲公司的某台服务器，执法人员乙取证时发现了某个外语的ftp登录密码，经过一段时间的溯源分析，我发现了某开发者平台的某用户使用该用户名，且整个中文互联网也就他一个人使用，通过名单的某个早期版本脚本获取了其家庭宽带的ip，并在丙威胁情报平台发现了有近段时间的扫描行为。最终将其ip，地理位置信息等做了线索提交给执法部门。
执法人员可以使用该工具分析一些通常不容易溯源的东西，比如一些登录的凭证帐号密码可以作为关键词，检索是否有国内黑客使用，从而找到一些可能的线索，但开源情报的数据并非完全闭环，需要进一步判断分析。
# 名单的简易使用方法
用户名开源情报：
eg: ./rabbit_list.sh --seek-username 用户名
后续模块大概每周提交一次更新...
# 早期版本设想和演示：
https://x.threatbook.com/v5/article?threatInfoID=41956

