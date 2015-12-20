/*Command (1) */

cd "D:/"

/*Command (2) */

global Rterm_path `"F:\Program Files\R-3.1.2\bin\x64\R.exe"'

global Rterm_options `"--vanilla"'

/*Command (3) */

rsource using mytest.R,roptions(--slave)

/*Command (4) */

use "swiss.dta"

regress Fertility Agriculture Catholic
