package dishsys.service;

import dishsys.bean.Order;
import dishsys.bean.OrderExample;
import dishsys.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 订单处理器
 */
@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

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
}
