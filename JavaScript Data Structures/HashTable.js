/*
 * 散列表/散列映射
 */
function HashTable(){
	var table = [];

	//散列函数("loselose"散列函数，将键值中的每个字母的ASCII值相加)
	var loseloseHashCode = function(key){
		var hash = 0;
		for (var i = 0; i < key.length; i++) {
			hash += key.charCodeAt(i);
		}
		return hash % 37;   //37是任意数
	};
	
	//散列函数djb2
	var djb2HashCode = function(key){
		var hash  = 5831; //初始为一个质数
		for(var i=0; i<key.length; i++){
			hash = hash*33 + key.charCodeAt(i); //33是魔力数
		}
		return hash % 1013;   //比散列表大的一个质数
	};

	this.put = function(key, value){
		var position = loseloseHashCode(key);
		table[position] = value;
	};

	this.get = function(key){
		return table[loseloseHashCode(key)];
	};

	this.remove = function(key){
		table[loseloseHashCode(key)] = undefined;
	};

}

