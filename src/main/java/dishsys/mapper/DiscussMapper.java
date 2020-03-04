package dishsys.mapper;

import dishsys.bean.Discuss;
import dishsys.bean.DiscussExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DiscussMapper {
    long countByExample(DiscussExample example);

    int deleteByExample(DiscussExample example);

    int deleteByPrimaryKey(Long id);

    int insert(Discuss record);

    int insertSelective(Discuss record);

    List<Discuss> selectByExample(DiscussExample example);

    Discuss selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") Discuss record, @Param("example") DiscussExample example);

    int updateByExample(@Param("record") Discuss record, @Param("example") DiscussExample example);

    int updateByPrimaryKeySelective(Discuss record);

    int updateByPrimaryKey(Discuss record);
}