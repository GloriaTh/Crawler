  // 自动补全
// autoInput 自动补全输入组件ID
// 自动补全UL列表ID
function AutoComplete(autoInputId, autoULId) {
 var child = null;
   // 获取服务器数据value文本框输入值,list数据库返回集合,valueProperty使用list对象的那个属性作为vlaue值
 this.autoComplete = function (value,list) {
     // 清空上次数据
  DWRUtil.removeAllOptions(autoULId);
  if (child != null && value == child.innerHTML) {
   return;
  }
  if (value == "") {
   return;
  }
  child = null;
  if (list.length > 0) {
   $(autoULId).style.display = "block";
   for (i = 0; i < list.length; i++) {
    var title = list[i];
    var li = document.createElement("li");
    li.ondblclick = function () {
     child = li;
     $(autoInputId).value = li.innerHTML;
     $(autoULId).style.display = "none";
    };
    li.innerHTML =title;// li.innerHTML 表示数据库中的tname
    // alert(li.innerHTML);
    $(autoULId).appendChild(li);
   }
  } else {
   $(autoULId).style.display = "none";
  }
 };
 
 // 当按下上下按钮的时候选中数据
 window.document.onkeydown = function () {
  var key = window.event.keyCode;
        // 向下
  if (key == 40) {
   if (child == null) {
    var nextNode = $(autoULId).firstChild;
    if (nextNode != null) {
     child = nextNode;
     child.style.backgroundColor = "powderblue";
    }
   } else {
    var nextNode = child.nextSibling;
    if (nextNode != null) {
     child.style.backgroundColor = "";
     child = child.nextSibling;
     child.style.backgroundColor = "powderblue";
    }
   }
        // 向上
  } else {
   if (key == 38) {
    if (child != null) {
     var previousNode = child.previousSibling;
     if (previousNode != null) {
      child.style.backgroundColor = "";
      child = child.previousSibling;
      child.style.backgroundColor = "powderblue";
     }
    }
   } else {
    if (key == 13) {
     if (child != null) {
      $(autoInputId).value = child.innerHTML;
      $(autoULId).style.display = "none";
     }
    }
   }
  }
 };
 
 // 设置补全数据位置
 window.onload = function () {
  var oRect = $(autoInputId).getBoundingClientRect();
  $(autoULId).style.left = oRect.left - 42;
  $(autoULId).style.top = oRect.top + 20;
 };
}  
