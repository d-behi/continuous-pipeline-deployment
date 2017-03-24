setwd("~/Documents/work/phd-papers/continuous-training/experiment-results/")
library(ggplot2)

loadData <- function(file){
  library(readr)
  library(stringr)
  data = read_file(file)
  data = str_replace_all(data, " ", "")
  data = strsplit(data, ',')
  return(as.numeric(data[[1]]))
}

loadQuality <- function(file){
  library(readr)
  library(stringr)
  data = read_file(file)
  data = str_replace_all(data, " ", "")
  data = strsplit(data, '\\[')
  one = strsplit(data[[1]][1], ',')
  two = strsplit(data[[1]][2], ',')
  three = strsplit(data[[1]][3], ',')
  four = strsplit(data[[1]][4], ',')
  five = strsplit(data[[1]][5], ',')
  six = strsplit(data[[1]][6], ',')
  seven = strsplit(data[[1]][7], ',')
  eight = strsplit(data[[1]][8], ',')
  nine = strsplit(data[[1]][9], ',')
  ten = strsplit(data[[1]][10], ',')
  
  return(list(one = as.numeric(one[[1]]), 
              two = as.numeric(two[[1]]),
              three = as.numeric(three[[1]]),
              four = as.numeric(four[[1]]),
              five = as.numeric(five[[1]]),
              six = as.numeric(six[[1]]),
              seven = as.numeric(seven[[1]]),
              eight = as.numeric(eight[[1]]),
              nine = as.numeric(nine[[1]]),
              ten = as.numeric(ten[[1]]))) 
}


# Plot Movie lens 100 K data
continuous = loadData('movie-lens-100k/5000/continuous-error.txt')
velox = loadData('movie-lens-100k/5000/velox-error.txt')
baselinePlus = loadData('movie-lens-100k/5000/offline-online.txt')
baseline= loadData('movie-lens-100k/5000/offline-only.txt')


df = data.frame(time = 1:length(continuous),
                continuous = continuous, 
                velox = velox,
                baseline = baseline,
                baselinePlus = baselinePlus)

retrainings = c(830,1699,2485,3355,4204,5000)

# data frame
p = ggplot(data = df) + 
  # plot lines
  geom_line(aes(x = time, y  = baseline, colour = "a"), size = 1.5) + 
  geom_line(aes(x = time, y  = baselinePlus, colour = "b"), size = 1.5) + 
  geom_line(aes(x = time, y  = continuous, colour = "c"), size = 1.5) + 
  geom_line(aes(x = time, y  = velox, colour = "d"), size = 1.5) + 
  # plot retraining points
  geom_point(data = df[retrainings,c(1,3)], 
             aes(x=time, y = velox, colour="e"), 
             shape = 17, 
             lwd = 5 ) + 
  # x and y labels
  xlab("Testing Increment") + ylab("Mean Squared Error") + 
  ylim(c(0.1,1.5)) + 
  # legend themes
  theme_bw() + 
  theme(legend.text = element_text(size = 28), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "transparent", fill = "transparent"), 
        axis.text.y=element_text(size=28),
        axis.text.x=element_text(size=28,angle = 90, hjust = 1 ),
        axis.title=element_text(size=28),  
        legend.position=c(0.85,0.25)) + 
  scale_color_manual(name ="",  # Name,
                     labels = c("baseline", "baseline+", "continuous", "velox", "retraining"), 
                     values = c("a" = "green", "b" = "orange", "c" = "blue","d" = "red", "e" = "black"))  + 
  guides(color=guide_legend(override.aes=list(shape=c(NA,NA,NA,NA,17),linetype=c(1,1,1,1,0)))) 

 
ggsave(p , filename = 'movie-lens-100k/5000/movie-lens-100k-quality-improved.eps', 
       device = 'eps', 
       width = 10, height = 7, 
       units = "in")


# Plot Movie lens 1M data
continuous = loadData('movie-lens-1M/50000/continuous-error.txt')
velox = loadData('movie-lens-1M/50000/velox-error.txt')
baselinePlus = loadData('movie-lens-1M/50000/offline-online.txt')
baseline= loadData('movie-lens-1M/50000/offline-only.txt')


df = data.frame(time = 1:length(continuous),
                continuous = continuous, 
                velox = velox,
                baseline = baseline,
                baselinePlus = baselinePlus)

retrainings = c(8379,16706,25075,33345,41765,50000)


