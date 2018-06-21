function Graph(){
	var vertices = []; //数组存储图中所有顶点
	var adjList = new Dictionary();  //字典存储图的邻接表（顶点的名字作为键，邻接顶点列表作为值）

	//向图中添加新的顶点，并且在邻接表中，设置顶点v作为键对应的字典值为空数组
	this.addVertex = function(v){
		vertices.push(v);
		adjList.set(v,[]);
	};

	this.addEdge = function(v,w){
		adjList.get(v).push(w);
		adjList.get(w).push(v);
	};

	//顶点未被访问为白色，访问但未被搜索过的为灰色，被搜索过的为黑色
	var initializeColor = function(){
		var color = {};
		for (var i = 0; i < vertices.length; i++) {
			color[vertices[i]] = "white";
		}
		return color;
	}；

	//广度优先搜索，利用队列
	this.bfs = function(v,callback){
		var color = initializeColor();
		var queue = new Queue();
		queue.enqueue(v);

		while(!queue.isEmpty()){
			var u = queue.dequeue();
			var neighbors = adjList.get(u);
			color[u] = "grey";
			for (var i = 0; i < neighbors.length; i++) {
				var w = neighbors[i];
				if(color[w] === "white"){
					color[w] = "grey";
					queue.enqueue(w)
				}
			}
			color[u] = "black";
			if(callback){
				callback(u);
			}
		}
	};

	//改进的广度优先算法（寻找v到其他顶点的最短路径）
	this.BFS = function(v){
		var color = initializeColor();
		var queue = new Queue();
		var d = [];  //u到v的距离
		var pred = []; //每个u的前溯点
		queue.enqueue(v);

		for (var i = 0; i < vertices.length; i++) {
			d[vertices[i]] = 0;
			pred[vertices[i]] = null;
		}

		while(!queue.isEmpty()){
			var u = queue.dequeue();
			var neighbors = adjList.get(u);
			color[u] = "grey";
			for (var i = 0; i < neighbors.length; i++) {
				var w = neighbors[i];
				if(color[w] === "white"){
					color[w] = "grey";
					d[w] = d[u] + 1;
					pred[w] = u;
					queue.enqueue(w)
				}
			}
			color[u] = "black";			
		}
		return {
			distance: d,
			predecessors: pred
		};
	};

	//深度优先搜索，利用栈
	var dfs = function(v,callback){
		color[v] = "grey";
		if(callback){
			callback(v);
		}
		var neighbors = adjList.get(v);
		for (var i = 0; i < neighbors.length; i++) {
			var w = neighbors[i];
			if(color[w] === "white"){
				dfs(w,callback);
			}
		}
		color[u] = "black";
	};

	this.dfsVisit = function(callback){
		var color = initializeColor();
		for (var i = 0; i < vertices.length; i++) {
			if(color[vertices[i]] === "white"){
				dfs(vertices[i], callback);
			}
		}
	};
}

