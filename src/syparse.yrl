%% -*- erlang -*-
Header "%% Copyright (C) Walter Weinmann"
"%% @private"
"%% @Author Walter Weinmann".

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nonterminals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 anonymous_opt
 array_type_name
 as_identifier
 as_identifier_opt
 block
 boolean_literal
 break
 continue
 contract_definition
 contract_part
 contract_part_list
 contract_part_list_opt
 elementary_type_name
 enum_definition
 enum_value
 enum_value_commalist
 enum_value_commalist_opt
 event_definition
 expression
 expression_commalist
 expression_commalist_opt
 expression_statement
 for_statement
 function_call
 function_definition
 function_definition_visibility
 function_definition_visibility_list
 function_definition_visibility_list_opt
 identifier
 if_statement
 import_directive
 import_directive_semicolonlist
 import_directive_semicolonlist_opt
 import_identifier
 import_identifier_commalist
 index_access
 indexed_type_parameter
 indexed_type_parameter_commalist
 indexed_type_parameter_list
 inheritance_specifier
 inheritance_specifier_commalist
 inheritance_specifier_commalist_opt
 initial_value_opt
 mapping
 member_access
 modifier_definition
 new_expression
 number_literal
 number_unit
 number_unit_opt
 parameter_list
 parameter_list_opt
 place_holder_statement
 primary_expression
 return
 returns_opt
 simple_statement
 source_unit
 state_variable_declaration
 state_variable_declaration_visibility
 state_variable_declaration_visibility_opt
 statement
 statement_list
 statement_list_opt
 string_literal
 struct_definition
 throw
 type_name
 type_name_commalist
 type_parameter_list
 using_for_declaration
 variable_declaration
 variable_declaration_commalist
 variable_declaration_commalist_opt
 variable_declaration_semicolonlist
 variable_declaration_semicolonlist_opt
 variable_definition
 while_statement
 .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Terminals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 ADDRESS
 AFTER
 ANONYMOUS
 AS
 BOOL
 BREAK
 BYTE
 CONSTANT
 CONTINUE
 CONTRACT
 DAYS
 DELETE
 ELSE
 ENUM
 ETHER
 EVENT
 EXTERNAL
 FALSE
 FINNEY
 FIXED
 FOR
 FROM
 FUNCTION
 HOURS
 IDENTIFIER
 IF
 IMPORT
 INDEXED
 INT
 INTERNAL
 IS
 LIBRARY
 MAPPING
 MEMORY
 MINUTES
 MODIFIER
 NEW
 NUMBER_LITERAL
 PRIVATE
 PUBLIC
 RETURN
 RETURNS
 SECONDS
 STORAGE
 STRING
 STRING_LITERAL
 STRUCT
 SZABO
 THROW
 TRUE
 UFIXED
 UINT
 USING
 VAR
 WEEKS
 WEI
 WHILE
 YEARS
 ','
 '{'
 '}'
 '('
 ')'
 '_'
 ';'
 '=>'
 '['
 ']'
 '.'
 '='
 '|='
 '^='
 '&='
 '<<='
 '>>='
 '+='
 '-='
 '*='
 '/='
 '%='
 '!'
 '~'
 '++'
 '--'
 '**'
 '*'
 '/'
 '%'
 '|'
 '^'
 '&'
 '<<'
 '>>'
 '>>>'
 '+'
 '-'
 '<='
 '>='
 '<'
 '>'
 '=='
 '!='
 '&&'
 '||'
 '?'
 ':'
