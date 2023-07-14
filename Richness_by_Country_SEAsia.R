
# Rough draft scropt to map richness of threatened and DD species by country.
# Country of occurrence from Red List
# July 14, 2023
# K Good
################################################################################

library(maps)
library(ggplot2)

main_dir <- "/Volumes/GoogleDrive/My Drive/Walder"

data <- read.csv(file.path(main_dir, "Richness.csv"), header = T, na.strings=c("","NA"),
  colClasses="character")

map_world <- map_data("world")

merged_data <- dplyr::left_join(map_world, data, by = "region")

merged_data$Richness <-as.numeric(merged_data$Richness)

base_map <- ggplot() +
  geom_polygon(data = merged_data, aes(x = long, y = lat, group = group, fill = Richness), color = "black") +
  scale_fill_gradient(low = "blue", high = "red", name = "Richness") +
  theme_void()

# Specify the zoom range for Asia
x_zoom <- c(left = 40, right = 150)    # Longitude range for Asia
y_zoom <- c(bottom = -10, top = 60)    # Latitude range for Asia

# Add the zoom functionality to the base map
zoom_map <- base_map +
  coord_cartesian(xlim = x_zoom, ylim = y_zoom) +
  theme(plot.margin = margin(0, 0, 0, 0))


# Plot the zoomable map for Asia
print(zoom_map)














