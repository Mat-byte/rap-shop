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
      expdate  as Expdate,
      @Semantics.user.createdBy: true
      created_by as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt
}
