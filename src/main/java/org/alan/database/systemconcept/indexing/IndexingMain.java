package org.alan.database.systemconcept.indexing;

public class IndexingMain {
    public static void main(String[] args) {
        BTree tree = new BTree(2);
        tree.insert(7);
        var node = tree.search(7);
        System.out.println(node);
    }
}
