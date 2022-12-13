module add1bit(output s, output cout, input a, input b, input cin);

// Level 1
xor xG1(t1, a, b);

// Level 2
xor xG2(s, t1, cin);
and xG3(t2, t1, cin);
and xG4(t3, a, b);

// Level 3
or xG5(cout, t2, t3);

endmodule