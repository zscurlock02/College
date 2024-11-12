package edu.iastate.cs228.hw3;

import java.util.AbstractSequentialList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.NoSuchElementException;

/**
 * @author 
 * Zachary Scurlock
 */

/**
 * Implementation of the list interface based on linked nodes
 * that store multiple items per node.  Rules for adding and removing
 * elements ensure that each node (except possibly the last one)
 * is at least half full.
 */
public class StoutList<E extends Comparable<? super E>> extends AbstractSequentialList<E>
{
  /**
   * Default number of elements that may be stored in each node.
   */
  private static final int DEFAULT_NODESIZE = 4;
  
  /**
   * Number of elements that can be stored in each node.
   */
  private final int nodeSize;
  
  /**
   * Dummy node for head.  It should be private but set to public here only  
   * for grading purpose.  In practice, you should always make the head of a 
   * linked list a private instance variable.  
   */
  public Node head;
  
  /**
   * Dummy node for tail.
   */
  private Node tail;
  
  /**
   * Number of elements in the list.
   */
  private int size;
  
  /**
   * Constructs an empty list with the default node size.
   */
  public StoutList()
  {
    this(DEFAULT_NODESIZE);
  }

  /**
   * Constructs an empty list with the given node size.
   * @param nodeSize number of elements that may be stored in each node, must be 
   *   an even number
   */
  public StoutList(int nodeSize)
  {
    if (nodeSize <= 0 || nodeSize % 2 != 0) throw new IllegalArgumentException();
    
    // dummy nodes
    head = new Node();
    tail = new Node();
    head.next = tail;
    tail.previous = head;
    this.nodeSize = nodeSize;
  }
  
  /**
   * Constructor for grading only.  Fully implemented. 
   * @param head
   * @param tail
   * @param nodeSize
   * @param size
   */
  public StoutList(Node head, Node tail, int nodeSize, int size)
  {
	  this.head = head; 
	  this.tail = tail; 
	  this.nodeSize = nodeSize; 
	  this.size = size; 
  }

  @Override
  public int size()
  {
	  return size;
  }
  
  @Override
  public boolean add(E item)
  {
	if(item == null) {
		throw new NullPointerException();
	}
    if(tail.previous.count == nodeSize) {
    	Node append = new Node();
    	tail.previous.next = append;
    	append.previous = tail.previous;
    	tail.previous = append;
    	append.next = tail;
    }
    else if(head.next == tail) {
    	Node append = new Node();
    	head.next = append;
    	append.previous = head;
    	tail.previous = append;
    	append.next = tail;
    }
    tail.previous.addItem(item);
    size++;
    return true;
  }

  @Override
  public void add(int pos, E item)
  {
	if(pos < 0 || pos > size) {
		throw new IndexOutOfBoundsException();
	}
	
	NodeInfo n = find(pos);
	
	if(item == null) {
		throw new NullPointerException();
	}
    if(size == 0 || pos == size) {
    	add(item);
    }
    else if(n.offset == 0) {
    	if(n.node.previous.count < nodeSize) {
    		n.node.previous.addItem(item);
    		size++;
    		return;
    	}
    	else if(pos == size && tail.previous.count == nodeSize) {
    		add(item);
    		return;
    	}
    }
    else if(n.node.count < nodeSize) {
    	n.node.addItem(n.offset, item);
    	size++;
    }
    else{
    	Node node = new Node();
    	int midpoint = nodeSize/2;
    	for(int i = 0; i < midpoint; i++) {
    		node.addItem(n.node.data[midpoint]);
    		n.node.removeItem(midpoint);
    	}
    	n.node.next.previous = node;
    	node.previous = n.node;
    	node.next = n.node.next;
    	n.node.next = node;
    	
    	if(n.offset <= nodeSize) {
    		n.node.addItem(n.offset, item);
    	}
    	else if(n.offset > nodeSize) {
    		node.addItem(n.offset - midpoint, item);
    	}
    	size++;
    }
  }
  
  
  @Override
  public E remove(int pos)
  {
	  if(pos < 0 || pos > size) {
			throw new IndexOutOfBoundsException();
	  }
	  
	  NodeInfo n = find(pos);
	  E thing = n.node.data[n.offset];
	  int midpoint = nodeSize / 2;
	  
	  if(n.node.next == tail && n.node.count == 1) {
		  tail.previous = n.node.previous;
		  n.node.previous.next = tail;
	  }
	  else if(n.node.next == tail || n.node.count > midpoint) {
		  n.node.removeItem(n.offset);
	  }
	  else {
		  n.node.removeItem(n.offset);
		  if(n.node.next.count > midpoint) {
			  n.node.addItem(n.node.next.data[0]);
			  n.node.next.removeItem(0);
		  }
		  else if(n.node.next.count <= midpoint) {
			  for(int i = 0; i < n.node.next.count; i++) {
				  n.node.addItem(n.node.next.data[i]);
			  }
			  n.node.next.next.previous = n.node;
			  n.node.next = n.node.next.next;
		  }
	  }
	  size--;
	  return thing;
	  
  }

