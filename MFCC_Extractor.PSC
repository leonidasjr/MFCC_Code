## MFCCsExtractor.PSC
## Copyright (C) Leônidas SILVA Jr. State University of Paraíba, Brazil
##-- HOW TO CITE --##
## SILVA Jr., L. MFCCs_Extractor. (2022). Computer program for Praat.
## URL: <https://github.com/leonidasjr/MFCC_Code>
#######################

form MFCCs extraction
	integer Number_of_coefficients 12
	positive Window_length 0.015
	boolean save_MFCC_as_a_table 1
endform

## cleaning Praat's objects window before workflow
numberOfSelectedObjects = numberOfSelected()
if numberOfSelectedObjects > 0
	select all
	Remove
endif
##

## start the MFCCs extraction for all of the audio files
Create Strings as file list... audioDataList *.wav
numberOfFiles = Get number of strings

for y from 1 to numberOfFiles
	select Strings audioDataList
	soundname$ = Get string... y
	Read from file... 'soundname$'
	sound_file$ = selected$ ("Sound")
	To MFCC: 'number_of_coefficients', 'window_length', 0.005, 100, 100, 0
	if save_MFCC_as_a_table
		select MFCC 'sound_file$'
		Write to text file... 'sound_file$'.MFCC
		select MFCC 'sound_file$'
			plus Sound 'sound_file$'
		Remove
	endif
endfor
