package org.alan.database.systemconcept.indexing;

import java.util.ArrayList;
import java.util.List;

public class BPlusTree {

    private final int MAX_KEYS;
    private Node root;

    public BPlusTree(int MAX_KEYS) {
        this.MAX_KEYS = MAX_KEYS;
    }

    public void insert(int key) {
        // If there is no element in tree, then create a leaf node.
        if (root == null) root = new LeafNode();

        root.insert(key);

        if (root.keyCount() <= MAX_KEYS) return;

        // If current key count is over than max key, split into 2 leaf nodes with 1 parent node.
        Node left = new LeafNode();
        Node right = new LeafNode();

        int middle = MAX_KEYS / 2;
        left.keys.addAll(root.keys.subList(0, middle));
        right.keys.addAll(root.keys.subList(middle + 1, root.keys.size()));
        int middleKey = root.keys.get(middle);

        InternalNode newRoot = new InternalNode();
        newRoot.keys.add(middleKey);
        newRoot.subNodes.add(left);
        newRoot.subNodes.add(right);
    }

    private abstract class Node {
        ArrayList<Integer> keys = new ArrayList<>();

        int keyCount() {
            return keys.size();
        }

        abstract void insert(int key);
    }

    private class InternalNode extends Node {
        List<Node> subNodes = new ArrayList<>();

        @Override
        void insert(int key) {

        }
    }

    private class LeafNode extends Node {
        List<Integer> records = new ArrayList<>();
        @Override
        void insert(int key) {

        }
    }



}