  /**
   * Sort all elements in the stout list in the NON-DECREASING order. You may do the following. 
   * Traverse the list and copy its elements into an array, deleting every visited node along 
   * the way.  Then, sort the array by calling the insertionSort() method.  (Note that sorting 
   * efficiency is not a concern for this project.)  Finally, copy all elements from the array 
   * back to the stout list, creating new nodes for storage. After sorting, all nodes but 
   * (possibly) the last one must be full of elements.  
   *  
   * Comparator<E> must have been implemented for calling insertionSort().    
   */
  public void sort()
  {
	  E[] sort = (E[]) new Comparable[size];
	  
	  int j = 0;
	  Node tempNode = head.next;

	  while(tempNode != tail) {
		  for(int i = 0; i < tempNode.count; i++) {
			  sort[j] = tempNode.data[i];
			  j++;
		  }
		  tempNode = tempNode.next;
	  }
	  
	  head.next = tail;
	  tail.previous = head;
	  
	  insertionSort(sort, new insertionHelper());
	  size = 0;
	  for(int i = 0; i < sort.length; i++) {
		  add(sort[i]);
	  }
  }
  
  /**
   * Sort all elements in the stout list in the NON-INCREASING order. Call the bubbleSort()
   * method.  After sorting, all but (possibly) the last nodes must be filled with elements.  
   *  
   * Comparable<? super E> must be implemented for calling bubbleSort(). 
   */
  public void sortReverse() 
  {
	  E[] sort = (E[]) new Comparable[size];
	  
	  int tempIndex = 0;
	  Node tempNode = head.next;
	  
	  while(tempNode != tail) {
		  for(int i = 0; i < tempNode.count; i++) {
			  sort[tempIndex] = tempNode.data[i];
			  tempIndex++;
		  }
		  tempNode = tempNode.next;
	  }
	  
	  head.next = tail;
	  tail.previous = head;
	  
	  bubbleSort(sort);
	  size = 0;
	  for(int i = 0; i < sort.length; i++) {
		  add(sort[i]);
	  }
  }
  
  @Override
  public Iterator<E> iterator()
  {
	  return new StoutListIterator();
  }

  @Override
  public ListIterator<E> listIterator()
  {
    return new StoutListIterator();
  }

  @Override
  public ListIterator<E> listIterator(int index)
  {
    return new StoutListIterator(index);
  }
  
  /**
   * Returns a string representation of this list showing
   * the internal structure of the nodes.
   */
  public String toStringInternal()
  {
    return toStringInternal(null);
  }

  /**
   * Returns a string representation of this list showing the internal
   * structure of the nodes and the position of the iterator.
   *
   * @param iter
   *            an iterator for this list
   */
  public String toStringInternal(ListIterator<E> iter) 
  {
      int count = 0;
      int position = -1;
      if (iter != null) {
          position = iter.nextIndex();
      }

      StringBuilder sb = new StringBuilder();
      sb.append('[');
      Node current = head.next;
      while (current != tail) {
          sb.append('(');
          E data = current.data[0];
          if (data == null) {
              sb.append("-");
          } else {
              if (position == count) {
                  sb.append("| ");
                  position = -1;
              }
              sb.append(data.toString());
              ++count;
          }

          for (int i = 1; i < nodeSize; ++i) {
             sb.append(", ");
              data = current.data[i];
              if (data == null) {
                  sb.append("-");
              } else {
                  if (position == count) {
                      sb.append("| ");
                      position = -1;
                  }
                  sb.append(data.toString());
                  ++count;

                  // iterator at end
                  if (position == size && count == size) {
                      sb.append(" |");
                      position = -1;
                  }
             }
          }
          sb.append(')');
          current = current.next;
          if (current != tail)
              sb.append(", ");
      }
      sb.append("]");
      return sb.toString();
  }
//___________________________________________________________________________________________________________________________________________________
//___________________________________________________________________________________________________________________________________________________
  /**
   * Node type for this list.  Each node holds a maximum
   * of nodeSize elements in an array.  Empty slots
   * are null.
   */
  private class Node
  {
    /**
     * Array of actual data elements.
     */
    // Unchecked warning unavoidable.
    public E[] data = (E[]) new Comparable[nodeSize];
    
