clear
clc
close all

%% Setup
resdir = setup();
datadir = fullfile(resdir, 'data');

%% Get data ids
files = dir(fullfile(datadir, '*.mat'));
ids = strings(length(files), 1);
for i=1:length(files)
    [~, id, ~] = fileparts(files(i).name);
    ids(i) = id;
end

%% TODO: loop over ids
A1_normal = readPcd(fullfile(datadir, ids(2) + '_normal.pcd'));
A1_cloud = readPcd(fullfile(datadir, ids(2) + '.pcd'));
A2_normal = readPcd(fullfile(datadir, ids(3) + '_normal.pcd'));
A2_cloud = readPcd(fullfile(datadir, ids(3) + '.pcd'));

A1 = filter_nanormals(A1_cloud, A1_normal);
A2 = filter_nanormals(A2_cloud, A2_normal);
% for i = 1:100
%     A1_normal = readPcd(fullfile(datadir, ids(i) + '_normal.pcd'));
%     A1 = readPcd(fullfile(datadir, ids(i) + '.pcd'));
%     Filter_A1 = filter_nanormals(A1, A1_normal);
% end
%% Run ICP
[R, t] = icp(A1, A2);


[~, vocabulary] = kmeans(double(D'), vocabulary_size, 'display', 'off', 'replicates', 1, 'maxiter', 100);
bow_path = strcat(folder, 'bow.mat');
BoW = [];
for i = 1:size(I_BoW, 2)
    BoW_ = get_BoW(I_BoW{i}, vocabulary, sampling_method, sift_descriptor, descriptor_type);
    BoW = cat(1, BoW, BoW_);
end


