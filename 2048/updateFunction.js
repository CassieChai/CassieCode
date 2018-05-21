//移动后更新每个逻辑位置的数字
function updateNumber(i,j,number){
	var numberCell = $("#number-cell-"+i+"-"+j);
	if(number==0){         
        numberCell.css('width','0px');
        numberCell.css('height','0px');
        numberCell.css('top',getPosTop(i, j)+cellSideLength/2);
        numberCell.css('left',getPosLeft(i,j)+cellSideLength/2);
        numberCell.text("");
    }
    else{
		numberCell.css("background-color",getNumberBgcolor(number));
		numberCell.css("color",getNumberColor(number));	
		// numberCell.css("width",cellSideLength);
		// numberCell.css("height",cellSideLength);
		// numberCell.css('top',getPosTop(i, j));
  //       numberCell.css('left',getPosLeft(i,j));

		numberCell.animate({
			width:cellSideLength,
			height:cellSideLength,
			top:getPosTop(i, j),
			left:getPosLeft(i, j)
		},200);
		
		numberCell.text(number);
	}
}
//更新实际位置
function updatePosition(x1,y1,x2,y2){
	var numberCell = $("#number-cell-"+x1+"-"+y1);
	numberCell.animate({
		top:getPosTop(x2,y2),
		left:getPosLeft(x2,y2)
	},0);
}

//更新分数
function updateScore(score){
	$("#score").text(score);
}

