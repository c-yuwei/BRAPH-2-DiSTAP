% BRAPH2GENESIS 
%
% This script generates and tests BRAPH2.
% The various subfolders contain the files necessary to generate the
% various parts of BRAPH2.
%
% BRAPH2GENESIS packages:
% <a href="matlab:help genesis  ">genesis</a>   - code to generate BRAPH2
% <a href="matlab:help braph2   ">braph2</a>    - BRAPH2 loader
% <a href="matlab:help src      ">src</a>       - BRAPH2 core
% <a href="matlab:help graphs   ">graphs</a>    - BRAPH2 graphs
% <a href="matlab:help measures ">measures</a>  - BRAPH2 measures
% <a href="matlab:help workflows">workflows</a> - BRAPH2 workflows
% <a href="matlab:help test     ">test</a>      - BRAPH2 test

close all
clear all %#ok<CLALL>
clc
warning('off', 'MATLAB:MKDIR:DirectoryExists')

addpath(fileparts(which('braph2genesis')))
addpath([fileparts(which('braph2genesis')) filesep 'genesis'])

[target_dir, source_dir] = genesis();

addpath(target_dir)
braph2

test_braph2