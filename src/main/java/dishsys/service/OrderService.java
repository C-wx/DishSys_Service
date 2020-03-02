package dishsys.service;

import dishsys.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Explain: 订单处理器
 */
@Service
public class OrderService {

    @Autowired
    private OrderMapper orderMapper;

}
