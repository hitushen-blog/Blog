module.exports = {
	configureWebpack: {
		resolve: {
			alias: {
				'assets': '@/assets',
				'common': '@/common',
				'components': '@/components',
				'api': '@/api',
				'views': '@/views',
				'plugins': '@/plugins'
			}
		}
	},
	transpileDependencies: [
		// 告诉Vue CLI需要转译tocbot库
		/[/\\]node_modules[/\\]tocbot[/\\]/
	]
}
