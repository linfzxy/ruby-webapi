# README

api接口
   接口1: ​GET /categories 
    ­ 返回数据样例
	{"data":[{"id":1,"name":"旅游","count":2},...{"id":3,"name":"音乐","count":4}]}
   接口2: ​GET /videos?category=​id​
    ­ 返回数据样例  {"id":1,"count":5,"name":"旅游","tags":[{"id":1,"name":"欧洲"}...],"videos":[{"id":1,"name":"欧洲一日游"}...]} 
	
ruby -v ruby 2.2.5p319 (2016-04-26 revision 54774) [i386-mingw32]
rails -v Rails 5.0.0.1
需要mysql-devel运行环境
需要添加config/database.yml文件