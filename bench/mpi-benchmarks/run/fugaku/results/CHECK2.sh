#!/bin/bash
#
grep snd-dst\(0\) *.err.1.* >/tmp/SND-DST-0
sed -e 's/.*\[\(.*\)\] .* s-recvidx(\(.*\)) usp.*/\2/' /tmp/SND-DST-0  | sort -n >/tmp/RECVIDX-0
sed -e 's/.*\[\(.*\)\] .* s-recvidx(\(.*\)) usp.*/\2 \1/' /tmp/123  | sort -n >/tmp/RANK-RECVIDX-0
START=`head -n 1 /tmp/RECVIDX-0`
END=`tail -n 1 /tmp/RECVIDX-0`
seq $START $END >/tmp/SEQ
diff /tmp/RECVIDX /tmp/SEQ >/tmp/DIFF-0

#sed -e 's/.*\[\(.*\)\] .* s-recvidx(\(.*\)) usp.*/\2 \1/' /tmp/123  | sort -n
