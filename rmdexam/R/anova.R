#' ---
#' title: Problem Setup for Variance Components
#' date:  2020-12-17
#' ---
#'
#'
#' @title Variance Components
#'
#' @description
#'
#' @details
#'
#' @param
#'
#' @return
# set.seed(20201216)
generate_problem_setup <- function(pl_input = NULL){
  # define constants
  n_res_sd <- rnorm(1,mean = 10, sd = 2)
  n_nr_obs <- 20
  n_intercept <- rnorm(1, mean = 600, sd=12)
  n_nr_farm <- 3
  vec_farm_effect <- rnorm(n_nr_farm, mean=10, sd = 5)
  vec_farm_incidence <- sample(c(1:n_nr_farm), n_nr_obs, replace = TRUE)
  mat_X <- model.matrix(lm(y ~ 0 + vec_farm_incidence, data = tibble::tibble(vec_farm_incidence = as.factor(vec_farm_incidence), y=rnorm(n_nr_obs))))[,]
  mat_lw <- n_intercept + crossprod(t(mat_X),  vec_farm_effect[1:ncol(mat_X)]) + rnorm(n_nr_obs, mean = 0, sd = n_res_sd)
  tbl_data_anova <- tibble::tibble(Animal = 1:n_nr_obs,
                                   Farm   = vec_farm_incidence,
                                   LiveWeight = round(mat_lw[,1], digits = 0))



  # return list of variables
  return(list(tbl_result = tbl_data_anova,
              rstmt      = paste0('tbl_data_anova <- tibble::tibble(Animal = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_anova$Animal),
                                  ', Farm = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_anova$Farm),
                                  ', LiveWeight = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_anova$LiveWeight),
                                  ')\n',
                                  collapse = '')))
}
