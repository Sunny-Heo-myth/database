package org.alan.database.systemconcept.indexing;

public class BTree {
    private final int base;
    private BTreeNode root;

    public BTree(int base) {
        this.base = base;
        this.root = new BTreeNode(base, true);
    }

    public BTreeNode search(int key) {
        return search(root, key);
    }

    private BTreeNode search(BTreeNode node, int key) {
        int i = 0;
        while (i < node.offset && key > node.keys[i]) {
            i++;
        }

        if (i < node.offset && key == node.keys[i]) {
            return node;
        } else if (node.isLeaf) {
            return null;
        } else {
            return search(node.subNodes[i], key);
        }
    }

    public void insert(int key) {
        BTreeNode rootNode = root;
        if (rootNode.offset == 2 * base - 1) {
            BTreeNode newRoot = new BTreeNode(base, false);
            newRoot.subNodes[0] = rootNode;
            splitNodes(newRoot, 0, rootNode);
            root = newRoot;
        }
        insertNonNull(root, key);
    }

    private void splitNodes(BTreeNode node, int i, BTreeNode y) {
        BTreeNode newNode = new BTreeNode(base, y.isLeaf);
        newNode.offset = base - 1;
        if (base - 1 >= 0) {
            System.arraycopy(y.keys, base, newNode.keys, 0, base - 1);
        }
        
        if (!y.isLeaf) {
            if (base >= 0) System.arraycopy(y.subNodes, base, newNode.subNodes, 0, base);
        }

        y.offset = base - 1;
        for (int j = node.offset; j > i; j--) {
            node.subNodes[j + 1] = node.subNodes[j];
        }
        node.subNodes[i + 1] = newNode;

        for (int j = node.offset - 1; j >= i; j--) {
            node.keys[j + 1] = node.keys[j];
        }
        node.keys[i] = y.keys[base - 1];
        node.offset++;
    }

    private void insertNonNull(BTreeNode node, int key) {
        int i = node.offset - 1;
        if (node.isLeaf) {
            while (i >= 0 && key < node.keys[i]) {
                node.keys[i + 1] = node.keys[i];
                i--;
            }
            node.keys[i + 1] = key;
            node.offset++;
        } else {
            while (i >= 0 && key < node.keys[i]) {
                i--;
            }
            i++;
            if (node.subNodes[i].offset == 2 * base - 1) {
                splitNodes(node, i, node.subNodes[i]);
                if (key > node.keys[i]) {
                    i++;
                }
            }
            insertNonNull(node.subNodes[i], key);
        }

    }

    public void update(int oldKey, int newKey) {
        delete(oldKey);
        insert(newKey);
    }

    public void delete(int key) {
        if (root == null) {
            System.out.println("The tree is empty");
            return;
        }

        delete(root, key);

        if (root.offset == 0) {
            if (root.isLeaf) {
                root = null;
            } else {
                root = root.subNodes[0];
            }
        }
    }

    private void delete(BTreeNode node, int key) {
        int offset = 0;
        while (offset < node.offset && key > node.keys[offset]) {
            offset++;
        }

        if (offset < node.offset && key == node.keys[offset]) { // Key is in current node
            if (node.isLeaf) {
                removeFromLeaf(node, offset);
            } else {
                removeFromNonLeaf(node, offset);
            }
        } else {
            if (node.isLeaf) {
                System.out.println("The key " + key + " is does not enodeist in the tree.");
                return;
            }

            boolean flag = (offset == node.offset);

            if (node.subNodes[offset].offset < base) {
                fill(node, offset);
            }

            if (flag && offset > node.offset) {
                delete(node.subNodes[offset - 1], key);
            } else {
                delete(node.subNodes[offset], key);
            }
        }
    }

    private void removeFromLeaf(BTreeNode node, int offset) {
        for (int i = offset + 1; i < node.offset; ++i) {
            node.keys[i - 1] = node.keys[i];
        }
        node.offset--;
    }

