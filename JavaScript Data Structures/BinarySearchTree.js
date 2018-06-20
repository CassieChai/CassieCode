/*
 * 二叉搜索树
 */
function BinarySearchTree(){
	var Node = function(key){
		this.key = key;
		this.left = null;
		this.right = null;
	};
	var root = null;

	var insertNode = function(node, newNode){
		if(newNode.key < node.key){
			if(node.left === null){
				node.left = newNode;
			}
			else{
				insertNode(node.left,newNode);
			}
		}
		else{
			if(node.right === null){
				node.right = newNode;
			}
			else{
				insertNode(node.right,newNode);
			}
		}
	};

	this.insert = function(key){
		var newNode = new Node(key);
		if(root === null){
			root = newNode;
		}
		else{
			insertNode(root, newNode);
		}
	};

	//中序遍历（左根右）
	//callback()回调函数，即要对每个节点进行的操作
	var inOrderTraverseNode = function(node, callback){
		if(node){
			inOrderTraverseNode(node.left, callback);
			callback(node.key);
			inOrderTraverseNode(node.right, callback);
		}
	};

	this.inOrderTraverse = function(callback){
		inOrderTraverseNode(root, callback);
	};

	//先序遍历（根左右）
	var preOrderTraverseNode = function(node, callback){
		if(node){
			callback(node.key);
			preOrderTraverseNode(node.left, callback);			
			preOrderTraverseNode(node.right, callback);
		}
	};

	this.preOrderTraverse = function(callback){
		preOrderTraverse(root, callback);
	};

	//后序遍历（左右根）
	var postOrderTraverseNode = function(node, callback){
		if(node){			
			postOrderTraverseNode(node.left, callback);			
			postOrderTraverseNode(node.right, callback);
			callback(node.key);
		}
	};

	this.postOrderTraverse = function(callback){
		preOrderTraverseNode(root,callback);
	};

	//寻找树的最小键
	var minNode = function(node){
		if(node){
			while(node && node.left !== null){
				node = node.left;
			}
			return node.key;
		}
		return null;
	};

	//寻找整棵树的最小值
	this.min = function(){
		return minNode(root);
	};

	//寻找树的最大键
	var maxNode = function(node){
		if(node){
			while(node && node.right !== null){
				node = node.right;
			}
			return node.key;
		}
		return null;
	};

	//寻找整棵树的最大值
	this.max = function(){
		return maxNode(root);
	};

	//搜索某个特定的值
	var searchNode = function(node, key){
		if(node === null){
			return false;
		}
		if(key < node.key){
			return searchNode(node.left,key);
		}
		else if(key > node.key){
			return searchNode(node.right,key);
		}
		else{
			return true;
		}
	};

	this.search = function(key){
		return searchNode(root,key);
	};

	//移除某个键
	var removeNode = function(node,key){
		if(node === null){
			return null;
		}
		if(key < node.key){
			node.left = removeNode(node.left,key);
			return node;
		}
		else if(key > node.key){
			node.right = removeNode(node.right,key);
			return node;
		}
		//键等于node.key
		else{
			//是一个叶节点
			if(node.left === null && node.right === null){
				node  = null;
				return node;
			}
			//是只有一个子节点的节点
			if(node.left === null){
				node = node.right;
				return node;
			}
			else if(node.right === null){
				node = node.left;
				return node;
			}
			//是有两个子节点的节点
			else{				
				node.key = min(node.right);
				node.right = removeNode(node.right,node.key);
				return node;
			}
		}
	};

	this.remove = function(key){
		root = remove(root, key);
	};
}

function printNode(value){
	console.log(value);
}
var tree = new BinarySearchTree();
tree.insert(5);
tree.insert(8);
tree.insert(2);
tree.insert(7);
tree.insert(3);
tree.inOrderTraverse(printNode);
console.log(tree.search(1) ? "key 1 found" : "key 1 not found");