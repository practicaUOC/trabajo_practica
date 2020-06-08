
#new.veg dataframe

DAW2 <- veg[grep("^DAW2",rownames(veg)),]
DAW2 <- DAW2 %>% summarise_if(is.numeric, mean)

DUW1 <- veg[grep("^DUW1",rownames(veg)),]
DUW1 <- DUW1 %>% summarise_if(is.numeric, mean)

KAW2 <- veg[grep("^KAW2",rownames(veg)),]
KAW2 <- KAW2 %>% summarise_if(is.numeric, mean)

KOW2 <- veg[grep("^KOW2",rownames(veg)),]
KOW2 <- KOW2 %>% summarise_if(is.numeric, mean)

KWW2 <- veg[grep("^KWW2",rownames(veg)),]
KWW2 <- KWW2 %>% summarise_if(is.numeric, mean)

MAW1 <- veg[grep("^MAW1",rownames(veg)),]
MAW1 <- MAW1 %>% summarise_if(is.numeric, mean)

MAW2 <- veg[grep("^MAW2",rownames(veg)),]
MAW2 <- MAW2 %>% summarise_if(is.numeric, mean)

MAW3 <- veg[grep("^MAW3",rownames(veg)),]
MAW3 <- MAW3 %>% summarise_if(is.numeric, mean)

NAW1 <- veg[grep("^NAW1",rownames(veg)),]
NAW1 <- NAW1 %>% summarise_if(is.numeric, mean)

NAW2 <- veg[grep("^NAW2",rownames(veg)),]
NAW2 <- NAW2 %>% summarise_if(is.numeric, mean)

TJW1 <- veg[grep("^TJW1",rownames(veg)),]
TJW1 <- TJW1 %>% summarise_if(is.numeric, mean)

TSK1 <- veg[grep("^TSK1",rownames(veg)),]
TSK1 <- TSK1 %>% summarise_if(is.numeric, mean)

TSW1 <- veg[grep("^TSW1",rownames(veg)),]
TSW1 <- TSW1 %>% summarise_if(is.numeric, mean)

TSW2 <- veg[grep("^TSW2",rownames(veg)),]
TSW2 <- TSW2 %>% summarise_if(is.numeric, mean)


veg.means <- rbind(DAW2, DUW1, KAW2, KOW2, KWW2, MAW1, MAW2, MAW3, MAW1, MAW2, TJW1, TSK1, TSW1, TSW2)