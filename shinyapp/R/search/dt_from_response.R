

dt_from_response <- function(x){
  
  # -- build df to display
  if("uniteLegale" %in% names(x))
    
    data.frame(
      "siren" = x$uniteLegale$siren,
      "denomination" = x$uniteLegale$periodesUniteLegale[x$uniteLegale$nombrePeriodesUniteLegale, "denominationUniteLegale"],
      "nom" = x$uniteLegale$periodesUniteLegale[x$uniteLegale$nombrePeriodesUniteLegale, "nomUniteLegale"],
      "prenom" = x$uniteLegale$prenom1UniteLegale,
      "creation" = x$uniteLegale$dateCreationUniteLegale,
      "mise_a_jour" = x$uniteLegale$dateDernierTraitementUniteLegale,
      "activite" = x$uniteLegale$periodesUniteLegale[x$uniteLegale$nombrePeriodesUniteLegale, "activitePrincipaleUniteLegale"])
  
  else if("unitesLegales" %in% names(x))
    
    data.frame(
      "siren" = x$unitesLegales$siren,
      "denomination" = unlist(lapply(x$unitesLegales$periodesUniteLegale, function(x) x$denominationUniteLegale)),
      "nom" = unlist(lapply(x$unitesLegales$periodesUniteLegale, function(x) x$nomUniteLegale)),
      "prenom" = x$unitesLegales$prenom1UniteLegale,
      "creation" = x$unitesLegales$dateCreationUniteLegale,
      "mise_a_jour" = x$unitesLegales$dateDernierTraitementUniteLegale,
      "activite" = unlist(lapply(x$unitesLegales$periodesUniteLegale, function(x) x$activitePrincipaleUniteLegale)))
  
  
  else if("etablissement" %in% names(x))
    
    data.frame(
      "siren" = x$etablissement$siren,
      "siret" = x$etablissement$siret,
      "nom" = x$etablissement$uniteLegale$nomUniteLegale,
      "prenom" = x$etablissement$uniteLegale$prenom1UniteLegale,
      "creation" = x$etablissement$dateCreationEtablissement,
      "mise_a_jour" = x$etablissement$dateDernierTraitementEtablissement,
      "activite" = x$etablissement$uniteLegale$activitePrincipaleUniteLegale)
  
}
