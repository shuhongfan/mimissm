package com.shf.pojo.vo;

/**
 * @author shkstart
 * @create 2021-09-16 20:04
 */
public class ProductInfoVo {
    //商品名称
    private String pname;
    //商品类型
    private Integer typeid;
    //最低价格
    private Integer lprice;
    //最高价格
    private Integer hprice;
    //设置 页码
    private Integer page = 1;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public Integer getTypeid() {
        return typeid;
    }

    public void setTypeid(Integer typeid) {
        this.typeid = typeid;
    }

    public Integer getLprice() {
        return lprice;
    }

    public void setLprice(Integer lprice) {
        if (lprice != null)
            lprice = lprice > 0 ? lprice : 0;
        this.lprice = lprice;
    }

    public Integer getHprice() {
        return hprice;
    }

    public void setHprice(Integer hprice) {
        if (hprice != null)
            hprice = hprice > 0 ? hprice : 0;
        this.hprice = hprice;
    }

    public ProductInfoVo(String pname, Integer typeid, Integer lprice, Integer hprice) {
        this.pname = pname;
        this.typeid = typeid;
        //避免输入负值
        if (lprice != null)
            lprice = lprice > 0 ? lprice : 0;
        this.lprice = lprice;
        //避免输入负值
        if (hprice != null)
            hprice = hprice > 0 ? hprice : 0;
        this.hprice = hprice;
    }

    public ProductInfoVo() {
    }

    @Override
    public String toString() {
        return "ProductInfoVo{" +
                "pname='" + pname + '\'' +
                ", typeid=" + typeid +
                ", lprice=" + lprice +
                ", hprice=" + hprice +
                ", page=" + page +
                '}';
    }
}
