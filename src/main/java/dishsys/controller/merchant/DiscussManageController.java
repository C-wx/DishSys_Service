package dishsys.controller.merchant;

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
import org.springframework.web.bind.annotation.RequestMapping;
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
     * -----------------------小程序端操作-----------------------
     */

    @ResponseBody
    @RequestMapping("/doComment")
    public Object doComment(Discuss discuss) {
        discussService.doAdd(discuss);
        Order order = new Order();
        order.setOrderCode(discuss.getOrderCode());
        order.setOrderStatus("2");
        orderService.doEdit(order);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/getAllDiscuss")
    public Object getAllDiscuss() {
        List<Discuss> discussList = discussService.getAll();
        for (Discuss discuss : discussList) {
            Customer customer = customerService.getByOpenId(discuss.getOpenId());
            discuss.setCustomer(customer);
            List<Order> orderList = orderService.getDetail(discuss.getOrderCode());
            for (Order order : orderList) {
                Dish dish = dishService.getOne(order.getDishId());
                order.setDish(dish);

            }
            discuss.setOrderList(orderList);
        }
        return Result.success(discussList);
    }

}