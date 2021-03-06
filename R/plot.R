# ds1: dataset1
# ds2: dataset2
# both ds1 and ds2 should contain the same snps in the same order

# Pos: positions of all snps in ds1 or in ds2
# chr: Chromosome
# pos.start: lower bound of positions
# pos.end: upper bound of positions
# trait1: name of trait 1
# trait2: name of trait 2   

##' Plot results of a coloc.abf run
##'
##' If coloc.obj is missing, it will be created as coloc.obj=coloc.abf(ds1,ds2).  Both ds1 and ds2 should contain the same snps in the same order
##' @title abf.plot
##' @param coloc.obj result of a coloc.abf()
##' @param ds1 dataset1 (optional)
##' @param ds2 dataset2 (optional)
##' @param Pos positions of all snps in ds1 or in ds2
##' @param chr Chromosome
##' @param pos.start lower bound of positions
##' @param pos.end upper bound of positions
##' @param trait1 name of trait 1
##' @param trait2 name of trait 2   
##' @return a ggplot object
##' @author Hui Guo, Chris Wallace
abf.plot <- function(  coloc.obj = coloc.abf(ds1, ds2),
                     ds1, ds2, Pos=1:nrow(coloc.obj$results),
                     chr, pos.start, pos.end,
                     trait1, trait2) {

  
  d.pp1 = signif(coloc.obj$summary[3], 3)
  d.pp2 = signif(coloc.obj$summary[4], 3)
  d.pp4 = signif(coloc.obj$summary[6], 3)
  df = coloc.obj$results
  
  df$pp1 <- exp(df$lABF.df1 - logsum(df$lABF.df1))
  df$pp2 <- exp(df$lABF.df2 - logsum(df$lABF.df2))
  df$pos <- Pos

  df <- melt(df[,c("snp","pos","pp1","pp2","SNP.PP.H4")], id.vars=c("snp","pos"))
  df$variable <- sub("pp1", paste0("pp1 (", trait1, ") = ", d.pp1) ,df$variable)
  df$variable <- sub("pp2", paste0("pp2 (", trait2, ") = ", d.pp2) ,df$variable)
  df$variable <- sub("SNP.PP.H4", paste0("pp4 (Both) = ", d.pp4) ,df$variable)


  ## identify and label the top 3 SNPs that have highest pp1, pp2 or pp4
  
  df.ord = df[order(df$value, decreasing=TRUE), ]
  snps = unique(df.ord$snp)[1:3]

  df$label <- ifelse(df$snp %in% snps, df$snp,"")
  ttl <- paste0(t1, ' & ', t2, ' (chr', chr, ': ', pos.start, '-', pos.end, ')')
 
  ggplot(df, aes(x=pos,y=value)) +
    geom_point(data=subset(df,label==""),size=1.5) +
    geom_point(data=subset(df,label!=""),col="red",size=1.5) +
    geom_text(aes(label=label),hjust=-0.1,vjust=0.5,size=2.5,col="red") +
    facet_grid(variable ~ .) +
    theme(legend.position="none") + xlab(paste("Chromosome", chr, sep=' ')) + ylab("Posterior probability") + 
    ggtitle(ttl)
    
}
