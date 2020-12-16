#' ---
#' title: Run Exam Generation
#' date:  2020-12-16
#' ---
#'
#' clean up environment
rm(list = ls())

#' set seed
set.seed(20201216)


#' read input record for test student
s_test_student_input_path <- here::here('misc/20200918_exercise_platform/test_students_lbgfs2020.txt')
con_test_student <- file(description = s_test_student_input_path)
vec_test_student_rec <- readLines(con = con_test_student)
close(con = con_test_student)
vec_test_student_user <- sapply(vec_test_student_rec, function(x) unlist(strsplit(x, split = ',', fixed = TRUE))[1], USE.NAMES = FALSE)

#' call exam generation function for test student
rmdexam::exam2rmd(pvec_problem = c('nrm', 'pbv'),
                  pvec_names   = vec_test_student_user,
                  pn_nr_exam   = length(vec_test_student_user),
                  ps_rmd_dir   = 'rmdexam/rmd',
                  ps_rsrc_dir  = 'rmdexam/R',
                  ps_tex_dir   = 'rmdexam/tex',
                  ps_out_dir   = 'rmdexam/out')


#' read input record for students
s_student_input_path <- here::here('misc/20200918_exercise_platform/students_lbgfs2020.txt')
con_student <- file(description = s_student_input_path)
vec_student_rec <- readLines(con = con_student)
close(con = con_student)
vec_student_user <- sapply(vec_student_rec, function(x) unlist(strsplit(x, split = ',', fixed = TRUE))[1], USE.NAMES = FALSE)

#' call exam generation function for students
rmdexam::exam2rmd(pvec_problem = c('nrm'),
                  pvec_names   = vec_student_user,
                  pn_nr_exam   = length(vec_student_user),
                  ps_rmd_dir   = 'rmdexam/rmd',
                  ps_rsrc_dir  = 'rmdexam/R',
                  ps_tex_dir   = 'rmdexam/tex',
                  ps_out_dir   = 'rmdexam/out')
