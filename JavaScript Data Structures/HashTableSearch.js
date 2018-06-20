/*
 * 线性探查法解决散列表冲突
 * 向某位置添加元素时，如果索引位置已经被占用，就尝试下一个位置，以此类推
 */
 function HashTableSearch(){
 	var table = [];

	//散列函数("loselose"散列函数，将键值中的每个字母的ASCII值相加)
	var loseloseHashCode = function(key){
		var hash = 0;
		for (var i = 0; i < key.length; i++) {
			hash += key.charCodeAt(i);
		}
		return hash % 37;   //37是任意数
	};

	//表示要加入LinkedList实例中的元素
	var keyValuePair = function(key,value){
		this.key = key;
		this.value = value;		
	}

	this.put = function(key, value){
		var position = loseloseHashCode(key);		
		
		while(table[position] !== undefined){
			position++;
		}
		table[position] = new keyValuePair(key,value);
	};


	this.get = function(key){
		var position = loseloseHashCode(key);

		while(table[position] !== undefined && table[position].key !== key){
			position++;
		}
		if(table[position] === undefined) return undefined;
		if(table[position].key === key) return table[position].value;		
	};

	this.remove = function(key){
		var position = loseloseHashCode(key);

		while(table[position] !== undefined && table[position].key !== key){
			position++;
		}
		if(table[position] === undefined) return false;
		
		table[position] = undefined;
		return true;		
	};
}

