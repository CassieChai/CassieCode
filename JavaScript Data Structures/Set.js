function Set(){
	var items = {};
	this.has = function(value){
		return items.hasOwnProperty(value);
	};

	this.add = function(value){
		if(!this.has(value)){
			items[value] = value;
			return true;
		}
		return false;
	};

	this.remove = function(value){
		if(this.has(value)){
			delete items[value];
			return true;
		}
		return false;
	};

	this.clear = function(){
		items = {};
	};

	//Object.keys(obj)返回给定对象的可枚举属性组成的数组
	this.size = function(){
		return Object.keys(items).length;
	};

	//返回一个包含集合中所有值的数组
	this.values = function(){
		return Object.keys(items);
	};

	//并集
	this.union = function(otherSet){
		var unionSet = new Set();

		var values = this.values();
		for(var i=0; i<values.length; i++){
			unionSet.add(values[i]);
		}

		values = otherSet.values();
		for(var i=0; i<values.length; i++){
			unionSet.add(values[i]);
		}
		return unionSet;
	};

	//交集
	this.intersection = function(otherSet){
		var intersectionSet = new Set();
		var values = this.values();
		for(var i=0; i<values.length; i++){
			if(otherSet.has(values[i])){
				intersectionSet.add(values[i]);
			}
		}
		return intersectionSet;
	};

	//差集
	this.difference = function(otherSet){
		var differenceSet = new Set();
		var values = this.values();
		for(var i=0; i<values.length; i++){
			if(!otherSet.has(values[i])){
				differenceSet.add(values[i]);
			}
		}
		return differenceSet;
	};

	//子集
	this.subSet = function(otherSet){
		if(this.size()>otherSet.size()){
			return false;
		}
		var values = this.values();
		for(var i=0; i<values.length; i++){
			if(!otherSet.has(values[i])){
				return false;
			}
		}
		return true; 
	};
}

