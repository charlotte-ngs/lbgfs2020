#' ---
#' title: Problem Setup for Genomics
#' date:  2020-12-17
#' ---
#'
#'
#' @title Prediction of Breeding Values
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
  library(dplyr)
  ### # fix the number of animals
  n_nr_animal <- 15
  ### # intercept
  n_inter_cept <- round(rnorm(1, mean = 15, sd=3), digits = 1)
  ### # residual standard deviation
  n_res_sd <- round(rnorm(1, mean = 6, sd=2), digits = 0)
  ### # vector of genotype value coefficients
  vec_geno_value_coeff <- c(-1,0,1)
  ### # fix allele frequency of positive allele
  n_prob_snps <- .45
  ### # genotypic values
  n_nr_snp <- 2
  vec_geno_val <- round(rnorm(n_nr_snp, mean=10.6, sd=3), digits = 1)
  ### # put together the genotypes into a matrix
  mat_geno_snp <- matrix(c(sample(vec_geno_value_coeff, n_nr_animal, prob = c((1-n_prob_snps)^2,
                                                                              2*(1-n_prob_snps)*n_prob_snps,
                                                                              n_prob_snps^2),
                                  replace = TRUE),
                           sample(vec_geno_value_coeff, n_nr_animal, prob = c(n_prob_snps^2,
                                                                              2*(1-n_prob_snps)*n_prob_snps,
                                                                              (1-n_prob_snps)^2),
                                  replace = TRUE)),
                         nrow = n_nr_snp)
  mat_obs_y <- n_inter_cept + crossprod(mat_geno_snp, vec_geno_val) + rnorm(n = n_nr_animal, mean = 0, sd = n_res_sd)
  ### # combine SNP genotypes into a tibble
  geno_code <- tibble::tibble(`SNPLGH` = mat_geno_snp[1,],
                              `SNPFS2` = mat_geno_snp[2,])

  ### # add the data
  mat_obs_y_rounded <- round(mat_obs_y, digits = 1)
  tbl_obs <- tibble::tibble(Observation = mat_obs_y_rounded[,1])
  geno_code %>% bind_cols(tbl_obs) -> tbl_all_data
  ### # add animal ids
  tbl_data_gnm <- bind_cols(Animal = c(1:n_nr_animal),tbl_all_data)

  # return results
  return(list(tbl_result = tbl_data_gnm,
              rstmt      = paste0('tbl_data_gnm <- tibble::tibble(Animal = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_gnm$Animal),
                                  ', `SNPLGH` = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_gnm$SNPLGH),
                                  ', `SNPFS2` = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_gnm$SNPFS2),
                                  ', Observation = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_gnm$Observation),
                                  ')\n',
                                  'n_nr_snp <- ', n_nr_snp,
                                  collapse = '')))
}
