\name{set_community_model}
\alias{set_community_model}
\title{Sets up parameters for a community-type model}
\usage{
  set_community_model(max_w = 1e+06, min_w = 0.001,
    z0 = 0.1, alpha = 0.2, h = 10, beta = 100, sigma = 2,
    q = 0.8, n = 2/3, kappa = 1000, lambda = 2 + q - n,
    f0 = 0.7, r_pp = 10, gamma = NA,
    knife_edge_size = 1000, knife_is_min = TRUE,
    recruitment = kappa * min_w^-lambda, rec_mult = 1, ...)
}
\arguments{
  \item{z0}{The background mortality of the community. The
  default value is 0.1.}

  \item{alpha}{The assimilation efficiency of the
  community. The default value is 0.2}

  \item{f0}{The average feeding level of individuals who
  feed mainly on the resource. This value is to used to
  calculate the search rate parameter \code{ga,,a} (see the
  package Vignette). The default value is 0.7.}

  \item{h}{The maximum food intake rate. The default value
  is 10.}

  \item{beta}{The preferred predator prey mass ratio. The
  default value is 100.}

  \item{sigma}{The width of the prey preference. The
  default value is 2.0.}

  \item{q}{The search volume exponent. The default value is
  0.8.}

  \item{n}{The scaling of the intake. The default value is
  2/3.}

  \item{kappa}{The carrying capacity of the background
  spectrum. The default value is 1000.}

  \item{lambda}{The exponent of the background spectrum.
  The default value is 2 + q - n.}

  \item{r_pp}{Growth rate of the primary productivity.
  Default value is 10.}

  \item{gamma}{Volumetric search rate. Estimated using
  \code{h}, \code{f0} and \code{kappa} if not supplied.}

  \item{recruitment}{The constant recruitment in the
  smallest size class of the community spectrum. This
  should be set so that the community spectrum continues
  the background spectrum. The default value = \code{kappa}
  * \code{min_w}^-\code{lambda}.}

  \item{rec_mult}{Additional multiplier for the constant
  recruitment. Default value is 1.}

  \item{knife_edge_size}{The size at the edge of the
  knife-selectivity function.}

  \item{knife_is_min}{Is the knife-edge selectivity
  function selecting above (TRUE) or below (FALSE) the
  edge.}

  \item{max_w}{The maximum size of the community. The
  \code{w_inf} of the species used to represent the
  community is set to 0.9 * this value. The default value
  is 1e6.}

  \item{min_w}{The minimum size of the community. The
  default value is 1e-3.}

  \item{...}{Other arguments to pass to the
  \code{MizerParams} constructor.}
}
\value{
  An object of type \code{MizerParams}
}
\description{
  This functions creates a \code{MizerParams} object so
  that community-type models can be easily set up and run.
  A community model has several features that distinguish
  it from the food-web type models. Only one 'species' is
  resolved, i.e. one 'species' is used to represent the
  whole community. The resource spectrum only extends to
  the start of the community spectrum. Recruitment to the
  smallest size in the community spectrum is constant and
  set by the user. As recruitment is constant, the
  proportion of energy invested in reproduction (the slot
  \code{psi} of the returned \code{MizerParams} object) is
  set to 0. Standard metabolism has been turned off (the
  parameter \code{ks} is set to 0). Consequently, the
  growth rate is now determined solely by the assimilated
  food (see the package Vignette for more details).
}
\details{
  The function has many arguments, all of which have
  default values. The main arguments that the users should
  be concerned with are \code{z0}, \code{recruitment},
  \code{alpha} and \code{f0} as these determine the average
  growth rate of the community.

  Fishing selectivity is modelled as a knife-edge function
  with one parameter, \code{knife_edge_size}, which
  determines the size at which species are selected.

  The resulting \code{MizerParams} object can be projected
  forward using \code{project()} like any other
  \code{MizerParams} object. When projecting the community
  model it may be necessary to reduce \code{dt} to 0.1 to
  avoid any instabilities with the solver. You can check
  this by plotting the biomass or abundance through time
  after the projection.
}
\examples{
\dontrun{
params <- set_community_model(f0=0.7, z0=0.2, recruitment=3e7)
sim <- project(params, effort = 0, t_max = 100, dt=0.1)
plotBiomass(sim)
plotSpectra(sim)
}
}
\references{
  K. H. Andersen,J. E. Beyer and P. Lundberg, 2009, Trophic
  and individual efficiencies of size-structured
  communities, Proceedings of the Royal Society, 276,
  109-114
}
\seealso{
  \code{\link{MizerParams}}
}

