import Foundation

class Trie {
 
    private var children = [Character: Trie]()
    private var holdsWord = false
    
    /** Initialize your data structure here. */
    init() {}
    
    private func subTrie(_ word: String) -> Trie? {
        // End of word is successfully reached
        guard let firstCharacter = word.first else { return self }
        
        // Get child
        let child: Trie
        if let existingChild = children[firstCharacter] {
            child = existingChild
        } else {
            return nil
        }
        
        // Ask child
        let remainingWord = String(word.suffix(from: String.Index(encodedOffset: 1)))
        return child.subTrie(remainingWord)
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        guard let firstCharacter = word.first else {
            holdsWord = true
            return
        }

        // Get or create child trie
        let child: Trie
        if let existingChild = children[firstCharacter] {
            child = existingChild
        } else {
            child = Trie()
            children[firstCharacter] = child
        }
        
        // Insert into child
        let remainingWord = String(word.suffix(from: String.Index(encodedOffset: 1)))
        child.insert(remainingWord)
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        guard let subTrie = self.subTrie(word) else { return false }
        return subTrie.holdsWord
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        guard let subTrie = self.subTrie(prefix) else { return false }
        return true
    }
}


let mytrie = Trie()
var matrix: [[Character]] = []
var visited: [[Bool]] = []
var rows: Int = 1
var cols: Int = 1

func buildTrie(i: Int, j: Int, str: String, counter: Int) -> Void{
    if (counter > 5){
        return
    }
    mytrie.insert( str + String(matrix[i][j]) )
    visited[i][j] = true
//    print(visited)
    for temp_i in -1...1{
        for temp_j in -1...1{
            if (i + temp_i > -1 && i + temp_i < rows && j + temp_j > -1 && j + temp_j < cols){
                if (visited[i + temp_i][j + temp_j] == false){
                    buildTrie(i: i + temp_i, j: j + temp_j, str: str + String(matrix[i][j]), counter: counter + 1)
                }
            }
        }
    }
    visited[i][j] = false
}





func split(str: String) -> [String]{
    var substr: String = ""
    var list: [String] = []
    for char in str{
        if (char == " "){
            list.append(substr)
            substr = ""
        } else{
            substr += String(char)
        }
    }
    if (substr != ""){
        list.append(substr)
    }
    return list
}

// getting inputs

print("enter the values")
let word_array = readLine()?
    .split {$0 == " "}
    .map(String.init)

print("Dimentions")
var temp = split(str: readLine()!)
rows = Int(temp[0])!
cols = Int(temp[1])!


print("write the matrix:")

for r in 0...(rows - 1){
    temp = split(str: readLine()!)
    matrix.append([])
    visited.append([])
    for c in temp{
        matrix[r].append(Character(c))
        visited[r].append(false)
    }
}



//mytrie.insert("salam")
//mytrie.insert("salaaaam")
//print(mytrie.search("salam"))



for i in 0...(rows - 1){
    for j in 0...(cols - 1){
        for b_i in 0...(rows - 1){
            for b_j in 0...(cols - 1){
                visited[b_i][b_j] = false
            }
        }
        buildTrie(i: i, j: j, str: "", counter: 0)
    }
}



for i in 0...(word_array!.count - 1){
    if (mytrie.search(word_array![i])){
        print(word_array![i])
    }
}
