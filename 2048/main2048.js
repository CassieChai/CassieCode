$(document).ready(function(){
    newgame();
});

function newgame(){
    init();
    generateOneNumber();
    generateOneNumber();
}

//按下键盘执行
$(document).keydown(function(event){
    switch(event.keyCode){
        case 37: //left
            if(moveLeft()){
                setTimeout("generateOneNumber()",200);//执行代码前等待的时间
                setTimeout("isGameOver()",300);
            }
            break;
        case 38: //up
            if(moveUp()){
                setTimeout("generateOneNumber()",200);
                setTimeout("isGameOver()",300);
            }
            break;
        case 39: //right
            if(moveRight()){
                setTimeout("generateOneNumber()",200);
                setTimeout("isGameOver()",300);
            }
            break;
        case 40: //down
            if(moveDown()){
                setTimeout("generateOneNumber()", 200);
                setTimeout("isGameOver()",300);
            }
            break;
        default: //default
            break;
    }
});