p = 
  ggplot(data = df) + 
  # plot lines
  geom_line(aes(x = time, y  = baseline, colour = "a"), size = 1.5) + 
  geom_line(aes(x = time, y  = baselinePlus, colour = "b"), size = 1.5) + 
  geom_line(aes(x = time, y  = continuous, colour = "c"), size = 1.5) + 
  geom_line(aes(x = time, y  = velox, colour = "d"), size = 1.5) + 
  # plot retraining points
  geom_point(data = df[retrainings,c(1,3)], 
             aes(x=time, y = velox, colour="e"), 
             shape = 17, 
             lwd = 5 ) + 
  # x and y labels
  xlab("Testing Increment") + ylab("Mean Squared Error") + 
  ylim(c(0.1,1.5)) + 
  # legend themes
  theme_bw() + 
  theme(legend.text = element_text(size = 28), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "transparent", fill = "transparent"), 
        axis.text.y=element_text(size=28),
        axis.text.x=element_text(size=28,angle = 90, hjust = 1 ),
        axis.title=element_text(size=28),  
        legend.position=c(0.85,0.25)) + 
  scale_color_manual(name ="",  # Name,
                     labels = c("baseline", "baseline+", "continuous", "velox", "retraining"), 
                     values = c("a" = "green", "b" = "orange", "c" = "blue","d" = "red", "e" = "black"))  + 
  guides(color=guide_legend(override.aes=list(shape=c(NA,NA,NA,NA,17),linetype=c(1,1,1,1,0)))) 


ggsave(p , filename = 'movie-lens-1M/50000/movie-lens-1m-quality-improved.eps', 
       device = 'eps',
       width = 10, height = 7, 
       units = "in")



# Plot buffer size vs time
times = loadData('movie-lens-100k/buffer-size/time.txt')
buffer = seq(500, 5000, 500)

df = data.frame(buffer, times = times/60)

bufferVsTimePlot = ggplot(data = df) + 
  aes(x = buffer, y = times, colour = "blue") + 
  geom_line(size = 1.5) + 
  geom_point(lwd = 4)  + 
  xlab("Buffer size") + ylab("Time (m)") + 
  scale_color_manual(values=c("blue" = "blue")) + 
  theme_bw() + 
  theme(legend.text = element_text(size = 30), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "black", fill = "transparent"), 
        axis.text=element_text(size=30),
        axis.title=element_text(size=32),  
        legend.position=c(0.85,0.2)) + 
  guides(colour=FALSE)

ggsave(bufferVsTimePlot , filename = 'movie-lens-100k/buffer-size/movie-lens-100k-buffer-time-improved.eps', 
       device = 'eps',
       width = 10, height = 7, 
       units = "in")

# Plot sampling rate vs time
times = loadData('movie-lens-100k/sampling/times.txt')
buffer = seq(0.1, 1.0, 0.1)

df = data.frame(buffer, times = times/60)

bufferVsTimePlot = ggplot(data = df) + 
  aes(x = buffer, y = times, colour = "blue") + 
  geom_line(size = 1.5) + 
  geom_point(lwd = 4)  + 
  xlab("Sampling Rate") + ylab("Time (m)") + 
  scale_color_manual(values=c("blue" = "blue")) + 
  theme_bw() + 
  theme(legend.text = element_text(size = 30), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "black", fill = "transparent"), 
        axis.text=element_text(size=30),
        axis.title=element_text(size=32),  
        legend.position=c(0.85,0.2)) + 
  guides(colour=FALSE)

ggsave(bufferVsTimePlot , filename = 'movie-lens-100k/sampling/movie-lens-100k-sampling-time-improved.eps', 
       device = 'eps', 
       width = 10, height = 7, 
       units = "in")
  
## MOVIE LENS 100K times    
continuous = 506
velox = 854
baseline = 187
methods = c('Baseline', 'Continuous', 'Velox')
df = data.frame(methods = methods, time = c(baseline, continuous, velox)/60)
melted = melt(df, id.vars = 'methods', variable.names = "methods")

movielens100kTimes = 
  ggplot(melted, aes(x = methods, y = value, fill = methods)) +
  geom_bar(stat='identity') + 
  xlab("") + ylab("Time (m)") + 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 30)) +
  scale_fill_manual("", values = c("Baseline"="green", "Continuous"="blue", "Velox" = "red")) + 
  theme_bw() + 
  theme(legend.title = element_text(size = 28),
        legend.text = element_text(size = 28), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "transparent", fill = "transparent"), 
        axis.text.y=element_text(size=28),
        axis.title.y=element_text(size=28),  
        legend.position=c(0.25,0.88), 
        axis.title.x = element_blank(), 
        axis.text.x = element_blank(), 
        plot.margin = unit(c(0.5, 0.0, 0.5, 0.2), "cm"))

