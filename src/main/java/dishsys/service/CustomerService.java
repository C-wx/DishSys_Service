package dishsys.service;

import dishsys.bean.Customer;
import dishsys.bean.CustomerExample;
import dishsys.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 客户处理器
 */
@Service
public class CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    public Customer getByOpenId(String openId) {
        CustomerExample customerExample = new CustomerExample();
        customerExample.createCriteria().andOpenIdEqualTo(openId);
        List<Customer> customerList = customerMapper.selectByExample(customerExample);
        return customerList.size() > 0 ? customerList.get(0) : null;
    }

    public void doAdd(Customer customer) {
        customerMapper.insertSelective(customer);
    }
}
