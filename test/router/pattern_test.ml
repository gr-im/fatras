open Router

let%expect_test _ =
  let p = Pattern.(make (s "foo" / s "bar" / s "baz")) in
  print_endline @@ Pattern.inspect p;
  [%expect {| /foo/bar/baz |}]

let%expect_test _ =
  let p = Pattern.(make (s "foo" / float / s "baz")) in
  print_endline @@ Pattern.inspect p;
  [%expect {| /foo/$hole/baz |}]

let%expect_test _ =
  let p =
    Pattern.(make (s "foo" / float / s "baz" / int / char / string / bool))
  in
  print_endline @@ Pattern.inspect p;
  [%expect {| /foo/$hole/baz/$hole/$hole/$hole/$hole |}]
