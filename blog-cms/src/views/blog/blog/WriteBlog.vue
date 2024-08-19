<template>
  <div>
    <el-form :model="form" :rules="formRules" ref="formRef" label-position="top">
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="文章标题" prop="title">
            <el-input v-model="form.title" placeholder="请输入标题"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="文章首图URL" prop="firstPicture">
            <el-input v-model="form.firstPicture" placeholder="文章首图，用于随机文章展示"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <el-form-item label="默认GitHub图床，使用请先配置图床管理">
        <el-row>
          <el-select v-model="activeRepos" placeholder="请选择仓库" :filterable="true" @change="changeRepos"
                     style="min-width: 300px;margin-right: 20px">
            <el-option v-for="item in reposList" :key="item.id" :label="item.name" :value="item.name"></el-option>
          </el-select>

          <el-cascader :key="resourceShow" v-model="activePath" placeholder="请选择目录" :options="pathArr"
                       :props="pathProps" :disabled="!activeRepos"
                       style="min-width: 450px;margin-right: 20px"></el-cascader>

          <el-switch v-model="isCDN" active-text="CDN" inactive-text="源站" :disabled="!activeRepos"></el-switch>

        </el-row>
      </el-form-item>


      <el-form-item label="文章描述" prop="description">
        <mavon-editor ref="md_one" v-model="form.description" @imgAdd="imgAdd('one',arguments)"/>
      </el-form-item>

      <el-form-item label="文章正文" prop="content">
        <mavon-editor ref="md_two" v-model="form.content" @imgAdd="imgAdd('two',arguments)"/>
      </el-form-item>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="分类" prop="cate">
            <el-select v-model="form.cate" placeholder="请选择分类（输入可添加新分类）" :allow-create="true"
                       :filterable="true" style="width: 100%;">
              <el-option :label="item.name" :value="item.id" v-for="item in categoryList" :key="item.id"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="标签" prop="tagList">
            <el-select v-model="form.tagList" placeholder="请选择标签（输入可添加新标签）" :allow-create="true"
                       :filterable="true" :multiple="true" style="width: 100%;">
              <el-option :label="item.name" :value="item.id" v-for="item in tagList" :key="item.id"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="8">
          <el-form-item label="字数" prop="words">
            <el-input v-model="form.words" placeholder="请输入文章字数（自动计算阅读时长）" type="number"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="阅读时长(分钟)" prop="readTime">
            <el-input v-model="form.readTime" placeholder="请输入阅读时长（可选）默认 Math.round(字数 / 200)"
                      type="number"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="8">
          <el-form-item label="浏览次数" prop="views">
            <el-input v-model="form.views" placeholder="请输入文章字数（可选）默认为 0" type="number"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <el-form-item style="text-align: right;">
        <el-button type="primary" @click="dialogVisible=true">保存</el-button>
      </el-form-item>
    </el-form>

    <!--编辑可见性状态对话框-->
    <el-dialog title="博客可见性" width="30%" :visible.sync="dialogVisible">
      <!--内容主体-->
      <el-form label-width="50px" @submit.native.prevent>
        <el-form-item>
          <el-radio-group v-model="radio">
            <el-radio :label="1">公开</el-radio>
            <el-radio :label="2">私密</el-radio>
            <el-radio :label="3">密码保护</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="密码" v-if="radio===3">
          <el-input v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item v-if="radio!==2">
          <el-row>
            <el-col :span="6">
              <el-switch v-model="form.appreciation" active-text="赞赏"></el-switch>
            </el-col>
            <el-col :span="6">
              <el-switch v-model="form.recommend" active-text="推荐"></el-switch>
            </el-col>
            <el-col :span="6">
              <el-switch v-model="form.commentEnabled" active-text="评论"></el-switch>
            </el-col>
            <el-col :span="6">
              <el-switch v-model="form.top" active-text="置顶"></el-switch>
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
      <!--底部-->
      <span slot="footer">
				<el-button @click="dialogVisible=false">取 消</el-button>
				<el-button type="primary" @click="submit">保存</el-button>
			</span>
    </el-dialog>
  </div>
</template>

<script>
import Breadcrumb from "@/components/Breadcrumb";
import {getCategoryAndTag, saveBlog, getBlogById, updateBlog} from '@/api/blog'
import {randomUUID} from "@/util/uuid";
import {taskQueue} from "@/util/task-queue";
import {getUserRepos, upload} from "@/api/github";

