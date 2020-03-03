package dishsys.service;

import dishsys.bean.Article;
import dishsys.mapper.ArticleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain: 文章处理器
 */
@Service
public class ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    public List<Article> getAll() {
        return articleMapper.selectByExampleWithBLOBs(null);
    }

    public Article getOne(Long id) {
        return articleMapper.selectByPrimaryKey(id);
    }

    public void doEdit(Article article) {
        articleMapper.updateByPrimaryKeySelective(article);
    }

    public void doAdd(Article article) {
        articleMapper.insertSelective(article);
    }

    public void doDel(Article article) {
        articleMapper.deleteByPrimaryKey(article.getId());
    }
}
