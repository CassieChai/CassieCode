/*
双向链表
 */
function DoublyLinkedList(){

	var Node = function(element){
		this.element = element;
		this.next = null;
		this.prev = null;
	};

	var length = 0;
	var head = null;
	var tail = null;


	//从列表中的特定位置移除一项
	this.removeAt = function(postion){
		if(postion < -1 || postion >= length){
			return null;
		}

		var current = head, index = 0, previous;
		if(postion === 0){
			head = current.next;
			if(length===1){
				tail = null;
			}
			else{
				head.prev = null;
			}
		}
		else if(postion === length-1){
			current =tail;
			tail = current.prev;
			tail.next = null;
		}
		else{
			while(index < postion){
				previous = current;
				current = current.next;
				index++;
			}
			previous.next = current.next;
			current.next.prev = previous;
		}
		length--;
		return current.element;
	};

	//向列表特定位置插入一个项
	this.insert() = function(postion, element){
		if(postion < 0 || postion > length){
			return false;
		}
		var node = new Node(element);
		var current = head, index = 0, previous;
		if(postion === 0){
			if(!head){
				head = node;
				tail = node;
			}
			else{
				node.next = current;
				current.prev = node;
				head = node;
			}			
		}
		else if(postion === length){
			current = tail;
			current.next = node;
			node.prev = current;
			tail = node;
		}
		else{
			while(index < postion){
				previous = current;
				current = current.next;
				index++;
			}
			node.next = current;
			previous.next = node;
			current.prev = node;
			node.prev = previous;
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
		return items.length;
	};
}