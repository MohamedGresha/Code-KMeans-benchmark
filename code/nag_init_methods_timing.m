%This script counts the execution time of each method (tic-toc).
%Requires a data file generated by nag_init_methods_generate.

%clear all
%close all
%clc

if isdeployed
    addpath(genpath(ctfroot));
else
    addpath(genpath(pwd));
end


NREP = 40;  %repeat dataset
NITER = 25; %repeat solution if non-deterministic
datasets = {'gap','wgap','Brodinova','mixed','hdims','real','S-sets','A-sets'};
unique_datasets = {'real','S-sets','A-sets'};
method_centers = {'Random points','K-Means++','ROBIN-STOCHASTIC','Kaufman','Density K-Means++','ROBIN-LOF',...
    'ROBIN','Maximin','Maximin-DETERMINISTIC'};
DETERM_METHODS = [4,5,6,7,9];
DO = [1,2,3,5,8];

VOCAL = 0;


%% Initialize
ndm = length(datasets);
nmi = length(method_centers);

selpath = uigetdir(pwd,'Select output folder. A subfolder NAG_init_time will be created.');
if isequal(selpath,0)
    return
end

[ffile,fpath] = uigetfile('*.mat','Select data file.','data.mat');
if isequal(selpath,0)
    return
else
    load(fullfile(fpath,ffile));
end

ff = fullfile(selpath,'NAG_init_time');
if ~exist(ff,'dir')
    mkdir(ff);
end


%% Run all the clustering algorithms and init methods
for dm = 1:ndm %for each dataset
    cdata = dataDataset{dm};
    for nm = 1:size(cdata,1) %for each model
        if exist(fullfile(ff,sprintf('%s_model_%d.mat',datasets{dm},nm)),'file')
            continue
        end
        if ~ismember(datasets{dm},unique_datasets)
            resModel = cell(1,NREP);
        else
            resModel = cell(1,1); %unique dataset
        end
        for nr = 1:NREP  %for each repetition
            x = cdata{nm,nr}{1};
            x_labs = cdata{nm,nr}{2};
            k = length(unique(x_labs));
            tmpres = struct('exeTime',[]);
            res = repmat(tmpres,nmi,NITER);     
            for mi = 1:nmi %for each init method
                if ~ismember(mi,DO)
                    continue
                end
                for I = 1:NITER
                    [~,time] = cluster_init_tictoc(x,k,method_centers{mi}); 
                    res(mi,I).exeTime = time;
                end
            end
            resModel{1,nr} = res;
            if ismember(datasets{dm},unique_datasets)
                break;
            end
        end
        save(fullfile(ff,sprintf('%s_model_%d.mat',datasets{dm},nm)),'resModel','method_centers','-v7.3');
    end
end
