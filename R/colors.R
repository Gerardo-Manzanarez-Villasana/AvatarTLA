#' Complete list of Avatar palettes
#'
#' Use \code{\link{avatar_palette}} to construct palettes of desired length.
#'
#' @export
avatar_palettes <- list(
  Mai = c("#982c2c", "#712929", "#4c2828", "#361818", "#000000"),
  Suki = c("#729663", "#FFFEE6", "#FFBB40", "#E15D40"),
  Iroh = c("#1E3414", "#737E44", "#CDAB43", "#E4DEAF", "#ECCAB0"),
  FireNation = c("#ecb100", "#a10000", "#7E605E", "#FF4500", "#994823",
                 "#4B4C4E", "#572530", "#000000"),
  AirNomads = c("#ff9933", "#C24841", "#FFFF33", "#8B5B45", "#87AFD1",
                "#EEB05A", "#DBC5A0"),
  EarthKingdom = c("#015E05", "#B1A866", "#7A5C12", "#646742", "#25351C",
                   "#4C7022", "#C7C45E", "#D2CFAB", "#FEFED8"),
  WaterTribe = c("#0047ab", "#1DB4D3", "#A2CAED", "#AFB5B8", "#120976",
                 "#174D79", "#949BBC"),
  Appa = c("#6C633B","#591509","#936F50","#FEF7DB","#E7CE9A","#4A4F4F"),
  Sokka = c("#488ECB","#E7C2A5","#7C6A66","#5A3D2F","#A27F43"),
  Toph = c("#1C2824","#437C1E","#F1EFC2","#F7D7B7","#BEB718"),
  Azula = c("#010101","#713011","#ECD8C0","#9F6B22"),
  Aang = c("#F9EFE3","#B6D7F4","#F4C135","#EE7223","#6E1700","#715447"),
  Zuko = c("#441100","#6E3208","#A77510","#E6BD9E","#A46A44"),
  Katara = c("#007CC3","#50413A","#F1DCC9","#A5A9AC","#383C1A"),
  Ty = c("#BB7169","#691400","#AE2F24","#ECD5A8","#2F1D01"),
  Momo = c("#4A422E","#6C4C32","#8AA15D","#FBF6D8","#1C1919")
)

#' An Avatar: The Last Airbender palette generator
#'
#' Color palettes inspired by characters and nations from Avatar: The Last Airbender.
#'
#' @param name Name of desired palette. Choices are:
#'   \code{Mai},
#'   \code{Suki},
#'   \code{Iroh},
#'   \code{FireNation},
#'   \code{AirNomads},
#'   \code{EarthKingdom},
#'   \code{WaterTribe},
#'   \code{Appa},
#'   \code{Sokka},
#'   \code{Toph},
#'   \code{Azula},
#'   \code{Aang},
#'   \code{Zuko},
#'   \code{Katara},
#'   \code{Ty},
#'   \code{Momo}
#' @param n Number of desired colors. If omitted, uses all colors from the palette.
#' @param type Either "discrete" or "continuous". Use continuous if you want
#'   to automatically interpolate between colors.
#' @return A vector of colors.
#' @export
#' @keywords colors
#' @examples
#' avatar_palette("Toph")
#' avatar_palette("Aang", 3)
#' avatar_palette("EarthKingdom", 30, type = "continuous")
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
