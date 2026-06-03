
module simple_dual_port_ram
#(
   parameter DATA_WIDTH       = 8,
   parameter ADDR_WIDTH       = 9,
   parameter OUTPUT_REG       = "TRUE",
   parameter RAM_INIT_FILE    = "",
   parameter RAM_INIT_RADIX   = "HEX"
)
(
   input [(DATA_WIDTH-1):0]   wdata,
   input [(ADDR_WIDTH-1):0]   waddr, raddr,
   input                      we, wclk, re, rclk,
   output [(DATA_WIDTH-1):0]  rdata
);

   localparam MEMORY_DEPTH = 2**ADDR_WIDTH;
   localparam MAX_DATA     = (1<<ADDR_WIDTH)-1;
   
   reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
   wire [DATA_WIDTH-1:0] r_rdata_1P;
   reg [DATA_WIDTH-1:0] r_rdata_2P;
//Encryption begin
`pragma protect begin_protected
`pragma protect version=1
`pragma protect encrypt_agent="ipecrypt"
`pragma protect encrypt_agent_info="http://ipencrypter.com Version: 20.0.8"
`pragma protect author="author-a"
`pragma protect author_info="author-a-details"

`pragma protect key_keyowner="Efinix Inc."
`pragma protect key_keyname="EFX_K01"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=256)
`pragma protect key_block
D1MPDgfJIBxb4Vy46hZeEUebRkdjoeSEnC3FWxvFMsXnv/RU2gEd10CHoccJ9uB+
UelltU5Uw6xFLTx+bkP/ySv9JfDZNEonkX3XL1acaqlNww/s4aGflh3hdz3vJ4Ch
nAxxasfdEjGLFs5I3Lxy9Zb5CFgfAT/cIlsE0CSTaZ73glB+zVyyg/4wrLfy8Ur6
lSQ78TZy4Tu8zdqkU0fSiq8ixkayIjM958eZ+AtFsjZ7ZpWTkisMZbbS9r3MXKpX
Dyh+uOpgbKX1xJLHhrHJe2BWjWEZCd3EDcJ5fzkhGyDxrbqMwIquxwzg9V7rrF22
J6WhhY6/cO1dh/Hj4ya6MA==
`pragma protect key_keyowner="Mentor Graphics Corporation"
`pragma protect key_keyname="MGC-VERIF-SIM-RSA-1"
`pragma protect key_method="rsa"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=128)
`pragma protect key_block
XvzTgZQwXLPB6ud03ryV/GaVfCV9rbhu6fu9aZA/fLw5n+7VHFQjob+uv8edoM/W
kBMpeQwoKDb/9n2vyxVrf8l23o9SfNW6vOvqndqwKyPs99YGncvMBY3yY9RZ0MCA
o1YPcnx+Y2YQ8sXBZUS26itNZw59I/O95KmfGOsPZk8=
`pragma protect data_method="aes256-cbc"
`pragma protect encoding=(enctype="base64", line_length=64, bytes=960)
`pragma protect data_block
Uo4opP8PWKZoHwaKJkTMyuoZ0PzDhJXJ+VTzT4S2Oe5pLLa5Q05GL+m439nXIdCQ
8qpBxCAPzV3/gmrcERk2EPS4U6ZuIoHP5Elax3RfJ6TFaeFve5SWpUDevcmg40jW
htjcdFz1+VzydRBspfeJVNIyrEXDoT4+SHG07ya7DOugW7AE+u+VXgqhqQtBqFG2
uTSUpQOeflln4R9r8fg6lypZOwBbzD3hrcyjTBx+G2X1k1vun08K2SLNrNyor9xn
68tkCtel+wk6E3b2wnUsvYNIjCjx6d4vCqibiFx8Rv0Ze78EwptLoCjnYcDSMetu
Uies6cdACd302BHHI0oyLmrgbKb1DMvqL/eGv4Yj/hXLOh2HVUQOiMYw/NF92YIv
fp0tXx2zurCplBf2kd0BZcEWcERLwfVLEreGti/2R3IBpWGXIB0wW5LBH/j6+DII
dtzxa2JH9HgqiMo64oSSU2gVQKSArFIcB68w/If1pTf+Oj4FZRaH96dzh5BZR3CP
98CrbmhGpATJl4Ow8ggA1HIKagxI7y1T55/QYWedmsowspwwanvELWLTh7YDwgFb
ZmMhIo+SpS6uH9rDmaqQKq5k7lq1poSB/Zuw4LWygUvg9wvbWwGMQMJl84HqUZfa
DV6Olracnm6Pbq34EMxg7IzcxKLyguLSJJJu/TgGqg6G6+Va9DvvU4saDk2xztPl
lwwqK4C+0KlMD/1xcN5UhC1RSbRbaAtI51HvAm4YytsU5/0tHh8Ao8pqj7vUGSsL
/kNZNHzIsqzITa97pLybNOYDdrel8YiGSLjCFIO80HabkQd+WDEzhlBX3yqx08yO
159epyQre2ayDXAs9jxiQGCbRJ4B/q2yHD1kbyN/hAI6pXuQxO1iN7oyZrXDrFZP
yKdpPAyo2GcVlwGIyiNGcuD5k+f2wzpLuLIkQfdxTr45YYJ7JhcoKGKMDCI/ovgA
yPGb8G+CsAbukNR1hfqoeReGqE8UA0DYhx7j4azu/ipu2oC4+mbNaDGNIzhCgUNh
qORfWaPhlxlizGvN7fXvU4cyObGRGASXc6DUtUrX2TbMt3vR/umrICpZGgMSMVOE
rOcCh2bopFcWQR9PSX4L0/DNGJ8gFEUpxcZ+syY6xsoZhTrRWewW8G/s1+aFyzL+
Gkz729p6bojwrN9sZFJ6DcJfWvD9Z1A9riup8RX2TNBEMN/2RpIIHcUm4+gK4p8M
zMdy1RdMmmbVuF3Mq9Zs2L5iegY5dn3megOs4o5KwlvxQ1I2stbB3UWYXwvvfQmk
`pragma protect end_protected

endmodule
