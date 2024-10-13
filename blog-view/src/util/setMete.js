export default (useMeta) => {
    // {
    //   title: import.meta.env.VITE_APP_TITLE, //标题
    //   titleTemplate: import.meta.env.VITE_APP_HELLO, //标题模板
    //   htmlAttrs: {
    //     //语言
    //     lang: "en",
    //     amp: true,
    //   },
    //   meta: [
    //     {
    //       //关键词
    //       name: "keywords",
    //       content: "办公系统",
    //     },
    //     {
    //       //介绍
    //       name: "description",
    //       content: "申云鹏,前端,办公系统",
    //     },
    //   ],
    // }
    //处理标题
    let title = document.getElementsByTagName("title");
    if (useMeta.title != null && useMeta.title != "") {
        for (let i = 0; i < title.length; i++) {
            const element = title[i];
            element.remove();
        }
        let createTitle = document.createElement("title");
        createTitle.innerText = useMeta.title;
        document.head.appendChild(createTitle);
    }
    if (useMeta.titleTemplate != null && useMeta.titleTemplate != "") {
        //处理titleTemplate
        let titleTemplate = document.getElementsByTagName("titleTemplate");
        for (let i = 0; i < titleTemplate.length; i++) {
            const element = titleTemplate[i];
            element.remove();
        }
        let createTitleTemplate = document.createElement("titleTemplate");
        createTitleTemplate.innerText = useMeta.titleTemplate;
        document.head.appendChild(createTitleTemplate);
    }
    //html语言
    if (Object.hasOwn(useMeta.htmlAttrs, 'lang') && bject.hasOwn(useMeta.htmlAttrs, 'amp')) {
        let htmlAttrs = document.getElementsByTagName("htmlAttrs");
        for (let i = 0; i < htmlAttrs.length; i++) {
            const element = htmlAttrs[i];
            element.remove();
        }
        let createhtmlAttrs = document.createElement("htmlAttrs");
        createhtmlAttrs.setAttribute("lang", useMeta.htmlAttrs.lang);
        createhtmlAttrs.setAttribute("amp", useMeta.htmlAttrs.amp);
        document.head.appendChild(createhtmlAttrs);
    }

    let metaSet = false;
    //处理meta
    let meta = document.getElementsByTagName("meta");
    for (let i = 0; i < meta.length; i++) {
        const element = meta[i];
        useMeta.meta.forEach((item) => {
            if (element.getAttribute("name") == item.name) {
                metaSet = true;
                element.setAttribute(item.name, item.content);
            }
        });
    }
    if (!metaSet) {
        useMeta.meta.forEach((item) => {
            let createMeta = document.createElement("meta");
            createMeta.setAttribute("name", item.name);
            createMeta.setAttribute("content", item.content);
            document.head.appendChild(createMeta);
        });
    }
}