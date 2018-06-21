/*
 * 冒泡排序
 */
 function bubbleSort(array){
 	var length = array.length;
 	for (var i = 0; i < length; i++) {
 		for (var j = 0; j < length-1; i++) {
 			if(array[j] > array[j+1]){
 				swap(array, j, j+1);
 			}
 		}
 	}

//改进的冒泡排序
function modifiedBubbleSort(array){
	var length = array.length;
	for (var i = 0; i < length; i++) {
		for (var j = 0; j < length-1-i; i++) {
			if(array[j] > array[j+1]){
				swap(array, j, j+1);
			}
		}
	}
}

//交换函数
function swap(array, index1, index2){
	var tmp = array[index1];
	array[index1] = array[index2];
	array[index2] = tmp;
}
