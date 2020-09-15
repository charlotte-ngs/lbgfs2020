#' ---
#' title: Deploy Material
#' date: 2020-09-15
#' ---
#'
#' @title Deploy Lecture Material
#'
#' @description
#'
#' @details
#'
#' @examples
#' \dontrun{
#' ps_src <- file.path('vignettes', '00_preface.Rmd')
#' ps_trg_dir <- file.path('docs', 'articles')
#' ps_out_fmt <- 'all'
#' deploy_material(ps_src, ps_trg_dir)
#' }
#'
deploy_material <- function(ps_src, ps_trg_dir, ps_output_fmt = 'all'){
  # render source
  rmarkdown::render(ps_src, ps_out_fmt)
  # check whether target exists
  if (!dir.exists(paths = ps_trg_dir)) dir.create(path = ps_trg_dir)
  # get source without ext
  s_src_noext <- fs::path_ext_remove(ps_src)
  # move output
  if (ps_out_fmt == 'all'){
    # assume html and pdf as formats
    for (f in c('pdf', 'html')){
      s_out_wext <- paste(s_src_noext, f, sep = '.')
      if (!file.exists(s_out_wext)) stop(" *** ERROR: Cannot find output file: ", s_out_wext)
      fs::file_move(path = s_out_wext, new_path = ps_trg_dir)
    }
  } else {
    s_out_wext <- paste(s_src_noext, ps_out_fmt, sep = '.')
    if (!file.exists(s_out_wext)) stop(" *** ERROR: Cannot find output file: ", s_out_wext)
    fs::file_move(path = s_out_wext, new_path = ps_trg_dir)
  }
  # return
  return(invisible(TRUE))
}
