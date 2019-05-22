<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'deal.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link href="css/style.css" rel="stylesheet" type="text/css">
    <script src="script/common.js"></script>
    <script type="text/javascript" language="JavaScript">
        function row(pagenum) {
            if (pagenum<1){
                alert("不能少于0!");
                return;
            }
            window.location.href="SavePageNumServlet?id=2&row_num="+pagenum;
            return;
        }
        function reload(page) {
            var turnTo=document.getElementById("turnTo").value;
            if (turnTo>page){
                alert("超过最大页!");
                return;
            }
            window.location.href="LoadServlet?action=dealBy&status=2&row_num=${row_num}&index="+turnTo;
        }
        function searchService() {
            var custname = document.getElementById("custname").value;
            var title = document.getElementById("title").value;
            var type = document.getElementById("type").value;
            var time1 = document.getElementById("time1").value;
            var time2 = document.getElementById("time2").value;
            var now=new Date();
            var month=(now.getMonth()+1);
            var day=now.getDate();
            if (month<9){
                month="0"+month;
            }
            if (day<9){
                day="0"+day;
            }
            var time=now.getFullYear()+"-"+month+"-"+day;
            if (time1<"0"){
                time1="1900-01-01";
            }
            if (time2<"0"){
                time2=time;
            }
            if (time1 > time2) {
                alert("时间错误！");
            }
            window.location.href="LoadServlet?action=dealBy&search=search&status=2&custname="+custname+"&title="+title+"&type="+type+"&time1="+time1+"&time2="+time2;
        }
    </script>
</head>
<body>

<div class="page_title">客户服务管理 &gt; 服务处理</div>
<div class="button_bar">
    <button class="common_button" onclick="help('');">帮助</button>
    <button class="common_button" onclick="searchService();">查询</button>
</div>
<table class="query_form_table">
    <tr>
        <th height="28">客户</th>
        <td><input id="custname"/>
        </td>
        <th height="28">概要</th>
        <td><input id="title"/>
        </td>
        <th height="28">服务类型</th>
        <td><select id="type" name="D1">
            <option value="0">全部</option>
            <option value="咨询">咨询</option>
            <option value="建议">建议</option>
            <option value="投诉">投诉</option>
        </select></td>
    </tr>
    <tr>
        <th height="22">创建日期</th>
        <td colspan="3">
            <input name="T2" id="time1" type="date" size="10"/> - <input name="T1" id="time2" type="date" size="10"/>
        </td>
        <th height="22">状态</th>
        <td><select name="D1">
            <option selected>已分配</option>
        </select></td>
    </tr>
</table>
<br/>
<table class="data_list_table">
    <tr>
        <th>编号</th>
        <th>客户</th>
        <th>概要</th>
        <th>服务类型</th>
        <th>处理人</th>
        <th>创建日期</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${dlist}" var="d">
        <tr>
            <td class="list_data_number">${d.sv_id}</td>
            <td class="list_data_text">${d.sv_custname}</td>
            <td class="list_data_ltext">${d.sv_title}</td>
            <td class="list_data_text">${d.sv_type}</td>
            <td class="list_data_text">${d.sv_dueto}</td>
            <td class="list_data_text">${d.sv_createdate}</td>
            <td class="list_data_op"><img onclick="to('LoadServlet?action=dealDetail&sv_id=${d.sv_id}');"
                                          title="处理" src="images/bt_deal.gif" class="op_button"/></td>
        </tr>
    </c:forEach>
    <tr>
        <th colspan="7" class="pager">
            <div class="pager">
                共${all_num}条记录 每页<input value="${row}" onblur="row(this.value)" type="number" id="row_num" size="2" />条 第<input value="${index}" disabled id="index" size="2"/>页/共${page_num}页
                <a href="LoadServlet?action=dealBy&status=2&index=1&row_num=${row_num}">第一页</a> <a href="LoadServlet?action=dealBy&status=2&index=${pre}&row_num=${row_num}">上一页</a> <a href="LoadServlet?action=dealBy&index=${next}&status=2&row_num=${row_num}">下一页</a> <a
                    href="LoadServlet?action=dealBy&status=2&row_num=${row_num}&index=${page_num}">最后一页</a> 转到<input value="${index}" id="turnTo" size="2"/>页
                <button width="20" onclick="reload('${page_num}');">GO</button>
            </div>
        </th>
    </tr>
</table>
</body>
</html>