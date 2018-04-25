# Stock-Ticker-App
For  this  coding  exercise,  please  build  an  app  that  performs  search  for  stock  symbol  lookup.  The  user  must  be  able  to  enter  a  search  term  in  a  text  field  and  see  the  results  of  the  search  term  auto-populate  in  either  a  collection  view  or  table  view  as  they  type.  The  minimum  character  length  you  should  start  searching  against  is  2-characters.  As  you  render  the  results,  for  each  row,  make  a  call  to  the  Quote  api  and  also  display  the  last  traded  price  in  each  row

REQUIREMENTS:
-Build  a  native  iOS  app  using  Xcode  9.x  and  Swift  version  3  or  4.
-Your  project  MUST  compile  and  run  successfully.  We  should  be  able  to  successfully  search  a  term  and  see  results.-We  would  prefer  you  use  NSURLSession  for  the  network  requests  opposed  to  a  third  party  library  for  the  networking  logic
-Deliver  an  archive  (compressed  folder)  of  the  entire  Xcode  project  and  it's  dependencies

OTHER  ITEMS:
-You  may  use  third  party  libraries-Pay  close  consideration  to  concurrency  and  unnecessary  work  on  the  main  thread
-Don't  spend  too  much  time  on  the  UI.  We  are  more  interested  in  your  coding  skills  rather  than  your  design  skills
-Don't  hesitate  to  reach  out  and  ask  questions
-Include  Unit  tests-Include  code  coverage  report  (~80%)

The  Symbol  Search  URL:
https://symlookup.cnbc.com/symservice/symlookup.do?prefix={SEARCH_TERM}&partnerid=20064&pgok=1&pgsize=50E.g.:  https://symlookup.cnbc.com/symservice/symlookup.do?prefix=net&partnerid=20064&pgok=1&pgsize=50Quote  

API  URL:  
https://quote.cnbc.com/quote-html-webservice/quote.htm?symbols=symbol_from_symbol_search_api&output=jsonThis  API  accepts  multiple  pipe  separated  symbols

E.g.:  
https://quote.cnbc.com/quote-html-webservice/quote.htm?symbols=nflx&output=json

http://quote.cnbc.com/quote-html-webservice/quote.htm?symbols=cmcsa|nflx&output=json

You  can  see  similar  functionality  in  our  ios  app  (https://itunes.apple.com/us/app/cnbc-breaking-business-news/id398018310?mt=8)  or  on  our  website  (https://www.cnbc.com/stocks/)
