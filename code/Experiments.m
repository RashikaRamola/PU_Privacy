
run('activity_recognition_s1.mat', 500, 5000, 5, [0.05 0.25], [1 0.75], 10);
run('activity_recognition_s1.mat', 1000, 10000, 5, [0.05 0.25], [1 0.75], 10);
run('activity_recognition_s1.mat', 1500, 15000, 5, [0.05 0.25], [1 0.75], 10);
run('activity_recognition_s1.mat', 2000, 20000, 5, [0.05 0.25], [1 0.75], 10);

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('activity_recognition_s1.mat', 200, 2000, 5, [0.05 0.25], [1 0.75], 10);exit;" > AR1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('activity_recognition_s1.mat', 500, 5000, 5, [0.05 0.25], [1 0.75], 10);exit;" > AR2.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('activity_recognition_s1.mat', 1000, 10000, 5, [0.05 0.25], [1 0.75], 10);exit;" > AR3.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('activity_recognition_s1.mat', 1500, 15000, 5, [0.05 0.25], [1 0.75], 10);exit;" > AR4.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('activity_recognition_s1.mat', 2000, 20000, 5, [0.05 0.25], [1 0.75], 10);exit;" > AR5.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('casp.mat', 200, 2000, 5, [0.05 0.25], [1 0.75], 10);exit;" > C1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('casp.mat', 500, 5000, 5, [0.05 0.25], [1 0.75], 10);exit;" > C2.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('casp.mat', 1000, 10000, 5, [0.05 0.25], [1 0.75], 10);exit;" > C3.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('casp.mat', 1500, 15000, 5, [0.05 0.25], [1 0.75], 10);exit;" > C4.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('casp.mat', 2000, 20000, 5, [0.05 0.25], [1 0.75], 10);exit;" > C5.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('covertype.mat', 200, 2000, 5, [0.05 0.25], [1 0.75], 10);exit;" > CT1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('covertype.mat', 500, 5000, 5, [0.05 0.25], [1 0.75], 10);exit;" > CT2.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('covertype.mat', 1000, 10000, 5, [0.05 0.25], [1 0.75], 10);exit;" > CT3.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('covertype.mat', 1500, 15000, 5, [0.05 0.25], [1 0.75], 10);exit;" > CT4.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('covertype.mat', 2000, 20000, 5, [0.05 0.25], [1 0.75], 10);exit;" > CT5.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('Gaussian1.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('Gaussian2.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('Gaussian3.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G3.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('BallInBox.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('WaveForm.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G3.log  &


run('BallInBox.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);
run('Waveform.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);
run('Gaussian1.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);
run('Gaussian2.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);
run('Gaussian3.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);

run('casp.mat', 200, 2000, 5, [0.05 0.25], [1 0.75], 10);
run('casp.mat', 500, 5000, 5, [0.05 0.25], [1 0.75], 10);
run('casp.mat', 1000, 10000, 5, [0.05 0.25], [1 0.75], 10);
run('casp.mat', 1500, 15000, 5, [0.05 0.25], [1 0.75], 10);
run('casp.mat', 2000, 20000, 5, [0.05 0.25], [1 0.75], 10);

run('covertype.mat', 200, 2000, 5, [0.05 0.25], [1 0.75], 10);
run('covertype.mat', 500, 5000, 5, [0.05 0.25], [1 0.75], 10);
run('covertype.mat', 1000, 10000, 5, [0.05 0.25], [1 0.75], 10);
run('covertype.mat', 1500, 15000, 5, [0.05 0.25], [1 0.75], 10);
run('covertype.mat', 2000, 20000, 5, [0.05 0.25], [1 0.75], 10);
