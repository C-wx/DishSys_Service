package dishsys.mapper;

import dishsys.bean.Order;
import dishsys.bean.OrderExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {
    long countByExample(OrderExample example);

    int deleteByExample(OrderExample example);

    int deleteByPrimaryKey(Long id);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    List<Order> getAll(@Param("orderCode") String orderCode);

    List<String> getOrderCodeList(@Param("orderStatus") String orderStatus,@Param("openId") String openId);
}