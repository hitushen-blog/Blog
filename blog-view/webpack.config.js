// webpack.config.js
const { VueLoaderPlugin } = require('vue-loader'); // 必须引入插件

module.exports = {
    module: {
        rules: [
            {
                test: /\.vue$/, // 匹配.vue文件
                loader: 'vue-loader' // 使用vue-loader
            },
            // 还需要处理vue中的js和css
            {
                test: /\.js$/,
                loader: 'babel-loader'
            },
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader'] // 顺序不能反
            }
        ]
    },
    plugins: [
        new VueLoaderPlugin() // 必须添加这个插件，否则vue-loader无效
    ]
};