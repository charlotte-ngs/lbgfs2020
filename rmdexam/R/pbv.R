#' ---
#' title: Problem Setup for Prediction of Breeding Values
#' date:  2020-12-16
#' ---
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
  # Define genetic parameter
  n_var_p <- ifelse(is.null(pl_input$n_var_p), sample(c(4,6,8)^2, 1), pl_input$n_var_p)
  n_h2 <- ifelse(is.null(pl_input$n_h2), sample(c(0.2, 0.25, 0.4), 1), pl_input$n_h2)
  n_var_u <- n_h2 * n_var_p
  n_var_e <- n_var_p - n_var_u
  n_lambda <- n_var_e / n_var_u
  # Define pedigree constants
  n_nr_founder <- ifelse(is.null(pl_input$n_nr_founder), 3, pl_input$n_nr_founder)                         # number of founders
  n_nr_cross_f1 <- ifelse(is.null(pl_input$n_nr_cross_f1), 2, pl_input$n_nr_cross_f1)      # number of crosses in f1
  n_nr_gen <- ifelse(is.null(pl_input$n_nr_gen), 2, pl_input$n_nr_gen)                                     # number of generations after founders
  vec_nr_cross <- pl_input$vec_nr_cross
  if (is.null(vec_nr_cross))
    vec_nr_cross <- c(2, 1)
  # generate a pedigree
  tbl_ped_pbv <- rmdexam::create_pedigree(pn_nr_founder  = n_nr_founder,
                                          pn_nr_cross_f1 = n_nr_cross_f1,
                                          pn_nr_gen      = n_nr_gen,
                                          pvec_nr_cross  = vec_nr_cross)
  # generate breeding values, start by extending pedigree
  tbl_ped_pbv_ext <- rmdexam::extend_pedigree(ptbl_ped = tbl_ped_pbv)
  # get relationship matrix
  ped_pbv <- pedigreemm::pedigree(sire = tbl_ped_pbv_ext$Sire,
                                  dam  = tbl_ped_pbv_ext$Dam,
                                  label = as.character(tbl_ped_pbv_ext$ID))
  mat_Apbv <- as.matrix(pedigreemm::getA(ped = ped_pbv))
  dimnames(mat_Apbv) <- NULL
  # cholesky decomposition of A
  mat_Rpbv <- chol(mat_Apbv)
  # vector of random normals with mean=0 and sd=sqrt(n_var_u)
  vec_u <- crossprod(mat_Rpbv, rnorm(nrow(tbl_ped_pbv_ext), mean = 0, sd = sqrt(n_var_u)))


  # generate Herd as fixed effect
  vec_herds <- c('Planta', 'Moos')
  vec_eff_herd <- c(3.1, 5.2) # intercept and difference between the herds
  tbl_data_pbv <- dplyr::bind_cols(tbl_ped_pbv,
                                   tibble::tibble(Herd = sample(vec_herds, nrow(tbl_ped_pbv), replace = TRUE)))
  # check that not all herds are the same
  if (nlevels(as.factor(tbl_data_pbv$Herd)) == 1){
    # set the first herd to the one not chosen
    tbl_data_pbv$Herd[1] <- setdiff(vec_herds, tbl_data_pbv$Herd[1])
  }
  tbl_pseudo <- dplyr::bind_cols(tibble::tibble(Herd = as.factor(tbl_data_pbv$Herd)),
                                 tibble::tibble(y = rnorm(nrow(tbl_data_pbv))))
  mat_model_herd <- model.matrix(lm(y ~ Herd, data = tbl_pseudo))
  vec_fix_eff <- crossprod(t(mat_model_herd), vec_eff_herd)

  # put together phenotypes
  vec_pheno <- as.vector(vec_fix_eff + vec_u[as.integer(tbl_ped_pbv$ID)] + rnorm(nrow(tbl_data_pbv), mean = 0, sd = sqrt(n_var_e)))
  tbl_data_pbv <- dplyr::bind_cols(tbl_data_pbv, `Phenotypic Observation` = vec_pheno)

  # tbl_data_pbv
  return(list(tbl_result = tbl_data_pbv,
              rstmt      = paste0('tbl_data_pbv <- tibble::tibble(ID = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_pbv$ID),
                                  ', Sex = ',
                                  rmdexam::character_vector_as_def_string(tbl_data_pbv$Sex),
                                  ', Sire = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_pbv$Sire),
                                  ', Dam = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_pbv$Dam),
                                  ', Herd = ',
                                  rmdexam::character_vector_as_def_string(tbl_data_pbv$Herd),
                                  ', `Phenotypic Observation` = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_data_pbv$`Phenotypic Observation`),
                                  collapse = '')))
}
