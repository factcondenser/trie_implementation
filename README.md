## Usage
```sh
# Start the Ruby REPL
$ irb 
```

```rb
# Index the files at a given path
trie = Service.index_emails('skilling-j')

# Search the indexed files for a given string
puts Service.search('cool', trie)
```
