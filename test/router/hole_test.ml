open Router

let%expect_test _ =
  let result = Hole.(to_string string) "foo" in
  print_endline result;
  [%expect {| foo |}]

let%expect_test _ =
  let result = Hole.(to_string int) 42 in
  print_endline result;
  [%expect {| 42 |}]

let%expect_test _ =
  let result = Hole.(from_string int) "42" in
  Format.printf "%a" (Format.pp_print_option Format.pp_print_int) result;
  [%expect {| 42 |}]

let%expect_test _ =
  let result = Hole.(from_string int) "s42" in
  Format.printf "%a" (Format.pp_print_option Format.pp_print_int) result;
  [%expect {| |}]

let%expect_test _ =
  let result = Hole.(from_string int) "42s" in
  Format.printf "%a" (Format.pp_print_option Format.pp_print_int) result;
  [%expect {| |}]

let%expect_test _ =
  let result = Hole.(from_string (guard int (fun x -> x mod 2 = 0))) "42" in
  Format.printf "%a" (Format.pp_print_option Format.pp_print_int) result;
  [%expect {| 42 |}]

let%expect_test _ =
  let result = Hole.(from_string (guard int (fun x -> x mod 2 = 0))) "43" in
  Format.printf "%a" (Format.pp_print_option Format.pp_print_int) result;
  [%expect {| |}]
