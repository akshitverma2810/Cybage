defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.
  @spec count(list) :: non_neg_integer
  def count(l) do
    list_size(l,0)
  end
  def list_size([],count), do: count
  def list_size([_head|tail],count), do: list_size(tail,count+1)

  @spec reverse(list) :: list
  def reverse(l) do
    reverse_list(l,[])
  end
  def reverse_list([],newlist), do: newlist
  def reverse_list([head|tail],list), do: reverse_list(tail,[head|list])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map_elements(l,f,[])
  end
  def map_elements([],_f,mapped_list), do: reverse(mapped_list)
  def map_elements([elem|rest],f,mapped_list) do
    newelem = f.(elem)
    map_elements(rest,f,[newelem|mapped_list])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter_elements(l,f,[])
  end
  def filter_elements([],_f,filtered_list), do: reverse(filtered_list)
  def filter_elements([nil|rest],f,filtered_list), do: filter_elements(rest,f,filtered_list)
  def filter_elements([elem|rest],f,filtered_list) do
    is_allowed = f.(elem)
    case is_allowed do
      false  -> filter_elements(rest,f,filtered_list)
      _      -> filter_elements(rest,f,[elem|filtered_list])
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f), do: acc
  def foldl([elem|l], acc, f) do
    newacc = f.(elem,acc)
    foldl(l,newacc,f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    reversed_list = reverse(l)
    foldl(reversed_list,acc,f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    combine_two(reverse(a),b)
  end
  def combine_two([],newlist), do: newlist
  def combine_two([head|tail],newlist), do: combine_two(tail,[head|newlist])

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    combine_multiple_lists(ll,[])
  end
  def combine_multiple_lists([],acc), do: reverse(acc)
  def combine_multiple_lists([head|tail],acc) do
    newacc = combine_two(head,acc)
    combine_multiple_lists(tail,newacc)
  end
end
