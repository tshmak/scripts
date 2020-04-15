These are some of the things I'll probably need when starting from a brand new Mac: 
1. Download Spectacle -- for efficiently moving windows around. 
2. Install Anaconda and python 
3. Install R -- Microsoft R doesn't have much support for controlling the number of cores used in Mac. It's probably best to stick with CRAN R with 1 core. 
4. ~~R for Mac needs XQuartz and Xcode Command Line Tools (CLT). Note that Xcode CLT is *not* the same as Xcode (a IDE/text editor).~~
Actually, I think it's best to just follow the instruction here: https://cran.r-project.org/bin/macosx/tools/ and download clang and gfortran. 
5. Let's use Chrome instead of Safari, and I'll have my old bookmarks since it syncs them. 
6. I'll need iTerm2 instead of Terminal. 
7. In iTerm2, go to Profiles -- Keys to try and adopt the "Natural text edit" setup. 
8. Try and enable the home and end keys in iTerm2. (Search online for how to do that.) 
9. Disable autosave in jupyter notebook. (Actually not sure it's a good idea now.)
10. Install homebrew, and where possible use it to install software (if dmg files not available)
11. Things like sox are best installed using homebrew. (Possibly Octave) 
12. Consider installing software with conda also! (e.g. R, Octave)
13. Install MacTex (MikTex is for Windows. Tex Live is for Linux)
14. Install Rstudio, and disable auto saving workspace and history. 

# Linux install 
Actually, Linux installs are a pain also. Some points to keep in mind: 
1. To install python: 
1.1 Install conda
1.2 Install spyder within conda (i.e. don't install separately)
1.3 Use the `~/scripts/start_spyder.sh` to launch spyder. 
1.4 Set up a launcher to spyder: likely through /usr/share/applications/spyder.desktop
2. Install Tex Live (MikTex is only for Windows) (Do full install instead of on-the-fly)
3. Install Mendeley
4. Install Microsoft R and Rstudio
5. Remember to install the packages such as roxygen2, devtools, etc. in R. These can actually be problematic, especially with the compiler settings. 
5.1 Type "R CMD config" to see a list of flags you can set for the c compilers. 
5.2 For example, `xml2` can fail if compiling using the default CXX. We may need to set CXX to "g++ -std=c++11" by creating a `~/.R/Makevars` file
6. Install a scanner driver (gscan2pdf)
7. Install Dropbox and rclone for Dropbox and Googledrive sync
8. Install VLC for playing media
9. Install LibreOffice
10. Install OpenFORTI for VPN
11. Install Inkscape for drawing



