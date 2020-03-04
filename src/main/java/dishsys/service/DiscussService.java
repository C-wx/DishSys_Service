package dishsys.service;

import dishsys.bean.Discuss;
import dishsys.mapper.DiscussMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 评论处理器
 */
@Service
public class DiscussService {

    @Autowired
    private DiscussMapper discussMapper;


    public void doAdd(Discuss discuss) {
        discussMapper.insertSelective(discuss);
    }

    public List<Discuss> getAll() {
        return  discussMapper.selectByExample(null);
    }
}
