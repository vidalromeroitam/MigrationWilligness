* Sintax for the regression models in the paper "Crossing the imaginary border: On the determinants of individuals' willingness to migrate"


**RECODE

recode q14 (1=1) (2=0) (nonmiss=.)

gen victim = vic1ext
recode victim (2=0) (.a=.) (.b=.)
label define victim 1 "Victima" 0 "No victima"
label values victim victim

generate wealth1=1 if wealth==1
generate wealth2=1 if wealth==2
generate wealth3=1 if wealth==3
generate wealth4=1 if wealth==4
generate wealth5=1 if wealth==5
recode wealth1-wealth5 (.=0) if wealth!=.

gen woman=q1tc_r
recode woman (2=1) (1=0) (3=.)

generate edad1=1 if edad==1
generate edad2=1 if edad==2
generate edad3=1 if edad==3
generate edad4=1 if edad==4
generate edad5=1 if edad==5
generate edad6=1 if edad==6
recode edad1-edad6 (.=0) if edad!=.

gen hijos=1 if q12bn>0
recode hijos .=0 if q12bn==0

recode colorr (97=.)

recode q14 aoj11 victim b18 wealth1 wealth2 wealth3 wealth4 q10e pn4 m1 b3 it1 woman edad1 edad2 edad3 edad4 edad5 hijos colorr urban (.a=.) (.b=.) (.c=.) (.z=.) (97=.)

drop if pais==5 | pais==22 | pais==40 | pais==41 | pais==27

gen centralamerica=1 if pais==1 | pais==2 | pais==3 | pais==4 | pais==6 | pais==7 | pais ==26
gen southamerica=1 if pais==8 | pais==9 | pais==10 | pais==11 | pais==12 | pais==13 | pais==14 | pais==15 | pais==17
gen caribean=1 if pais==21 | pais==23 | pais==25 | pais==28 | pais==30
recode centralamerica southamerica caribean (.=0)

**Weight by country

gen weight_country=0.9157014157 if pais==1
recode weight_country  .=0.973990417522245  if  pais==2
recode weight_country  .=0.96736913664174  if  pais==3
recode weight_country  .=1.01497860199715  if  pais==4
recode weight_country  .=0.982734806629834  if  pais==6
recode weight_country  .=0.982056590752243  if  pais==7
recode weight_country  .=0.993021632937893  if  pais==8
recode weight_country  .=1.01209103840683  if  pais==9
recode weight_country  .=0.942384105960265  if  pais==10
recode weight_country  .=0.966711956521739  if  pais==11
recode weight_country  .=1.11607843137255  if  pais==12
recode weight_country  .=0.926432291666667  if  pais==13
recode weight_country  .=0.990257480862909  if  pais==14
recode weight_country  .=1.06035767511177  if  pais==15
recode weight_country  .=0.978679504814305  if  pais==17
recode weight_country  .=0.95503355704698  if  pais==21
recode weight_country  .=1.17023026315789  if  pais==23
recode weight_country  .=0.97599451303155  if  pais==25
recode weight_country  .=1.00565371024735  if  pais==26
recode weight_country  .=1.06352765321375  if  pais==28
recode weight_country  .=1.08130699088146  if  pais==30


*Model 1 in Table 1
	
logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban i.pais [iweight=weight_country] if yhatm1_d==1, cluster(pais) 

**Probabilities estimation for Model 1
	
margins , at(victim=1)
margins , at(victim=0)

margins , at(aoj11=1)
margins , at(aoj11=2)
margins , at(aoj11=3)
margins , at(aoj11=4)

margins , at(b18=1)
margins , at(b18=2)
margins , at(b18=3)
margins , at(b18=4)
margins , at(b18=5)
margins , at(b18=6)
margins , at(b18=7)

margins , at(victim=1 idio2=1)
margins , at(victim=1 idio2=2)
margins , at(victim=1 idio2=3)

margins , at(victim=0 idio2=1)
margins , at(victim=0 idio2=2)
margins , at(victim=0 idio2=3)

