package dishsys.service;

import dishsys.bean.Classify;
import dishsys.mapper.ClassifyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 分类处理器
 */
@Service
public class ClassifyService {

    @Autowired
    private ClassifyMapper classifyMapper;

    public List<Classify> getAll() {
        return classifyMapper.selectByExample(null);
    }

    public void doEdit(Classify classify) {
        classifyMapper.updateByPrimaryKeySelective(classify);
    }

    public void doAdd(Classify classify) {
        classifyMapper.insertSelective(classify);
    }

    public void doDel(Classify classify) {
        classifyMapper.deleteByPrimaryKey(classify.getId());
    }

    public Classify getOne(Integer classifyId) {
        return classifyMapper.selectByPrimaryKey(classifyId);
    }
}