export default {
  name: "WriteBlog",
  components: {Breadcrumb},
  data() {
    return {
      categoryList: [],
      tagList: [],
      dialogVisible: false,
      radio: 1,
      form: {
        title: '',
        firstPicture: '',
        description: '',
        content: '',
        cate: null,
        tagList: [],
        words: null,
        readTime: null,
        views: 0,
        appreciation: false,
        recommend: false,
        commentEnabled: false,
        top: false,
        published: false,
        password: '',
      },
      formRules: {
        title: [{required: true, message: '请输入标题', trigger: 'change'}],
        firstPicture: [{required: true, message: '请输入首图链接', trigger: 'change'}],
        cate: [{required: true, message: '请选择分类', trigger: 'change'}],
        tagList: [{required: true, message: '请选择标签', trigger: 'change'}],
        words: [{required: true, message: '请输入文章字数', trigger: 'change'}],
      },

      isCDN: true,
      resourceShow: 0,
      activeRepos: '',
      reposList: [],// 用户仓库
      activePath: [''],// 默认选中根目录
      pathArr: [{value: '', label: '根目录'}],
      userInfo: {}, // 用户信息
      pathProps: {
        lazy: true,
        checkStrictly: true,
        lazyLoad: async (node, resolve) => {
          let path = node.path.join('/')
          let nodes = []
          await this.getReposContents(nodes, path)
          resolve(nodes)
        }
      }
    }
  },
  watch: {
    'form.words'(newValue) {
      this.form.readTime = newValue ? Math.round(newValue / 200) : null
    },
  },
  created() {
    this.getData()
    if (this.$route.params.id) {
      this.getBlog(this.$route.params.id)
    }

    // 我用的是GitHup当作图床，其他对象存储可根据自己的选择更改
    const token = localStorage.getItem('githubToken')
    const userInfo = localStorage.getItem('githubUserInfo')
    if (token && userInfo) {
      this.userInfo = JSON.parse(userInfo)
      this.getRepos()
    } else {
      this.msgError('文件上传功能，请先配置Token')
    }
  },
  methods: {
    getData() {
      getCategoryAndTag().then(res => {
        this.categoryList = res.data.categories
        this.tagList = res.data.tags
      })
    },
    getBlog(id) {
      getBlogById(id).then(res => {
        this.computeCategoryAndTag(res.data)
        this.form = res.data
        this.radio = this.form.published ? (this.form.password !== '' ? 3 : 1) : 2
      })
    },
    computeCategoryAndTag(blog) {
      blog.cate = blog.category.id
      blog.tagList = []
      blog.tags.forEach(item => {
        blog.tagList.push(item.id)
      })
    },
    submit() {
      if (this.radio === 3 && (this.form.password === '' || this.form.password === null)) {
        return this.msgError("密码保护模式必须填写密码！")
      }
      this.$refs.formRef.validate(valid => {
        if (valid) {
          if (this.radio === 2) {
            this.form.appreciation = false
            this.form.recommend = false
            this.form.commentEnabled = false
            this.form.top = false
            this.form.published = false
          } else {
            this.form.published = true
          }
          if (this.radio !== 3) {
            this.form.password = ''
          }
          if (this.$route.params.id) {
            this.form.category = null
            this.form.tags = null
            updateBlog(this.form).then(res => {
              this.msgSuccess(res.msg)
              this.$router.push('/blog/list')
            })
          } else {
            saveBlog(this.form).then(res => {
              this.msgSuccess(res.msg)
              this.$router.push('/blog/list')
            })
          }
        } else {
          this.dialogVisible = false
          return this.msgError('请填写必要的表单项')
        }
      })
    },


    imgAdd(site, [pos, file]) {
      var formData = new FormData()
      formData.append('image', file)
      this.upload({fileName: "file", file}, pos, site)
    },
    //获取用户仓库
    getRepos() {
      getUserRepos(this.userInfo.login).then(res => {
        this.reposList = res
      })
    },
    changeRepos() {
      this.resourceShow++ //改变级联选择器的key来重置其中选项内容
      this.activePath = [''] //默认选中根目录
      this.fileList = []
    },
    upload(data, pos, site) {
      let reader = new FileReader()
      reader.readAsDataURL(data.file)
      reader.onload = (() => {
        let base64 = reader.result.split(",")[1]
        let fileName = data.file.name
        // 富文本编辑默认使用uuid
        fileName = randomUUID() + fileName.substr(fileName.lastIndexOf("."))
        // 批量上传需要间隔时间，否则可能commit版本号冲突，返回409错误码，Status: 409 Conflict
        taskQueue(() => this.push2Github(data, fileName, base64, pos, site), 1000)
      })
    },
    push2Github(data, fileName, base64, pos, site) {
      let requestData = {
        message: "Add files via PictureHosting",
        content: base64,
      }

      let path = this.activePath.join('/')
      if (this.isCustomPath) {
        if (this.customPath === '/') {
          path = ''
        } else {
          path = this.customPath
          if (path.charAt(0) !== '/') {
            path = '/' + path
          }
          if (path.charAt(path.length - 1) === '/') {
            path = path.substring(0, path.length - 1)
          }
        }
      }

      upload(this.userInfo.login, this.activeRepos, path, fileName, requestData).then((res) => {
        let ref = site == "one" ? "md_" + site : "md_" + site
        this.msgSuccess('上传成功')
        this.$refs[ref].$img2Url(pos, res.content.download_url)
      })
    },
  }
}
</script>

<style scoped>

</style>