ggsave(movielens100kTimes , filename = 'movie-lens-100k/movie-lens-100k-times.eps', 
       device = 'eps',
       width = 7, height = 5, 
       units = "in")

## MOVIE LENS 100K times    

continuous =4608
velox = 9610
baseline = 1825
methods = c('Baseline', 'Continuous', 'Velox')
df = data.frame(methods = methods, time = c(baseline, continuous, velox)/60)
melted = melt(df, id.vars = 'methods', variable.names = "methods")


movielens1MTimes = 
  ggplot(melted, aes(x = methods, y = value, fill = methods)) +
  geom_bar(stat='identity') + 
  xlab("") + ylab("Time (m)") + 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 250)) +
  scale_fill_manual("", values = c("Baseline"="green", "Continuous"="blue", "Velox" = "red")) + 
  theme_bw() + 
  theme(legend.title = element_text(size = 28),
        legend.text = element_text(size = 28), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "transparent", fill = "transparent"), 
        axis.text.y=element_text(size=28),
        axis.title.y=element_text(size=28),  
        legend.position=c(0.25,0.88), 
        axis.title.x = element_blank(), 
        axis.text.x = element_blank(), 
        plot.margin = unit(c(0.5, 0.0, 0.5, 0.2), "cm"))

ggsave(movielens1MTimes , filename = 'movie-lens-1M/movie-lens-1M-times.eps', 
       device = 'eps',
       width = 7, height = 5, 
       units = "in")

# Plot running time of different work loads
time_100k = c( 506.1425, 854.3796, 187.6295)
time_1M = c( 4608.0255, 9610.6307, 1825.9909)
time_MNIST = c( 244.62878799438477, 1569.8254868984222, 56.363343954086304)
models = c('Continuous', 'Velox', 'Static Training')
library(reshape)

df = data.frame("models" = models, "MNIST"=time_MNIST, "movie_lens_100k"=time_100k, "movie_lens_1M"=time_1M)
melted = melt(df, id.vars = 'models')
colnames(melted) = c("models", "data_sets", "value")

runningTimePlot = 
  ggplot(melted, aes(x = models, y = value, label = sprintf("%4.0f", value))) +   
  geom_bar(aes(fill = data_sets), position = position_dodge(width = NULL), stat="identity", width = 0.5) + 
  geom_text(aes(x = models, y = value, group = data_sets), position = position_dodge(width = 0.5), 
            size = 8, 
            vjust = -0.1) +
  xlab("") + ylab("Time (s) in Log Scale") + 
  scale_y_log10() +
  scale_fill_discrete(name = "Workloads", labels = c("MNIST","movie_lens_100k", "movie_lens_1M")) + 
  theme_bw() + 
  theme(legend.title = element_text(size = 28),
        legend.text = element_text(size = 28), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "black", fill = "transparent"), 
        axis.text=element_text(size=30),
        axis.title=element_text(size=32),  
        legend.position=c(0.395,0.88)) 

ggsave(runningTimePlot , filename = 'times-log-scale-improved.eps', 
       device = 'eps', dpi = 1000, 
       width = 16, height = 9, 
       units = "in")

# Plot quality vs buffer size
data = loadQuality('movie-lens-100k/buffer-size/buffers.txt')
df = data.frame(ind = 1:5001, b5000 = data$ten , b2500 = data$five,  b500 = data$one)
ml = melt(df, id.vars = 'ind')

bufferSizePlot = 
  ggplot(data = ml, aes(x = ind, y = value, group = variable), size = 1.5) + 
  geom_line(aes( colour = variable), size = 1.5) + 
  xlab("Testing Increments") + ylab("Mean Squared Error")  + 
  scale_color_manual("Buffer Size", labels = c("5000", "2500", "500") , values = c("b5000"="green", "b2500"="red", "b500"="blue")) + 
  theme_bw() + 
  theme(legend.title = element_text(size = 30),
        legend.text = element_text(size = 30), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "transparent", fill = "transparent"), 
        axis.text=element_text(size=30),
        axis.title=element_text(size=32),  
        legend.position=c(0.85,0.2)) 


