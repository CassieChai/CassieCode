var index = 1;
var timer;
window.onload = init;
/*初始化函数*/
function init() {
    eventBind();
    autoPlay();
}
/*自动轮播*/
function autoPlay() {
    timer = setInterval(function(){
        changeOffset(changeIndex(true));
    },2000)
}
/*停止轮播*/
function stopAutoPlay() {
    clearInterval(timer)
}
/*改变显示的图片序号*/
function changeIndex(para) {
    if(para) {
        if(index === 4) {
            index = 1;
        } else {
            index++;
        }
    } else {
        if(index === 1) {
            index = 4;
        } else {
            index--;
        }
    }    
    return index;
}
/*根据图片序号偏移imglist容器*/
function changeOffset(index) {
    var list = document.getElementById("imgList");
    var offset = (index-1) * 533;
    list.style.left = "-" + offset + "px";
}
/*初始化事件绑定*/
function eventBind() {
    /*点击数字*/
    var num = document.getElementsByClassName("num");
    var len = num.length;
    for(let i=0; i<len; i++){
        (function(k){
            num[k].onclick = function(){
                changeOffset(k+1);
                index = k+1;
            }
        })(i)
    }
    /*点击箭头*/
    var pre = document.getElementById("prev");
    var next = document.getElementById("next");
    (pre.onclick = function() {
        changeOffset(changeIndex(false));       
    })();
    (next.onclick = function() {
        changeOffset(changeIndex(true));
    })();
    /*鼠标移动到容器上，停止滚动*/
    var con = document.getElementById("scrollPics");
    con.onmouseover = function() {
        stopAutoPlay();
    }
    con.onmouseout = function() {
        autoPlay();
    }

}