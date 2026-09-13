# ============================================================================
# Ternary diagrams of Mariana Trench geomorphic factors (R, ggtern).
# This produced figures in the peer-reviewed article:
#   Lemenkova, P. (2019). Plotting Ternary Diagrams by R Library ggtern for
#   Geological Modelling. Eastern Anatolian Journal of Science, 5(2), 16-25.
#   DOI: https://doi.org/10.6084/m9.figshare.11369955
#   HAL: https://hal.science/hal-02413007  Zenodo: https://zenodo.org/record/3576669
# Author: Polina Lemenkova | ORCID: 0000-0002-5759-1089
# ============================================================================

# Ternary Diagram // треугольные диаграммы
# ЧАСТЬ 1: вчитываем таблицу. делаем data.frame. удаляем NA
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))})
sum(row.has.na) 
head(MDF) 

MDTt = melt(setDT(MDF), measure = patterns("^plate"), value.name = c("tectonics"))
head(MDTt)
levels(MDTt$variable) = c("Philippine" , "Pacific", "Mariana", "Caroline")
Plates<- c("Philippine" , "Pacific", "Mariana", "Caroline")


# ЧАСТЬ 2: чертим треугольную диаграмму Марианского желоба пакетом ggtern
library(ggtern)  
 
# вариант-1. по тектонике (4 плиты)
MDTer <- data.frame(
			x = MDTt$igneous_volc,
			y = MDTt$tectonics,
			z = MDTt$slope_angle,
			Value = MDTt$slope_angle,
			Group = as.factor(MDTt$variable))

MT1<- ggtern(data= MDTer,aes(x,y,z,color = Group)) + 
	theme_rgbw() +
	geom_point() + 
#	geom_path() + 
	scale_color_manual(values = c("green" , "red", "orange", "blue")) + 
	labs(x="Igneous \nVolcanos",y="Tectonics",z="Slope \nAngle",
  		title="Mariana Trench",
  		subtitle="Ternary Diagram: Tectonic Plates") +
  geom_Tline(Tintercept=.5,arrow=arrow(), colour='red') +
  geom_Lline(Lintercept=.2, colour='magenta') +
  geom_Rline(Rintercept=.1, colour='blue') +
  geom_confidence_tern() 
MT1

# вариант-2. по классам морфология

levels(MDTt$morph_class) = c("Strong Slope", "Very Strong Slope", "Steep Slope", "Extreme Slope")
MDTM <- data.frame(
			x = MDTt$Min,
			y = MDTt$aspect_degree,
			z = MDTt$slope_angle,
			Value = MDTt$slope_angle,
			Group = as.factor(MDTt$morph_class))

MT2<- ggtern(data= MDTM,aes(x,y,z,color=Group), show.legend=TRUE) + 
	theme_rgbw() +
	geom_point() + 
	geom_path() + 
	labs(x="Max \nDepth",y="Aspect Degree",z="Slope\nAngle",
  		title="Mariana Trench",
  		subtitle="Ternary Diagram: Slope Morphology Class") +
  geom_Tline(Tintercept=.5,arrow=arrow(), colour='red') +
  geom_Lline(Lintercept=.2, colour='magenta') +
  geom_Rline(Rintercept=.1, colour='blue') +
  geom_confidence_tern() +
  geom_Tisoprop(value=0.5) +
  geom_Lisoprop(value=0.5) +
  geom_Risoprop(value=0.5)
MT2
	
# вариант-3 по аспекту - разворот угла
MDTAs <- data.frame(
			x = MDTt$slope_angle,
			y = MDTt$aspect_degree,
			z = MDTt$Min,
			Value = MDTt$aspect_degree,
			Group = as.factor(MDTt$aspect_class))

MT3<- ggtern(data = MDTAs,aes(x,y,z,color = Group)) + 
	theme_rgbw() +
	geom_point() + 
	scale_color_manual(values = c("green", "red", "orange", "blue", "yellow" , "brown", "grey", "cyan")) + 
	labs(x="Slope \nAngle", size = 1, y="Aspect \nDegree", z="Max \nDepth",
  		title="Mariana Trench",
  		subtitle="Ternary Diagram: Aspect Class") +
  geom_Tline(Tintercept=.5,arrow=arrow(), colour='red') +
  geom_Lline(Lintercept=.2, colour='magenta') +
  geom_Rline(Rintercept=.1, colour='blue') +
  geom_confidence_tern() +
  geom_Tisoprop(value=0.5) +
  geom_Lisoprop(value=0.5) +
  geom_Risoprop(value=0.5) 
MT3

plot<- grid.arrange(MT1, MT2, MT3, newpage = TRUE, nrow = 1, ncol = 3, top="Mariana Trench")


# вариант-4. по толщине мор. отложений / седиментология
MD4 <- data.frame(
			x = MDTt$igneous_volc,
			y = MDTt$sedim_thick,
			z = MDTt$slope_angle,
			Value = MDTt$slope_angle)

MT4<- ggtern(data = MD4,aes(x,y,z), show.legend=TRUE) + 
	theme_rgbw() +
	geom_point() + 
#	geom_path(alpha = .5, lwd = 0.2) + 
	labs(x="Igneous \nVolcanos", size = 0.5,y="Sedimental \nThickness",z="Slope \nAngle",
  		title="Mariana Trench",
  		subtitle="Ternary Diagram: Sedimental Thickness") +
  geom_Tline(Tintercept=.5,arrow=arrow(), colour='deeppink') +
  geom_Lline(Lintercept=.2, colour='magenta') +
  geom_Rline(Rintercept=.1, colour='springgreen') +
  geom_confidence_tern() + 
  geom_smooth_tern(method = 'loess', size = .4, color = "yellow1") +
  geom_mean_ellipse (size = .5, color = "cyan")
MT4

figure <-plot_grid(MT1, MT2, MT3, MT4, labels = c("1", "2", "3", "4"), ncol = 2, nrow = 2)
