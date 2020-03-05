package dishsys.controller;

import dishsys.bean.Customer;
import dishsys.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Explain: 客户控制器
 */
@Controller
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    /**
     * @param customer
     * @Explain 如果用户为首次登录, 则往数据库插入用户信息
     */
    @ResponseBody
    @RequestMapping("addCustomer")
    public Object addCustomer(Customer customer) {
        Customer ci = customerService.getByOpenId(customer.getOpenId());
        if (null == ci) {       //没有查到用户 说明是首次登录
            customerService.doAdd(customer);
        }
        return "success";
    }

}