    /**
     * Link to next node.
     */
    public Node next;
    
    /**
     * Link to previous node;
     */
    public Node previous;
    
    /**
     * Index of the next available offset in this node, also 
     * equal to the number of elements in this node.
     */
    public int count;

    /**
     * Adds an item to this node at the first available offset.
     * Precondition: count < nodeSize
     * @param item element to be added
     */
    void addItem(E item)
    {
      if (count >= nodeSize)
      {
        return;
      }
      data[count++] = item;
      //useful for debugging
      //      System.out.println("Added " + item.toString() + " at index " + count + " to node "  + Arrays.toString(data));
    }
  
    /**
     * Adds an item to this node at the indicated offset, shifting
     * elements to the right as necessary.
     * 
     * Precondition: count < nodeSize
     * @param offset array index at which to put the new element
     * @param item element to be added
     */
    void addItem(int offset, E item)
    {
      if (count >= nodeSize)
      {
    	  return;
      }
      for (int i = count - 1; i >= offset; --i)
      {
        data[i + 1] = data[i];
      }
      ++count;
      data[offset] = item;
      //useful for debugging 
//      System.out.println("Added " + item.toString() + " at index " + offset + " to node: "  + Arrays.toString(data));
    }

    /**
     * Deletes an element from this node at the indicated offset, 
     * shifting elements left as necessary.
     * Precondition: 0 <= offset < count
     * @param offset
     */
    void removeItem(int offset)
    {
      E item = data[offset];
      for (int i = offset + 1; i < nodeSize; ++i)
      {
        data[i - 1] = data[i];
      }
      data[count - 1] = null;
      --count;
    }    
  }
  
  //__________________________________________________________________________________________________________________________________________________
  //__________________________________________________________________________________________________________________________________________________
  
  private class StoutIterator implements Iterator<E>{
	  
	  private Node current = head.next;
	  private int index1 = -1;
	  private int index2 = -1;

	@Override
	public boolean hasNext() {
		return index1 < (size - 1);
	}

	@Override
	public E next() {
		if(!hasNext()) {
			throw new NoSuchElementException();
		}
		index1++;
		index2++;
		if(index2 == current.count) {
			index2 = 0;
			current = current.next;
		}
		return current.data[index2];
	}
  }
  
 //___________________________________________________________________________________________________________________________________________________ 
 //___________________________________________________________________________________________________________________________________________________
  
  /*
   * This is a helper class that represents a specific point in the list
   */
  private class NodeInfo { 
	  
	  public Node node; 
	  public int offset; 
	  
      public NodeInfo(Node node, int offset) { 
          this.node = node; 
          this.offset = offset; 
      } 
  } 
  
  //___________________________________________________________________________________________________________________________________________________ 
  //___________________________________________________________________________________________________________________________________________________
  
  /*
   * Helper method that helps locate a specific item in a list
   * 
   * @param position (pos) of item that needs an info
   * @return NodeInfo of a specific point in the list
   */
  private NodeInfo find(int pos) {
	  
	  Node temp = head.next;
	  int cursorPosition = 0;
	  
	  while(temp != tail) {
		  if(cursorPosition + temp.count <= pos) {
			  cursorPosition += temp.count;
			  temp = temp.next;
			  continue;
		  }
		  NodeInfo info = new NodeInfo(temp, pos - cursorPosition);
		  return info;
	  }
	  return null;
  }
  
  //___________________________________________________________________________________________________________________________________________________ 
  //___________________________________________________________________________________________________________________________________________________
  
  private class StoutListIterator implements ListIterator<E>
  {
	  int current;
	  boolean prevCallNext;
	  boolean prevCallPrev;
	  public E[] list;

	  
    /**
     * Default constructor 
     */
    public StoutListIterator()
    {
    	current = 0;
    	prevCallNext = false;
    	prevCallPrev = false;
    	assist();
    }

