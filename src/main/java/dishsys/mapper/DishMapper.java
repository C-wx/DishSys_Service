package dishsys.mapper;

import dishsys.bean.Dish;
import dishsys.bean.DishExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DishMapper {
    long countByExample(DishExample example);

    int deleteByExample(DishExample example);

    int deleteByPrimaryKey(Long id);

    int insert(Dish record);

    int insertSelective(Dish record);

    List<Dish> selectByExample(DishExample example);

    Dish selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") Dish record, @Param("example") DishExample example);

    int updateByExample(@Param("record") Dish record, @Param("example") DishExample example);

    int updateByPrimaryKeySelective(Dish record);

    int updateByPrimaryKey(Dish record);

    List<Dish> getHotFootList();

    List<Dish> getCorrespond(@Param("classifyId") Integer classifyId);
}