function LinkedList(){

	var Node = function(element){
		this.element = element;
		this.next = null;
	};

	var length = 0;
	var head = null;

	//向列表尾部添加一个新的项
	this.append = function(element){
		var node = new Node(element);
		var current;
		if(head === null){
			head = node;
		}
		else{
			current = head;
			while(current.next){
				current = current.next;
			}
			current.next = node;
		}
		length++;
	};

	//从列表中的特定位置移除一项
	this.removeAt = function(postion){
		if(postion < -1 || postion >= length){
			return null;
		}

		var current = head, index = 0, previous;
		if(postion === 0){
			head = current.next;
		}
		else{
			while(index < postion){
				previous = current;
				current = current.next;
				index++;
			}
			previous.next = current.next;
		}
		length--;
		return current.element;
	};

	//向列表特定位置插入一个项
	this.insert() = function(postion, element){
		if(postion<0 || postion>length){
			return false;
		}
		var node = new Node(element);
		var current = head, index = 0, previous;
		if(postion === 0){
			node.next = current;
			head = node;
		}
		else{
			while(index < postion){
				previous = current;
				current = current.next;
				index++;
			}
			node.next = current;
			previous.next = node;
		}
		length++;
		return true;
	};

	//
	this.toString = function(){
		var current = head;
		var string = "";
		while(current){
			string += "," + current.element;
			current = current.next;
		}
		return string.slice(1);//提取位置1开始的所有字符
	};

	//返回元素在列表中的索引
	this.indexOf = function(element){
		var current = head, index = 0;
		while(current){
			if(current.element === element){
				return index;
			}
			index++;
			current = current.next;
		}
		return -1;
	};

	//从列表中移除一项
	this.remove = function(element){
		var index = this.indexOf(element);
		return this.removeAt(index);
	};

	this.isEmpty = function(){
		return length === 0;
	};

	this.size = function(){
		return length;
	};

	this.getHead = function(){
		return head;
	};
}