    /**
     * Constructor finds node at a given position.
     * @param pos
     */
    public StoutListIterator(int pos)
    {
    	current = pos;
    	prevCallNext = false;
    	prevCallPrev = false;
    	assist();
    }
    
    @Override    
    public boolean hasNext()
    {
    	if(current >= size) {
    		return false;
    	}
    	return true;
    }

    @Override
    public E next()
    {
    	if(!hasNext()) {
    		throw new NoSuchElementException(); 
    	}
    	prevCallNext = true;
    	prevCallPrev = false;
    	return list[current++];
    }

    @Override
    public void remove()
    {
    	if(prevCallNext) {
    		StoutList.this.remove(current - 1);
    		assist(); 
    		prevCallNext = false;
    		prevCallPrev = false;
    		current--;
    		if(current < 0) {
    			current = 0;
    		}
    	}
    	else if(prevCallPrev) {
    		StoutList.this.remove(current);
    		assist();
    		prevCallNext = false;
    		prevCallPrev = false;
    	}
    	else{
    		throw new IllegalStateException();
    	}
    }
    
    @Override
    public boolean hasPrevious() {
    	if(current <= 0) {
    		return false;
    	}
    	return true;
    }
    
    @Override
    public E previous() {
    	if(!hasPrevious()) {
    		throw new NoSuchElementException();
    	}
    	prevCallPrev = true;
    	prevCallNext = false;
    	current--;
    	return list[current];
    }
    
    @Override
    public int nextIndex() {
    	return current;
    }
    
    @Override 
    public int previousIndex() {
    	return current - 1;
    }
    
    @Override
    public void set(E liquid) {
    	if(prevCallNext) {
    		NodeInfo info = find(current - 1);
    		info.node.data[info.offset] = liquid;
    		list[current - 1] = liquid;
    	}
    	else if(prevCallPrev) {
    		NodeInfo info = find(current);
    		info.node.data[info.offset] = liquid;
    		list[current] = liquid;
    	}
    	else {
    		throw new IllegalStateException();
    	}
    }
    /*
     * Takes data from StoutList and inserts data into an array
     */
    private void assist() {
    	list = (E[]) new Comparable[size];
    	
    	int temp = 0;
    	Node temporary = head.next;
    	while(temporary != tail) {
    		for(int i = 0; i < temporary.count; i++) {
    			list[temp] = temporary.data[i];
    			temp++;
    		}
    		temporary = temporary.next;
    	}
    }

	@Override
	public void add(E e) {
		if(e == null) {
			throw new NullPointerException();
		}
		StoutList.this.add(current, e);
		current++;
		assist();
		prevCallPrev = false;
		prevCallNext = false;
	}
  }
  
  //___________________________________________________________________________________________________________________________________________________ 
  //___________________________________________________________________________________________________________________________________________________

  /**
   * Sort an array arr[] using the insertion sort algorithm in the NON-DECREASING order. 
   * @param arr   array storing elements from the list 
   * @param comp  comparator used in sorting 
   */
  private void insertionSort(E[] arr, Comparator<? super E> comp)
  {
	  for(int i = 1; i < arr.length; i++) {
		  E key = arr[i];
		  int j = i - 1;
		  
		  while(j >= 0 && comp.compare(arr[j], key) > 0) {
			  arr[j + 1] = arr[j];
			  j--;
		  }
		  arr[j + 1] = key;
	  }
  }
  
  /**
   * Sort arr[] using the bubble sort algorithm in the NON-INCREASING order. For a 
   * description of bubble sort please refer to Section 6.1 in the project description. 
   * You must use the compareTo() method from an implementation of the Comparable 
   * interface by the class E or ? super E. 
   * @param arr  array holding elements from the list
   */
  private void bubbleSort(E[] arr)
  {
	  for(int i = 0; i < arr.length - 1; i++) {
		  for(int j = 0; j < arr.length - i - 1; j++) {
			  if(arr[j].compareTo(arr[j + 1]) < 0){
				  E temp = arr[j];
				  arr[j] = arr[j + 1];
				  arr[j + 1] = temp;
			  }
		  }
	  }
  }
  
  /*
   * Helper class used when calling the insertionSort method
   */
  private class insertionHelper implements Comparator<E>{
	@Override
	public int compare(E o1, E o2) {
		return o1.compareTo(o2);
	}
	  
  }
}