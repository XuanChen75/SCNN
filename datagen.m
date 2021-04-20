testdata = loadMNISTImages('t10k-images.idx3-ubyte');%28*28*10000 row col image
testlabel = loadMNISTLabels('t10k-labels.idx1-ubyte');%1*10000 label image
traindata = loadMNISTImages('train-images.idx3-ubyte');%28*28*60000 row col image
trainlabel = loadMNISTLabels('train-labels.idx1-ubyte');%1*60000 label image
save test.mat testdata testlabel
save train.mat traindata trainlabel