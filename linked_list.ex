defmodule LinkedList do
  @opaque t :: tuple()
  @doc """
  Construct a new LinkedList
  """
  defstruct value: nil, next: nil
  @spec new() :: t
  def new() do
    # Your implementation here...
    %LinkedList{value: nil, next: nil}
  end
  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list,elem), do: push_node(list,elem)
  def push_node(%LinkedList{value: nil, next: nil}, elem), do: %LinkedList{value: elem, next: nil}
  def push_node(list, elem) do
    %LinkedList{value: elem, next: list}
  end
  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list) do
    node_count(list,1)
  end
  def node_count(%LinkedList{value: nil, next: nil},_count), do: 0
  def node_count(%LinkedList{value: _data, next: nil},count), do: count
  def node_count(%LinkedList{value: _data, next: nextode},count), do: node_count(nextode,count+1)
  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(%LinkedList{value: nil, next: nil}), do: true
  def empty?(_list), do: false
  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{value: nil, next: nil}), do: {:error, :empty_list}
  def peek(%LinkedList{value: data, next: _nextode}), do: {:ok, data}
  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%LinkedList{value: nil, next: nil}), do: {:error, :empty_list}
  def tail(%LinkedList{value: _value, next: nil}), do: {:ok, %LinkedList{value: nil, next: nil}}
  def tail(%LinkedList{value: _value, next: nextnode}), do: {:ok, nextnode}
  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(%LinkedList{value: nil, next: nil}), do: {:error,:empty_list}
  def pop(%LinkedList{value: value, next: nil}), do: {:ok,value,%LinkedList{value: nil, next: nil}}
  def pop(%LinkedList{value: value, next: nextnode}), do: {:ok,value,nextnode}
  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    create_linked_list(Enum.reverse(list),new())
  end
  def create_linked_list([],linklist), do: linklist
  def create_linked_list([head|tail],linklist), do: create_linked_list(tail,push(linklist,head))
  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    Enum.reverse(linklist_to_list(list,[]))
  end
  def linklist_to_list(%LinkedList{value: nil, next: nil},_acc), do: []
  def linklist_to_list(%LinkedList{value: value, next: nil},acc), do: [ value|acc]
  def linklist_to_list(%LinkedList{value: value, next: nextnode},acc), do: linklist_to_list(nextnode,[value|acc])
  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    listarray = to_list(list)
    from_list(Enum.reverse(listarray))
  end
end
