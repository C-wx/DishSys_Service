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

    public List<Order> getAll() {
        return orderMapper.getAll();
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

    public List<List<Order>> getOrderList(String orderStatus) {
        List<String> orderCodeList = orderMapper.getOrderCodeList(orderStatus);
        List<List<Order>> totalList = new ArrayList<>();
        for (String orderCode : orderCodeList) {
            OrderExample orderExample = new OrderExample();
            orderExample.createCriteria().andOrderCodeEqualTo(orderCode);
            List<Order> orderList = orderMapper.selectByExample(orderExample);
            for (Order order : orderList) {
                Dish dish = dishService.getOne(order.getDishId());
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
