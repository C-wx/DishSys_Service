package dishsys.controller.merchant;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dishsys.bean.Customer;
import dishsys.bean.Discuss;
import dishsys.bean.Dish;
import dishsys.bean.Order;
import dishsys.dto.Result;
import dishsys.service.CustomerService;
import dishsys.service.DiscussService;
import dishsys.service.DishService;
import dishsys.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Explain: 评论控制器
 */
@Controller
public class DiscussManageController {

    @Autowired
    private DiscussService discussService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private DishService dishService;

    /**
     * @param pn        页码
     * @param size      每页的数量
     * @param sort      排序条件
     * @param order     排序规则
     * @param orderCode 订单编码
     * @Explain 获取评论列表
     */
    @RequestMapping("/toDiscussManage")
    public String toDiscussManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                                  @RequestParam(value = "size", defaultValue = "6") Integer size,
                                  @RequestParam(value = "sort", defaultValue = "id") String sort,
                                  @RequestParam(value = "order", defaultValue = "desc") String order,
                                  @RequestParam(value = "orderCode", defaultValue = "%") String orderCode,
                                  Model model) {
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Discuss> discussList = discussService.getAll(orderCode);
        for (Discuss discuss : discussList) {
            Customer customer = customerService.getByOpenId(discuss.getOpenId());
            discuss.setCustomer(customer);
        }
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据，传入分页插件中要显示的页的数目 1 2 3 4 5
        PageInfo pageInfo = new PageInfo(discussList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "discussManage";
    }


    /**
     * -----------------------小程序端操作-----------------------
     */

    /**
     * @param discuss 评论传输实体
     * @Explain 发布评论
     */
    @ResponseBody
    @RequestMapping("/doComment")
    public Object doComment(Discuss discuss) {
        discussService.doAdd(discuss);          //插入评论
        Order order = new Order();
        order.setOrderCode(discuss.getOrderCode());
        order.setOrderStatus("2");      // 将订单状态置为  “已评论”
        orderService.doEdit(order);
        return Result.success();
    }

    /**
     * @Explain 获取评论列表
     */
    @ResponseBody
    @RequestMapping("/getAllDiscuss")
    public Object getAllDiscuss() {
        List<Discuss> discussList = discussService.getAll("%");
        for (Discuss discuss : discussList) {       //遍历评论
            Customer customer = customerService.getByOpenId(discuss.getOpenId());
            discuss.setCustomer(customer);          //查出评论人
            List<Order> orderList = orderService.getDetail(discuss.getOrderCode());         //查出该评论对应的订单
            for (Order order : orderList) {         //查出订单中所有的菜品
                Dish dish = dishService.getOne(order.getDishId());
                order.setDish(dish);

            }
            discuss.setOrderList(orderList);
        }
        return Result.success(discussList);
    }

}