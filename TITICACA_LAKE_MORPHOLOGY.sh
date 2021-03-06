#gmtset HEADER_FONT_SIZE 10 ANNOT_FONT_SIZE_PRIMARY 8 BASEMAP_TYPE PLAIN DEGREE_FORMAT 1

PS=TITICACA_LAKE_MORPHOLOGY_PERU.ps

###################################################################################################################
###################################################################################################################
########################## PARAMETROS GMT #########################################################################
###################################################################################################################
############################ LOCATION PARAMETERS ##################################################################
###################################################################################################################
#-R<xmin>/<xmax>/<ymin>/<ymax>[/<zmin>/<zmax>], dd:mm format ok
PERU=288.5/291.5/-16.7/-14.49
##########################################################################################################################################################
############################### SCALES ###################################################################################################################
#   -L[f][x]<x0>/<y0>/<lat>/<length>[m|n|k], append m, n, or k for miles, nautical miles, or km [Default]
ESC=7
SCALE_BAR_PUNO=289.3/-16.6/50/100
#################################################################################################################################################################
########################## LOCATION ############################################################################################################################
################################## PALETTE COLORS CPT ##################################################################################################################
CPT3=PUNO_12PTES.cpt
########################## GEOGRAPHICS #######################################################################################################################################
DEPARTAMENTO=~/CONSULTORIA/02_DATA_GMT/01_PSXY/03_PSXY_GEOGRAFICAS/00_DEPARTMENT/PUNO.xyz
PROVINCIAS=~/CONSULTORIA/02_DATA_GMT/01_PSXY/03_PSXY_GEOGRAFICAS/00_PROVINCES/PROVINCIAS_PERU.xyz
#PROVINCIAS_PUNO=~/CONSULTORIA/02_DATA_GMT/01_PSXY/03_PSXY_GEOGRAFICAS/00_PROVINCES/PROV_PUNO.xyz

#############################################################################################################################################################################
###############################################DEFAULTS ######################################################################################################################
gmtset BASEMAP_TYPE plain DEGREE_FORMAT 5 LABEL_FONT_SIZE 8 ANOT_FONT_SIZE 8 OBLIQUE_ANNOTATION	1 ANNOT_MIN_ANGLE 20

#-DEGREE_FORMAT 1 --- grades minutes second - 0 to 180
#-DEGREE_FORMAT 5 --- grades - 0 to 180
#-DEGREE_FORMAT 4 --- grades - 0 to 360

#############################################################################################################################################################################
#############################################################################################################################################################################
################################# G M T #####################################################################################################################################
#############################################################################################################################################################################
#############################################################################################################################################################################
################################# FRAME  ####################################################################################################################################
psbasemap -Ba10mWESN -Jm$ESC  -R$PERU -V -K -X5 -Y4 > $PS
#gmtdefaults -D > .gmtdeafults_puno
############################################################################################################################################################################
##################################### GRID ################################################################################################################################
#surface $PUNO_XYZ -G14.6_16.6_71.5_68.5_PUNO.grd -I15c -R$PERU
#makecpt -Cglobe -T-7000/7000/10 > prof.cpt
#############################################################################################################################################################################
#grdgradient 14.6_16.6_71.5_68.5_PUNO.grd  -G14.6_16.6_71.5_68.5_PUNO.inten -A45/125  -Nt
#pscoast -Jm$ESC  -R$PERU -Ba4mg4mWeSn -N1/1p -W1.5p/0/0/0 -Lf$SCALE_BAR_PUNO  -Dh -V -K -O >> $PS
grdimage -R$PERU 14.6_16.6_71.5_68.5_PUNO.grd -C$CPT3 -Jm$ESC -I14.6_16.6_71.5_68.5_PUNO.inten -V -K -O >>  $PS
#####################################################################################################################
################################# MAPA ##############################################################################
#####################################################################################################################
grdcontour -R$PERU 14.6_16.6_71.5_68.5_PUNO.grd -L-3000/7000 -C250 -Af8/169/101/101t -Jm$ESC -W0.04p/150/100/50 -B -V -O -K >> $PS
#-Af10t transparent, WITHOUT BOX
#-A aint=annotation interval
#-Af6/250/0/0o  BOX RED LABEL SIZE 6
#####################################################################################################################
########################## GEOGRAFICAS ####################################################################################
##########################################################################################################################
psxy PROVINCIAS_PERU.xyz -Jm$ESC -R$PERU -M -A -W0.5p/0/0/0  -K -V -O >> $PS
##########################################################################################################################
######################################## LAGOS ############################################################################
pscoast -B -N1/1p -W1p/50/150/250  -S0/255/255 -Jm$ESC  -Lf$SCALE_BAR_PUNO -R$PERU -Dh -V -O -K >> $PS
######################################## SCALE #################################################################################
psscale  -B100:"Topografia(m)":  -D10/-1.5/20/0.3h  -C$CPT3 -O -V -K  >> $PS
#################################### GRD ########################################################################################
psbasemap -B -Jm$ESC  -R$PERU -V -K  -O  >> $PS
#################################################################################################################################
################################## PROVINCIAS ###################################################################################
pstext -R -Jm$ESC -: -D.05/.05 -S0.5p/0/150/250  -G50/150/250 -O -V -K <<END>>$PS
-15.6 -69.65 15 0 1 BC TITICACA
END
pstext -R -Jm$ESC -: -D.05/.05 -S0.5p/0/150/250 -G50/150/250 -O -V -K <<END>>$PS
-15.85 -69.4 15 0 1 BC LAKE
END
#################################################################################################################################



