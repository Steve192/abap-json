class ltcl_test definition final
  for testing
  risk level harmless
  duration short.

  private section.

    methods unicode for testing.
    METHODS replace_crlf_linebreak FOR TESTING RAISING cx_static_check.

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
  
  method replace_crlf_linebreak.
     types:
      begin of ty_one_string,
        str type string,
      end of ty_one_string.

    data ls_input type ty_one_string.
    data lo_cut type ref to zcl_pmc_json.
    create object lo_cut.

    ls_input-str = 'Line1' && cl_abap_char_utilities=>cr_lf && 'Line2'.

    lo_cut->encode(
      EXPORTING
        value = ls_input
      RECEIVING
        json  = data(lv_json_result)
    ).


    cl_abap_unit_assert=>assert_equals(
      act = lv_json_result
      exp = '{"str": "Line1\r\nLine2"}' ).

  endmethod.

endclass.
