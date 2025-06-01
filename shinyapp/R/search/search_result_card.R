

search_result_card <- function(result){
  
  card(
    
    card_header("Siren :", result$siren, if("siret" %in% names(result)) paste("| Siret :", result$siret)),
    
    card_body(
      fillable = FALSE,
      
      if("dénomination" %in% names(result)) div(result$denomination, br()),
      "Nom / prénom :", result$nom, result$prenom, br(),
      "Code activité :", result$activite, br(),
      "Date de création :", result$creation, "| Mise à jour :", result$mise_a_jour
      
    ))
  
}
