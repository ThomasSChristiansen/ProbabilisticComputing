
B
Command: %s
53*	vivadotcl2
phys_opt_designZ4-113h px� 

@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2	
xc7z010Z17-347h px� 
o
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2	
xc7z010Z17-349h px� 
R

Starting %s Task
103*constraints2
Initial Update TimingZ18-103h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.076 . Memory (MB): peak = 2044.012 ; gain = 0.000h px� 
�
^PhysOpt_Tcl_Interface Runtime Before Starting Physical Synthesis Task | CPU: %ss |  WALL: %ss
566*	vivadotcl2
0.002
0.09Z4-1435h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

2044.0122
0.000Z17-268h px� 
O

Starting %s Task
103*constraints2
Physical SynthesisZ18-103h px� 
^

Phase %s%s
101*constraints2
1 2#
!Physical Synthesis InitializationZ18-101h px� 
n
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
2Z32-721h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.3362	
-22.946Z32-619h px� 
[
%s*common2B
@Phase 1 Physical Synthesis Initialization | Checksum: 170848edc
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.063 . Memory (MB): peak = 2044.012 ; gain = 0.000h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.3362	
-22.946Z32-619h px� 
V

Phase %s%s
101*constraints2
2 2
DSP Register OptimizationZ18-101h px� 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22
02
net or cell2
02
cell2
02
cell2
02
cellZ32-775h px� 
S
%s*common2:
8Phase 2 DSP Register Optimization | Checksum: 170848edc
h px� 
�

%s
*constraints2a
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.072 . Memory (MB): peak = 2044.012 ; gain = 0.000h px� 
W

Phase %s%s
101*constraints2
3 2
Critical Path OptimizationZ18-101h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.3362	
-22.946Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[0]I_i_reg_n_33_[0]8Z32-702h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2T
'P_bit_instances[2].p_bit_inst/m_i_reg_0'P_bit_instances[2].p_bit_inst/m_i_reg_02
18Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2T
'P_bit_instances[2].p_bit_inst/m_i_reg_0'P_bit_instances[2].p_bit_inst/m_i_reg_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.3302	
-22.087Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[1]I_i_reg_n_33_[1]8Z32-702h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN2
18Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.2762	
-20.737Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_2_n_00P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_2_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_13_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_13_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_9_n_00P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_9_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_22_n_51P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_22_n_58Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_59_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_59_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.2232	
-20.281Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_08Z32-702h px� 
�
+Net %s was not replicated. - no resolution
314*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_08Z32-571h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_41P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_48Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_59_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_59_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_08Z32-702h px� 
�
[Processed net %s. Critical path length was reduced through logic transformation on cell %s.374*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_02j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_comp	2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_comp8Z32-710h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2P
%P_bit_instances[2].p_bit_inst/h[0][6]%P_bit_instances[2].p_bit_inst/h[0][6]8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.2192	
-20.173Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_17_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_17_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
222
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_24_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.2182	
-20.126Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_59_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_59_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
222
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.2062	
-20.030Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_24_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
212
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.2052	
-19.412Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_17_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_17_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
192
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1992	
-19.192Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
222
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_58_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_58_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1792	
-19.012Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_08Z32-702h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_02
18Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1732	
-18.928Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_08Z32-702h px� 
�
[Processed net %s. Critical path length was reduced through logic transformation on cell %s.374*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_02j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_comp	2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_comp8Z32-710h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2P
%P_bit_instances[2].p_bit_inst/h[0][6]%P_bit_instances[2].p_bit_inst/h[0][6]8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1712	
-18.900Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
222
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1482	
-18.430Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_58_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_58_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_n_08Z32-702h px� 
�
[Processed net %s. Critical path length was reduced through logic transformation on cell %s.374*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_n_02j
2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_comp	2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_comp8Z32-710h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1382	
-17.960Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
172
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2r
6P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_0_repN6P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_0_repN8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1082	
-17.720Z32-619h px� 
�
-Processed net %s. Net driver %s was replaced
317*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN2`
-P_bit_instances[2].p_bit_inst/m_i_reg_replica	-P_bit_instances[2].p_bit_inst/m_i_reg_replica8Z32-601h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.1012	
-17.037Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_n_08Z32-702h px� 
�
[Processed net %s. Critical path length was reduced through logic transformation on cell %s.374*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_n_02j
2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_comp	2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_65_comp8Z32-710h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.0892	
-16.667Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_n_08Z32-702h px� 
�
[Processed net %s. Critical path length was reduced through logic transformation on cell %s.374*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_n_02j
2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_comp	2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_66_comp8Z32-710h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.0502	
-15.667Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_19_n_71P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_19_n_78Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_18_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_18_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_31_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_31_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
212
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_78_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_78_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-1.0452	
-15.657Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_08Z32-702h px� 
�
[Processed net %s. Critical path length was reduced through logic transformation on cell %s.374*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_02j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_comp	2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_comp8Z32-710h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2P
%P_bit_instances[2].p_bit_inst/h[0][6]%P_bit_instances[2].p_bit_inst/h[0][6]8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9712	
-14.843Z32-619h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN2
18Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9612	
-14.617Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
262
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_63_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_63_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9572	
-14.449Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_2.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_28Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2P
%P_bit_instances[2].p_bit_inst/p_12_in%P_bit_instances[2].p_bit_inst/p_12_in8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_111_n_02P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_111_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2^
,P_bit_instances[2].p_bit_inst/ADDRARDADDR[7],P_bit_instances[2].p_bit_inst/ADDRARDADDR[7]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clk_IBUFclk_IBUF8Z32-702h px� 
v
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clkclk8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[0]I_i_reg_n_33_[0]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_2.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_28Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_41P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_48Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
192
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9512	
-14.292Z32-619h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_12d
/P_bit_instances[2].p_bit_inst/m_i_reg_replica_1	/P_bit_instances[2].p_bit_inst/m_i_reg_replica_18Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9402	
-14.130Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[1]I_i_reg_n_33_[1]8Z32-702h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN2`
-P_bit_instances[2].p_bit_inst/m_i_reg_replica	-P_bit_instances[2].p_bit_inst/m_i_reg_replica8Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN8Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9282	
-14.000Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9272	
-13.649Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_13_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_13_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_9_n_00P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_9_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_22_n_51P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_22_n_58Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
252
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_27_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_27_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9212	
-13.589Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN8Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_58_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_58_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9212	
-13.589Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_24_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9192	
-13.487Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_59_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_59_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
212
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_67_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.9132	
-13.229Z32-619h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2T
'P_bit_instances[0].p_bit_inst/m_i_reg_0'P_bit_instances[0].p_bit_inst/m_i_reg_02P
%P_bit_instances[0].p_bit_inst/m_i_reg	%P_bit_instances[0].p_bit_inst/m_i_reg8Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2T
'P_bit_instances[0].p_bit_inst/m_i_reg_0'P_bit_instances[0].p_bit_inst/m_i_reg_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8972	
-13.197Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_8_n_00P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_8_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_5_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_19_n_71P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_19_n_78Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_31_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_31_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
232
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_76_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_76_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8922	
-13.159Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_59_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_59_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
182
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8842	
-13.051Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8782	
-12.621Z32-619h px� 
^
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
52
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_26_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_26_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8782	
-12.567Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_18_n_41P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_18_n_48Z32-702h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33_n_02`
-P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33	-P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_338Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8612	
-12.383Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_58_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_58_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8542	
-12.327Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_33_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_69_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2N
$P_bit_instances[2].p_bit_inst/p_9_in$P_bit_instances[2].p_bit_inst/p_9_in8Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_123_n_02P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_123_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8412	
-12.017Z32-619h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
182
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_67_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8262	
-11.883Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2P
%P_bit_instances[2].p_bit_inst/p_15_in%P_bit_instances[2].p_bit_inst/p_15_in8Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
182
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_122_n_02P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_122_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8232	
-11.393Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_76_n_01P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_76_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2N
$P_bit_instances[2].p_bit_inst/p_6_in$P_bit_instances[2].p_bit_inst/p_6_in8Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
342
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_111_n_02P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_111_n_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8182	
-11.343Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_122_n_02P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_122_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_8_0[7]1P_bit_instances[2].p_bit_inst/I_i_reg[1]_i_8_0[7]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clk_IBUFclk_IBUF8Z32-702h px� 
v
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clkclk8Z32-702h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8182	
-11.343Z32-619h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

2044.0122
0.000Z17-268h px� 
T
%s*common2;
9Phase 3 Critical Path Optimization | Checksum: 129599438
h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:07 ; elapsed = 00:00:04 . Memory (MB): peak = 2044.012 ; gain = 0.000h px� 
W

Phase %s%s
101*constraints2
4 2
Critical Path OptimizationZ18-101h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8182	
-11.343Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[1]I_i_reg_n_33_[1]8Z32-702h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_12d
/P_bit_instances[2].p_bit_inst/m_i_reg_replica_1	/P_bit_instances[2].p_bit_inst/m_i_reg_replica_18Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.8012	
-10.491Z32-619h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2T
'P_bit_instances[0].p_bit_inst/m_i_reg_0'P_bit_instances[0].p_bit_inst/m_i_reg_02
18Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2T
'P_bit_instances[0].p_bit_inst/m_i_reg_0'P_bit_instances[0].p_bit_inst/m_i_reg_08Z32-735h px� 
r
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.7922	
-10.401Z32-619h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN2`
-P_bit_instances[2].p_bit_inst/m_i_reg_replica	-P_bit_instances[2].p_bit_inst/m_i_reg_replica8Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2^
,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN,P_bit_instances[2].p_bit_inst/m_i_reg_0_repN8Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.7752
-9.921Z32-619h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2^
,P_bit_instances[0].p_bit_inst/m_i_reg_0_repN,P_bit_instances[0].p_bit_inst/m_i_reg_0_repN2
38Z32-81h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2^
,P_bit_instances[0].p_bit_inst/m_i_reg_0_repN,P_bit_instances[0].p_bit_inst/m_i_reg_0_repN8Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.7132
-9.787Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[0]I_i_reg_n_33_[0]8Z32-702h px� 
�
(Processed net %s.  Re-placed instance %s337*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_12d
/P_bit_instances[2].p_bit_inst/m_i_reg_replica_1	/P_bit_instances[2].p_bit_inst/m_i_reg_replica_18Z32-663h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.6712
-8.815Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_2.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_28Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_08Z32-702h px� 
�
+Net %s was not replicated. - no resolution
314*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_08Z32-571h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_41P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_48Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_17_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_17_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_08Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
242
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_08Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.6652
-8.739Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_66_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2P
%P_bit_instances[2].p_bit_inst/p_15_in%P_bit_instances[2].p_bit_inst/p_15_in8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_121_n_02P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_121_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2^
,P_bit_instances[2].p_bit_inst/ADDRARDADDR[7],P_bit_instances[2].p_bit_inst/ADDRARDADDR[7]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clk_IBUFclk_IBUF8Z32-702h px� 
v
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clkclk8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2&
I_i_reg_n_33_[0]I_i_reg_n_33_[0]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2b
.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_1.P_bit_instances[2].p_bit_inst/m_i_reg_0_repN_18Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_8_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2f
0P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_00P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_5_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_41P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_22_n_48Z32-702h px� 
_
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
192
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_24_n_08Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.6632
-8.239Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_19_n_71P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_19_n_78Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_44_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_44_n_08Z32-702h px� 
^
!Optimized %s %s.  Swapped %s %s.
322*physynth2
12
net2
62
pinsZ32-608h px� 
�
;Processed net %s. Optimization improves timing on the net.
394*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_40_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_40_n_08Z32-735h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.6542
-8.221Z32-619h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2h
1P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_59_n_01P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_59_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2r
6P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_0_repN6P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_65_n_0_repN8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2P
%P_bit_instances[2].p_bit_inst/h[0][6]%P_bit_instances[2].p_bit_inst/h[0][6]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2P
%P_bit_instances[2].p_bit_inst/p_15_in%P_bit_instances[2].p_bit_inst/p_15_in8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2j
2P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_121_n_02P_bit_instances[2].p_bit_inst/I_i_reg[0]_i_121_n_08Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2^
,P_bit_instances[2].p_bit_inst/ADDRARDADDR[7],P_bit_instances[2].p_bit_inst/ADDRARDADDR[7]8Z32-702h px� 
�
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clk_IBUFclk_IBUF8Z32-702h px� 
v
BPorcessed net %s. Optimizations did not improve timing on the net.366*physynth2
clkclk8Z32-702h px� 
q
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2
 2
-0.6542
-8.221Z32-619h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0042

2044.0122
0.000Z17-268h px� 
T
%s*common2;
9Phase 4 Critical Path Optimization | Checksum: 1eccf61f9
h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:05 . Memory (MB): peak = 2044.012 ; gain = 0.000h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

2044.0122
0.000Z17-268h px� 
v
>Post Physical Optimization Timing Summary | WNS=%s | TNS=%s |
318*physynth2
-0.6542
-8.221Z32-603h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�-------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization   |  WNS Gain (ns)  |  TNS Gain (ns)  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  DSP Register   |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Critical Path  |          0.682  |         14.725  |            8  |              0  |                    48  |           0  |           2  |  00:00:05  |
|  Total          |          0.682  |         14.725  |            8  |              0  |                    48  |           0  |           3  |  00:00:05  |
-------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

2044.0122
0.000Z17-268h px� 
P
%s*common27
5Ending Physical Synthesis Task | Checksum: 229bc7bac
h px� 
}

%s
*constraints2]
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:05 . Memory (MB): peak = 2044.012 ; gain = 0.000h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
3332
02
02
0Z4-41h px� 
O
%s completed successfully
29*	vivadotcl2
phys_opt_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
phys_opt_design: 2

00:00:092

00:00:062

2044.0122
0.000Z17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0022

2044.0122
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote PlaceDB: 2

00:00:002
00:00:00.0412

2044.0122
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote PulsedLatchDB: 2

00:00:002

00:00:002

2044.0122
0.000Z17-268h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote RouteStorage: 2

00:00:002
00:00:00.0282

2044.0122
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote Netlist Cache: 2

00:00:002
00:00:00.0012

2044.0122
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Wrote Device Cache: 2

00:00:002
00:00:00.0112

2044.0122
0.000Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write Physdb Complete: 2

00:00:002
00:00:00.0922

2044.0122
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2U
SC:/Users/thoma/Desktop/AND_gate_wip_ver2/AND_gate.runs/impl_1/P_bit_AND_physopt.dcpZ17-1381h px� 


End Record