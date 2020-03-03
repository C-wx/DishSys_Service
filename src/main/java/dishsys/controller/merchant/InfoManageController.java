package dishsys.controller.merchant;

import dishsys.bean.Merchant;
import dishsys.dto.Result;
import dishsys.service.MerchantService;
import dishsys.utils.QiniuCloudUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.UUID;

/**
 * @Explain: 信息管理控制类
 */
@Controller
public class InfoManageController {

    @Autowired
    private MerchantService merchantService;

    @RequestMapping("/toInfoManage")
    public String toInfoManage() {
        return "infoManage";
    }

    /**
     * @Explain 修改店铺信息
     */
    @ResponseBody
    @RequestMapping("/modifyInfo")
    public Object modifyInfo(Merchant merchant, @RequestParam(value = "files", required = false) MultipartFile[] files, HttpSession session) {
        //上传图片
        for (MultipartFile file : files) {
            if (StringUtils.isNotBlank(file.getOriginalFilename())) {
                try {
                    byte[] bytes = file.getBytes();
                    String imageName = UUID.randomUUID().toString();
                    String url = QiniuCloudUtil.put64image(bytes, imageName);
                    merchant.setAvatar(url);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        merchantService.doEdit(merchant);
        Merchant loginMerchant = merchantService.getByPhoneAndPwd(merchant);
        session.setAttribute("LOGIN_USER", loginMerchant);
        return Result.success();
    }
}
