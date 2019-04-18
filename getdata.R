install.packages("babynames")

download.file("https://gist.githubusercontent.com/stevejackson/1429696/raw/0ae04f6d1af406a43ca617b2bdb9b2ef7034ba5a/gistfile1.txt",
              "pinyin.txt")

download.file("https://raw.githubusercontent.com/davidmhu/blogsite/85330d3741dea6e610e176fe92a3e2d7bd5be498/public/qa/hanziDict.js",
              "haizi_dict.txt")

library(tidyverse)
sample_hanzi <- read_lines("hanzi_dict.txt")[3:6761]
sample_hanzi <- sample_hanzi %>%
  str_extract_all("'([^']*)'", simplify = T) %>%
  str_remove_all("'")
sample_hanzi <- tibble(
  hanzi = sample_hanzi[1:(length(sample_hanzi)/2)],
  pinyin = sample_hanzi[(1+length(sample_hanzi)/2):length(sample_hanzi)]
)
sample_hanzi <- sample_hanzi %>%
  group_by(pinyin) %>%
  slice(1) %>%
  ungroup() %>%
  filter(!pinyin %in% c("m", "n", "o"))
write_csv(sample_hanzi, "sample_hanzi.csv")
