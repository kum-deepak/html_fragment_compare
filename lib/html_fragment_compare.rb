require "html_fragment_compare/version"

require "nokogiri"

module HtmlFragmentCompare
  def self._attrs_to_hash(attrs)
    Hash[ attrs.map{|key, attr| [ key, attr.value ]} ]
  end

  def self._prune_comments_and_empty_text_nodes(node_set)
    node_set.reject do |c|
      c.class == Nokogiri::XML::Comment ||
          c.class == Nokogiri::XML::Text && c.text.strip == ""
    end
  end

  def self._eql_node_set(node_set1, node_set2)
    node_set1= _prune_comments_and_empty_text_nodes(node_set1)
    node_set2= _prune_comments_and_empty_text_nodes(node_set2)

    return false unless node_set1.size == node_set2.size

    e2= node_set2.to_a.each
    node_set1.to_a.each do |c1|
      c2= e2.next

      return false unless _eql?(c1, c2)
    end

    return true
  end

  def self._eql?(node1, node2)
    node1.name == node2.name &&
        _compare_text_nodes(node1, node2) &&
        _attrs_to_hash(node1.attributes) == _attrs_to_hash(node2.attributes) &&
        _eql_node_set(node1.children, node2.children)
  end

  def self._compare_text_nodes(node1, node2)
    if node1.class == Nokogiri::XML::Text && node2.class == Nokogiri::XML::Text
      node1.text.strip == node2.text.strip
    else
      true
    end
  end

  def self._parse(s)
    Nokogiri::HTML::DocumentFragment.parse(s)
  end

  def self.compare(s1, s2)

    node1 = _parse(s1)
    node2 = _parse(s2)

    _eql?(node1, node2)
  end
end
