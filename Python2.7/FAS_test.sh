#!/usr/bin/env bash
# bash compare_FAS_scores.py <FAS directory> <Test directory>

echo "clearing $2/Test_OUT/"
rm $2/Test_OUT/* 
echo "##### basic run #####"
echo "running python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/standart_noref"
python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/standart_noref
echo "checking standart_noref.xml"
python $2/compare_FAS_scores.py $2/Result_Templates/standart_noref.xml $2/Test_OUT/standart_noref.xml $2/log/standart_noref.log

echo "##### reference #####"
echo "running python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/standart_ref -r $2/References/HUMAN_9606\@1/ -e 0"
python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/standart_ref -r $2/References/HUMAN_9606\@1/ -e 0
echo "checking standart_ref.xml"
python $2/compare_FAS_scores.py $2/Result_Templates/standart_ref.xml $2/Test_OUT/standart_ref.xml $2/log/standart_ref.log

echo "##### priority #####"
echo "running python $1/greedyFAS.py -q $2/Annotations/Priority_Test_01/ -s $2/Annotations/Priority_Test_02/ -j $2/Test_OUT/priority_noref -e 0"
python $1/greedyFAS.py -q $2/Annotations/Priority_Test_01/ -s $2/Annotations/Priority_Test_02/ -j $2/Test_OUT/priority_noref -e 0
echo "checking priority_noref.xml"
python $2/compare_FAS_scores.py $2/Result_Templates/priority_noref.xml $2/Test_OUT/priority_noref.xml $2/log/priority_noref.log

echo "running python $1/greedyFAS.py -q $2/Annotations/Priority_Test_01/ -s $2/Annotations/HUMAN/ -j $2/Test_OUT/priority_ref -r $2/References/HUMAN_9606\@1/ -e 0"
python $1/greedyFAS.py -q $2/Annotations/Priority_Test_01/ -s $2/Annotations/HUMAN/ -j $2/Test_OUT/priority_ref -r $2/References/HUMAN_9606\@1/ -e 0
echo "checking priority_ref.xml"
python $2/compare_FAS_scores.py $2/Result_Templates/priority_ref.xml $2/Test_OUT/priority_ref.xml $2/log/priority_ref.log

echo "##### constraints #####"
echo "running python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/constraints -r $2/References/HUMAN_9606\@1/ -e 0 -x $2/constraints"
python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/constraints -r $2/References/HUMAN_9606\@1/ -e 0 -x $2/constraints
echo "checking constraints.xml"
python $2/compare_FAS_scores.py $2/Result_Templates/constraints.xml $2/Test_OUT/constraints.xml $2/log/constraints.log

echo "##### thresholds #####"
echo "running python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/thresholds -r $2/References/HUMAN_9606\@1/ -e 0 -x $2/constraints -c 40 -w 0.6 0.1 0.3 --classicMS 0 -g log10"
python $1/greedyFAS.py -q $2/Annotations/HUMAN/ -s $2/Annotations/YEAST/ -j $2/Test_OUT/thresholds -r $2/References/HUMAN_9606\@1/ -e 0 -x $2/constraints -c 40 -c 40 -w 0.6 0.1 0.3 --classicMS 0 -g log10
echo "checking thresholds.xml"
python $2/compare_FAS_scores.py $2/Result_Templates/thresholds.xml $2/Test_OUT/thresholds.xml $2/log/thresholds.log

