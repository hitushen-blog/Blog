/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : nblog

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 16/08/2024 22:25:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about`  (
  `id` bigint NOT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of about
-- ----------------------------
INSERT INTO `about` VALUES (1, 'title', '标题', '关于帅气的 Naccl');
INSERT INTO `about` VALUES (2, 'musicId', '网易云歌曲ID', '423015580');
INSERT INTO `about` VALUES (3, 'content', '正文Markdown', '');
INSERT INTO `about` VALUES (4, 'commentEnabled', '评论开关', 'true');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章标题',
  `first_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章首图，用于随机文章展示',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章正文',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `is_published` bit(1) NOT NULL COMMENT '公开或私密',
  `is_recommend` bit(1) NOT NULL COMMENT '推荐开关',
  `is_appreciation` bit(1) NOT NULL COMMENT '赞赏开关',
  `is_comment_enabled` bit(1) NOT NULL COMMENT '评论开关',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `views` int NOT NULL COMMENT '浏览次数',
  `words` int NOT NULL COMMENT '文章字数',
  `read_time` int NOT NULL COMMENT '阅读时长(分钟)',
  `category_id` bigint NOT NULL COMMENT '文章分类',
  `is_top` bit(1) NOT NULL COMMENT '是否置顶',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码保护',
  `user_id` bigint NULL DEFAULT NULL COMMENT '文章作者',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id`(`category_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (1, '测试', 'https://cdn.pixabay.com/photo/2021/11/12/03/04/woman-6787784_1280.png', '测试', '测试', b'1', b'1', b'1', b'1', '2024-08-16 17:35:09', '2024-08-16 17:35:09', 0, 100, 1, 3, b'1', '', 1);

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag`  (
  `blog_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES (1, 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (2, 'java');
INSERT INTO `category` VALUES (3, 'spring boot');
INSERT INTO `category` VALUES (4, 'vue2');
INSERT INTO `category` VALUES (5, 'vue3');
INSERT INTO `category` VALUES (6, 'node js');
INSERT INTO `category` VALUES (7, 'css');
INSERT INTO `category` VALUES (8, 'html');
INSERT INTO `category` VALUES (9, 'mysql');
INSERT INTO `category` VALUES (10, 'redis');

-- ----------------------------
-- Table structure for city_visitor
-- ----------------------------
DROP TABLE IF EXISTS `city_visitor`;
CREATE TABLE `city_visitor`  (
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '城市名称',
  `uv` int NOT NULL COMMENT '独立访客数量',
  PRIMARY KEY (`city`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of city_visitor
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像(图片路径)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论者ip地址',
  `is_published` bit(1) NOT NULL COMMENT '公开或回收站',
  `is_admin_comment` bit(1) NOT NULL COMMENT '博主回复',
  `page` int NOT NULL COMMENT '0普通文章，1关于我页面，2友链页面',
  `is_notice` bit(1) NOT NULL COMMENT '接收邮件提醒',
  `blog_id` bigint NULL DEFAULT NULL COMMENT '所属的文章',
  `parent_comment_id` bigint NOT NULL COMMENT '父评论id，-1为根评论',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人网站',
  `qq` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '如果评论昵称为QQ号，则将昵称和头像置为QQ昵称和QQ头像，并将此字段置为QQ号备份',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '2287674693', '2287674693@qq.com', '你好', '/img/comment-avatar/6.jpg', '2024-08-16 14:51:17', '192.168.0.34', b'1', b'0', 2, b'1', NULL, -1, '', '2287674693');
INSERT INTO `comment` VALUES (2, 'Admin', 'admin@naccl.top', '你好我是站长', '/img/avatar.jpg', '2024-08-16 18:02:05', '192.168.0.34', b'1', b'1', 2, b'0', NULL, 1, '/', NULL);

-- ----------------------------
-- Table structure for exception_log
-- ----------------------------
DROP TABLE IF EXISTS `exception_log`;
CREATE TABLE `exception_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exception_log
-- ----------------------------
INSERT INTO `exception_log` VALUES (1, '/login', 'POST', '{\"loginInfo\":{\"username\":\"Naccl\",\"password\":\"11\"}}', '', 'org.springframework.security.core.userdetails.UsernameNotFoundException: 用户不存在\r\n	at top.naccl.service.impl.UserServiceImpl.findUserByUsernameAndPassword(UserServiceImpl.java:39)\r\n	at top.naccl.controller.LoginController.login(LoginController.java:35)\r\n	at top.naccl.controller.LoginController$$FastClassBySpringCGLIB$$4e2e7481.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at top.naccl.controller.LoginController$$EnhancerBySpringCGLIB$$b7319d30.login(<generated>)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.base/java.lang.reflect.Method.invoke(Method.java:566)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at top.naccl.config.JwtFilter.doFilter(JwtFilter.java:35)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)\r\n	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.base/java.lang.Thread.run(Thread.java:834)\r\n', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', '2024-08-16 18:01:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
  `is_published` bit(1) NOT NULL COMMENT '公开或隐藏',
  `views` int NOT NULL COMMENT '点击次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of friend
-- ----------------------------

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `status` bit(1) NULL DEFAULT NULL COMMENT '登录状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `create_time` datetime NOT NULL COMMENT '登录时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES (1, 'admin', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', b'1', '登录成功', '2024-08-16 15:59:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');

-- ----------------------------
-- Table structure for moment
-- ----------------------------
DROP TABLE IF EXISTS `moment`;
CREATE TABLE `moment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '动态内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `likes` int NULL DEFAULT NULL COMMENT '点赞数量',
  `is_published` bit(1) NOT NULL COMMENT '是否公开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of moment
-- ----------------------------
INSERT INTO `moment` VALUES (1, '测试动态信息', '2024-08-16 17:46:14', 0, b'1');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作者用户名',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES (1, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Naccl\'s Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" - Naccl\'s Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"/img/qr.png\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2020 - 2024\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"/img/reward.jpg\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"咕咕\",\"type\":1},{\"id\":9,\"nameEn\":\"playlistServer\",\"nameZh\":\"播放器平台\",\"value\":\"netease\",\"type\":1},{\"id\":10,\"nameEn\":\"playlistId\",\"nameZh\":\"播放器歌单\",\"value\":\"3071528549\",\"type\":1},{\"id\":11,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":12,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Naccl\",\"type\":2},{\"id\":13,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":14,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/Naccl\",\"type\":2},{\"id\":15,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":16,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":17,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":18,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":19,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":21,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 🤤\\\",\\\"', '更新站点配置信息', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 79, '2024-08-16 17:19:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (2, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Hitushen Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" Hitushen Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"/img/qr.png\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2020 - 2024\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"/img/reward.jpg\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"咕咕\",\"type\":1},{\"id\":9,\"nameEn\":\"playlistServer\",\"nameZh\":\"播放器平台\",\"value\":\"netease\",\"type\":1},{\"id\":10,\"nameEn\":\"playlistId\",\"nameZh\":\"播放器歌单\",\"value\":\"3071528549\",\"type\":1},{\"id\":11,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":12,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Hitushen\",\"type\":2},{\"id\":13,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":14,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/AnQiLaYa\",\"type\":2},{\"id\":15,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":16,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":17,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":18,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":19,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":21,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 ?', '更新站点配置信息', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 44, '2024-08-16 17:22:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (3, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Hitushen Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" Hitushen Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"/img/qr.png\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2020 - 2024\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"/img/reward.jpg\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"咕咕\",\"type\":1},{\"id\":9,\"nameEn\":\"playlistServer\",\"nameZh\":\"播放器平台\",\"value\":\"netease\",\"type\":1},{\"id\":10,\"nameEn\":\"playlistId\",\"nameZh\":\"播放器歌单\",\"value\":\"3071528549\",\"type\":1},{\"id\":11,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":12,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Hitushen\",\"type\":2},{\"id\":13,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":14,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/AnQiLaYa\",\"type\":2},{\"id\":15,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":16,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":17,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":18,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":19,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":21,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 ?', '更新站点配置信息', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 44, '2024-08-16 17:24:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (4, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":1,\"name\":\"日志\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 18, '2024-08-16 17:32:14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (5, 'Admin', '/admin/category', 'DELETE', '{\"id\":1}', '删除分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 17, '2024-08-16 17:32:25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (6, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":2,\"name\":\"JAVA\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 11, '2024-08-16 17:32:32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (7, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":3,\"name\":\"spring boot\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 14, '2024-08-16 17:32:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (8, 'Admin', '/admin/category', 'PUT', '{\"category\":{\"id\":2,\"name\":\"java\",\"blogs\":[]}}', '修改分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 12, '2024-08-16 17:32:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (9, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":4,\"name\":\"vue2\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 17:33:00', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (10, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":5,\"name\":\"vue3\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 11, '2024-08-16 17:33:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (11, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":6,\"name\":\"nodeJS\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 11, '2024-08-16 17:33:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (12, 'Admin', '/admin/category', 'PUT', '{\"category\":{\"id\":6,\"name\":\"node js\",\"blogs\":[]}}', '修改分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 12, '2024-08-16 17:33:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (13, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":7,\"name\":\"css\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 8, '2024-08-16 17:33:30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (14, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":8,\"name\":\"html\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 11, '2024-08-16 17:33:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (15, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":9,\"name\":\"mysql\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 14, '2024-08-16 17:33:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (16, 'Admin', '/admin/category', 'POST', '{\"category\":{\"id\":10,\"name\":\"redis\",\"blogs\":[]}}', '添加分类', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 9, '2024-08-16 17:34:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (17, 'Admin', '/admin/tag', 'POST', '{\"tag\":{\"id\":1,\"name\":\"日志\",\"color\":\"blue\",\"blogs\":[]}}', '添加标签', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 14, '2024-08-16 17:34:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (18, 'Admin', '/admin/blog', 'POST', '{\"blog\":{\"id\":1,\"title\":\"测试\",\"firstPicture\":\"https://cdn.pixabay.com/photo/2021/11/12/03/04/woman-6787784_1280.png\",\"content\":\"测试\",\"description\":\"测试\",\"published\":true,\"recommend\":true,\"appreciation\":true,\"commentEnabled\":true,\"top\":true,\"createTime\":1723800908764,\"updateTime\":1723800908764,\"views\":0,\"words\":100,\"readTime\":1,\"password\":\"\",\"user\":{\"id\":1,\"username\":null,\"password\":null,\"nickname\":null,\"avatar\":null,\"email\":null,\"createTime\":null,\"updateTime\":null,\"role\":null},\"category\":{\"id\":3,\"name\":\"spring boot\",\"blogs\":[]},\"tags\":[],\"cate\":3,\"tagList\":[1]}}', '发布博客', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 29, '2024-08-16 17:35:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (19, 'Admin', '/admin/moment', 'POST', '{\"moment\":{\"id\":1,\"content\":\"测试动态信息\",\"createTime\":1723801574000,\"likes\":0,\"published\":true}}', '发布动态', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 13, '2024-08-16 17:46:17', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `operation_log` VALUES (20, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Hitushen Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" Hitushen Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"/img/qr.png\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2020 - 2024\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"/img/reward.jpg\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"站长\",\"type\":1},{\"id\":9,\"nameEn\":\"playlistServer\",\"nameZh\":\"播放器平台\",\"value\":\"netease\",\"type\":1},{\"id\":10,\"nameEn\":\"playlistId\",\"nameZh\":\"播放器歌单\",\"value\":\"3071528549\",\"type\":1},{\"id\":11,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":12,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Hitushen\",\"type\":2},{\"id\":13,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":14,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/AnQiLaYa\",\"type\":2},{\"id\":15,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":16,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":17,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":18,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":19,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":21,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 ?', '更新站点配置信息', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 60, '2024-08-16 18:02:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint NULL DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', '0 0 1 * * ?', 1, '每天凌晨一点，从Redis将博客浏览量同步到数据库', '2020-11-17 23:45:42');
INSERT INTO `schedule_job` VALUES (2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', '0 0 0 * * ?', 1, '清空当天Redis访客标识，记录当天的PV和UV，更新当天所有访客的PV和最后访问时间，更新城市新增访客UV数', '2021-02-05 08:14:28');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`  (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint NOT NULL COMMENT '任务执行结果',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `times` int NOT NULL COMMENT '耗时（单位：毫秒）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for site_setting
-- ----------------------------
DROP TABLE IF EXISTS `site_setting`;
CREATE TABLE `site_setting`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `type` int NULL DEFAULT NULL COMMENT '1基础设置，2页脚徽标，3资料卡，4友链信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of site_setting
-- ----------------------------
INSERT INTO `site_setting` VALUES (1, 'blogName', '博客名称', 'Hitushen Blog', 1);
INSERT INTO `site_setting` VALUES (2, 'webTitleSuffix', '网页标题后缀', ' Hitushen Blog', 1);
INSERT INTO `site_setting` VALUES (3, 'footerImgTitle', '页脚图片标题', '手机看本站', 1);
INSERT INTO `site_setting` VALUES (4, 'footerImgUrl', '页脚图片路径', '/img/qr.png', 1);
INSERT INTO `site_setting` VALUES (5, 'copyright', 'Copyright', '{\"title\":\"Copyright © 2020 - 2024\",\"siteName\":\"NACCL\'S BLOG\"}', 1);
INSERT INTO `site_setting` VALUES (6, 'beian', 'ICP备案号', '', 1);
INSERT INTO `site_setting` VALUES (7, 'reward', '赞赏码', '/img/reward.jpg', 1);
INSERT INTO `site_setting` VALUES (8, 'commentAdminFlag', '博主评论标识', '站长', 1);
INSERT INTO `site_setting` VALUES (9, 'playlistServer', '播放器平台', 'netease', 1);
INSERT INTO `site_setting` VALUES (10, 'playlistId', '播放器歌单', '3071528549', 1);
INSERT INTO `site_setting` VALUES (11, 'avatar', '头像', '/img/avatar.jpg', 2);
INSERT INTO `site_setting` VALUES (12, 'name', '昵称', 'Hitushen', 2);
INSERT INTO `site_setting` VALUES (13, 'rollText', '滚动个签', '\"云鹤当归天，天不迎我妙木仙；\",\"游龙当归海，海不迎我自来也。\"', 2);
INSERT INTO `site_setting` VALUES (14, 'github', 'GitHub', 'https://github.com/AnQiLaYa', 2);
INSERT INTO `site_setting` VALUES (15, 'telegram', 'Telegram', 'https://t.me/NacclOfficial', 2);
INSERT INTO `site_setting` VALUES (16, 'qq', 'QQ', 'http://sighttp.qq.com/authd?IDKEY=', 2);
INSERT INTO `site_setting` VALUES (17, 'bilibili', 'bilibili', 'https://space.bilibili.com/', 2);
INSERT INTO `site_setting` VALUES (18, 'netease', '网易云音乐', 'https://music.163.com/#/user/home?id=', 2);
INSERT INTO `site_setting` VALUES (19, 'email', 'email', 'mailto:you@example.com', 2);
INSERT INTO `site_setting` VALUES (20, 'favorite', '自定义', '{\"title\":\"最喜欢的动漫 📺\",\"content\":\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\"}', 2);
INSERT INTO `site_setting` VALUES (21, 'favorite', '自定义', '{\"title\":\"最喜欢我的女孩子们 🤤\",\"content\":\"芙兰达、土间埋、食蜂操祈、佐天泪爷、樱岛麻衣、桐崎千棘、02、亚丝娜、高坂桐乃、五更琉璃、安乐冈花火、一色彩羽、英梨梨、珈百璃、时崎狂三、可儿那由多、和泉纱雾、早坂爱\"}', 2);
INSERT INTO `site_setting` VALUES (22, 'favorite', '自定义', '{\"title\":\"最喜欢玩的游戏 🎮\",\"content\":\"Stellaris、巫师、GTA、荒野大镖客、刺客信条、魔兽争霸、LOL、PUBG\"}', 2);
INSERT INTO `site_setting` VALUES (23, 'badge', '徽标', '{\"title\":\"本博客已开源于 GitHub\",\"url\":\"https://github.com/Naccl/NBlog\",\"subject\":\"NBlog\",\"value\":\"Open Source\",\"color\":\"brightgreen\"}', 3);
INSERT INTO `site_setting` VALUES (24, 'badge', '徽标', '{\"title\":\"由 Spring Boot 强力驱动\",\"url\":\"https://spring.io/projects/spring-boot/\",\"subject\":\"Powered\",\"value\":\"Spring Boot\",\"color\":\"blue\"}', 3);
INSERT INTO `site_setting` VALUES (25, 'badge', '徽标', '{\"title\":\"Vue.js 客户端渲染\",\"url\":\"https://cn.vuejs.org/\",\"subject\":\"SPA\",\"value\":\"Vue.js\",\"color\":\"brightgreen\"}', 3);
INSERT INTO `site_setting` VALUES (26, 'badge', '徽标', '{\"title\":\"UI 框架 Semantic-UI\",\"url\":\"https://semantic-ui.com/\",\"subject\":\"UI\",\"value\":\"Semantic-UI\",\"color\":\"semantic-ui\"}', 3);
INSERT INTO `site_setting` VALUES (27, 'badge', '徽标', '{\"title\":\"阿里云提供服务器及域名相关服务\",\"url\":\"https://www.aliyun.com/\",\"subject\":\"VPS & DNS\",\"value\":\"Aliyun\",\"color\":\"blueviolet\"}', 3);
INSERT INTO `site_setting` VALUES (28, 'badge', '徽标', '{\"title\":\"静态资源托管于 GitHub\",\"url\":\"https://github.com/\",\"subject\":\"OSS\",\"value\":\"GitHub\",\"color\":\"github\"}', 3);
INSERT INTO `site_setting` VALUES (29, 'badge', '徽标', '{\"title\":\"jsDelivr 加速静态资源\",\"url\":\"https://www.jsdelivr.com/\",\"subject\":\"CDN\",\"value\":\"jsDelivr\",\"color\":\"orange\"}', 3);
INSERT INTO `site_setting` VALUES (30, 'badge', '徽标', '{\"color\":\"lightgray\",\"subject\":\"CC\",\"title\":\"本站点采用 CC BY 4.0 国际许可协议进行许可\",\"url\":\"https://creativecommons.org/licenses/by/4.0/\",\"value\":\"BY 4.0\"}', 3);
INSERT INTO `site_setting` VALUES (31, 'friendContent', '友链页面信息', '随机排序，不分先后。欢迎交换友链~(￣▽￣)~*\n\n* 昵称：Naccl\n* 一句话：游龙当归海，海不迎我自来也。\n* 网址：[https://naccl.top](https://naccl.top)\n* 头像URL：[https://naccl.top/img/avatar.jpg](https://naccl.top/img/avatar.jpg)\n\n仅凭个人喜好添加友链，请在收到我的回复邮件后再于贵站添加本站链接。原则上已添加的友链不会删除，如果你发现自己被移除了，恕不另行通知，只需和我一样做就好。\n\n', 4);
INSERT INTO `site_setting` VALUES (32, 'friendCommentEnabled', '友链页面评论开关', '1', 4);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签颜色(可选)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, '日志', 'blue');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色访问权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Admin', '$2a$10$4wnwMW8Z4Bn6wR4K1YlbquQunlHM/4rvudVBX8oyfx16xeVtI6i7C', 'Admin', '/img/avatar.jpg', 'admin@naccl.top', '2020-09-21 16:47:18', '2020-09-21 16:47:22', 'ROLE_admin');

-- ----------------------------
-- Table structure for visit_log
-- ----------------------------
DROP TABLE IF EXISTS `visit_log`;
CREATE TABLE `visit_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访客标识码',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求参数',
  `behavior` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问行为',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '访问时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_log
-- ----------------------------
INSERT INTO `visit_log` VALUES (1, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 177, '2024-08-16 14:44:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (2, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 40, '2024-08-16 14:45:01', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (3, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 3, '2024-08-16 14:49:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (4, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 14, '2024-08-16 14:50:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (5, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/moments', 'GET', '{\"pageNum\":1}', '访问页面', '动态', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 23, '2024-08-16 14:50:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (6, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 116, '2024-08-16 14:50:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (7, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 16, '2024-08-16 14:51:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (8, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 14:51:37', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (9, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 14:52:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (10, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 2, '2024-08-16 14:52:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (11, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 3, '2024-08-16 14:53:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (12, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 14:53:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (13, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 15:01:06', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (14, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 15:18:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (15, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 15:18:43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (16, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 83, '2024-08-16 16:56:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (17, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 6, '2024-08-16 17:14:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (18, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 8, '2024-08-16 17:14:56', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (19, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 17:15:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (20, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 5, '2024-08-16 17:15:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (21, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 8, '2024-08-16 17:16:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (22, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 17:16:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (23, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 17:17:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (24, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 3, '2024-08-16 17:19:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (25, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 19, '2024-08-16 17:22:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (26, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 17:28:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (27, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 498, '2024-08-16 17:35:18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (28, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blog', 'GET', '{\"id\":1}', '查看博客', '测试', '文章标题：测试', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 12, '2024-08-16 17:35:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (29, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/searchBlog', 'GET', '{\"query\":\"测试\"}', '搜索博客', '测试', '搜索内容：测试', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 6, '2024-08-16 17:36:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (30, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 5, '2024-08-16 17:46:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (31, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/moments', 'GET', '{\"pageNum\":1}', '访问页面', '动态', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 12, '2024-08-16 17:46:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (32, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 9, '2024-08-16 17:48:42', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (33, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 9, '2024-08-16 17:57:47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (34, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 17:58:04', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (35, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 18:01:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (36, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 30, '2024-08-16 18:01:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (37, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/moments', 'GET', '{\"pageNum\":1}', '访问页面', '动态', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 13, '2024-08-16 18:01:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (38, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 5, '2024-08-16 18:01:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (39, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 18:02:40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (40, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 18:02:58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (41, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 3, '2024-08-16 18:03:50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (42, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 2, '2024-08-16 18:04:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (43, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 18:04:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (44, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/category', 'GET', '{\"categoryName\":\"redis\",\"pageNum\":1}', '查看分类', 'redis', '分类名称：redis，第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 8, '2024-08-16 18:04:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (45, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/category', 'GET', '{\"categoryName\":\"spring boot\",\"pageNum\":1}', '查看分类', 'spring boot', '分类名称：spring boot，第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 10, '2024-08-16 18:04:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (46, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 4, '2024-08-16 18:04:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (47, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 5, '2024-08-16 18:08:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (48, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 18:09:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (49, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 7, '2024-08-16 18:11:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (50, '40e41c5e-6fcb-36d1-95ce-4b3827250faf', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.100.198', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 9, '2024-08-16 22:12:33', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visit_log` VALUES (51, '40e41c5e-6fcb-36d1-95ce-4b3827250faf', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.100.198', '内网IP|内网IP', 'Windows >=10', 'Edge 127', 5, '2024-08-16 22:12:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');

-- ----------------------------
-- Table structure for visit_record
-- ----------------------------
DROP TABLE IF EXISTS `visit_record`;
CREATE TABLE `visit_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pv` int NOT NULL COMMENT '访问量',
  `uv` int NOT NULL COMMENT '独立用户',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日期\"02-23\"',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visit_record
-- ----------------------------

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '访客标识码',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '首次访问时间',
  `last_time` datetime NOT NULL COMMENT '最后访问时间',
  `pv` int NULL DEFAULT NULL COMMENT '访问页数统计',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_uuid`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of visitor
-- ----------------------------
INSERT INTO `visitor` VALUES (1, '49d7b85c-bfdf-317a-9921-2d9ba9ea8f45', '192.168.0.34', '内网IP|内网IP', 'Windows >=10', 'Edge 127', '2024-08-16 14:44:56', '2024-08-16 14:44:56', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');
INSERT INTO `visitor` VALUES (2, '40e41c5e-6fcb-36d1-95ce-4b3827250faf', '192.168.100.198', '内网IP|内网IP', 'Windows >=10', 'Edge 127', '2024-08-16 22:12:33', '2024-08-16 22:12:33', 0, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36 Edg/127.0.0.0');

SET FOREIGN_KEY_CHECKS = 1;
