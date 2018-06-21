/*
 * 选择排序
 */
 function selectionSort(arr) {
 	var len = arr.length;
 	var minIndex, temp;
 	for (var i = 0; i < len - 1; i++) {
 		minIndex = i;
 		for (var j = i + 1; j < len; j++) {
            if (arr[j] < arr[minIndex]) {     // 寻找最小的数
                minIndex = j;                 // 将最小数的索引保存
            }
        }
        if(i !== minIndex){
        	swap(i, minIndex);
        }
    }
    return arr;

    //交换函数
    function swap(index1, index2){
    	var temp = arr[index1];
    	arr[index1] = arr[index2];
    	arr[index2] = temp;
    }
}

var array1 = [5,4,3,2,1];
console.log(array1.toString());
array1 = selectionSort(array1);
console.log(array1.toString());
