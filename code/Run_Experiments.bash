nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('Gaussian1.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G1.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "run('Gaussian2.mat', 100, 1000, 5, [0.05 0.25], [1 0.75], 10);exit;" > G2.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian1.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G1_a.log  & 
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian1.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G1_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian1.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G1_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian1.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G1_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian2.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G2_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian2.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G2_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian2.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G2_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian2.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G2_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian3.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G3_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian3.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G3_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian3.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G3_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('Gaussian3.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > G3_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('WaveForm.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > WF_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('WaveForm.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > WF_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('WaveForm.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > WF_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('WaveForm.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > WF_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('BallInBox.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > BIB_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('BallInBox.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > BIB_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('BallInBox.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > BIB_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('BallInBox.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > BIB_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('abalone.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > abalone_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('abalone.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > abalone_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('abalone.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > abalone_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('abalone.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > abalone_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s1.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR1_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s1.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR1_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s1.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR1_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s1.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR1_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s2.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR2_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s2.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR2_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s2.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR2_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('activity_recognition_s2.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > AR2_d.log  &


nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('casp.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > casp_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('casp.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > casp_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('casp.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > casp_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('casp.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > casp_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('covertype.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > CT_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('covertype.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > CT_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('covertype.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > CT_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('covertype.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > CT_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('h1b.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > h1b_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('h1b.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > h1b_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('h1b.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > h1b_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('h1b.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > h1b_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('epileptic.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > EL_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('epileptic.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > EL_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('epileptic.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > EL_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('epileptic.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > EL_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('parkinsons.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > PS_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('parkinsons.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > PS_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('parkinsons.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > PS_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('parkinsons.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > PS_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mushroom.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MR_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mushroom.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MR_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mushroom.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MR_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mushroom.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MR_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mol_bio.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MB_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mol_bio.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MB_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mol_bio.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MB_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('mol_bio.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > MB_d.log  &

nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('smartphone.mat', 100, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > SP_a.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('smartphone.mat', 200, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > SP_b.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('smartphone.mat', 300, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > SP_c.log  &
nohup /l/matlab-R2018a/bin/matlab  -nodisplay -nojvm -r "runrun('smartphone.mat', 400, 1000, 30, [0.05 0.25], [1 0.75], 10);exit;" > SP_d.log  &
