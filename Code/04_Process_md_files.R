# For each md file coverted using pandoc, post-process each file and do URL substitution
# ./Posts final/

setwd('C:/Users/vinhd/My Drive/Documents/Web/org2blog migrate to quarto')

library(dplyr)
library(stringr)
library(readr)

# Orig md files
md_dir <- 'Posts md'
md_files <- paste0(md_dir, '/', dir(md_dir))

# Manually clean up these files: mathjax, yaml, html, and latex ($$)
# ## 2015-09-25-calculate-the-weighted-gini-coefficient-or-auc-in-r.qmd
# ## 2016-03-18-secure-access-to-home-ip-cameras-over-the-web-with-ssl.qmd
# ## 2020-07-22-windows-10-weve-got-an-update-for-you-not-responding.qmd:
# ## 2009-05-10-note-to-self-on-uploading-images-to-blog\index.qmd
# ## delete: 2009-05-10-note-to-self-on-uploading-images-to-blog

# URL mapping/lookup
d_mapping <- read_csv('Mappings/all_urls.csv')
new_url <- d_mapping$new_relative_url[!is.na(d_mapping$new_relative_url)]
names(new_url) <- d_mapping$old_url[!is.na(d_mapping$new_relative_url)]

## md_content <- read_file(md_files[1])
## cat(md_content)

# Following shows what languages are supported in pandoc
## pandoc --list-highlight-languages

# Function to process md file
process_md_file <- function(fn) {
  # fn <- md_files[1]
  
  md_content <- read_lines(fn) %>%
    str_replace_all(fixed('``` {.bash org-language="sh"}'), '```{bash}') %>%
    str_replace_all(fixed('``` {.c org-language="C"}'), '{c}') %>%
    str_replace_all(fixed('``` {.commonlisp org-language="emacs-lisp"}'), '```{commonlisp}') %>%
    str_replace_all(fixed('``` {.example}'), '```') %>%
    str_replace_all(fixed('``` {.javascript org-language="js"}'), '```{javascript}') %>%
    str_replace_all(fixed('``` {.php}'), '```{php}') %>%
    # str_replace_all(fixed('``` {.python}'), '```{python eval=FALSE, python.reticulate=FALSE}') %>%
    # str_replace_all(fixed('``` {.r org-language="R"}'), '```{r eval=FALSE}') %>%
    str_replace_all(fixed('``` {.python}'), '```{{python}}') %>%
    str_replace_all(fixed('``` {.r org-language="R"}'), '```{{r}}') %>%
    str_replace_all(fixed('``` {.ruby}'), '```{ruby}') %>%
    str_replace_all(fixed('``` {.sas}'), '```{sas eval=FALSE}') %>%
    str_replace_all(fixed('``` {.sql}'), '```{sql}') %>%
    # str_replace_all(fixed('```{=html}'), '```{html}') %>%
    # str_replace_all(fixed('```{=latex}'), '```{latex}') %>%
    # str_replace_all(fixed('- \'`src="http://cdn.mathjax.org/mathjax/latest/MathJax.js">`{=html}\''), '') %>%
    # str_replace_all(fixed('\'`src="http://cdn.mathjax.org/mathjax/latest/MathJax.js">`{=html}\''), '') %>%
    # str_replace_all(fixed('- \'`</script>`{=html}\''), '') %>%
    # str_replace_all(fixed('\'`</script>`{=html}\''), '') %>%
    # str_replace_all(fixed('`</script>`{=html}'), '') %>%
    # str_replace_all(fixed('\[mathjax\]'), '') %>%
    str_replace_all(new_url)

  # category: 'LaTeX, R, Statistics, Teaching'
  categories <- str_match(md_content, "category: ([0-9a-zA-Z ,']+)")[,2]
  categories <- categories[!is.na(categories)] %>%
    str_replace_all("'", "") %>%
    str_split(', ') %>%
    unlist %>%
    paste0('  - ', ., collapse='\r\n') %>%
    paste0('categories:\r\n', .)
  categories <- ifelse(categories == 'categories:\r\n  - ', '', categories)
  categories <- ifelse(categories == 'categories:\r\n  - Self', '', categories)
  categories <- str_replace_all(categories, '  - $', '')
  
  # date: '\[2009-05-10 Sun 02:42\]'
  date_field <- str_match(md_content, "date: '\\\\\\[([0-9-]+)")[,2]
  date_field <- paste0(
    'date: "'
    , date_field[!is.na(date_field)]
    , '"'
  )
  
  # postid: 7
  ## delete
  
  # tags: 'Beamer, LaTeX, R, Statistics, Teaching'
  tags <- str_match(md_content, "tags: ([0-9a-zA-Z ,']+)")[,2]
  tags <- tags[!is.na(tags)] %>%
    str_replace_all("'", "") %>%
    str_split(', ') %>%
    unlist %>%
    paste0('  - ', ., collapse='\r\n') %>%
    paste0('tags:\r\n', .)
  tags <- ifelse(tags == 'tags:\r\n  - ', '', tags)
  tags <- ifelse(tags == 'tags:\r\n  - Self', '', tags)
  tags <- ifelse(tags == 'tags:\r\n  - 11', '', tags)
  tags <- str_replace_all(tags, '  - 64$', '')
  tags <- str_replace_all(tags, '  - $', '')

  # title: 
  title_field <- str_match(md_content, "title: (.+)$")[,2]
  title_field <- title_field[!is.na(title_field)] %>%
    str_replace_all(fixed("\\''"), "'") %>%
    str_replace_all(fixed("\\["), "[") %>%
    str_replace_all("'$", "") %>%
    str_replace_all("^'", "") %>%
    paste0('title: "', ., '"')
    
  
  # add author:
  author <- 'author: "Vinh Nguyen"'
  
  # add description: 
  description <- 'description: ""'
  
  # yaml end
  yaml_end <- which(md_content == '---')[2]
  
  # New
  md_content_new <- c(md_content[1]
                      , title_field
                      , description
                      , author
                      , date_field
                      , categories
                      , tags
                      , md_content[yaml_end:length(md_content)]
  )
   
  new_dir <- str_replace(fn, fixed('Posts md'), 'Posts final') %>%
    str_replace('\\.qmd$', '/')
  dir.create(new_dir)
  fn_new <- paste0(new_dir, 'index.qmd')
  
  write_lines(md_content_new, fn_new)
}
# str(md_content)

# do all
lapply(md_files, process_md_file) %>%
  suppressMessages

