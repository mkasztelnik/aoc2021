#!/usr/bin/env ruby

file_path  = File.expand_path("input.txt", __dir__)
# file_path  = File.expand_path("example.txt", __dir__)
input      = File.read(file_path)
connections = input.split("\n").map { |line| line.split("-") }

class Vertex
  attr_reader :name, :edges

  def initialize(name)
    @name = name
    @edges = []
  end

  def add(vertex)
    @edges << vertex
  end

  def to_s
    "#{name} -> #{@edges.map(&:name).join(",")}"
  end
end

vertices = {}
connections.each do |connection|
  v_start, v_end = connection.map do |name|
    (vertices[name] || Vertex.new(name)).tap do |v|
      vertices[name] = v
    end
  end

  v_start.add(v_end) if v_start.name != "end"
  v_end.add(v_start) if v_start.name != "start"
end

def find(paths, vertex, path = [])
  path << vertex.name
  if vertex.name == "end"
    paths << path
  else
    vertex.edges
      .select { |v| big?(v) || v.name == "end" || !path.include?(v.name) }
      .each { |v| find(paths, v, path.dup)  }
  end
end

def big?(vertex)
  vertex.name < "a"
end

paths = []
find(paths, vertices["start"])

# puts paths.map { |p| p.join("-") }
puts paths.size
