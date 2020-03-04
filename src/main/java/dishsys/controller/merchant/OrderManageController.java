package dishsys.controller.merchant;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dishsys.bean.Customer;
import dishsys.bean.Dish;
import dishsys.bean.Order;
import dishsys.dto.Result;
import dishsys.service.CustomerService;
import dishsys.service.DishService;
import dishsys.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @Explain: 订单管理控制类
 */
@Controller
public class OrderManageController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private DishService dishService;

    @RequestMapping("/toOrderManage")
    public String toOrderManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                                @RequestParam(value = "size", defaultValue = "6") Integer size,
                                @RequestParam(value = "sort", defaultValue = "id") String sort,
                                @RequestParam(value = "order", defaultValue = "desc") String order,
                                Model model) {
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Order> orderList = orderService.getAll();
        for (Order o : orderList) {
            Customer custome = customerService.getByOpenId(o.getOpenId());
            o.setCustomer(custome);
        }
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        //封装了详细的分页信息，包括有我们查询出来的数据，传入分页插件中要显示的页的数目 1 2 3 4 5
        PageInfo pageInfo = new PageInfo(orderList, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "orderManage";
    }

    @RequestMapping("toOrderDetail")
    public String toOrderDetail(String orderCode, Model model) {
        List<Order> orderList = orderService.getDetail(orderCode);
        Float totalPrice = 0f;
        for (Order order : orderList) {
            Dish dish = dishService.getOne(order.getDishId());
            order.setDish(dish);
            totalPrice += order.getPrice();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("orderList", orderList);
        return "orderDetail";
    }

    @ResponseBody
    @RequestMapping("/doOutDish")
    public Object doOutDish(Order order) {
        orderService.doEdit(order);
        return Result.success();
    }

    /**
     * ----------------------小程序端---------------------------
     **/

    @ResponseBody
    @RequestMapping("/submitOrder")
    public Object submitOrder(@RequestParam("orderInfo") String orderInfo) {
        JSONArray orderArray = JSONArray.parseArray(orderInfo);
        String orderCode = UUID.randomUUID().toString().substring(0, 8);
        for (Object o : orderArray) {
            Order oi = JSON.toJavaObject((JSON) o, Order.class);
            oi.setOrderCode(orderCode);
            orderService.doAdd(oi);
        }
        return Result.success(orderCode);
    }

    @ResponseBody
    @RequestMapping("/doPay")
    public Object doPay(String orderCode) {
        Order order = new Order();
        order.setPayTime(new Date());
        order.setOrderStatus("1");
        order.setOrderCode(orderCode);
        orderService.doPay(order);
        return Result.success();
    }

    @ResponseBody
    @RequestMapping("/getOrderList")
    public Object getOrderList(String orderStatus) {
        if ("-1".equals(orderStatus)) {
            orderStatus = "%";
        } else {
            orderStatus = "%" + orderStatus + "%";
        }
        List<List<Order>> orderList = orderService.getOrderList(orderStatus);
        return Result.success(orderList);
    }

    @ResponseBody
    @RequestMapping("/cancelOrder")
    public Object cancelOrder(String orderCode) {
        orderService.doDel(orderCode);
        return Result.success();
    }

}