    private void removeFromNonLeaf(BTreeNode node, int offset) {
        int k = node.keys[offset];

        if (node.subNodes[offset].offset >= base) {
            int pred = getPred(node, offset);
            node.keys[offset] = pred;
            delete(node.subNodes[offset], pred);
        } else if (node.subNodes[offset + 1].offset >= base) {
            int succ = getSucc(node, offset);
            node.keys[offset] = succ;
            delete(node.subNodes[offset + 1], succ);
        } else {
            merge(node, offset);
            delete(node.subNodes[offset], k);
        }
    }

    private int getPred(BTreeNode node, int offset) {
        BTreeNode cur = node.subNodes[offset];
        while (!cur.isLeaf) {
            cur = cur.subNodes[cur.offset];
        }
        return cur.keys[cur.offset - 1];
    }

    private int getSucc(BTreeNode node, int offset) {
        BTreeNode cur = node.subNodes[offset + 1];
        while (!cur.isLeaf) {
            cur = cur.subNodes[0];
        }
        return cur.keys[0];
    }

    private void fill(BTreeNode node, int offset) {
        if (offset != 0 && node.subNodes[offset - 1].offset >= base) {
            borrowFromPrev(node, offset);
        } else if (offset != node.offset && node.subNodes[offset + 1].offset >= base) {
            borrowFromNext(node, offset);
        } else {
            if (offset != node.offset) {
                merge(node, offset);
            } else {
                merge(node, offset - 1);
            }
        }
    }

    private void borrowFromPrev(BTreeNode node, int offset) {
        BTreeNode child = node.subNodes[offset];
        BTreeNode sibling = node.subNodes[offset - 1];

        for (int i = child.offset - 1; i >= 0; --i) {
            child.keys[i + 1] = child.keys[i];
        }

        if (!child.isLeaf) {
            for (int i = child.offset; i >= 0; --i) {
                child.subNodes[i + 1] = child.subNodes[i];
            }
        }

        child.keys[0] = node.keys[offset - 1];

        if (!child.isLeaf) {
            child.subNodes[0] = sibling.subNodes[sibling.offset];
        }

        node.keys[offset - 1] = sibling.keys[sibling.offset - 1];

        child.offset += 1;
        sibling.offset -= 1;
    }

    private void borrowFromNext(BTreeNode node, int offset) {
        BTreeNode child = node.subNodes[offset];
        BTreeNode sibling = node.subNodes[offset + 1];

        child.keys[child.offset] = node.keys[offset];

        if (!child.isLeaf) {
            child.subNodes[child.offset + 1] = sibling.subNodes[0];
        }

        node.keys[offset] = sibling.keys[0];

        for (int i = 1; i < sibling.offset; ++i) {
            sibling.keys[i - 1] = sibling.keys[i];
        }

        if (!sibling.isLeaf) {
            for (int i = 1; i <= sibling.offset; ++i) {
                sibling.subNodes[i - 1] = sibling.subNodes[i];
            }
        }

        child.offset += 1;
        sibling.offset -= 1;
    }

    private void merge(BTreeNode node, int offset) {
        BTreeNode child = node.subNodes[offset];
        BTreeNode sibling = node.subNodes[offset + 1];

        child.keys[base - 1] = node.keys[offset];

        if (sibling.offset >= 0) System.arraycopy(sibling.keys, 0, child.keys, base, sibling.offset);

        if (!child.isLeaf) {
            if (sibling.offset + 1 >= 0) {
                System.arraycopy(sibling.subNodes, 0, child.subNodes, base, sibling.offset + 1);
            }
        }

        for (int i = offset + 1; i < node.offset; ++i) {
            node.keys[i - 1] = node.keys[i];
        }

        for (int i = offset + 2; i <= node.offset; ++i) {
            node.subNodes[i - 1] = node.subNodes[i];
        }

        child.offset += sibling.offset + 1;
        node.offset--;
    }

    static class BTreeNode {
        private final BTreeNode[] subNodes;
        private final int[] keys;
        private final boolean isLeaf;
        private int offset;

        private BTreeNode(int base, boolean isLeaf) {
            this.subNodes = new BTreeNode[2 * base];
            this.keys = new int[2 * base - 1];
            this.isLeaf = isLeaf;
            this.offset = 0;
        }
    }

}
