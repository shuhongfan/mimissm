<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <%--如果增或者失败则提示用户  不会刷新当前页--%>
    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>
    <%--删除提示--%>
    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
    //全选复选框功能实现
    function allClick() {
        //取得全选复选框的选中未选 中状态
        //获得当前点击后全选按钮的状态
        var ischeck = $("#all").prop("checked");
        //将此状态赋值给每个商品列表里的复选框
        $("input[name=ck]").each(function () {
            //赋值选中或者非选中状态
            this.checked = ischeck;
        });
    }

    //单个复选框点击改变全选复选框功能实现
    function ckClick() {
        //取得所有name=ck的被选中的复选框
        var length = $("input[name=ck]:checked").length;//:checked 过滤只有是被选中的复选框
        //取得所有name=ck的复选框
        var len = $("input[name=ck]").length;
        //进行对比,改变全选复选框的状态
        if (len == length) {
            $("#all").prop("checked", true);
        } else {
            $("#all").prop("checked", false);
        }
    }
</script>
<body>
<div id="brall">
    <div id="nav">
        <p>商品管理>商品列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            商品名称：<input name="pname" id="pname">&nbsp;&nbsp;&nbsp;
            商品类型：<select name="typeid" id="typeid">
            <option value="-1">请选择</option>
            <c:forEach items="${typeList}" var="pt">
                <option value="${pt.typeId}">${pt.typeName}</option>
            </c:forEach>
        </select>&nbsp;&nbsp;&nbsp;
            价格：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <%--不分页查询--%>
            <input type="button" value="查询" onclick="condition()">
            <%--<input type="button" value="查询" onclick="ajaxsplit(${info.pageNum})">--%>
        </form>
    </div>
    <br>
    <div id="table">
        <%--条件判断--%>
        <c:choose>
            <%--如果 集合有数据就展示--%>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">

                        <input type="button" class="btn btn-warning" id="btn1"
                               value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="批量删除" onclick="deleteBatch(${info.pageNum})">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>商品名</th>
                            <th>商品介绍</th>
                            <th>定价（元）</th>
                            <th>商品图片</th>
                            <th>商品数量</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${info.list}" var="p">
                            <tr>
                                <td valign="center" align="center"><input type="checkbox" name="ck" id="ck"
                                                                          value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="${pageContext.request.contextPath}/image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>
                                    <%--<td><a href="${pageContext.request.contextPath}/admin/product?flag=delete&pid=${p.pId}" onclick="return confirm('确定删除吗？')">删除</a>--%>
                                    <%--&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/product?flag=one&pid=${p.pId}">修改</a></td>--%>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.pId},${info.pageNum})">编辑
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId},${info.pageNum})">删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                            <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <%--
                                        如果当前页 == 循环页,如果当前页等于循环页就让它背景色改变
                                        --%>
                                        <c:if test="${info.pageNum==i}">
                                            <li>
                                                    <%--                                                <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: hotpink">${i}</a>
                                            </li>
                                        </c:if>
                                        <%--
                                        如果当前页 != 循环页,就让它直接展示

                                        --%>
                                        <c:if test="${info.pageNum!=i}">
                                            <li>
                                                    <%--                                                <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                            <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">总共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%--如果当前第几页不等于0,那么是第几页就让他显示第几页--%>
                                        <c:if test="${info.pageNum!=0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                            <%--如果当前第几页等于0,就让他显示 1--%>
                                        <c:if test="${info.pageNum==0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <%--如果 没有就显示:展示没有符合条件的商品--%>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的商品！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch(page) {
        //alert(page)

        //取得所有被选中复选框的删除商品的pid
        var cks = $("input[name=ck]:checked");
        var str = "";
        var id = "";
        if (cks.length == 0) {//没有选中商品
            alert("请选择将要删除的商品！");
        } else {
            // 有选中的商品，则取出每个选 中商品的ID，拼提交的ID的数据
            if (confirm("您确定删除" + cks.length + "条商品吗？")) {
                //取出查询条件
                var pname = $("#pname").val();
                var typeid = $("#typeid").val();
                var lprice = $("#lprice").val();
                var hprice = $("#hprice").val();

                //拼接ID
                $.each(cks, function (index, item) {
                    //进行提交商品 id的字符串的拼接
                    id = $(item).val(); //每一个被选中的商品id 22 33
                    //alert(id);
                    //进行非空判断,避免出错
                    if (id != null) {
                        str += id + ",";  //22,33,44,
                    }
                });

                //alert(str);
                //发送请求到服务器端
                //window.location = "<%--${pageContext.request.contextPath}--%>/prod/deleteBatch.action?str=" + str;
                //发送 ajax请求,进行批量删除的提交
                $.ajax({
                    url: "${pageContext.request.contextPath}/prod/deleteBatch.action",
                    data: {"pids": str, "pname": pname, "typeid": typeid, "lprice": lprice, "hprice": hprice, "page": page},
                    type: "post",
                    dataType: "text",
                    success: function (msg) {
                        alert(msg);//批量删除成功!失败!不可删除
                        //将页面上显示商品数据的容器重新加载
                        $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table");
                    }
                })
            }
        }
    }

    //单个删除
    function del(pid, page) {
        if (confirm("确定删除吗")) {
            //取出查询条件
            var pname = $("#pname").val();
            var typeid = $("#typeid").val();
            var lprice = $("#lprice").val();
            var hprice = $("#hprice").val();

            //alert(pid)
            //向服务器提交请求完成删除
            //window.location = "\${pageContext.request.contextPath}/prod/delete.action?pid=" + pid;
            $.ajax({
                url: "${pageContext.request.contextPath}/prod/delete.action",
                data: {"pid": pid, "pname": pname, "typeid": typeid, "lprice": lprice, "hprice": hprice, "page": page},
                type: "post",
                dataType: "text", //删完之后要将删除成功的这句话从服务器端扔回来在 success中提示,ajax执行结束之后直接弹窗提示
                success: function (msg) {
                    /*
                    * 在这里琢磨了1个多小时因为没有传入 msg Ajax对象               * */
                    alert(msg);
                    //重新加载 #table容器
                    $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table")
                }
            })
        }
    }

    //查询 先服务提交请求,传递商品id
    function one(pid, page) {
        //取出查询条件
        var pname = $("#pname").val();
        // alert(pname)
        var typeid = $("#typeid").val();
        //alert(typeid)

        var lprice = $("#lprice").val();
        //alert(lprice)
        var hprice = $("#hprice").val();
        //alert(hprice)
        //向服务器提交请求,传递商品  //?key=value&key=value
        var str = "?pid=" + pid + "&pname=" + pname + "&typeid=" + typeid
            + "&lprice=" + lprice + "&hprice=" + hprice + "&page=" + page;
        //alert(str);
        // http://localhost/prod/one.action?pid=6&pname=&typeid=2&lprice=undefined&hprice=&page=1
        location.href = "${pageContext.request.contextPath}/prod/one.action" + str;
    }


    //查询条件 异步ajax 发送到 服务器
    function condition() {
        //取出查询条件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/prod/ajaxSplit.action",///prod/condition.action
            data: {"pname": pname, "typeid": typeid, "lprice": lprice, "hprice": hprice},
            success: function () {
                //刷新数据
                $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table");
            }
        })
    }

    <!--分页的AJAX实现-->
    function ajaxsplit(page) {
        //取出查询条件
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        //向服务发出 ajax请求,请示 page页中的所有数据,在当前页面上局部刷新
        //异步ajax分页请求
        $.ajax({
            url: "${pageContext.request.contextPath}/prod/ajaxSplit.action",
            //将所有条件也带上去
            data: {"page": page, "pname": pname, "typeid": typeid, "lprice": lprice, "hprice": hprice},
            type: "post",
            success: function () {
                //重新加载分页显示的组件table
                //location.href---->http://localhost:8080/admin/login.action
                //在这个地址的页面上的 #table容器重新加载一遍
                $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table");
            }
        })
    };

</script>

</html>