@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Shop: Root entity - Inventory'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_MTB_01
  as select from zmbtt_01
{
  key id       as Id,
      prdname  as Prdname,
      category as Category,
      valid    as Valid,
      expdate  as Expdate
}
