package dishsys.service;

import dishsys.bean.Dish;
import dishsys.bean.Order;
import dishsys.bean.OrderExample;
import dishsys.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Explain: 订单处理器
 */
@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private DishService dishService;

    public List<Order> getAll(String orderCode) {
        return orderMapper.getAll("%" + orderCode.trim() + "%");
    }

    public List<Order> getDetail(String orderCode) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andOrderCodeEqualTo(orderCode);
        return orderMapper.selectByExample(orderExample);
    }

    public void doEdit(Order order) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andOrderCodeEqualTo(order.getOrderCode());
        orderMapper.updateByExampleSelective(order, orderExample);
    }

    public void doAdd(Order oi) {
        orderMapper.insertSelective(oi);
    }

    public void doPay(Order order) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andOrderCodeEqualTo(order.getOrderCode());
        orderMapper.updateByExampleSelective(order, orderExample);
    }

    public List<List<Order>> getOrderList(String orderStatus, String openId) {
        List<String> orderCodeList = orderMapper.getOrderCodeList(orderStatus, openId);      //获取订单编号列表
        List<List<Order>> totalList = new ArrayList<>();
        for (String orderCode : orderCodeList) {                                            //根据订单编号查找对应订单
            OrderExample orderExample = new OrderExample();
            orderExample.createCriteria().andOrderCodeEqualTo(orderCode);
            List<Order> orderList = orderMapper.selectByExample(orderExample);
            for (Order order : orderList) {
                Dish dish = dishService.getOne(order.getDishId());                          //根据菜品ID 查找该订单对应的菜品
                order.setDish(dish);
            }
            totalList.add(orderList);
        }
        return totalList;
    }

    public void doDel(String orderCode) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andOrderCodeEqualTo(orderCode);
        orderMapper.deleteByExample(orderExample);
    }
}