.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rootsymbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 source_unit.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Endsymbol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 '$end'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Operator precedences.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nonassoc    100 '++' '--'.                              %% increment and decrement.
Nonassoc    110 '(' ')'.                                %% function-like call.
Nonassoc    120 '[' ']'.                                %% array subscripting.
Nonassoc    130 '.'.                                    %% member access.
%Unary      150 '+' '-'.                                %% unary plus and minus.
Nonassoc    160 '!'.                                    %% logical NOT.
Nonassoc    170 '~'.                                    %% bitwise NOT.
Left        200 '**'.                                   %% exponentation.
Left        210 '*' '/' '%'.                            %% multiplication, division and modulo. 
Left        220 '+' '-'.                                %% addition and subtraction. 
Left        300 '<<' '>>' '>>>'.                        %% bitwise shift operators.
Left        310 '&'.                                    %% bitwise AND.
Left        320 '^'.                                    %% bitwise XOR.
Left        330 '|'.                                    %% bitwise OR.
Nonassoc    400 '<' '>' '<=' '>='.                      %% inequality operators.
Nonassoc    410 '==' '!='.                              %% equality operators.
Left        500 '&&'.                                   %% logical AND.
Left        510 '||'.                                   %% logical OR.
Left        600 '?' ':'.                                %% tenary operator. 
Nonassoc    700 '=' '|=' '^=' '&=' '<<=' '>>='  '+=' '-=' '*=' '/=' '%='.     
                                                        %% assignment operators.
Nonassoc    800 ','.                                    %% comma operator.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Grammar rules.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

source_unit -> import_directive_semicolonlist_opt contract_definition                           : {sourceUnit, '$1', '$2'}.
 
source_unit -> elementary_type_name                                                             : '$1'.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
import_directive_semicolonlist_opt -> '$empty'                                                  : [].
import_directive_semicolonlist_opt -> import_directive_semicolonlist                            : '$1'.

import_directive_semicolonlist -> import_directive                                              : ['$1'].
import_directive_semicolonlist -> import_directive ';' import_directive_semicolonlist           : ['$1' | '$3'].
%% =====================================================================================================================

contract_definition -> CONTRACT identifier inheritance_specifier_commalist_opt '{' contract_part_list_opt '}'
                                                                                                : {contractDefinition, '$1', '$2', '$3', '$5'}.
