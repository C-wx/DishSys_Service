package dishsys;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan("dishsys.mapper")
@ServletComponentScan
@EnableTransactionManagement  // 启注解事务管理，等同于xml配置方式的 <tx:annotation-driven />
public class DishApplication {

    public static void main(String[] args) {
        SpringApplication.run(DishApplication.class, args);
        System.out.println("----启动结束----");
    }

}
