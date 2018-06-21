/*
 * 归并排序
 */
 function mergeSort(arr) {
 	var len = arr.length;

 	//将原数组分割至只有一个元素的子数组
 	if(len === 1){
 		return arr;   
 	}
 	var mid = Math.floor(len /2);
 	var left = arr.slice(0,mid);
 	var right = arr.slice(mid, length);
 	return merge(mergeSort(left),mergeSort(right));
}

//将两个已经排序的序列合并成一个序列的操作
function merge(arr){
	var result = [];
	var il = 0, ir = 0;
	while(il <left.length && ir <right.length){
		if(left[il]<right[ir]){
			result.push(right[il]);
			il++;
		}
		else{
			result.push(right[ir]);
			ir++;
		}
	}
	while(il<left.length){
		result.push(right[il]);
		il++;
	}
	while(ir<right.length){
		result.push(right[ir]);
		ir++;
	}
	return result;
}
