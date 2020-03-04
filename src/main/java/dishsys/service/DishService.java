package dishsys.service;

import dishsys.bean.Classify;
import dishsys.bean.Dish;
import dishsys.bean.DishExample;
import dishsys.mapper.DishMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Explain: 菜品处理器
 */
@Service
public class DishService {

    @Autowired
    private DishMapper dishMapper;

    @Autowired
    private ClassifyService classifyService;

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

    public List<Dish> getRemendedFootList() {
        DishExample dishExample = new DishExample();
        dishExample.createCriteria().andRecommendedGreaterThan(4);
        return dishMapper.selectByExample(dishExample);
    }

    public List<Dish> getHotFootList() {
        return dishMapper.getHotFootList();
    }

    public List<Map<String, Object>> getClassifyDish() {
        List<Classify> classifies = classifyService.getAll();
        List<Map<String, Object>> classifyDishList = new ArrayList<>();
        for (Classify classify : classifies) {
            Map<String,Object> foodMap = new HashMap<>();
            foodMap.put("name",classify.getValue());
            List<Dish> dishList = dishMapper.getCorrespond(classify.getId());
            foodMap.put("foods",dishList);
            classifyDishList.add(foodMap);
        }
        return classifyDishList;
    }

    public List<Dish> getSearchResult(String name) {
        DishExample dishExample = new DishExample();
        dishExample.createCriteria().andNameLike("%" + name + "%");
        return dishMapper.selectByExample(dishExample);
    }
}
