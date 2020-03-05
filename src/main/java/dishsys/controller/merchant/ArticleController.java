package dishsys.controller.merchant;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dishsys.bean.Article;
import dishsys.dto.NkUploader;
import dishsys.dto.Result;
import dishsys.service.ArticleService;
import dishsys.utils.QiniuCloudUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

/**
 * @Explain: 文章控制器
 */
@Controller
public class ArticleController {

    @Autowired
    private ArticleService articleService;


    /**
     * @param pn    页码
     * @param size  每页的数量
     * @param sort  排序条件
     * @param order 排序规则
     * @param title 文章标题
     * @Explain 获取文章列表
     */
    @RequestMapping("/toArticleManage")
    public String toArticleManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                                  @RequestParam(value = "size", defaultValue = "6") Integer size,
                                  @RequestParam(value = "sort", defaultValue = "id") String sort,
                                  @RequestParam(value = "order", defaultValue = "desc") String order,
                                  @RequestParam(value = "title", defaultValue = "%") String title,
                                  Model model) {
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Article> articleList = articleService.getAll(title);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了l。
        //封装了详细的分页信息，包括有我们查询出来的数据，传入分页插件中要显示的页的数目 1 2 3 4 5
        PageInfo pageInfo = new PageInfo(articleList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "articleManage";
    }

    /**
     * @param id 文章ID
     * @Explain 跳转文章操作页面
     */
    @RequestMapping("/toOpeArticle")
    public String toOpeArticle(Long id, Model model) {
        if (null != id) {       //ID 不为空为修改操作  查出对应文章回显
            Article article = articleService.getOne(id);
            model.addAttribute("article", article);
        } else {                //ID 为空为添加操作
            model.addAttribute("article", new Article());
        }
        return "articleOpe";
    }

    /**
     * @param article 文章传输实体
     * @Explain 修改/添加文章操作
     */
    @ResponseBody
    @RequestMapping("doOpeArticle")
    public Object doOpeArticle(Article article) {
        if ("delete".equals(article.getType())) {       //删除文章
            articleService.doDel(article);
            return Result.success();
        }
        if (null != article.getId()) {                  //ID 不为空为修改操作
            articleService.doEdit(article);
        } else {                                         //ID 为空为添加操作
            articleService.doAdd(article);
        }
        return Result.success();
    }

    /**
     * @param file 文件流
     * @Explain 上传文件
     */
    @ResponseBody
    @RequestMapping("/uploadImg")
    public Object uploadImg(@RequestParam(value = "file", required = false) MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件不能为空");
        }
        try {
            byte[] bytes = file.getBytes();
            String imageName = UUID.randomUUID().toString();
            String url = QiniuCloudUtil.put64image(bytes, imageName);
            return new NkUploader().ok(url);
        } catch (Exception e) {
            return Result.error("上传图片异常");
        }
    }

    /**
     * @param id 文章ID
     * @Explain 获取文章详情
     */
    @ResponseBody
    @RequestMapping("/getArticle")
    public Object getArticle(Long id) {
        Article article = articleService.getOne(id);
        return Result.success(article);
    }

    /**
     * -----------------小程序端操作--------------------
     */

    /**
     * @Explain 获取文章列表
     */
    @ResponseBody
    @RequestMapping("/getAllArticle")
    public Object getAllArticle() {
        List<Article> articleList = articleService.getAll("%");
        return Result.success(articleList);
    }

}
