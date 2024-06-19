library(igraph)


path <- "F:/Eagle/courses/innovativesensors/districts_wue_selection_NEW.gpkg"

library(sf)

dn <- st_read(path)

dn <- st_transform(dn, "+init=epsg:3035")



# Lade das GeoPackage mit Straßen und Polygonen
streets <- st_read("F:/Eagle/courses/innovativesensors/streetsCR.gpkg")

polygone <- st_read("F:/Eagle/courses/innovativesensors/districts_wue_selection_NEW.gpkg")

# Erstelle einen leeren Graphen
g <- make_empty_graph()

# Füge die Polygone als Knoten hinzu
g <- add_vertices(g, nv = nrow(polygone))

# Füge die Straßen als Kanten hinzu
for (i in 1:nrow(streets)) {
  from_index <- which(polygone$id == streets$von_id[i])
  to_index <- which(polygone$id == streets$nach_id[i])
  g <- add_edges(g, edges = c(from_index, to_index))
}

# Berechne den kürzesten Weg, der jedes Polygon mindestens einmal durchläuft
shortest_path <- do.call(
  "union",
  lapply(1:nrow(polygone), function(start_node) {
    all_shortest_paths(g, from = start_node, to = 1:nrow(polygone))$res
  })
)

# Drucke den kürzesten Weg aus
print(shortest_path)
