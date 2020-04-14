require_relative 'node'
require_relative 'graph'
require_relative 'depth_first_search'
require_relative 'breadth_first_search'

node1 = Node.new 'Node-1'
node2 = Node.new 'Node-2'
node3 = Node.new 'Node-3'
node4 = Node.new 'Node-4'
node5 = Node.new 'Node-5'
node6 = Node.new 'Node-6'
node7 = Node.new 'Node-7'
node8 = Node.new 'Node-8'

graph = Graph.new
graph.add_edge node1, node2
graph.add_edge node1, node3
graph.add_edge node1, node4
graph.add_edge node1, node6
graph.add_edge node2, node3
graph.add_edge node3, node6
graph.add_edge node4, node6
graph.add_edge node5, node6
graph.add_edge node6, node8
graph.add_edge node7, node8

dfs = DepthFirstSearch.new(graph)
p "[DFS] #{node1.to_s} has path to #{node8.to_s}? Answer: #{dfs.has_path_between? node1, node8}"
p "[DFS] #{node2.to_s} has path to #{node7.to_s}? Answer: #{dfs.has_path_between? node2, node7}"

bfs = BreadthFirstSearch.new(graph)
p "[BFS] #{node1.to_s} has path to #{node8.to_s}? Answer: #{bfs.has_path_between? node1, node8}"
p "[BFS] #{node2.to_s} has path to #{node7.to_s}? Answer: #{bfs.has_path_between? node2, node7}"