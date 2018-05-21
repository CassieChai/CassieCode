var board = new Array();
var score;

function init(){
    $(".number-cell").remove();
    for(var i=0;i<4;i++){
        board[i]=new Array();
        for (var j = 0; j < 4; j++) {
            board[i][j] = 0;
            // var gridCell=$("#grid-cell-"+i+"-"+j);
            // gridCell.css('top',getPosTop(i, j));
            // gridCell.css('left',getPosLeft(i, j));
            $('#grid-container').append('<div class="number-cell" id="number-cell-'+i+'-'+j+'"></div>');
            var theNumberCell=$('#number-cell-'+i+'-'+j);            
            theNumberCell.css('width','0px');
            theNumberCell.css('height','0px');
            theNumberCell.css('top',getPosTop(i, j)+cellSideLength/2);
            theNumberCell.css('left',getPosLeft(i,j)+cellSideLength/2);            
        }
    }
    score = 0;    
}


//生成一个方框
function generateOneNumber(){
    //判断是否格子全满
    if(noSpace(board)){
        return false;
    }
    //随机生成2或4
    var randNumber = Math.random()<0.5?2:4;
    //随机生成一个位置
    var times =0;
    do{
        var randx = Math.floor(Math.random()*4);
        var randy = Math.floor(Math.random()*4);
        times++;
    }while(board[randx][randy]!=0&&times<50);
    if(times==50){//人工寻找到一个没有数字的位置
        for(var i=0; i<4; i++)
            for(var j=0; j<4; j++){
                if(board[i][j]==0)
                    randx=x;
                    randy=y;
            }
    }
    board[randx][randy]=randNumber;
    updateNumber(randx,randy,randNumber);
    return true;

}
//游戏结束
function isGameOver(){
    if(noSpace(board)&&noMove(board)){
        alert("Game Over!");
    }
}

function moveLeft(){
    // //不能向左移动
    if( !canMoveLeft( board ) )
        return false;
    //可以向左移动
    for( var i = 0 ; i < 4 ; i ++ ){
        for( var j = 1 ; j < 4 ; j ++ ){
            if( board[i][j] != 0 ){
                for( var k = 0 ; k < j ; k ++ ){
                    if( noBlockHorizontal( i , k , j , board )&&(board[i][k] == 0||board[i][k] == board[i][j]) ){
                        updatePosition(i,j,i,k);
                        if(board[i][k] == board[i][j]){
                            score +=  2*board[i][k];     
                            updateScore(score);
                        }
                        board[i][k] += board[i][j];
                        board[i][j] = 0; 
                        updateNumber(i,k,board[i][k]); 
                        updateNumber(i,j,0);                                         
                        break;
                    }                  
                                               
                }
            }
        }
    }
    return true;
}

function moveRight(){
    if( !canMoveRight( board ) )
        return false;
    for( var i = 0 ; i < 4 ; i ++ ){
        for( var j = 2 ; j >=0 ; j -- ){
            if( board[i][j] != 0 ){
                for( var k = 3 ; k > j ; k -- ){
                    if( noBlockHorizontal( i , k , j , board )&&(board[i][k] == 0||board[i][k] == board[i][j]) ){
                        updatePosition(i,j,i,k);
                        if(board[i][k] == board[i][j]){
                            score +=  2*board[i][k];     
                            updateScore(score);
                        }
                        board[i][k] += board[i][j];
                        board[i][j] = 0; 
                        updateNumber(i,k,board[i][k]);
                        updateNumber(i,j,0); 
                        break;
                    }                  
                                               
                }
            }
        }
    }
    return true;
}

function moveUp(){
    if( !canMoveUp( board ) )
        return false;
    for( var j = 0 ; j < 4 ; j ++ ){
        for( var i = 1 ; i < 4 ; i ++ ){
            if( board[i][j] != 0 ){
                for( var k = 0 ; k <i ; k++ ){
                    if( noBlockVertical( j,i,k,board )&&(board[k][j] == 0||board[k][j] == board[i][j]) ){
                        updatePosition(i,j,k,j);
                        if(board[k][j] == board[i][j]){
                            score +=  board[k][j] ; 
                            updateScore(score); 
                        }
                        board[k][j] += board[i][j];
                        board[i][j] = 0; 
                        updateNumber(k,j,board[k][j]);
                        updateNumber(i,j,0);                         
                        break;
                    }                  
                                               
                }
            }
        }
    }
    return true;
}

function moveDown(){
    if( !canMoveDown( board ) )
        return false;
    for( var j = 0 ; j < 4 ; j ++ ){
        for( var i = 2 ; i >= 0 ; i -- ){
            if( board[i][j] != 0 ){
                for( var k = 3 ; k > i ; k -- ){
                    if( noBlockVertical( j,i,k,board )&&(board[k][j] == 0||board[k][j] == board[i][j]) ){
                        updatePosition(i,j,k,j);
                        if(board[k][j] == board[i][j]){
                            score +=  board[k][j] ; 
                            updateScore(score); 
                        }
                        board[k][j] += board[i][j];
                        board[i][j] = 0; 
                        updateNumber(k,j,board[k][j]);
                        updateNumber(i,j,0);                         
                        break;
                    }                  
                                               
                }
            }
        }
    }
    return true;
}
