搭建 ssm项目的步骤，
1. 新建 maven工程
2. 修改目录，修改 pom.xml文件
3. 添加 smm框架的所有依赖
4. 拷贝 jdbc.properties到 resources目录下
5. 新建 applicationContext_dao.xml 文件，进行数据访问层的配置 
6. 新建 applicationContext_service.xml 文件，进行业务逻辑的配置
7. 新建 springMVC.xml 文件，配置 springMVC的狂降
8. 新建 sqlMapConfig.xml 文件，进行分页插件的配置
9. 使用逆向工程生成 pojo 和 mapper的文件
10. 开发业务逻辑层，实现登陆判断
11. 开发控制器 AdminAction，完成登陆处理
12. 改造页面，发送登陆请求，验证登陆请求