package dishsys.service;

import dishsys.bean.Dish;
import dishsys.mapper.DishMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 菜品处理器
 */
@Service
public class DishService {

    @Autowired
    private DishMapper dishMapper;

    public List<Dish> getAll() {
        return dishMapper.selectByExample(null);
    }

    public Dish getOne(Long id) {
        return dishMapper.selectByPrimaryKey(id);
    }

    public void doEdit(Dish dish) {
        dishMapper.updateByPrimaryKeySelective(dish);
    }

    public void doAdd(Dish dish) {
        dishMapper.insertSelective(dish);
    }

    public void doDel(Dish dish) {
        dishMapper.deleteByPrimaryKey(dish.getId());
    }
}
