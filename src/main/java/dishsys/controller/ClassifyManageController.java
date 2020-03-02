package dishsys.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dishsys.bean.Classify;
import dishsys.dto.Result;
import dishsys.service.ClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Explain: 分类管理控制类
 */
@Controller
public class ClassifyManageController {

    @Autowired
    private ClassifyService classifyService;

    @RequestMapping("/toClassifyManage")
    public String toClassifyManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                                   @RequestParam(value = "size", defaultValue = "6") Integer size,
                                   @RequestParam(value = "sort", defaultValue = "id") String sort,
                                   @RequestParam(value = "order", defaultValue = "desc") String order,
                                   Model model) {
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Classify> classifyList = classifyService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据，传入分页插件中要显示的页的数目 1 2 3 4 5
        PageInfo pageInfo = new PageInfo(classifyList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "classifyManage";
    }

    @ResponseBody
    @RequestMapping("/doSaveClassify")
    public Object doSaveClassify(Classify classify) {
        if ("delete".equals(classify.getType())) {      //删除操作
            classifyService.doDel(classify);
        } else if (null != classify.getId()) {     // ID 不为空说明为修改操作
            classifyService.doEdit(classify);
        } else {                              // 否则是 添加操作
            classifyService.doAdd(classify);
        }
        return Result.success();
    }

}
