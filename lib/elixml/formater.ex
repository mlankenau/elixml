defmodule Elixml.Formater do
  def format(element)
  def format(%{name: name, attributes: attributes, children: []}) do
    "<" <> name <> format_attributes(attributes) <> "/>"
  end
  def format(%{name: name, attributes: attributes, children: children}) do
    "<" <> name <> format_attributes(attributes) <> ">" <>
    format(children) <>
    "</" <> name <> ">"
  end

  def format(list) when is_list(list) do
    list
    |> Enum.map(fn el -> format(el) end)
    |> Enum.join("")
  end

  def format(text) when is_binary(text), do: text


  def format_document(element) do
    root_node = format(element)
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n#{root_node}"
  end

  defp format_attributes(list) do
    (list
    |> Enum.map(fn {k, v} -> "#{k}=\"#{v}\"" end)
    |> Enum.join(" "))
    |> case do
      "" -> ""
      str -> " " <> str
    end
  end
end
