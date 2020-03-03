package dishsys.service;

import dishsys.bean.Merchant;
import dishsys.bean.MerchantExample;
import dishsys.mapper.MerchantMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 商家处理器
 */
@Service
public class MerchantService {

    @Autowired
    private MerchantMapper merchantMapper;

    public Merchant getByPhoneAndPwd(Merchant merchant) {
        MerchantExample example = new MerchantExample();
        example.createCriteria().andPhoneEqualTo(merchant.getPhone()).andPasswordEqualTo(merchant.getPassword());
        List<Merchant> merchantList = merchantMapper.selectByExample(example);
        return merchantList.size() > 0 ? merchantList.get(0) : null;
    }

    public void doEdit(Merchant merchant) {
        merchantMapper.updateByPrimaryKeySelective(merchant);
    }
}