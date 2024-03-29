#EvidenciaA
library(survival)
datos<-survival::rats

########An�lisis Descriptivo

#Tabla de contingencia
table(datos$status,datos$sex)
#Categor�a: Female or Male
#0-censura   1-Tumor
table(datos$status,datos$rx)
#Categor�a: treatment
#0-control 1-tumor


#Tiempo promedio de �xito seg�n la categoria de la variable

hembrase<-datos$time[datos$sex=="f" & datos$status==1]
hembrasc<-datos$time[datos$sex=="f" & datosr$status==0]
mean(hembrase) 

machose<-datos$time[datos$sex=="m" & datos$status==1]
machosc<-datos$time[datos$sex=="m" & datos$status==0]
mean(machose)


######An�lisis de supervivencia

#Supervivencia general
help(rats)
ratsg<-Surv(datos$time,datos$status)
km.ratsg<- survfit(ratsg~1) #Funci�n Kaplan-Meier general de supervivencia
summary(km.ratsg)
plot(km.ratsg)
summary(km.ratsg,c(20,70,120))
#Probabilidad de sobrevivir a 20 d�as = 1.00 ~ 100%
#Probabilidad de sobrevivir a 70 d�as =0.955 ~ 95.5%
#Probabilidad de sobrevivir a 120 d�as = 

#Como el tiempo que m�s a durado un esp�cimen bajo observaci�n
#fueron 104 d�as, no tenemos informaci�n para conocer 
#probabilidad de supervivencia para 120 d�as de un esp�cimen

#######Comparaci�n de funciones de supervivencia


#El sexo de la rata influye de manera significativa en la probabilidad
#de supervivencia, �El macho es m�s fuerte?

km.ratsS<- survfit(ratsg~rats$sex)
summary(km.ratsS)
plot(km.ratsS,col=c("magenta","blue"))
#Viendo las gr�ficas, podemos ver que los machos son "mas resistentes"
#que las hembras. Porque de los machos y hembras que han generado
#el tumor han sobrevivido m�s los machos.


#Comparativa de funciones sobre "Sex"
survdiff(ratsg~rats$sex,rho = 0) #p-value = 0.000000002

#H0: funciones de supervivencia iguales
#H1: difieren las funciones

#Como p-value < alpha -> 0.000000002 < 0.05, entonces decimos que
#Rechazamos H0, por lo tanto decimos que las funciones son diferentes

#al guiarnos por la gr�fica podemos observar que los machos sobreviven m�s 
#que las hembras

###################################################################

#El tipo de tratamiento afecta de manera significativa en la 
#supervivencia de las ratas macho.
#Que tratamiento ayuda de manera m�s efectiva a la cura 
# de tumores en las ratas macho


km.t<-survfit(ratsg[datos$sex!="f"]~datos$rx[datos$sex!="f"])
summary(km.t)
plot(km.t, col=c("red", "blue"))

survdiff(ratsg[datos$sex!="f"]~datos$rx[datos$sex!="f"])
#H0: las funciones son iguales
#Ha: las funciones son diferentes
#Con un pvalor=0.3>alpha=0.05 NO rechazamos H0, por lo que las
#funciones son iguales, por lo tanto, que los tratamientos tienen
#las mismas probabilidades de supervivencia en las ratas macho
