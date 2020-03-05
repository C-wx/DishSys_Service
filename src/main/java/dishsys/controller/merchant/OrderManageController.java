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

    /**
     * @param pn        页码
     * @param size      每页的数量
     * @param sort      排序条件
     * @param order     排序规则
     * @param orderCode 订单编码
     * @Explain 获取订单列表
     */
    @RequestMapping("/toOrderManage")
    public String toOrderManage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
                                @RequestParam(value = "size", defaultValue = "6") Integer size,
                                @RequestParam(value = "sort", defaultValue = "id") String sort,
                                @RequestParam(value = "order", defaultValue = "desc") String order,
                                @RequestParam(value = "orderCode", defaultValue = "%") String orderCode,
                                Model model) {
        //在查询之前开启，传入页码，以及每页的大小
        PageHelper.startPage(pn, size, sort + " " + order);     //pn:页码  10：页大小
        List<Order> orderList = orderService.getAll(orderCode);
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

    /**
     * @param orderCode 订单编码
     * @Explain 获取订单详情
     * @Return
     */
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

    /**
     * @param order 订单传输实体
     * @Explain 出菜操作
     */
    @ResponseBody
    @RequestMapping("/doOutDish")
    public Object doOutDish(Order order) {
        orderService.doEdit(order);
        return Result.success();
    }

    /**
     * ----------------------小程序端---------------------------
     **/

    /**
     * @param orderInfo 订单信息
     * @Explain 提交订单
     * @Return
     */
    @ResponseBody
    @RequestMapping("/submitOrder")
    public Object submitOrder(@RequestParam("orderInfo") String orderInfo) {
        JSONArray orderArray = JSONArray.parseArray(orderInfo);
        String orderCode = UUID.randomUUID().toString().substring(0, 8);        //随机生成订单编码
        for (Object o : orderArray) {                                           //拆单操作
            Order oi = JSON.toJavaObject((JSON) o, Order.class);
            oi.setOrderCode(orderCode);
            orderService.doAdd(oi);
        }
        return Result.success(orderCode);
    }

    /**
     * @param orderCode 订单编码
     * @Explain 付款操作
     * @Return
     */
    @ResponseBody
    @RequestMapping("/doPay")
    public Object doPay(String orderCode) {
        Order order = new Order();
        order.setPayTime(new Date());
        order.setOrderStatus("1");      //将订单状态置为  “已付款”
        order.setOrderCode(orderCode);
        orderService.doPay(order);
        List<Order> orderList = orderService.getAll(orderCode);     //获取该订单编码下的所有订单
        /**遍历订单，改变菜品销量*/
        for (Order o : orderList) {
            Dish dish = dishService.getOne(o.getDishId());
            dish.setSales(dish.getSales() + o.getNum());      //原有销量加上订单中的销量 => 当前销量
            dishService.doEdit(dish);                       //更新菜品
        }
        return Result.success();
    }

    /**
     * @param orderStatus 订单状态
     * @param openId 用户标识ID
     * @Explain 根据对应订单状态/用户标识 获取对应订单
     */
    @ResponseBody
    @RequestMapping("/getOrderList")
    public Object getOrderList(String orderStatus,String openId) {
        if ("-1".equals(orderStatus)) {
            orderStatus = "%";
        } else {
            orderStatus = "%" + orderStatus + "%";
        }
        List<List<Order>> orderList = orderService.getOrderList(orderStatus,openId);
        return Result.success(orderList);
    }

    /**
     * @param orderCode 订单编码
     * @Explain 取消订单 == 删除订单
     * @Return
     */
    @ResponseBody
    @RequestMapping("/cancelOrder")
    public Object cancelOrder(String orderCode) {
        orderService.doDel(orderCode);
        return Result.success();
    }

}