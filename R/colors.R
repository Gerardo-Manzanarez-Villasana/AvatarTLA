#' Complete list of Avatar palettes
#'
#' Use \code{\link{avatar_palette}} to construct palettes of desired length.
#'
#' @export
avatar_palettes <- list(
  Mai = c("#982c2c", "#712929", "#4c2828", "#361818", "#000000"),
  Suki = c("#729663", "#FFFEE6", "#FFBB40", "#E15D40"),
  Iroh = c("#1E3414", "#737E44", "#CDAB43", "#E4DEAF", "#F9F8F6", "#ECCAB0"),
  FireNation = c("#ecb100", "#a10000", "#7E605E", "#FF4500", "#994823",
                 "#4B4C4E", "#572530", "#000000"),
  AirNomads = c("#ff9933", "#C24841", "#FFFF33", "#8B5B45", "#87AFD1",
                "#EEB05A", "#DBC5A0"),
  EarthKingdom = c("#015E05", "#B1A866", "#7A5C12", "#646742", "#25351C",
                   "#4C7022", "#C7C45E", "#D2CFAB", "#FEFED8"),
  WaterTribe = c("#0047ab", "#1DB4D3", "#A2CAED", "#AFB5B8", "#120976",
                 "#fffafa", "#174D79", "#949BBC")
)

#' An Avatar: The Last Airbender palette generator
#'
#' Color palettes inspired by characters and nations from Avatar: The Last Airbender.
#'
#' @param name Name of desired palette. Choices are:
#'   \code{Mai}, \code{Suki}, \code{Iroh},
#'   \code{FireNation}, \code{AirNomads}, \code{EarthKingdom}, \code{WaterTribe}.
#' @param n Number of desired colors. If omitted, uses all colors from the palette.
#' @param type Either "discrete" or "continuous". Use continuous if you want
#'   to automatically interpolate between colors.
#' @return A vector of colors.
#' @export
#' @keywords colors
#' @examples
#' avatar_palette("FireNation")
#' avatar_palette("WaterTribe", 3)
#' avatar_palette("AirNomads", 30, type = "continuous")
avatar_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- avatar_palettes[[name]]

  if (is.null(pal)) {
    stop("Palette not found.")
  }

  if (missing(n)) {
    n <- length(pal)
  }

  if (n <= 0) {
    stop("Number of requested colors (n) must be greater than 0.")
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer.")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )

  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}
