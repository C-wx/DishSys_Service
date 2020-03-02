package dishsys.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @Explain 用于响应请求结果的对象
 */
@Data
public class Result<T> implements Serializable {
    /**
     * 状态码，200代表成功， 401代表失败
     */
    private Integer code;
    /**
     * 状态信息，一般可为空
     */
    private String msg;
    /**
     * 数据，一般可为空
     */
    private T data;
    /**
     * 数据总量
     */
    private long count;

    public static Result error() {
        Result result = new Result();
        result.setCode(401);
        return result;
    }

    public static Result error(String s) {
        Result result = new Result();
        result.setCode(501);
        result.setMsg(s);
        return result;
    }

    public static Result success() {
        Result result = new Result();
        result.setCode(200);
        return result;
    }

    public static <T> Result success(T t) {
        Result result = new Result();
        result.setCode(200);
        result.setMsg("请求成功!");
        result.setData(t);
        return result;
    }

    /**
     * @param count
     * @param data
     * @Explain 用于返回响应layTable
     * @Return Result
     */
    public static <T> Result layuiTable(long count, List<T> data) {
        Result result = new Result();
        result.setCode(0);
        result.setMsg("获取数据成功！");
        result.setCount(count);
        result.setData(data);
        return result;
    }
}
