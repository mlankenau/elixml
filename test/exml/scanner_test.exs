defmodule Exml.ScannerTest do
  use ExUnit.Case
  import Exml.Scanner

  test "test super simple case" do
    assert {{:element_start, "bla", []}, ""}  == scan("<bla>")
  end

  test "test super simple case with ns" do
    assert {{:element_start, "ns1:bla", []}, ""}  == scan("<ns1:bla>")
  end

  test "scan attributes" do
    assert {{:element_start, "bla", [{"foo", "bar"}]}, ""}  == scan(~S{<bla foo="bar">})
  end


  test "scan text" do
    assert {{:text, "foobar"}, "</bla>"} = scan(~S{foobar</bla>})
  end
end
