\name{ps2ps}
\alias{ps2ps}
\title{Find orthologous/homologous probe sets across two different Affymetrix microarray formats using a table of orthologs}
\description{
Takes two Affymetrix annotation files, a table of orthologs (either 'gene_orthologs' or the HomoloGene database), a target species ID and returns a mapping table with homologous/orthologous probe sets.
}
\usage{
ps2ps(annotation_1,annotation_2,ortholog,target_species,probesets=NULL,tableType="homologene")
}
\arguments{
  \item{annotation_1}{A data.frame with Affymetrix annotation for the source microarray format.}
  \item{annotation_2}{A data.frame with Affymetrix annotation for the target microarray format.}
  \item{ortholog}{A data.frame with the HomoloGene or 'gene_orthologs' database.}
  \item{target_species}{The target species identifier (i.e. the species corresponding to the target microarray).}
  \item{probesets}{A vector of probe set identifiers. If not specified, all probe sets on the source microarray format are mapped (default).}
  \item{tableType}{Character string (either 'homologene' or 'gene_orthologs') specifying the type of ortholog table used ('homologene' is the default).}
}
\details{
A table of orthologous/homologous probe sets is built by looking up gene IDs (corresponding to the probe sets on the source microarray array) in HomoloGene or 'gene_orthologs' to find their orthologs, and identifying probe sets in the target microarray that probe the orthologous gene transcripts.

Affymetrix annotation files can be obtained from Affymetrix (http://www.affymetrix.com).
A flat file database version can be obtained from HomoloGene (http://www.ncbi.nlm.nih.gov/HomoloGene) or from NCBI's 'Orthologs from Annotation pipeline' database, referred to as 'gene_orthologs' (ftp.ncbi.nlm.nih.gov/gene/DATA/gene_orthologs.gz).
Target species ID are defined by the NCBI Taxonomy database (http://www.ncbi.nlm.nih.gov/Taxonomy)
}
\value{
  \item{mappingTable}{A data.frame with four columns and as many rows as there are probe sets in the source annotation. Eache row corresponds to a probe set in the source annotation (column1), the corresponding gene IDs (column 2), the orthologous gene IDs in the target species (column 3), and the probe sets in the target annotation correspondin to the orthologous gene IDs (column 4).}
}
\references{Kuhn et al. Cross-species and cross-platform gene expression studies with the Bioconductor-compliant R package 'annotationTools'. BMC Bioinformatics, 9:26 (2008)}
\author{Alexandre Kuhn}
\examples{
\dontrun{
##load Affymetrix annotations
annotMouse<-read.csv('Mouse430_2_annot.csv',colClasses='character',comment.char='#')
annotHuman<-read.csv('HG-U133A_annot.csv',colClasses='character',comment.char='#')

##load HomoloGene database
homologene<-read.delim('homologene.data',header=FALSE)

##define target species ID 
homoSapiens_ID<-9609

##map all probe sets on mouse array Mouse 430 2.0 to their orthologs on human array HG-U133A
mappingTable<-ps2ps(annotMouse,annotHuman,homologene,homoSapiens_ID)

##write mapping table to disk
write.table(mappingTable,file='Mouse4302_HGU133A.txt',sep='\t',col.names=T,row.names=F,quote=FALSE)

##to map the first 10 probe sets given in the annotation only
mappingTable<-ps2ps(annotMouse,annotHuman,homologene,targetSpecies,probesets=annotMouse[1:10,1])
}
}
\keyword{manip}
