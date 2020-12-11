# Solution by C.N.

n_nr_trait <- 2
n_nr_founder <- 3
n_nr_animal <- 8
n_nr_observation <- n_nr_animal - n_nr_founder

tbl_data_sol12p01 <- tibble::tibble(Animal = c((n_nr_founder+1):n_nr_animal),
                                    Sex = c("Male", "Female","Female","Male","Male"),
                                    Sire = c(1,3,1,4,3),
                                    Dam = c(NA,2,2,5,6),
                                    WWG = c(4.5,2.9,3.9,3.5,5.0),
                                    PWG = c(6.8,5.0,6.8,6.0,7.5))

mat_g0 <- matrix(data = c(20,18,18,40), nrow = n_nr_trait, byrow = TRUE)
mat_r0 <- matrix(data = c(40,11,11,30), nrow = n_nr_trait, byrow = TRUE)
mat_x1 <- mat_x2 <- matrix(data = c(1, 0,
                                    0, 1,
                                    0, 1,
                                    1, 0,
                                    1, 0), nrow = n_nr_observation, byrow = TRUE)
mat_zero <- matrix(0, nrow = nrow(mat_x1), ncol = ncol(mat_x1))
mat_X <- rbind(cbind(mat_x1, mat_zero), cbind(mat_zero, mat_x2))
mat_Xt <- t(mat_X)

mat_z1zero <- matrix(0, nrow = n_nr_observation, ncol = n_nr_founder)
mat_z1 <- mat_z2 <- cbind(mat_z1zero, diag(1, n_nr_observation))
mat_zzero <- matrix(0, nrow = nrow(mat_z1), ncol(mat_z2))
mat_Z <- rbind(cbind(mat_z1, mat_zzero), cbind(mat_zzero, mat_z2))
mat_Zt <- t(mat_Z)

mat_r <- mat_r0 %x% diag(1, n_nr_observation)
mat_R_1 <- solve(mat_r)

ped_sol12p01 <- pedigreemm::pedigree(sire = c(rep(NA, n_nr_founder), tbl_data_sol12p01$Sire),
                                     dam  = c(rep(NA, n_nr_founder), tbl_data_sol12p01$Dam),
                                     label = as.character(1:n_nr_animal))
mat_ainv <- as.matrix(pedigreemm::getAInv(ped = ped_sol12p01))

mat_Ginv <- solve(mat_g0) %x% mat_ainv

linksoben <- mat_Xt %*% mat_R_1 %*% mat_X #obenlinks
rechtsoben <- mat_Xt %*% mat_R_1 %*% mat_Z
linksunten <- mat_Zt %*% mat_R_1 %*% mat_X

unten <- mat_Zt %*% mat_R_1 %*% mat_Z
rechtsunten <- unten + mat_Ginv
matbig <- rbind(cbind(linksoben, rechtsoben), cbind(linksunten, rechtsunten)) #M^-1
M_1 <- solve(matbig)


y <- c(4.5,2.9,3.9,3.5,5.0,6.8,5.0,6.8,6.0,7.5)
vec_y <- c(tbl_data_sol12p01$WWG, tbl_data_sol12p01$PWG)
vec_y - y
roben <- mat_Xt %*% mat_R_1 %*% y
runten <- mat_Zt %*% mat_R_1 %*% y
r <- c(roben, runten)
r

s <- M_1 %*% r
s
round(s, digits = 4)
