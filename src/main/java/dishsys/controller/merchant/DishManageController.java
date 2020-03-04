package dishsys.controller.merchant;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dishsys.bean.Classify;
import dishsys.bean.Dish;
import dishsys.dto.Result;
import dishsys.service.ClassifyService;
import dishsys.service.DishService;
import dishsys.utils.QiniuCloudUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @Explain: 菜品控制器
 */
@Controller
public class DishManageController {

    @Autowired
    private DishService dishService;

    @Autowired
    private ClassifyService classifyService;


    @RequestMapping("/toDishManage")
    public String toDishManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                               @RequestParam(value = "size", defaultValue = "6") Integer size,
                               @RequestParam(value = "sort", defaultValue = "id") String sort,
                               @RequestParam(value = "order", defaultValue = "desc") String order,
                               Model model) {
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Dish> dishList = dishService.getAll();
        for (Dish dish : dishList) {
            Classify classify = classifyService.getOne(dish.getClassifyId());
            dish.setClassify(classify);
        }
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据，传入分页插件中要显示的页的数目 1 2 3 4 5
        PageInfo pageInfo = new PageInfo(dishList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "dishManage";
    }

    @RequestMapping("/toOpeDish")
    public String toOpeDish(Long id, Model model) {
        if (null != id) {           //ID 不为空为修改操作，查找对应菜品做回显
            Dish dish = dishService.getOne(id);
            Classify classify = classifyService.getOne(dish.getClassifyId());
            dish.setClassify(classify);
            model.addAttribute("dish", dish);
        }
        List<Classify> classifies = classifyService.getAll();
        model.addAttribute("classifyList", classifies);
        return "dishOpe";
    }

    /**
     * @Explain 添加/修改/删除 菜品
     */
    @ResponseBody
    @RequestMapping("/doOpeDish")
    public Object doOpeDish(Dish dish, @RequestParam(value = "files", required = false) MultipartFile[] files) {
        if ("delete".equals(dish.getType())) {
            dishService.doDel(dish);
            return Result.success();
        }
        //上传图片
        for (MultipartFile file : files) {
            if (StringUtils.isNotBlank(file.getOriginalFilename())) {
                try {
                    byte[] bytes = file.getBytes();
                    String imageName = UUID.randomUUID().toString();
                    String url = QiniuCloudUtil.put64image(bytes, imageName);
                    dish.setPicture(url);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        if (null != dish.getId()) {         //更新操作
            dishService.doEdit(dish);
        } else {
            dishService.doAdd(dish);
        }
        return Result.success();
    }


    /**
     * -------------------------小程序端操作-----------------------------
     */

    @ResponseBody
    @RequestMapping("/getRemendedFootList")
    public Object getRemendedFootList() {
        List<Dish> dishList = dishService.getRemendedFootList();
        return Result.success(dishList);
    }

    @ResponseBody
    @RequestMapping("/getHotFootList")
    public Object getHotFootList() {
        List<Dish> dishList = dishService.getHotFootList();
        return Result.success(dishList);
    }

    @ResponseBody
    @RequestMapping("/getClassifyDish")
    public Object getClassifyDish() {
        List<Map<String, Object>> classifyDishList = dishService.getClassifyDish();
        return Result.success(classifyDishList);
    }

    @ResponseBody
    @RequestMapping("/getDishDetail")
    public Object getDishDetail(Long id) {
        Dish dish = dishService.getOne(id);
        return Result.success(dish);
    }

    @ResponseBody
    @RequestMapping("/getSearchResult")
    public Object getSearchResult(String name) {
        List<Dish> dishList = dishService.getSearchResult(name);
        return Result.success(dishList);

    }
}
