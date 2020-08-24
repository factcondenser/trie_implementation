#!/usr/bin/env ruby

class Trie
  DELIMITER_REGEX = /[^\w\d']+/.freeze

  def initialize(path)
    @root = { paths: [] }
    build_trie(path)
  end

  def list_paths(word)
    node = fetch_node(word)
    return [] if node.nil?

    node[:paths]
  end

  private

  attr_reader :root

  def build_trie(path)
    Dir.glob("#{path}/**/*").each do |file|
      next if File.directory?(file)

      parse_file(file)
    end
  end

  def parse_file(file)
    File.readlines(file).each do |line|
      parse_line(line, file)
    end
  end

  def parse_line(line, file)
    line.encode('UTF-8', invalid: :replace).split(DELIMITER_REGEX).each do |word|
      build_node(word, file)
    end
  end

  def build_node(word, file)
    node = root
    word.downcase.split('').each do |char|
      node[char] ||= { paths: [] }
      node = node[char]
    end
    node[:paths] << file
  end

  def fetch_node(word)
    root.dig(*word.downcase.split(''))
  end
end

class Service
  def self.index_emails(path)
    Trie.new(path)
  end

  def self.search(word, trie)
    trie.list_paths(word)
  end
end
