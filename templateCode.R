# Day 1 Example Plot
# Import data and name columns
viremia <- read.csv("viremia_data_full.csv") 
colnames(viremia) <- c("Bird","n","Species",
                       "Family","Order","1","3","4","6")

# Choose some colors
cols <- c("black","grey",rainbow(26)[4:26])  # rainbow colors

# Expand right margin of plot to fit
par(mar=c(5,4,4,10))

# Plot by species
plot(c(1,3,4,6), as.numeric(viremia[1, 6:9]), 
     type="l", lwd=2,
     ylim=c(0,max(viremia[,6:9], na.rm=TRUE)),
     xlab="Day Postinfection", 
     ylab="Log PFU/mL Serum")
for(i in 2:nrow(viremia)){ # Add rows in loop
  lines(c(1,3,4,6), 
        as.numeric(viremia[i, 6:9]), 
        lwd=2, col=cols[i])
}
# Legend
legend("right", inset=c(-0.38,0),  legend=viremia$Bird, 
       col=cols,
       lty=1, lwd=2, cex=0.6,xpd=TRUE)  




# Totally extra, probably don't really have time for:
# Compile by Order 
n <- length(unique(viremia$Order))  # n = number of orders
# Create data frame by order
df <- data.frame("Order" = unique(viremia$Order), 
                 "Viremia1" = rep(0,n), # Empty data day 1
                 "Viremia3" = rep(0,n), # Empty data day 3
                 "Viremia4" = rep(0,n), # Empty data day 4
                 "Viremia6" = rep(0,n)) # Empty data day 6
row.names(df) <- df$Order # Set row names

# Fill in data frame by order = ord
for (ord in df$Order){  
  df[ord,"Viremia1"] <- mean(viremia[viremia$Order==ord,6])
  df[ord,"Viremia3"] <- mean(viremia[viremia$Order==ord,7])
  df[ord,"Viremia4"] <- mean(viremia[viremia$Order==ord,8])
  df[ord,"Viremia6"] <- mean(viremia[viremia$Order==ord,9])
}

# Choose some colors
cols <- c("black","grey",rainbow(11)[4:11])  # rainbow colors

# Expand right margin of plot to fit
par(mar=c(5,4,4,10))

# Plot by order
days <- c(1,3,4,6)
plot(days, as.numeric(df[1, 2:5]), type="l", lwd=2,
     ylim = range(df[, 2:5], na.rm = TRUE),
     xlab="Day Postinfection", ylab="Log PFU/mL Serum")
for(i in 2:nrow(df)){
  lines(days, as.numeric(df[i, 2:5]), lwd=2, col=i)
}
legend("right", inset=c(-0.38,0), 
       legend=df$Order, col=cols, lty=1, 
       lwd=2, cex=0.8,xpd = TRUE)

