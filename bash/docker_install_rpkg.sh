# Install additional R-packages in docker container
#
docker exec -it pvr_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
# check installation
docker exec -it pvr_rstudio R -e "require(rmdhelp)"

# pedigreemm
docker exec -it pvr_rstudio R -e "install.packages('pedigreemm')"



