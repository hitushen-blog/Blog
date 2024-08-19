<template>
  <div>
    <el-form :model="form" label-position="top">

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

      <el-form-item label="动态内容" prop="content">
        <mavon-editor ref="md_one" v-model="form.content" @imgAdd="imgAdd('one',arguments)"/>
      </el-form-item>

      <el-form-item label="点赞数" prop="likes" style="width: 50%">
        <el-input v-model="form.likes" type="number" placeholder="可选，默认为 0"></el-input>
      </el-form-item>

      <el-form-item label="创建时间" prop="createTime">
        <el-date-picker v-model="form.createTime" type="datetime" placeholder="可选，默认此刻"
                        :editable="false"></el-date-picker>
      </el-form-item>

      <el-form-item style="text-align: right;">
        <el-button type="info" @click="submit(false)">仅自己可见</el-button>
        <el-button type="primary" @click="submit(true)">发布动态</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import Breadcrumb from "@/components/Breadcrumb";
import {getMomentById, saveMoment, updateMoment} from "@/api/moment";
import {randomUUID} from "@/util/uuid";
import {taskQueue} from "@/util/task-queue";
import {getUserRepos, upload} from "@/api/github";

export default {
  name: "WriteMoment",
  components: {Breadcrumb},
  data() {
    return {
      form: {
        content: '',
        createTime: null,
        likes: 0,
        published: false,
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
  created() {
    if (this.$route.params.id) {
      this.getMoment(this.$route.params.id)
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
    getMoment(id) {
      getMomentById(id).then(res => {
        this.form = res.data
      })
    },
    submit(published) {
      this.form.published = published
      if (this.$route.params.id) {
        updateMoment(this.form).then(res => {
          this.msgSuccess(res.msg)
          this.$router.push('/blog/moment/list')
        })
      } else {
        saveMoment(this.form).then(res => {
          this.msgSuccess(res.msg)
          this.$router.push('/blog/moment/list')
        })
      }
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