margins , at(victim=1 wealth=1)
margins , at(victim=1 wealth=2)
margins , at(victim=1 wealth=3)
margins , at(victim=1 wealth=4)
margins , at(victim=1 wealth=5)

margins , at(victim=0 wealth=1)
margins , at(victim=0 wealth=2)
margins , at(victim=0 wealth=3)
margins , at(victim=0 wealth=4)
margins , at(victim=0 wealth=5)

margins , at(victim=1 b18=1)
margins , at(victim=1 b18=2)
margins , at(victim=1 b18=3)
margins , at(victim=1 b18=4)
margins , at(victim=1 b18=5)
margins , at(victim=1 b18=6)
margins , at(victim=1 b18=7)

margins , at(victim=0 b18=1)
margins , at(victim=0 b18=2)
margins , at(victim=0 b18=3)
margins , at(victim=0 b18=4)
margins , at(victim=0 b18=5)
margins , at(victim=0 b18=6)
margins , at(victim=0 b18=7)

*Worse and better

margins , at(victim=1 aoj11=4 b18=1)
margins , at(victim=0 aoj11=1 b18=7)

*Eco

margins , at(idio2=1)
margins , at(idio2=3)

margins , at(wealth=1)
margins , at(wealth=5)


**Model 2 in Table 1

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban victim_b18 victim_aoj11 victim_idio2 victim_wealth i.pais [iweight=weight_country] if yhatm1_d==1 , cluster(pais) 


**Models by country in Appendix 2

*MODELOS POR PAIS

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==1, robust
estimates store MEX

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==2, robust
estimates store GTM

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==3, robust
estimates store SLV

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==4, robust
estimates store HND

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==6, robust
estimates store CRI

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==7, robust
estimates store PAN

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==8, robust
estimates store COL

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==9, robust
estimates store ECU

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==10, robust
estimates store BOL

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==11, robust
estimates store PER

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==12, robust
estimates store PRY

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==13, robust
estimates store CHL

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==14, robust
estimates store URY

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==15, robust
estimates store BRA

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==17, robust
estimates store ARG

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==21, robust
estimates store DOM

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==23, robust
estimates store JAM

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==25, robust
estimates store TTO

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==26, robust
estimates store BLZ

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==28, robust
estimates store BHS

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==30, robust
estimates store GRD

**Probabilities estimation for country regressions

*VICTIM

 logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban i.pais [iweight=weight_country] if yhatm1_d==1 , cluster(pais) 
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==1, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==2, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==3, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==4, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==6, robust
margins , at(victim=1)
margins , at(victim=0)

logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==7, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==8, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==9, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==10, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==11, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==12, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==13, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==14, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==15, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==17, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==21, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==23, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==25, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==26, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==28, robust
margins , at(victim=1)
margins , at(victim=0)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==30, robust
margins , at(victim=1)
margins , at(victim=0)

*AOJ11 - SECURITY PERCEPTION 

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban i.pais [iweight=weight_country] if yhatm1_d==1 , cluster(pais) 
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==1, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==2, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==3, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==4, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==6, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==7, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==8, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==9, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==10, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==11, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==12, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==13, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==14, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==15, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==17, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==21, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==23, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==25, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==26, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==28, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==30, robust
margins , at(aoj11=4)
margins , at(aoj11=1)

*B18 - TRUST IN THE POLICE 

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban i.pais [iweight=weight_country] if yhatm1_d==1 , cluster(pais) 
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==1, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==2, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==3, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==4, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==6, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==7, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==8, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==9, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==10, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==11, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==12, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==13, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==14, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==15, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==17, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==21, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==23, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==25, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==26, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==28, robust
margins , at(b18=1)
margins , at(b18=7)

quietly logit q14 aoj11 victim b18 idio2 b3 it1 woman edad1 edad2 edad3 edad4 edad5 wealth hijos colorr urban if yhatm1_d==1 & pais==30, robust
margins , at(b18=1)
margins , at(b18=7)



