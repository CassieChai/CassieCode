/*
 * 分离链接法解决散列表冲突
 */
function HashTableLinkedList(){
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
		
		if(table[position] === undefined){
			table[position] = new LinkedList();
		}
		table[position].append(new keyValuePair(key,value));
	};

	this.get = function(key){
		var position = loseloseHashCode(key);

		if(table[position] !==undefined){
			var current = table[position].getHead();
			while(current.next){
				if(current.element.key === key){
					return current.element.value;
				}
				current = current.next;
			}
			//检查元素在链表最后一个的情况
			if(current.element.key === key){
				return current.element.value;
			}			
		}
		return undefined;
	};

	this.remove = function(key){
		var position = loseloseHashCode(key);

		if(table[position] !== undefined){
			var current = table[position].getHead();
			while(current.next){
				if(current.element.key === key){
					table[position].remove(current.element);
					if(table[position].isEmpty()){
						table[position] = undefined;
					}
					return true;
				}
				current = current.next;
			}

			if(current.element.key === key){
				table[position].remove(current.element);
				if(table[position].isEmpty()){
					table[position] = undefined;
				}
				return true;
			}			
		}
		return false;
	};

}

