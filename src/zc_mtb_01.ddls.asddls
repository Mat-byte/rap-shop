@EndUserText.label: 'Shop: Projection - Inventory'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_MTB_01 provider contract transactional_interface
  as projection on ZI_MTB_01 as Products
{

  key Id,
      Prdname,
      Category,
      Valid,
      Expdate

}
