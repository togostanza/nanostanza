class OrganismMicrobialCellShapeNanoStanza < TogoStanza::Stanza::Base
  property :cell_shapes do |tax_id|
    result = query("http://togostanza.org/sparql", <<-SPARQL.strip_heredoc).first
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX mpo: <http://purl.jp/bio/01/mpo#>
      PREFIX tax: <http://identifiers.org/taxonomy/>
      SELECT DISTINCT ?cell_shape ?label
      FROM <http://togogenome.org/graph/mpo/>
      FROM <http://togogenome.org/graph/gold/>
      WHERE {
        tax:#{tax_id} mpo:MPO_10001 ?cell_shape .
        ?cell_shape rdfs:label ?l .
        FILTER (lang(?l) = "en")
        BIND(str(?l) AS ?label)
      }
    SPARQL
    result[:image_url] = ['http://togostanza.org/static/img/cell_shapes/', result[:label].downcase, '.png'].join
    result
  end
end