contract_definition -> LIBRARY  identifier inheritance_specifier_commalist_opt '{' contract_part_list_opt '}'
                                                                                                : {contractDefinition, '$1', '$2', '$3', '$5'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
inheritance_specifier_commalist_opt -> '$empty'                                                 : [].
inheritance_specifier_commalist_opt -> IS inheritance_specifier_commalist                       : '$1'.

inheritance_specifier_commalist -> inheritance_specifier                                        : ['$1'].
inheritance_specifier_commalist -> inheritance_specifier ',' inheritance_specifier_commalist    : ['$1' | '$3'].

contract_part_list_opt -> '$empty'                                                              : [].
contract_part_list_opt -> contract_part_list                                                    : '$1'.

contract_part_list -> contract_part_list contract_part                                          : '$1' ++ ['$2'].
contract_part_list -> contract_part                                                             : ['$1'].
%% =====================================================================================================================

import_directive -> IMPORT STRING_LITERAL as_identifier_opt                                     : {importDirective, '$2'}.
import_directive -> IMPORT '*' as_identifier_opt FROM STRING_LITERAL                            : {importDirective, '$2', unwrap('$4'), "*"}.
import_directive -> IMPORT identifier as_identifier_opt FROM STRING_LITERAL                     : {importDirective, '$1', '$2', unwrap('$4')}.
import_directive -> IMPORT '(' import_identifier_commalist ')' FROM STRING_LITERAL              : {importDirective, '$2', unwrap('$4'), "("}.
 
%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
as_identifier_opt -> '$empty'                                                                   : [].
as_identifier_opt -> as_identifier                                                              : '$1'.

as_identifier -> AS identifier                                                                  : '$1'.

import_identifier_commalist -> import_identifier                                                : ['$1'].
import_identifier_commalist -> import_identifier ',' import_identifier_commalist                : ['$1' | '$3'].

import_identifier -> identifier as_identifier_opt                                               : {'$1', '$2'}.
%% =====================================================================================================================

contract_part -> state_variable_declaration                                                     : {contractPart, '$1'}.
contract_part -> using_for_declaration                                                          : {contractPart, '$1'}.
contract_part -> struct_definition                                                              : {contractPart, '$1'}.
contract_part -> modifier_definition                                                            : {contractPart, '$1'}.
contract_part -> function_definition                                                            : {contractPart, '$1'}.
contract_part -> event_definition                                                               : {contractPart, '$1'}.
contract_part -> enum_definition                                                                : {contractPart, '$1'}.

inheritance_specifier -> identifier '(' expression_commalist ')'                                : {inheritanceSpecifier, '$1', '$3'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
expression_commalist -> expression                                                              : ['$1'].
expression_commalist -> expression ',' expression_commalist                                     : ['$1' | '$3'].
%% =====================================================================================================================

state_variable_declaration -> type_name state_variable_declaration_visibility_opt identifier ';'
                                                                                                : {stateVariableDeclaration, '$1', '$2', '$3'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
state_variable_declaration_visibility_opt -> '$empty'                                           : [].
state_variable_declaration_visibility_opt -> state_variable_declaration_visibility              : '$1'.

state_variable_declaration_visibility -> PUBLIC                                                 : "public".
state_variable_declaration_visibility -> INTERNAL                                               : "internal".
state_variable_declaration_visibility -> PRIVATE                                                : "private".
%% =====================================================================================================================

using_for_declaration -> USING identifier FOR '*'       ';'                                     : {usingDeclaratioon, '$2', "*"}.
using_for_declaration -> USING identifier FOR type_name ';'                                     : {usingDeclaratioon, '$2', '$4'}.

struct_definition -> STRUCT identifier '{' variable_declaration_semicolonlist_opt '}'           : {structDefinition, '$2', '$4'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
variable_declaration_semicolonlist_opt -> '$empty'                                              : [].
variable_declaration_semicolonlist_opt -> variable_declaration_semicolonlist                    : '$1'.

variable_declaration_semicolonlist -> variable_declaration                                      : ['$1'].
variable_declaration_semicolonlist -> variable_declaration ',' variable_declaration_semicolonlist
                                                                                                : ['$1' | '$3'].
%% =====================================================================================================================

modifier_definition -> MODIFIER identifier parameter_list_opt block                             : {modifierDefinition, '$2', '$3', '$4'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
parameter_list_opt -> '$empty'                                                                  : [].
parameter_list_opt -> parameter_list                                                            : '$1'.
%% =====================================================================================================================

function_definition -> FUNCTION identifier parameter_list function_definition_visibility_list_opt returns_opt block
                                                                                                : {functionDefinition, '$2', '$3', '$4', '$5', '$6'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
function_definition_visibility_list_opt -> '$empty'                                             : [].
function_definition_visibility_list_opt -> function_definition_visibility_list                  : '$1'.

function_definition_visibility_list -> function_definition_visibility_list function_definition_visibility
                                                                                                : '$1' ++ ['$2'].
function_definition_visibility_list -> function_definition_visibility                           : ['$1'].

function_definition_visibility -> function_call                                                 : '$1'.
function_definition_visibility -> identifier                                                    : '$1'.
function_definition_visibility -> CONSTANT                                                      : "constant".
function_definition_visibility -> EXTERNAL                                                      : "external".
function_definition_visibility -> PUBLIC                                                        : "public".
function_definition_visibility -> INTERNAL                                                      : "internal".
function_definition_visibility -> PRIVATE                                                       : "private".

returns_opt -> '$empty'                                                                         : [].
returns_opt -> RETURNS parameter_list                                                           : '$1'.
returns_opt -> RETURNS type_parameter_list                                                      : '$1'.
%% ---------------------------------------------------------------------------------------------------------------------

event_definition -> EVENT identifier parameter_list anonymous_opt ';'                           : {eventDefinition, '$2', '$3', '$4'}.
event_definition -> EVENT identifier type_parameter_list anonymous_opt ';'                      : {eventDefinition, '$2', '$3', '$4'}.
event_definition -> EVENT identifier indexed_type_parameter_list anonymous_opt ';'              : {eventDefinition, '$2', '$3', '$4'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
anonymous_opt -> '$empty'                                                                       : [].
anonymous_opt -> ANONYMOUS                                                                      : "anonymous".
%% ---------------------------------------------------------------------------------------------------------------------

enum_value -> identifier                                                                        : {enumValue, '$1'}.

enum_definition -> ENUM identifier '{' enum_value_commalist_opt '}'                             : {enumDefinition, '$2', '$4'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
enum_value_commalist_opt -> '$empty'                                                            : [].
enum_value_commalist_opt -> enum_value_commalist                                                : '$1'.

enum_value_commalist -> enum_value                                                              : ['$1'].
enum_value_commalist -> enum_value ',' enum_value_commalist                                     : ['$1' | '$3'].
%% ---------------------------------------------------------------------------------------------------------------------

indexed_type_parameter_list -> '(' indexed_type_parameter_commalist ')'                         : {indexedTypeParameterList, '$2'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
indexed_type_parameter_commalist -> indexed_type_parameter                                      : ['$1'].
indexed_type_parameter_commalist -> indexed_type_parameter ',' indexed_type_parameter_commalist : ['$1' | '$3'].

indexed_type_parameter -> type_name                                                             : {'$1', [], []}.

%% =====================================================================================================================
%% Helper definitions - reduce/reduce problem.
%% ---------------------------------------------------------------------------------------------------------------------
% wwe indexed_type_parameter -> type_name identifier                                                  : {'$1', [], '$2'}.
%% ---------------------------------------------------------------------------------------------------------------------

indexed_type_parameter -> type_name INDEXED                                                     : {'$1', "indexed", []}.
indexed_type_parameter -> type_name INDEXED identifier                                          : {'$1', "indexed", '$3'}.
%% ---------------------------------------------------------------------------------------------------------------------

type_parameter_list -> '('                     ')'                                              : {typeParameterList, []}.
type_parameter_list -> '(' type_name_commalist ')'                                              : {typeParameterList, '$2'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
% reduce/reduce problem.
% wwe type_name_commalist -> type_name                                                                : ['$1'].
type_name_commalist -> type_name ',' type_name_commalist                                        : ['$1' | '$3'].
%% ---------------------------------------------------------------------------------------------------------------------

parameter_list -> '(' variable_declaration_commalist_opt ')'                                          : {typeParameterList, '$2'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
variable_declaration_commalist_opt -> '$empty'                                                  : [].
variable_declaration_commalist_opt -> variable_declaration_commalist                            : '$1'.

variable_declaration_commalist -> variable_declaration                                          : ['$1'].
variable_declaration_commalist -> variable_declaration ',' variable_declaration_commalist       : ['$1' | '$3'].
%% ---------------------------------------------------------------------------------------------------------------------

variable_declaration -> type_name identifier                                                    : {variableDeclaration, '$1', '$2'}.

type_name -> elementary_type_name                                                               : {typeName, '$1'}.
type_name -> identifier                                                                         : {typeName, '$1', []}.
type_name -> identifier MEMORY                                                                  : {typeName, '$1', "memory"}.
type_name -> identifier STORAGE                                                                 : {typeName, '$1', "storage"}.
type_name -> mapping                                                                            : {typeName, '$1'}.
type_name -> array_type_name                                                                    : {typeName, '$1'}.

mapping -> MAPPING '(' elementary_type_name '=>' type_name ')'                                  : {mapping, '$3', '$5'}.

array_type_name -> type_name         '['            ']'                                         : {arrayTypeName, '$1', [],         []}.
array_type_name -> type_name         '[' expression ']'                                         : {arrayTypeName, '$1', [],         '$3'}.
array_type_name -> type_name MEMORY  '['            ']'                                         : {arrayTypeName, '$1', "memory",   []}.
array_type_name -> type_name STORAGE '['            ']'                                         : {arrayTypeName, '$1', "storagfe", []}.
array_type_name -> type_name MEMORY  '[' expression ']'                                         : {arrayTypeName, '$1', "memory",   '$4'}.
array_type_name -> type_name STORAGE '[' expression ']'                                         : {arrayTypeName, '$1', "storagfe", '$4'}.

block -> '{' statement_list_opt '}'                                                             : {block, '$2'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
statement_list_opt -> '$empty'                                                                  : {}.
statement_list_opt -> statement_list                                                            : '$1'.

statement_list -> statement_list statement                                                      : '$1' ++ ['$2'].
statement_list -> statement                                                                     : ['$1'].
%% =====================================================================================================================

statement -> if_statement                                                                       : {statement, '$1'}.
statement -> while_statement                                                                    : {statement, '$1'}.
statement -> for_statement                                                                      : {statement, '$1'}.
statement -> block                                                                              : {statement, '$1'}.
statement -> place_holder_statement                                                             : {statement, '$1'}.
statement -> continue                                                                           : {statement, '$1'}.
statement -> break                                                                              : {statement, '$1'}.
statement -> return                                                                             : {statement, '$1'}.
statement -> throw                                                                              : {statement, '$1'}.
statement -> simple_statement                                                                   : {statement, '$1'}.
statement -> expression_statement ';'                                                           : {statement, '$1'}.

expression_statement -> expression                                                              : {expressionStatement, '$1'}.

%% =====================================================================================================================
%% Helper definitions - reduce/reduce problem.
%% ---------------------------------------------------------------------------------------------------------------------
% wwe expression_statement -> variable_definition                                                     : {expressionStatement, '$1'}.
%% =====================================================================================================================

if_statement -> IF '(' expression ')' statement                                                 : {ifStatement, '$3', '$5', []}.
if_statement -> IF '(' expression ')' statement ELSE statement                                  : {ifStatement, '$3', '$5', '$6'}.

while_statement -> WHILE '(' expression ')' statement                                           : {whileStatement, '$3', '$5'}.

place_holder_statement -> '_'                                                                   : {placeHolderStatement, "_"}.

simple_statement -> variable_definition                                                         : {simpleStatement, '$1'}.
simple_statement -> expression_statement                                                        : {simpleStatement, '$1'}.

for_statement -> FOR '('                  ';'            ';'                      ')' statement : {forStatement, [],   [],   [],   '$6'}.
for_statement -> FOR '('                  ';'            ';' expression_statement ')' statement : {forStatement, [],   [],   '$5', '$7'}.
for_statement -> FOR '(' simple_statement ';'            ';'                      ')' statement : {forStatement, '$3', [],   [],   '$7'}.
for_statement -> FOR '(' simple_statement ';'            ';' expression_statement ')' statement : {forStatement, '$3', [],   '$6', '$8'}.
for_statement -> FOR '('                  ';' expression ';'                      ')' statement : {forStatement, [],   '$4', [],   '$7'}.
for_statement -> FOR '('                  ';' expression ';' expression_statement ')' statement : {forStatement, [],   '$4', '$6', '$8'}.
for_statement -> FOR '(' simple_statement ';' expression ';'                      ')' statement : {forStatement, '$3', '$5', [],   '$8'}.
for_statement -> FOR '(' simple_statement ';' expression ';' expression_statement ')' statement : {forStatement, '$3', '$5', '$7', '$9'}.

continue -> CONTINUE ';'                                                                        : {continue, "continue"}.

break -> BREAK ';'                                                                              : {break, "break"}.

return -> RETURN            ';'                                                                 : {return, []}.
return -> RETURN expression ';'                                                                 : {return, '$2'}.

throw -> THROW ';'                                                                              : {throw, "throw"}.

variable_definition -> variable_declaration initial_value_opt ';'                               : {variableDefinition, '$1', '$2'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
initial_value_opt -> '$empty'                                                                   : [].
initial_value_opt -> '=' expression                                                             : '$2'.
%% ---------------------------------------------------------------------------------------------------------------------

expression -> '++'                                                                              : {expression, "++"}.
expression -> '--'                                                                              : {expression, "--"}.
expression -> function_call                                                                     : {expression, '$1'}.
expression -> index_access                                                                      : {expression, '$1'}.
expression -> member_access                                                                     : {expression, '$1'}.
expression -> '(' expression ')'                                                                : {expression, "(", '$2'}.

expression -> '!' expression                                                                    : {expression, "!", '$2'}.
expression -> '~' expression                                                                    : {expression, "~", '$2'}.
expression -> AFTER expression                                                                  : {expression, "after", '$2'}.
expression -> DELETE expression                                                                 : {expression, "delete", '$2'}.
expression -> '++' expression                                                                   : {expression, "++", '$2'}.
expression -> '--' expression                                                                   : {expression, "--", '$2'}.
expression -> '+' expression                                                                    : {expression, "+", '$2'}.
expression -> '-' expression                                                                    : {expression, "-", '$2'}.

expression -> expression '**' expression                                                        : {expression, '$1', "**", '$3'}.

expression -> expression '*' expression                                                         : {expression, '$1', "*", '$3'}.
expression -> expression '/' expression                                                         : {expression, '$1', "/", '$3'}.
expression -> expression '%' expression                                                         : {expression, '$1', "%", '$3'}.

expression -> expression '+' expression                                                         : {expression, '$1', "+", '$3'}.
expression -> expression '-' expression                                                         : {expression, '$1', "-", '$3'}.

expression -> expression '<<' expression                                                        : {expression, '$1', "<<", '$3'}.
expression -> expression '>>' expression                                                        : {expression, '$1', ">>", '$3'}.
expression -> expression '>>>' expression                                                       : {expression, '$1', ">>>", '$3'}.

expression -> expression '&' expression                                                         : {expression, '$1', "&", '$3'}.

expression -> expression '^' expression                                                         : {expression, '$1', "^", '$3'}.

expression -> expression '|' expression                                                         : {expression, '$1', "|", '$3'}.

expression -> expression '<' expression                                                         : {expression, '$1', "<", '$3'}.
expression -> expression '>' expression                                                         : {expression, '$1', ">", '$3'}.
expression -> expression '<=' expression                                                        : {expression, '$1', "<=", '$3'}.
expression -> expression '>=' expression                                                        : {expression, '$1', ">=", '$3'}.

expression -> expression '==' expression                                                        : {expression, '$1', "==", '$3'}.
expression -> expression '!=' expression                                                        : {expression, '$1', "!=", '$3'}.

expression -> expression '&&' expression                                                        : {expression, '$1', "&&", '$3'}.
expression -> expression '||' expression                                                        : {expression, '$1', "||", '$3'}.

expression -> expression '?' expression ':' expression                                          : {expression, '$1', "?", '$3', '$5'}.

expression -> expression '=' expression                                                         : {expression, '$1', "=", '$3'}.
expression -> expression '|=' expression                                                        : {expression, '$1', "|=", '$3'}.
expression -> expression '^=' expression                                                        : {expression, '$1', "^=", '$3'}.
expression -> expression '&=' expression                                                        : {expression, '$1', "&=", '$3'}.
expression -> expression '<<=' expression                                                       : {expression, '$1', "<<=", '$3'}.
expression -> expression '>>=' expression                                                       : {expression, '$1', ">>=", '$3'}.
expression -> expression '+=' expression                                                        : {expression, '$1', "+=", '$3'}.
expression -> expression '-=' expression                                                        : {expression, '$1', "-=", '$3'}.
expression -> expression '*=' expression                                                        : {expression, '$1', "*=", '$3'}.
expression -> expression '/=' expression                                                        : {expression, '$1', "/=", '$3'}.
expression -> expression '%=' expression                                                        : {expression, '$1', "%=", '$3'}.

%% =====================================================================================================================
%% Helper definitions - reduce/shift problem.
%% ---------------------------------------------------------------------------------------------------------------------
% wwe expression -> expression                                                                        : {expression, '$1', ",", []}.
% wwe expression -> expression ',' expression                                                         : {expression, '$1', ",", '$3'}.
% wwe expression -> ',' expression                                                                    : {expression, [],   ",", '$2'}.
%% =====================================================================================================================

expression -> primary_expression                                                                : {expression, '$1'}.

%% =====================================================================================================================
%% Helper definitions - reduce/reduce problem.
%% ---------------------------------------------------------------------------------------------------------------------
% wwe primary_expression -> identifier                                                                : {primaryExpression, '$1'}.
%% =====================================================================================================================

primary_expression -> boolean_literal                                                           : {primaryExpression, '$1'}.
primary_expression -> number_literal                                                            : {primaryExpression, '$1'}.
primary_expression -> string_literal                                                            : {primaryExpression, '$1'}.

%% =====================================================================================================================
%% Helper definitions - reduce/reduce problem.
%% ---------------------------------------------------------------------------------------------------------------------
% wwe primary_expression -> function_call                                                             : {primaryExpression, '$1'}.
%% =====================================================================================================================

function_call -> identifier '(' expression_commalist_opt ')'                                    : {functionCall, '$1', '$3'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
expression_commalist_opt -> '$empty'                                                            : {}.
expression_commalist_opt -> expression_commalist                                                : '$1'.
%% =====================================================================================================================

new_expression -> NEW identifier                                                                : {newExpression, '$2'}.

member_access -> expression '.' identifier                                                      : {memberAccess, '$1', '$3'}.

index_access -> expression '['            ']'                                                   : {indexAccess, '$1', []}.
index_access -> expression '[' expression ']'                                                   : {indexAccess, '$1', '$3'}.

boolean_literal -> TRUE                                                                         : {booleanLiteral, "true"}.
boolean_literal -> FALSE                                                                        : {booleanLiteral, "false"}.

number_literal -> NUMBER_LITERAL number_unit_opt                                                : {numberLiteral, unwrap('$1'), '$2'}.

%% =====================================================================================================================
%% Helper definitions.
%% ---------------------------------------------------------------------------------------------------------------------
number_unit_opt -> '$empty'                                                                     : [].
number_unit_opt -> number_unit                                                                  : '$1'.
%% =====================================================================================================================

number_unit -> WEI                                                                              : {numberUnit, "wei"}.
number_unit -> SZABO                                                                            : {numberUnit, "szabo"}.
number_unit -> FINNEY                                                                           : {numberUnit, "finney"}.
number_unit -> ETHER                                                                            : {numberUnit, "ether"}.
number_unit -> SECONDS                                                                          : {numberUnit, "seconds"}.
number_unit -> MINUTES                                                                          : {numberUnit, "minutes"}.
number_unit -> HOURS                                                                            : {numberUnit, "hours"}.
number_unit -> DAYS                                                                             : {numberUnit, "days"}.
number_unit -> WEEKS                                                                            : {numberUnit, "weeks"}.
number_unit -> YEARS                                                                            : {numberUnit, "years"}.

string_literal -> STRING_LITERAL                                                                : {stringLiteral, unwrap('$1')}.

identifier -> IDENTIFIER                                                                        : {identifier, unwrap('$1')}.

elementary_type_name -> ADDRESS                                                                 : {elementaryTypeName, "address"}.
elementary_type_name -> BOOL                                                                    : {elementaryTypeName, "bool"}.
elementary_type_name -> STRING                                                                  : {elementaryTypeName, "string"}.
elementary_type_name -> VAR                                                                     : {elementaryTypeName, "var"}.

elementary_type_name -> BYTE                                                                    : {elementaryTypeName, unwrap('$1')}.
elementary_type_name -> FIXED                                                                   : {elementaryTypeName, unwrap('$1')}.
elementary_type_name -> INT                                                                     : {elementaryTypeName, unwrap('$1')}.
elementary_type_name -> UFIXED                                                                  : {elementaryTypeName, unwrap('$1')}.
elementary_type_name -> UINT                                                                    : {elementaryTypeName, unwrap('$1')}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Expect 2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Erlang code.

-behaviour(application).
-behaviour(supervisor).

% application callbacks
-export([start/0, start/2, stop/1, stop/0]).

% Supervisor callbacks
-export([init/1]).

% parser and compiler interface
-export([fold/3,
         fold_bu/3,
         fold_td/3,
         is_reserved/1,
         parsetree/1,
         parsetree_to_string/1,
         parsetree_to_string_bu/1,
         parsetree_to_string_td/1,
         parsetree_with_tokens/1
        ]).

% -define(NODEBUG, true).
-include_lib("eunit/include/eunit.hrl").

-define(Dbg(__Rule, __Production),
begin
    io:format(user, "__ "??__Rule" (~p)~n", [__Production]),
    __Production
end).

%%-----------------------------------------------------------------------------
%%                          dummy application interface
%%-----------------------------------------------------------------------------

start() ->
    application:start(?MODULE).
stop() ->
    application:stop(?MODULE).

start(_Type, _Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).
stop(_State) ->
    ok.

init([]) ->
     {ok, { {one_for_one, 5, 10}, []} }.

%%-----------------------------------------------------------------------------
%%                          parser helper functions
%%-----------------------------------------------------------------------------

unwrap({_,_,X}) ->
    X.

%%-----------------------------------------------------------------------------

%%-----------------------------------------------------------------------------
%%                                  PARSER
%%-----------------------------------------------------------------------------
-spec parsetree(binary()|list()) ->
    {parse_error, term()} | {lex_error, term()} | {ok, [tuple()]}.
parsetree(Cypher) ->
   case parsetree_with_tokens(Cypher) of
       {ok, {ParseTree, _Tokens}} -> {ok, ParseTree};
       Error -> Error
   end.

-spec parsetree_with_tokens(binary()|list()) ->
    {parse_error, term()} | {lex_error, term()} | {ok, {[tuple()], list()}}.
parsetree_with_tokens([]) -> {parse_error, invalid_string};
parsetree_with_tokens(<<>>) -> {parse_error, invalid_string};
parsetree_with_tokens(Cypher0) ->
    Cypher = re:replace(Cypher0, "(^[ \r\n]+)|([ \r\n]+$)", "",
                     [global, {return, list}]),
    [C|_] = lists:reverse(Cypher),
    NCypher = if C =:= $; -> Cypher; true -> string:strip(Cypher) end,
    case sylexer:string(NCypher) of
        {ok, Toks, _} ->
            case syparse:parse(Toks) of
                {ok, PTree} -> {ok, {PTree, Toks}};
                {error,{N,?MODULE,ErrorTerms}} ->
                    {parse_error, {lists:flatten([integer_to_list(N), ": ", ErrorTerms]), Toks}};
                {error,Error} -> {parse_error, {Error, Toks}}
            end;
        {error,Error,_} -> {lex_error, Error}
    end.

-spec is_reserved(binary() | atom() | list()) ->
    true | false.
is_reserved(Word) when is_binary(Word) ->
    is_reserved(erlang:binary_to_list(Word));
is_reserved(Word) when is_atom(Word) ->
    is_reserved(erlang:atom_to_list(Word));
is_reserved(Word) when is_list(Word) ->
    lists:member(erlang:list_to_atom(string:to_upper(Word)),
                 sylexer:reserved_keywords()).

%%-----------------------------------------------------------------------------

%%-----------------------------------------------------------------------------
%%                                  COMPILER
%%-----------------------------------------------------------------------------

-spec parsetree_to_string(tuple()| list()) ->
    {error, term()} | binary().
parsetree_to_string(PTree) ->
    parsetree_to_string_td(PTree).

-spec parsetree_to_string_bu(tuple()| list()) ->
    {error, term()} | binary().
parsetree_to_string_bu(PTree) ->
    fold_bu(fun(_,_) -> null_fun end, null_fun, PTree).

-spec parsetree_to_string_td(tuple()| list()) ->
    {error, term()} | binary().
parsetree_to_string_td(PTree) ->
    fold_td(fun(_,_) -> null_fun end, null_fun, PTree).

-spec fold(fun(), term(), tuple()) ->
    {error, term()} | binary().
fold(Fun, Ctx, PTree) when is_function(Fun, 2) ->
    fold_td(Fun, Ctx, PTree).

-spec fold_bu(fun(), term(), tuple()) ->
    {error, term()} | binary().
fold_bu(Fun, Ctx, PTree) when is_function(Fun, 2) ->
    try syparse_fold:fold(bottom_up, Fun, Ctx, 0, PTree) of
        {error,_} = Error -> Error;
        {Cypher, null_fun = Ctx} -> list_to_binary(string:strip(Cypher));
        {_Output, NewCtx} -> NewCtx
    catch
        _:Error -> {error, Error}
    end.

-spec fold_td(fun(), term(), tuple() | list()) ->
    {error, term()} | binary().
fold_td(Fun, Ctx, PTree) when is_function(Fun, 2) ->
    try syparse_fold:fold(top_down, Fun, Ctx, 0, PTree) of
        {error,_} = Error -> Error;
        {Cypher, null_fun = Ctx} ->
            list_to_binary(string:strip(Cypher));
        {_Output, NewCtx} ->
            NewCtx
    catch
        _:Error -> {error, Error}
    end.