# June 04, 2018
# get protein sequence files for published fungal genomes
# All protein sequence files from Mycocosm were downloaded when working Lysozyme Project. Hence, there no need to re-download all of the data. Only need to check and copy the ones that were published into a folder for processing data for the AA3_2 manuscript

#! /usr/perl/bin -w
use strict;

my $filein_published_species_abbs="/home/mnguyen/Research/Symbiomics/AA3/AA3_2/AA3_2_manuscript/Published_proteomes_Mycocosm_species_abb.txt";
#my $folderin_JGI_proteomes="/home/mnguyen/Research/JGI_Mycocosm/CAZymes/Proteomes";
my $folderin_JGI_proteomes="/home/mnguyen/Research/Lysozyme/Fungi/Added_JGI_fungi_26Feb2018/JGI_protein_files_to_add";
my $folderout="/home/mnguyen/Research/Symbiomics/AA3/AA3_2/AA3_2_manuscript/Published_fungal_proteomes_04Jun2018_added";
mkdir $folderout;

my @arr_published_species;
open (In,"<$filein_published_species_abbs") || die "Cannot open file $filein_published_species_abbs";
while (<In>)
{
	$_=~s/\s*//g;
	push(@arr_published_species,$_);
}
close(In);

opendir(DIR,$folderin_JGI_proteomes) || die "Cannot open folder $folderin_JGI_proteomes";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		foreach my $species (@arr_published_species)
		{
			if ($file=~/^\Q$species\E/)
			{
				my $cmd="cp $folderin_JGI_proteomes/$file $folderout";
				system $cmd;
			}
		}
	}
}
closedir(DIR);