package dishsys.service;

import dishsys.mapper.ImageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Explain: 图片处理器
 */
@Service
public class ImageService {

    @Autowired
    private ImageMapper imageMapper;

}
