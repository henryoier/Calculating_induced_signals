function varargout = process_diff_induce( varargin )
% PROCESS_DIFF: generate induced signal from total and evoked.
% Modified from Difference: A - B
% @=============================================================================
% This function is part of the Brainstorm software:
% http://neuroimage.usc.edu/brainstorm
% 
% Copyright (c)2000-2015 University of Southern California & McGill University
% This software is distributed under the terms of the GNU General Public License
% as published by the Free Software Foundation. Further details on the GPL
% license can be found at http://www.gnu.org/copyleft/gpl.html.
% 
% FOR RESEARCH PURPOSES ONLY. THE SOFTWARE IS PROVIDED "AS IS," AND THE
% UNIVERSITY OF SOUTHERN CALIFORNIA AND ITS COLLABORATORS DO NOT MAKE ANY
% WARRANTY, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, NOR DO THEY ASSUME ANY
% LIABILITY OR RESPONSIBILITY FOR THE USE OF THIS SOFTWARE.
%
% For more information type "brainstorm license" at command prompt.
% =============================================================================@
% Version 1 -   Dec. 2015
% Authors   -   Sheng Qin (shengqin [AT] mit (DOT) edu)

macro_methodcall;
end


%% ===== GET DESCRIPTION =====
function sProcess = GetDescription() %#ok<DEFNU>
    % Description the process
    sProcess.Comment     = 'Difference: Total - Evoked';
    sProcess.FileTag     = [];
    sProcess.Category    = 'Filter2';
    sProcess.SubGroup    = 'Difference';
    sProcess.Index       = 250;
    sProcess.Description = 'http://neuroimage.usc.edu/brainstorm/Tutorials/Difference';
    % Definition of the input accepted by this process
    sProcess.InputTypes  = {'data', 'results', 'timefreq', 'matrix'};
    sProcess.OutputTypes = {'data', 'results', 'timefreq', 'matrix'};
    sProcess.nInputs     = 2;
    sProcess.nMinFiles   = 1;
    sProcess.isPaired    = 0;
    % Default values for some options
    sProcess.isSourceAbsolute = 1;
end


%% ===== FORMAT COMMENT =====
function Comment = FormatComment(sProcess) %#ok<DEFNU>
    Comment = sProcess.Comment;
    % Absolute values 
    if isfield(sProcess.options, 'source_abs') && sProcess.options.source_abs.Value
        Comment = [Comment, ', abs'];
    end
end


%% ===== RUN =====
function sOutput = Run(sProcess, sInputsA, sInputsB) %#ok<DEFNU>
    % Difference
    sOutput = sInputsA;
    sOutput.A = sInputsA.A - sInputsB.A;
    % Output condition name
    sOutput.Condition = [sInputsA.Condition, '-', sInputsB.Condition];
    sOutput.Comment   = [sInputsA.Comment ' - ' sInputsB.Comment];
    % Colormap for recordings: keep the original
    % Colormap for sources, timefreq... : difference (stat2)
    if ~strcmpi(sInputsA(1).FileType, 'data')
        sOutput.ColormapType = 'stat2';
    end
end






