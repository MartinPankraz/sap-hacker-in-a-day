*&---------------------------------------------------------------------*
*& Report ZBD_UPLOADUSERS
*&---------------------------------------------------------------------*
REPORT ZBD_UPLOADUSERS.

type-pools: truxs.

DATA: lt_csv_data TYPE TABLE OF string,
      lv_user_id TYPE bapibname,
      lv_email TYPE bapiaddr3-e_mail,
      lv_password TYPE bapipwd VALUE 'SomeInitialPass',
      lv_ref_user type bapirefus VALUE 'DEVELOPER',
      ls_logon_data TYPE bapilogond,
      ls_user_address TYPE bapiaddr3,
      lt_return TYPE TABLE OF bapiret2,
      ls_return TYPE bapiret2,
      lv_success_count1 TYPE i VALUE 0,
      lv_error_count1 TYPE i VALUE 0,
      lv_success_count2 TYPE i VALUE 0,
      lv_error_count2 TYPE i VALUE 0,
      lt_profiles type table of bapiprof,
      lv_profile type bapiprof.

" Set initial value for the file parameter
PARAMETERS: p_file TYPE string DEFAULT 'C:\localsource\uploadusers\users.csv',
            p_head type char01 DEFAULT 'X',
            p_user type string DEFAULT 'DEVELOPER'.


* At selection screen
* AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
*  CALL FUNCTION 'F4_FILENAME'
*    EXPORTING
*      field_name = 'P_FILE'
*    IMPORTING
*      file_name  = p_file.


START-OF-SELECTION.
" Assign the parameter values
lv_ref_user  = p_user.

"prepare profiles to be attached to the user
lv_profile = 'SAP_ALL'.
append lv_profile to lt_profiles.
lv_profile = 'SAP_NEW'.
append lv_profile to lt_profiles.

" Upload the file content into internal table
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                = p_file
    filetype                = 'ASC' " ASCII for text files
  TABLES
    data_tab                = lt_csv_data
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    invalid_type            = 5
    no_authority            = 6
    unknown_error           = 7
    bad_data_format         = 8
    header_not_allowed      = 9
    separator_not_allowed   = 10
    header_too_long         = 11
    unknown_dp_error        = 12
    access_denied           = 13
    dp_out_of_memory        = 14
    disk_full               = 15
    dp_timeout              = 16
    OTHERS                  = 17.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  EXIT.
ENDIF.

END-of-selection.


" Parse Excel data and create users
LOOP AT lt_csv_data INTO DATA(lv_csv_line).
  " Assuming first column is USER_ID and second column is EMAIL
  SPLIT lv_csv_line AT ';' INTO lv_user_id lv_email.

  " Prepare the user data
  CLEAR: ls_logon_data, ls_user_address.
  ls_logon_data-ustyp = 'A'.
  ls_user_address-e_mail = lv_email.

  " Create user
  CALL FUNCTION 'BAPI_USER_CREATE1'
    EXPORTING
      username     = lv_user_id
      password     = lv_password
      logondata    = ls_logon_data
      address      = ls_user_address
      ref_user     = lv_ref_user
    TABLES
      return       = lt_return.

  " Check for errors in user creation
  LOOP AT lt_return INTO ls_return WHERE type = 'E' OR type = 'A'.
    WRITE: / 'Error creating user:', lv_user_id, ls_return-message.
    lv_error_count1 = lv_error_count1 + 1.
  ENDLOOP.

  LOOP AT lt_return INTO ls_return WHERE type = 'S'.
    WRITE: / 'Successfully created:', lv_user_id.
    lv_success_count1 = lv_success_count1 + 1.
  ENDLOOP.

  " Commit the creation
  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
    EXPORTING
      wait = 'X'.

  " Add SAP_ALL & SAP_NEW profile
  CALL FUNCTION 'BAPI_USER_PROFILES_ASSIGN'
    EXPORTING
      username = lv_user_id
    TABLES
      profiles = lt_profiles
      return   = lt_return.
ENDLOOP.