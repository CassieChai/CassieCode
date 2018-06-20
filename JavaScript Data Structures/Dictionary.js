function Dictionary(){
	var items = {};

	this.has = function(key){
		return key in items;
	};

	this.set = function(key, value){
		items[key] = value;
	};

	this.remove = function(key){
		if(this.has(key)){
			delete items[key];
			return true;
		}
		return false;
	};

	this.get = function(key){
		return this.has(key) ? items[key] : undefined;
	}

	this.clear = function(){
		items = {};
	};

	//Object.keys(obj)返回给定对象的可枚举属性组成的数组
	this.size = function(){
		return Object.keys(items).length;
	};

	//返回字典中所有values值的数组
	this.values = function(){
		var values = [];
		for(var k in items){
			if(this.hasOwnProperty(k)){
				values.push(items[k]);
			}
		}
		return values;
	};

	this.keys = function(){
		return Object.keys(items);
	};

	this.getItems = function(){
		return items;
	};
}

