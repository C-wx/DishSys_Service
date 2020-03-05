package dishsys.service;

import dishsys.bean.Article;
import dishsys.bean.ArticleExample;
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

    public List<Article> getAll(String title) {
        ArticleExample articleExample = new ArticleExample();
        articleExample.createCriteria().andTitleLike("%" + title.trim() + "%");
        articleExample.setOrderByClause("id desc");
        return articleMapper.selectByExampleWithBLOBs(articleExample);
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
