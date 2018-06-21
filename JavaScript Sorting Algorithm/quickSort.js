/*
 * 快速排序
 */
 function quickSort(arr) {
 	if (arr.length <= 1) { return arr; }

 	//选择"基准"（pivot），并将其与原数组分离，再定义两个空数组，用来存放一左一右的两个子集
　　var pivotIndex = Math.floor(arr.length / 2);
　　var pivot = arr.splice(pivotIndex, 1)[0];
　　var left = [];
　　var right = [];

	//遍历数组，小于基准的元素放入左边的子集，大于基准的元素放入右边的子集
　　for (var i = 0; i < arr.length; i++){
　　　　if (arr[i] < pivot) {
　　　　　　left.push(arr[i]);
　　　　} 
		else {
　　　　　　right.push(arr[i]);
　　　　}
　　}
　　return quickSort(left).concat([pivot], quickSort(right));
};
