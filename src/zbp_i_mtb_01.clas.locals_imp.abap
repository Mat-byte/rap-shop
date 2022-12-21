CLASS lhc_ZI_MTB_01 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.

    TYPES ty_numc2 TYPE n LENGTH 2.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Products RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Products RESULT result.

    METHODS setValid FOR MODIFY
      IMPORTING keys FOR ACTION Products~setValid RESULT result.

    METHODS determineExpDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Products~determineExpDays.

    METHODS validateExpDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Products~validateExpDate.

    METHODS validateKeyFiels FOR VALIDATE ON SAVE
      IMPORTING keys FOR Products~validateKeyFiels.

ENDCLASS.

CLASS lhc_ZI_MTB_01 IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setValid.

    MODIFY ENTITIES OF zi_mtb_01 IN LOCAL MODE
      ENTITY Products
       UPDATE FIELDS ( Valid )
        WITH VALUE #( FOR key IN keys (
                        %tky  = key-%tky
                        Valid = abap_true )
                     )
        FAILED failed
        REPORTED reported.

  ENDMETHOD.

  METHOD determineExpDays.

    READ ENTITIES OF zi_mtb_01 IN LOCAL MODE
      ENTITY Products
       FIELDS ( ExpirationDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(Products).

    LOOP AT Products INTO DATA(product) WHERE ExpirationDays IS INITIAL.

      DATA(expDays) = CONV ty_numc2( product-ExpirationDate - cl_abap_context_info=>get_system_date( ) ).

      "Determine Expiration days
      MODIFY ENTITIES OF zi_mtb_01 IN LOCAL MODE
        ENTITY Products
         UPDATE FIELDS ( ExpirationDays )
          WITH VALUE #( ( %tky = product-%tky
                          ExpirationDays = expDays
                      ) ).

    ENDLOOP.

  ENDMETHOD.

  METHOD validateExpDate.

    READ ENTITIES OF zi_mtb_01 IN LOCAL MODE
      ENTITY Products
       FIELDS ( ExpirationDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(Products).

    "Save is aborted when Failed table is returned as fill
    LOOP AT Products INTO DATA(product).

      "Validate Expiration date
      IF product-ExpirationDate - cl_abap_context_info=>get_system_date( ) < 60.

        APPEND VALUE #( %tky = product-%tky ) TO failed-products.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateKeyFiels.

    "We don't specified any field, but, keys are provided by default
    READ ENTITIES OF zi_mtb_01 IN LOCAL MODE
      ENTITY Products
       ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(Products).

    "Save is aborted when Failed table is returned as fill
    LOOP AT Products INTO DATA(product).

      IF product-Id IS INITIAL.

        APPEND VALUE #( %tky = product-%tky ) TO failed-products.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
