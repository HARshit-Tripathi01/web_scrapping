library(rvest)
library(dplyr)


movie=data.frame()

for(page_result in seq(from=1,to=51,by =50)){
  link=paste0("https://www.imdb.com/search/title/?title_type=feature&sort=num_votes,desc&start=",
                         page_result,"&ref_=adv_nxt")


page=read_html(link)

name=page%>%html_nodes(".lister-item-header a")%>%
              html_text()

movies_links=page%>%html_nodes(".lister-item-header a")%>%
  html_attr("href")%>%paste("https//www.imdb.com" , .,sep="")

year=page%>%html_nodes("  .text-muted.unbold")%>%
             html_text()



vote=page%>%
  html_nodes(".sort-num_votes-visible span:nth-child(2)")%>%
              html_text()

gross=page%>%
  html_nodes(" .ghost~ .text-muted+ span")%>%
            html_text()

rating=page%>%
  html_nodes(" .ratings-imdb-rating strong")%>%
          html_text()

synopsis=page%>%
  html_nodes(" .ratings-bar+ .text-muted")%>%
      html_text()


Director_Star=page%>%
  html_nodes(" .text-muted+ p")%>%
   html_text()




Gener=page%>%
  html_nodes("  .genre")%>%
  html_text()
Certification=page%>%
  html_nodes("  .certificate")%>%
  html_text()

movie=rbind(movie,data.frame(name,year,Gener,Certification,rating,vote,gross,synopsis,Director_Star,stringsAsFactors = FALSE))

print(paste("Page:",page_result))

}
write.csv(movie,"Movies.csv")


