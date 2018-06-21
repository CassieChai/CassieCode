/*
 * 插入排序
 */
 function insertionSort(arr) {
 	var len = arr.length;
 	var j, temp;
 	for (var i = 1; i < len; i++) {
 		j = i;
        temp = arr[i];
 		while(j > 0 && arr[j-1] > arr[j]) {
            arr[j] = arr[j-1];
            j--;
        }
        arr[j] = temp;
    }
    return arr;   
}
