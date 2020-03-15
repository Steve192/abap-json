class ltcl_test definition final
  for testing
  risk level harmless
  duration short.

  private section.

    methods unicode for testing.

endclass.

class zcl_json definition local friends ltcl_test.

class ltcl_test implementation.

  method unicode.

    types:
      begin of ty_one_string,
        str type string,
      end of ty_one_string.

    data ls_act type ty_one_string.
    data ls_exp type ty_one_string.
    data lo_cut type ref to zcl_json.
    create object lo_cut.

    lo_cut->decode(
      exporting
        json = '{ "str": "\u0410" }'
      changing
        value = ls_act ).

    ls_exp-str = 'А'. " Cyrillic A
    cl_abap_unit_assert=>assert_equals(
      act = ls_act
      exp = ls_exp ).

  endmethod.

endclass.
