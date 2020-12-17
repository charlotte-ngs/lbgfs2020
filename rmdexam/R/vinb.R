#' ---
#' title: Problem Setup for Variance and Inbreeding
#' date:  2020-12-17
#' ---
#'
#'
#' @title Variance and Inbreeding
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
  n_nr_base_animals <- ifelse(is.null(pl_input$n_nr_base_animals), sample(seq(200,300,10), 1), pl_input$n_nr_base_animals)
  n_nr_gen <- ifelse(is.null(pl_input$n_nr_gen), sample(seq(12,18), 1), pl_input$n_nr_gen)
  n_hom_diff <- ifelse(is.null(pl_input$n_hom_diff), sample(seq(10,50, 10), 1), pl_input$n_hom_diff)
  n_maf <- ifelse(is.null(pl_input$n_maf), sample(seq(0.1, 0.2, 0.01), 1), pl_input$n_maf)
  n_level_inb <- ifelse(is.null(pl_input$n_level_inb), sample(seq(0.01, 0.05, 0.01), 1), pl_input$n_level_inb)
  n_inb_dep <- ifelse(is.null(pl_input$n_inb_dep), sample(seq(0.1, 0.2, 0.01), 1), pl_input$n_inb_dep)
  n_dom_dev <- ifelse(is.null(pl_input$n_dom_dev), sample(seq(10,30, 5), 1), pl_input$n_dom_dev)

  # return list of variables
  return(list(tbl_result = NULL,
              rstmt      = paste0('n_nr_base_animals <- ', n_nr_base_animals, '\n',
                                  'n_nr_gen <- ', n_nr_gen, '\n',
                                  'n_hom_diff <- ', n_hom_diff, '\n',
                                  'n_maf <- ', n_maf, '\n',
                                  'n_level_inb <- ', n_level_inb, '\n',
                                  'n_inb_dep <- ', n_inb_dep, '\n',
                                  'n_dom_dev <- ', n_dom_dev, '\n',
                                  collapse = '')))
}
