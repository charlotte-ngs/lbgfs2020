#' ---
#' title: Problem Setup for Numerator Relationship Matrix and Inbreeding (nrm)
#' date:  2020-12-15
#' ---
#'
#'
#' # Debug
#' rm(list = ls())
#' source('~/Data/Projects/Github/pvrqualitasag/rexam/20201214_lbgfs_test/R/helper_function.R', echo=TRUE)
#' source('~/Data/Projects/Github/pvrqualitasag/rexam/20201214_lbgfs_test/R/nrm.R', echo=TRUE)
#' l_nrm <- generate_problem_nrm()
#' eval(parse(text = l_nrm$rstmt))
# pl_input$n_nr_founder   = NULL
# pl_input$n_nr_cross_f1  = NULL
# pl_input$n_nr_gen       = NULL
# pl_input$vec_nr_cross   = NULL
#'
generate_problem_setup <- function(pl_input = NULL){
  # check availabilty of AlphaSimR
  if (!require(AlphaSimR)){
    install.packages('AlphaSimR')
    require(AlphaSimR)
  }

  # Define Constants
  n_nr_founder <- ifelse(is.null(pl_input$n_nr_founder), 4, pl_input$n_nr_founder)                         # number of founders
  n_nr_cross_f1 <- ifelse(is.null(pl_input$n_nr_cross_f1), sample(c(2:3), 1), pl_input$n_nr_cross_f1)      # number of crosses in f1
  n_nr_gen <- ifelse(is.null(pl_input$n_nr_gen), 3, pl_input$n_nr_gen)                                     # number of generations after founders
  vec_nr_cross <- pl_input$vec_nr_cross
  if (is.null(vec_nr_cross))
    vec_nr_cross <- c(4-n_nr_cross_f1, 1, 1)                                                               # number of crosses in generations f2, ...

  # Founder Population Haplotypes
  founderPop = quickHaplo(nInd=n_nr_founder, nChr=1, segSites=10)

  # Set simulation parameters
  SP = SimParam$new(founderPop)
  SP$setSexes("yes_sys")

  # Create founder population
  pop = newPop(founderPop, simParam=SP)

  # F1 population with founder parents
  pop2 <- randCross(pop, n_nr_cross_f1, simParam=SP)

  # loop over a number of subsequenct generations
  for (idx in 1:n_nr_gen){
    pop2 <- c(pop2, randCross(pop2, vec_nr_cross[idx], simParam=SP))
  }

  # put pedigree information into a tibble
  tbl_ped_nrm <- tibble::tibble(ID = pop2@id, Sex = pop2@sex, Sire = pop2@father, Dam = pop2@mother)

  # return output
  return(list(tbl_result = tbl_ped_nrm,
              rstmt      = paste0('tbl_ped_nrm <- tibble::tibble(ID = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_ped_nrm$ID),
                                  ', Sex = ',
                                  rmdexam::character_vector_as_def_string(tbl_ped_nrm$Sex),
                                  ', Sire = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_ped_nrm$Sire),
                                  ', Dam = ',
                                  rmdexam::numeric_vector_as_def_string(tbl_ped_nrm$Dam),
                                  ')\n',
                                  'dam_id <- tbl_ped_nrm$Dam[length(tbl_ped_nrm$Dam)]\n',
                                  'sire_id <- tbl_ped_nrm$Sire[length(tbl_ped_nrm$Sire)]',
                                  collapse = '')))


}