ggsave(bufferSizePlot , filename = 'movie-lens-100k/buffer-size/movie-lens-buffer-quality-improved.eps', 
       device = cairo_ps, 
       width = 14, height = 5, 
       units = "in")



# Plot quality vs Sampling rate
data = loadQuality('movie-lens-100k/sampling/samples.txt')
df = data.frame(ind = 1:5001 ,  s0.1 = data$one, s0.5 = data$five, s1.0 = data$ten)

ml = melt(df, id.vars = 'ind')
samplingRatePlot = 
  ggplot(data = ml, aes(x = ind, y = value, group = variable), size = 1.5) + 
  geom_line(aes( colour = variable), size = 1.5) + 
  xlab("Testing Increments") + ylab("Mean Squared Error")  + 
  scale_color_manual("Sampling Rate", labels = c("0.1", "0.5", "1.0") , values = c("s0.1"="green", "s0.5"="red", "s1.0"="blue")) + 
  theme_bw() + 
  theme(legend.title = element_text(size = 30),
        legend.text = element_text(size = 30), 
        legend.key = element_rect(colour = "transparent", fill = "transparent"), 
        legend.key.size  = unit(1.0, "cm"),
        legend.background = element_rect(colour = "transparent", fill = "transparent"), 
        axis.text=element_text(size=30),
        axis.title=element_text(size=32),  
        legend.position=c(0.85,0.2)) 
  


ggsave(samplingRatePlot , filename = 'movie-lens-100k/sampling/movie-lens-sampling-quality-improved.eps', 
       device = cairo_ps, 
       width = 14, height = 5, 
       units = "in")


# Meta graph: performance, quality model type
continuous100k = loadData('movie-lens-100k/5000/continuous-error.txt')
velox100k = loadData('movie-lens-100k/5000/velox-error.txt')

continuous1m = loadData('movie-lens-1m/50000/continuous-error.txt')
velox1m = loadData('movie-lens-1m/50000/velox-error.txt')

time_100k = c(128.7379, 506.1425, 854.3796, 187.6295)/60.0
time_1M = c(235.8159, 4608.0255, 9610.6307, 1825.9909)/60.0


df = data.frame('error'=c(mean(continuous100k), mean(velox100k), 0.7362879642607749), 
                'time' = c(506.1425/60, 854.3796/60, 187.6295/60), 
                'models'=c('Continuous', 'Velox', 'Static'))
p = ggplot(data = df, aes(x = time, y = error)) + 
  geom_point(alpha = 0) + 
  geom_text(aes(label = models, colour = models), size = 14, fontface ="bold", hjust="inward", vjust="inward", show.legend  = F, angle = 45)  + 
  xlab("Time (m)") + ylab("Mean Squared Error") + 
  ylim(c(0.5, 1.0)) + 
  theme_bw() + 
  theme(legend.text = element_text(size = 26), 
        legend.title = element_text(size = 26), 
        legend.key.size  = unit(1.0, "cm")) +
  theme(axis.text=element_text(size=40),
        axis.title=element_text(size=40)) +
  scale_colour_manual(values = c("Static" = "black", "Continuous" = "Green", "Velox" = "Red"))

ggsave(p , filename = 'movie-lens-100k/movie-lens-100k-systems.eps', 
       device = cairo_ps, dpi = 1000, 
       width = 16, height = 9, 
       units = "in")


df = data.frame('error'=c(mean(continuous1m), mean(velox1m), 0.5392938220858208), 
                'time' = c(4608.0255/60, 9610.6307/60, 1825.9909/60), 
                'models'=c('Continuous', 'Velox', 'Static'))
p = ggplot(data = df, aes(x = time, y = error)) + 
  geom_point(alpha = 0) + 
  geom_text(aes(label = models, colour = models), size = 14, fontface ="bold", hjust="inward", vjust="inward", show.legend  = F, angle = 45)  + 
  xlab("Time (m)") + ylab("") + 
  ylim(c(0.5, 1.0)) + 
  theme_bw() + 
  theme(legend.text = element_text(size = 26), 
        legend.title = element_text(size = 26), 
        legend.key.size  = unit(1.0, "cm")) +
  theme(axis.text=element_text(size=40),
        axis.title=element_text(size=40)) +
  scale_colour_manual(values = c("Static" = "black", "Continuous" = "Green", "Velox" = "Red"))

ggsave(p , filename = 'movie-lens-1m/movie-lens-1m-systems.eps', 
       device = cairo_ps, dpi = 1000, 
       width = 16, height = 9, 
       units = "in")

