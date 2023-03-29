class Tree
    attr_accessor :arr, :root
  
    def initialize(arr)
      @arr = arr
      @root = build_tree(arr)
    end
  
    def build_tree(arr = @arr)
      return Node.new(arr[0]) if arr.length == 1
    
      mid = (arr.length / 2).to_i
      root = Node.new(arr[mid])
      left_arr = arr[0..(mid - 1)]
      right_arr = arr[(mid + 1)..(arr.length - 1)]
      if left_arr.length != 0
        root.left_child = build_tree(left_arr) 
        root.left_child.parent = root
      end
      if right_arr.length != 0
        root.right_child = build_tree(right_arr) 
        root.right_child.parent = root
      end
  
      return root
    end
  
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
      pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end
  
    def insert(element, root = @root)
      if element > root.value
        if root.right_child
          insert(element, root.right_child)
        else
          root.right_child = Node.new(element)
          root.right_child.parent = root
          puts "#{element} has been successfully added to the tree!"
          return
        end
      elsif element < root.value
        if root.left_child
          insert(element, root.left_child)
        else
          root.left_child = Node.new(element)
          root.left_child.parent = root
          puts "#{element} has been successfully added to the tree!"
          return
        end
      else puts "#{element} is already in the list!"
      end
    end
  
    def delete(element)
      if !self.search(element)
        puts "#{element} is not in the tree"
        return
      else node = self.search(element)
      end
      parent = node.parent
      if !node.right_child && !node.left_child
        parent.left_child = nil if parent.value > node.value
        parent.right_child = nil if parent.value < node.value
      elsif !node.right_child && node.left_child
        parent.left_child = node.left_child if parent.value > node.value
        parent.right_child = node.left_child if parent.value < node.value
      elsif node.right_child && !node.left_child
        parent.left_child = node.right_child if parent.value > node.value
        parent.right_child = node.right_child if parent.value < node.value
      else
        minimum = self.minimum_node(node.right_child)
        self.delete(minimum.value)
        node.value = minimum.value
      end
    end
  
    def find(element)
      result = self.search(element)
      if result == false
        puts "#{element} is not in the tree"
      else
        message = "#{result.value} found, "
        message += "parent: #{result.parent.value} " if result.parent
        message += "left child: #{result.left_child.value} " if result.left_child
        message += "right child: #{result.right_child.value}" if result.right_child
        message += "."
        puts message
      end
    end
  
    def level_order(node = @root, queue = [node], order = [])
      while queue.length != 0
        yield queue[0] if block_given?
        order.push(queue[0].value)
        queue.push(queue[0].left_child) if queue[0].left_child
        queue.push(queue[0].right_child) if queue[0].right_child
        queue.delete_at(0)
      end
      return order
    end
  
    def inorder(node = @root, order = [], &block)
      self.inorder(node.left_child, order, &block) if node.left_child
      yield node if block_given?
      order.push(node.value)
      self.inorder(node.right_child, order, &block) if node.right_child
      order
    end
  
    def preorder(node = @root, order = [], &block)
      yield node if block_given?
      order.push(node.value)
      self.preorder(node.left_child, order, &block) if node.left_child
      self.preorder(node.right_child, order, &block) if node.right_child
      order
    end
  
    def postorder(node = @root, order = [], &block)
      self.postorder(node.left_child, order, &block) if node.left_child
      self.postorder(node.right_child, order, &block) if node.right_child
      yield node if block_given?
      order.push(node.value)
      order
    end
  
    def height(value)
      node = search(value)
      return "#{value} is not an element of the tree!" if !node
      height_node(node)
    end
  
    def depth(value)
      node = search(value)
      return "#{value} is not an element of the tree!" if !node
      depth_node(node)
    end
  
    def balanced?
      result = true
      self.level_order do |node|  
         result = false if !node_balanced?(node)
         result
      end
      result  
    end
  
    def rebalance
      puts "tree is already balanced" if self.balanced?
      ordered = self.inorder
      @root = self.build_tree(ordered)
    end
  
    private
  
    def minimum_node(node = @root)
      if node.left_child
        minimum_node(node.left_child)
      else return node
      end
    end
  
    def search(element, node = @root)
      return false if !node
      if element == node.value
        return node
      elsif element > node.value
        if root.right_child
          search(element, node.right_child)
        else return false
        end
      else 
        if root.left_child
          search(element, node.left_child)
        else return false
        end
      end
    end
  
    def height_node(node)
      if node.left_child
        left = height_node(node.left_child) + 1
      else
        left = 1
      end
      if node.right_child
        right = height_node(node.right_child) + 1
      else
        right = 1
      end
      return max(left, right)
    end
  
    def depth_node(node)
      if node.parent
        depth = depth_node(node.parent) + 1
      else
        depth = 1
      end
      depth
    end
  
    def node_balanced?(node)
      result = true
      if node.left_child
        height_left = height_node(node.left_child)
      else
        height_left = 0
      end
  
      if node.right_child
        height_right = height_node(node.right_child)
      else
        height_right = 0
      end
  
      result = false if (height_left - height_right).abs > 1
  
      return result
    end
  end