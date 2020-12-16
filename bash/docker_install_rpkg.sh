# Install additional R-packages in docker container
#
docker exec -it pvr_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
# check installation
docker exec -it pvr_rstudio R -e "require(rmdhelp)"

# pedigreemm
docker exec -it pvr_rstudio R -e "install.packages('pedigreemm')"


# ###
SCRIPTDIR=/home/quagadmin/source/misctools/
TESTSTUDENT=/home/quagadmin/lbgfs2020/test-student-usernames-lbgfs2020.txt
STUDENTUSER=/home/quagadmin/lbgfs2020/student-usernames-lbgfs2020.txt
#' fetch individual directory
#' change to progdir
cd $SCRIPTDIR

cat $TESTSTUDENT | while read s
do
  echo " * Student: $s"
  docker exec -it "${s}_rstudio" R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
  docker exec -it "${s}_rstudio" R -e "require(rmdhelp)"
  sleep 2
done

docker exec -it pvr_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it pvr_rstudio R -e "require(rmdhelp)"

cat $STUDENTUSER | while read s
do
  #echo " * Student: $s"
  echo "docker exec -it ${s}_rstudio R -e \"install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')\""
  echo "docker exec -it ${s}_rstudio R -e \"require(rmdhelp)\""
done
docker exec -it deuberj_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it deuberj_rstudio R -e "require(rmdhelp)"
docker exec -it fomasid_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it fomasid_rstudio R -e "require(rmdhelp)"
docker exec -it pahofman_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it pahofman_rstudio R -e "require(rmdhelp)"
docker exec -it jungenr_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it jungenr_rstudio R -e "require(rmdhelp)"
docker exec -it penlin_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it penlin_rstudio R -e "require(rmdhelp)"
docker exec -it xenamarie.mapel_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it xenamarie.mapel_rstudio R -e "require(rmdhelp)"
docker exec -it kmessmer_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it kmessmer_rstudio R -e "require(rmdhelp)"
docker exec -it clemence.nanchen_rstudio R -e "install.packages('pedigreemm');remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it clemence.nanchen_rstudio R -e "require(rmdhelp)"


# kableExtra

docker exec -it deuberj_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it fomasid_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it pahofman_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it jungenr_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it penlin_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it xenamarie.mapel_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it kmessmer_rstudio R -e "install.packages('kableExtra')"
sleep 2
docker exec -it clemence.nanchen_rstudio R -e "install.packages('kableExtra')"

# update rmdhelp
docker exec -it pvr_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"

docker exec -it deuberj_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it fomasid_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it pahofman_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it jungenr_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it penlin_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it xenamarie.mapel_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it kmessmer_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"
docker exec -it clemence.nanchen_rstudio R -e "remotes::install_github(repo = 'charlotte-ngs/rmdhelp')"

# rvcetools
docker exec -it pvr_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"

docker exec -it deuberj_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it fomasid_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it pahofman_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it jungenr_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it penlin_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it xenamarie.mapel_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it kmessmer_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"
docker exec -it clemence.nanchen_rstudio R -e "remotes::install_github(repo = 'pvrqualitasag/rvcetools')"

# AlphaSimR
docker exec -it pvr_rstudio R -e "install.packages('AlphaSimR')"

docker exec -it deuberj_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it fomasid_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it pahofman_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it jungenr_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it penlin_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it xenamarie.mapel_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it kmessmer_rstudio R -e "install.packages('AlphaSimR')"
sleep 2
docker exec -it clemence.nanchen_rstudio R -e "install.packages('AlphaSimR')"

