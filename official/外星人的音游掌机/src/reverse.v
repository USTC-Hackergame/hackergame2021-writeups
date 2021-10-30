// Reading file 'bitstream.rev.asc'..

module chip (input clk, input btn1, output tx, output led, input btn2, input btn3, input btn4);

wire n1;
// (0, 0, 'glb_netwk_0')
// (6, 1, 'sp4_r_v_b_32')
// (6, 2, 'neigh_op_tnr_4')
// (6, 2, 'sp4_r_v_b_21')
// (6, 3, 'neigh_op_rgt_4')
// (6, 3, 'sp4_r_v_b_8')
// (6, 4, 'neigh_op_bnr_4')
// (7, 0, 'fabout')
// (7, 0, 'local_g1_0')
// (7, 0, 'span4_vert_32')
// (7, 1, 'sp4_v_b_32')
// (7, 2, 'lutff_global/s_r')
// (7, 2, 'neigh_op_top_4')
// (7, 2, 'sp4_v_b_21')
// (7, 3, 'lutff_4/out')
// (7, 3, 'sp4_v_b_8')
// (7, 4, 'neigh_op_bot_4')
// (8, 2, 'lutff_global/s_r')
// (8, 2, 'neigh_op_tnl_4')
// (8, 3, 'lutff_global/s_r')
// (8, 3, 'neigh_op_lft_4')
// (8, 4, 'lutff_global/s_r')
// (8, 4, 'neigh_op_bnl_4')

wire n2;
// (0, 0, 'glb_netwk_1')
// (6, 16, 'sp4_r_v_b_36')
// (7, 10, 'lutff_global/cen')
// (7, 14, 'neigh_op_tnr_1')
// (7, 15, 'neigh_op_rgt_1')
// (7, 15, 'sp4_h_r_7')
// (7, 15, 'sp4_v_t_36')
// (7, 16, 'neigh_op_bnr_1')
// (7, 16, 'sp4_v_b_36')
// (7, 17, 'fabout')
// (7, 17, 'local_g0_1')
// (7, 17, 'span4_vert_25')
// (8, 14, 'neigh_op_top_1')
// (8, 15, 'lutff_1/out')
// (8, 15, 'sp4_h_r_18')
// (8, 16, 'neigh_op_bot_1')
// (9, 9, 'lutff_global/cen')
// (9, 14, 'neigh_op_tnl_1')
// (9, 15, 'neigh_op_lft_1')
// (9, 15, 'sp4_h_r_31')
// (9, 16, 'neigh_op_bnl_1')
// (10, 15, 'sp4_h_r_42')
// (11, 7, 'lutff_global/cen')
// (11, 15, 'sp4_h_l_42')

wire n3;
// (0, 0, 'glb_netwk_2')
// (6, 13, 'lutff_global/s_r')
// (6, 16, 'glb2local_1')
// (6, 16, 'local_g0_5')
// (6, 16, 'lutff_0/in_3')
// (7, 10, 'lutff_global/s_r')
// (8, 6, 'neigh_op_tnr_3')
// (8, 7, 'neigh_op_rgt_3')
// (8, 8, 'neigh_op_bnr_3')
// (8, 15, 'glb2local_0')
// (8, 15, 'local_g0_4')
// (8, 15, 'lutff_1/in_3')
// (9, 6, 'neigh_op_top_3')
// (9, 7, 'lutff_3/out')
// (9, 7, 'sp4_h_r_6')
// (9, 8, 'neigh_op_bot_3')
// (9, 9, 'lutff_global/s_r')
// (10, 6, 'neigh_op_tnl_3')
// (10, 7, 'neigh_op_lft_3')
// (10, 7, 'sp4_h_r_19')
// (10, 8, 'neigh_op_bnl_3')
// (11, 7, 'lutff_global/s_r')
// (11, 7, 'sp4_h_r_30')
// (12, 7, 'sp4_h_r_43')
// (13, 7, 'span4_horz_43')
// (13, 7, 'span4_vert_t_15')
// (13, 8, 'span4_vert_b_15')
// (13, 9, 'fabout')
// (13, 9, 'local_g0_3')
// (13, 9, 'span4_vert_b_11')
// (13, 10, 'span4_vert_b_7')
// (13, 11, 'span4_vert_b_3')

wire clk;
// (0, 0, 'glb_netwk_3')
// (0, 5, 'span4_vert_t_14')
// (0, 6, 'span4_vert_b_14')
// (0, 7, 'span4_vert_b_10')
// (0, 8, 'io_1/D_IN_0')
// (0, 8, 'io_1/PAD')
// (0, 8, 'span4_vert_b_6')
// (0, 9, 'fabout')
// (0, 9, 'local_g1_2')
// (0, 9, 'span4_vert_b_2')
// (1, 7, 'neigh_op_tnl_2')
// (1, 7, 'neigh_op_tnl_6')
// (1, 8, 'neigh_op_lft_2')
// (1, 8, 'neigh_op_lft_6')
// (1, 9, 'neigh_op_bnl_2')
// (1, 9, 'neigh_op_bnl_6')
// (5, 5, 'lutff_global/clk')
// (5, 6, 'lutff_global/clk')
// (6, 7, 'lutff_global/clk')
// (6, 8, 'lutff_global/clk')
// (6, 9, 'lutff_global/clk')
// (6, 12, 'lutff_global/clk')
// (6, 13, 'lutff_global/clk')
// (7, 2, 'lutff_global/clk')
// (7, 5, 'lutff_global/clk')
// (7, 7, 'lutff_global/clk')
// (7, 10, 'lutff_global/clk')
// (7, 12, 'lutff_global/clk')
// (7, 13, 'lutff_global/clk')
// (8, 2, 'lutff_global/clk')
// (8, 3, 'lutff_global/clk')
// (8, 4, 'lutff_global/clk')
// (8, 6, 'lutff_global/clk')
// (8, 7, 'lutff_global/clk')
// (9, 7, 'lutff_global/clk')
// (9, 9, 'lutff_global/clk')
// (9, 11, 'lutff_global/clk')
// (9, 12, 'lutff_global/clk')
// (11, 7, 'lutff_global/clk')
// (11, 9, 'lutff_global/clk')

wire n5;
// (0, 0, 'glb_netwk_4')
// (5, 15, 'neigh_op_tnr_0')
// (5, 16, 'neigh_op_rgt_0')
// (5, 17, 'logic_op_bnr_0')
// (6, 12, 'lutff_global/s_r')
// (6, 15, 'neigh_op_top_0')
// (6, 16, 'lutff_0/out')
// (6, 17, 'fabout')
// (6, 17, 'local_g1_0')
// (6, 17, 'logic_op_bot_0')
// (7, 12, 'lutff_global/s_r')
// (7, 13, 'lutff_global/s_r')
// (7, 15, 'neigh_op_tnl_0')
// (7, 16, 'neigh_op_lft_0')
// (7, 17, 'logic_op_bnl_0')

wire n6;
// (0, 0, 'glb_netwk_5')
// (4, 0, 'span4_horz_r_1')
// (5, 0, 'span4_horz_r_5')
// (6, 0, 'fabout')
// (6, 0, 'local_g0_1')
// (6, 0, 'span4_horz_r_9')
// (6, 5, 'glb2local_0')
// (6, 5, 'glb2local_3')
// (6, 5, 'local_g0_4')
// (6, 5, 'local_g0_7')
// (6, 5, 'lutff_1/in_2')
// (6, 5, 'lutff_3/in_3')
// (6, 7, 'lutff_global/cen')
// (6, 8, 'lutff_global/cen')
// (6, 9, 'lutff_global/cen')
// (7, 0, 'span4_horz_r_13')
// (7, 1, 'sp4_r_v_b_31')
// (7, 2, 'sp4_r_v_b_18')
// (7, 3, 'sp4_r_v_b_7')
// (7, 4, 'sp4_r_v_b_46')
// (7, 5, 'sp4_r_v_b_35')
// (7, 6, 'sp4_r_v_b_22')
// (7, 7, 'lutff_global/cen')
// (7, 7, 'sp4_r_v_b_11')
// (7, 10, 'neigh_op_tnr_5')
// (7, 11, 'neigh_op_rgt_5')
// (7, 12, 'neigh_op_bnr_5')
// (8, 0, 'span4_horz_l_13')
// (8, 0, 'span4_vert_31')
// (8, 1, 'sp4_v_b_31')
// (8, 2, 'sp4_v_b_18')
// (8, 3, 'sp4_v_b_7')
// (8, 3, 'sp4_v_t_46')
// (8, 4, 'sp12_v_t_22')
// (8, 4, 'sp4_v_b_46')
// (8, 5, 'sp12_v_b_22')
// (8, 5, 'sp4_v_b_35')
// (8, 6, 'sp12_v_b_21')
// (8, 6, 'sp4_v_b_22')
// (8, 7, 'sp12_v_b_18')
// (8, 7, 'sp4_v_b_11')
// (8, 8, 'sp12_v_b_17')
// (8, 9, 'sp12_v_b_14')
// (8, 10, 'neigh_op_top_5')
// (8, 10, 'sp12_v_b_13')
// (8, 11, 'lutff_5/out')
// (8, 11, 'sp12_v_b_10')
// (8, 12, 'neigh_op_bot_5')
// (8, 12, 'sp12_v_b_9')
// (8, 13, 'sp12_v_b_6')
// (8, 14, 'sp12_v_b_5')
// (8, 15, 'sp12_v_b_2')
// (8, 16, 'sp12_v_b_1')
// (9, 10, 'neigh_op_tnl_5')
// (9, 11, 'neigh_op_lft_5')
// (9, 12, 'neigh_op_bnl_5')

wire n7;
// (0, 0, 'glb_netwk_6')
// (0, 8, 'fabout')
// (0, 8, 'local_g0_1')
// (0, 8, 'span4_horz_1')
// (1, 8, 'sp4_h_r_12')
// (2, 8, 'sp4_h_r_25')
// (3, 8, 'sp4_h_r_36')
// (4, 8, 'sp4_h_l_36')
// (4, 8, 'sp4_h_r_10')
// (5, 7, 'neigh_op_tnr_1')
// (5, 8, 'neigh_op_rgt_1')
// (5, 8, 'sp4_h_r_23')
// (5, 9, 'neigh_op_bnr_1')
// (6, 7, 'lutff_global/s_r')
// (6, 7, 'neigh_op_top_1')
// (6, 8, 'lutff_1/out')
// (6, 8, 'lutff_global/s_r')
// (6, 8, 'sp4_h_r_34')
// (6, 9, 'lutff_global/s_r')
// (6, 9, 'neigh_op_bot_1')
// (7, 7, 'lutff_global/s_r')
// (7, 7, 'neigh_op_tnl_1')
// (7, 8, 'neigh_op_lft_1')
// (7, 8, 'sp4_h_r_47')
// (7, 9, 'neigh_op_bnl_1')
// (8, 8, 'sp4_h_l_47')

wire btn1;
// (0, 0, 'glb_netwk_7')
// (8, 6, 'lutff_global/cen')
// (8, 7, 'lutff_global/cen')
// (9, 0, 'span4_horz_r_2')
// (9, 11, 'lutff_global/cen')
// (9, 12, 'lutff_global/cen')
// (10, 0, 'span4_horz_r_6')
// (11, 0, 'span4_horz_r_10')
// (12, 0, 'span4_horz_r_14')
// (12, 2, 'neigh_op_tnr_2')
// (12, 2, 'neigh_op_tnr_6')
// (12, 3, 'neigh_op_rgt_2')
// (12, 3, 'neigh_op_rgt_6')
// (12, 4, 'neigh_op_bnr_2')
// (12, 4, 'neigh_op_bnr_6')
// (13, 1, 'span4_vert_b_14')
// (13, 2, 'span4_vert_b_10')
// (13, 3, 'io_1/D_IN_0')
// (13, 3, 'io_1/PAD')
// (13, 3, 'span4_vert_b_6')
// (13, 4, 'span4_vert_b_2')
// (13, 4, 'span4_vert_t_14')
// (13, 5, 'span4_vert_b_14')
// (13, 6, 'span4_vert_b_10')
// (13, 7, 'span4_vert_b_6')
// (13, 8, 'fabout')
// (13, 8, 'local_g1_2')
// (13, 8, 'span4_vert_b_2')

wire n9;
// (0, 5, 'span12_horz_7')
// (1, 5, 'sp12_h_r_8')
// (2, 5, 'sp12_h_r_11')
// (3, 5, 'sp12_h_r_12')
// (4, 4, 'neigh_op_tnr_4')
// (4, 5, 'neigh_op_rgt_4')
// (4, 5, 'sp12_h_r_15')
// (4, 6, 'neigh_op_bnr_4')
// (5, 4, 'neigh_op_top_4')
// (5, 5, 'local_g1_4')
// (5, 5, 'lutff_4/out')
// (5, 5, 'lutff_5/in_0')
// (5, 5, 'sp12_h_r_16')
// (5, 6, 'neigh_op_bot_4')
// (6, 4, 'neigh_op_tnl_4')
// (6, 5, 'local_g0_3')
// (6, 5, 'local_g1_3')
// (6, 5, 'lutff_5/in_2')
// (6, 5, 'lutff_7/in_3')
// (6, 5, 'neigh_op_lft_4')
// (6, 5, 'sp12_h_r_19')
// (6, 6, 'neigh_op_bnl_4')
// (7, 5, 'sp12_h_r_20')
// (8, 5, 'sp12_h_r_23')
// (9, 5, 'sp12_h_l_23')

reg n10 = 0;
// (0, 7, 'span12_horz_1')
// (1, 7, 'sp12_h_r_2')
// (2, 7, 'sp12_h_r_5')
// (3, 7, 'sp12_h_r_6')
// (4, 7, 'sp12_h_r_9')
// (5, 7, 'local_g0_2')
// (5, 7, 'local_g1_2')
// (5, 7, 'lutff_0/in_1')
// (5, 7, 'lutff_2/in_2')
// (5, 7, 'lutff_6/in_0')
// (5, 7, 'sp12_h_r_10')
// (5, 8, 'local_g2_5')
// (5, 8, 'lutff_7/in_2')
// (5, 8, 'sp4_r_v_b_37')
// (5, 9, 'local_g1_0')
// (5, 9, 'lutff_0/in_1')
// (5, 9, 'lutff_7/in_0')
// (5, 9, 'sp4_r_v_b_24')
// (5, 10, 'sp4_r_v_b_13')
// (5, 11, 'sp4_r_v_b_0')
// (6, 7, 'local_g1_5')
// (6, 7, 'lutff_4/in_2')
// (6, 7, 'sp12_h_r_13')
// (6, 7, 'sp4_h_r_6')
// (6, 7, 'sp4_v_t_37')
// (6, 8, 'sp4_v_b_37')
// (6, 9, 'local_g2_0')
// (6, 9, 'local_g3_0')
// (6, 9, 'lutff_0/in_0')
// (6, 9, 'lutff_1/in_0')
// (6, 9, 'lutff_5/in_1')
// (6, 9, 'sp4_r_v_b_45')
// (6, 9, 'sp4_v_b_24')
// (6, 10, 'sp4_r_v_b_32')
// (6, 10, 'sp4_v_b_13')
// (6, 11, 'sp4_r_v_b_21')
// (6, 11, 'sp4_v_b_0')
// (6, 12, 'sp4_r_v_b_8')
// (7, 7, 'local_g0_6')
// (7, 7, 'lutff_0/in_2')
// (7, 7, 'lutff_2/in_0')
// (7, 7, 'lutff_5/in_3')
// (7, 7, 'sp12_h_r_14')
// (7, 7, 'sp4_h_r_19')
// (7, 8, 'local_g0_0')
// (7, 8, 'lutff_1/in_1')
// (7, 8, 'lutff_2/in_0')
// (7, 8, 'lutff_4/in_2')
// (7, 8, 'sp4_h_r_8')
// (7, 8, 'sp4_v_t_45')
// (7, 9, 'local_g3_5')
// (7, 9, 'lutff_4/in_2')
// (7, 9, 'lutff_7/in_1')
// (7, 9, 'sp4_v_b_45')
// (7, 10, 'local_g3_0')
// (7, 10, 'lutff_1/in_2')
// (7, 10, 'sp4_v_b_32')
// (7, 11, 'sp4_v_b_21')
// (7, 12, 'sp4_v_b_8')
// (8, 7, 'sp12_h_r_17')
// (8, 7, 'sp4_h_r_30')
// (8, 8, 'sp4_h_r_21')
// (9, 7, 'sp12_h_r_18')
// (9, 7, 'sp4_h_r_43')
// (9, 8, 'sp4_h_r_32')
// (9, 8, 'sp4_r_v_b_43')
// (9, 9, 'local_g0_6')
// (9, 9, 'lutff_1/in_3')
// (9, 9, 'sp4_r_v_b_30')
// (9, 10, 'sp4_r_v_b_19')
// (9, 11, 'sp4_r_v_b_6')
// (10, 5, 'sp4_r_v_b_38')
// (10, 6, 'neigh_op_tnr_7')
// (10, 6, 'sp4_r_v_b_27')
// (10, 7, 'neigh_op_rgt_7')
// (10, 7, 'sp12_h_r_21')
// (10, 7, 'sp4_h_l_43')
// (10, 7, 'sp4_r_v_b_14')
// (10, 7, 'sp4_v_t_43')
// (10, 8, 'neigh_op_bnr_7')
// (10, 8, 'sp4_h_r_45')
// (10, 8, 'sp4_r_v_b_3')
// (10, 8, 'sp4_v_b_43')
// (10, 9, 'sp4_v_b_30')
// (10, 10, 'sp4_v_b_19')
// (10, 11, 'sp4_v_b_6')
// (11, 4, 'sp4_v_t_38')
// (11, 5, 'sp4_v_b_38')
// (11, 6, 'neigh_op_top_7')
// (11, 6, 'sp4_v_b_27')
// (11, 7, 'local_g0_7')
// (11, 7, 'lutff_7/in_2')
// (11, 7, 'lutff_7/out')
// (11, 7, 'sp12_h_r_22')
// (11, 7, 'sp4_v_b_14')
// (11, 8, 'neigh_op_bot_7')
// (11, 8, 'sp4_h_l_45')
// (11, 8, 'sp4_v_b_3')
// (12, 6, 'neigh_op_tnl_7')
// (12, 7, 'neigh_op_lft_7')
// (12, 7, 'sp12_h_l_22')
// (12, 8, 'neigh_op_bnl_7')

wire n11;
// (0, 7, 'span12_horz_3')
// (1, 7, 'sp12_h_r_4')
// (2, 7, 'sp12_h_r_7')
// (3, 7, 'sp12_h_r_8')
// (4, 7, 'sp12_h_r_11')
// (5, 7, 'sp12_h_r_12')
// (6, 6, 'neigh_op_tnr_4')
// (6, 7, 'local_g1_7')
// (6, 7, 'lutff_5/in_3')
// (6, 7, 'neigh_op_rgt_4')
// (6, 7, 'sp12_h_r_15')
// (6, 8, 'neigh_op_bnr_4')
// (7, 6, 'neigh_op_top_4')
// (7, 7, 'lutff_4/out')
// (7, 7, 'sp12_h_r_16')
// (7, 8, 'neigh_op_bot_4')
// (8, 6, 'neigh_op_tnl_4')
// (8, 7, 'neigh_op_lft_4')
// (8, 7, 'sp12_h_r_19')
// (8, 8, 'neigh_op_bnl_4')
// (9, 7, 'sp12_h_r_20')
// (10, 7, 'sp12_h_r_23')
// (11, 7, 'sp12_h_l_23')

wire n12;
// (0, 7, 'span12_horz_5')
// (1, 7, 'sp12_h_r_6')
// (2, 7, 'sp12_h_r_9')
// (3, 7, 'sp12_h_r_10')
// (4, 6, 'neigh_op_tnr_3')
// (4, 7, 'neigh_op_rgt_3')
// (4, 7, 'sp12_h_r_13')
// (4, 8, 'neigh_op_bnr_3')
// (5, 6, 'neigh_op_top_3')
// (5, 7, 'lutff_3/out')
// (5, 7, 'sp12_h_r_14')
// (5, 8, 'neigh_op_bot_3')
// (6, 6, 'neigh_op_tnl_3')
// (6, 7, 'neigh_op_lft_3')
// (6, 7, 'sp12_h_r_17')
// (6, 8, 'neigh_op_bnl_3')
// (7, 7, 'local_g1_2')
// (7, 7, 'lutff_4/in_3')
// (7, 7, 'sp12_h_r_18')
// (8, 7, 'sp12_h_r_21')
// (9, 7, 'sp12_h_r_22')
// (10, 7, 'sp12_h_l_22')

wire n13;
// (0, 8, 'span12_horz_10')
// (1, 8, 'sp12_h_r_13')
// (2, 8, 'sp12_h_r_14')
// (3, 8, 'sp12_h_r_17')
// (4, 8, 'sp12_h_r_18')
// (5, 8, 'sp12_h_r_21')
// (6, 6, 'neigh_op_tnr_1')
// (6, 7, 'local_g3_1')
// (6, 7, 'lutff_1/in_3')
// (6, 7, 'neigh_op_rgt_1')
// (6, 8, 'local_g0_1')
// (6, 8, 'local_g0_6')
// (6, 8, 'lutff_0/in_2')
// (6, 8, 'lutff_4/in_1')
// (6, 8, 'lutff_5/in_2')
// (6, 8, 'neigh_op_bnr_1')
// (6, 8, 'sp12_h_r_22')
// (7, 0, 'span12_vert_14')
// (7, 1, 'sp12_v_b_14')
// (7, 2, 'sp12_v_b_13')
// (7, 3, 'sp12_v_b_10')
// (7, 4, 'sp12_v_b_9')
// (7, 5, 'sp12_v_b_6')
// (7, 6, 'neigh_op_top_1')
// (7, 6, 'sp12_v_b_5')
// (7, 7, 'lutff_1/out')
// (7, 7, 'sp12_v_b_2')
// (7, 8, 'neigh_op_bot_1')
// (7, 8, 'sp12_h_l_22')
// (7, 8, 'sp12_v_b_1')
// (8, 6, 'neigh_op_tnl_1')
// (8, 7, 'neigh_op_lft_1')
// (8, 8, 'neigh_op_bnl_1')

wire n14;
// (0, 8, 'span12_horz_9')
// (1, 8, 'sp12_h_r_10')
// (2, 8, 'sp12_h_r_13')
// (3, 8, 'sp12_h_r_14')
// (4, 7, 'neigh_op_tnr_5')
// (4, 8, 'neigh_op_rgt_5')
// (4, 8, 'sp12_h_r_17')
// (4, 9, 'neigh_op_bnr_5')
// (5, 7, 'neigh_op_top_5')
// (5, 8, 'lutff_5/out')
// (5, 8, 'sp12_h_r_18')
// (5, 9, 'neigh_op_bot_5')
// (6, 7, 'neigh_op_tnl_5')
// (6, 8, 'local_g0_5')
// (6, 8, 'lutff_0/in_1')
// (6, 8, 'neigh_op_lft_5')
// (6, 8, 'sp12_h_r_21')
// (6, 9, 'neigh_op_bnl_5')
// (7, 8, 'local_g1_6')
// (7, 8, 'lutff_2/in_1')
// (7, 8, 'sp12_h_r_22')
// (8, 8, 'sp12_h_l_22')

wire n15;
// (0, 9, 'span12_horz_1')
// (1, 9, 'sp12_h_r_2')
// (2, 9, 'sp12_h_r_5')
// (3, 9, 'sp12_h_r_6')
// (4, 9, 'sp12_h_r_9')
// (5, 9, 'sp12_h_r_10')
// (6, 9, 'sp12_h_r_13')
// (7, 9, 'sp12_h_r_14')
// (8, 7, 'sp4_h_r_4')
// (8, 9, 'sp12_h_r_17')
// (9, 7, 'local_g1_1')
// (9, 7, 'lutff_3/in_3')
// (9, 7, 'sp4_h_r_17')
// (9, 9, 'local_g0_2')
// (9, 9, 'lutff_6/in_2')
// (9, 9, 'sp12_h_r_18')
// (10, 7, 'sp4_h_r_28')
// (10, 9, 'sp12_h_r_21')
// (11, 4, 'sp4_r_v_b_46')
// (11, 5, 'neigh_op_tnr_3')
// (11, 5, 'sp4_r_v_b_35')
// (11, 6, 'neigh_op_rgt_3')
// (11, 6, 'sp4_r_v_b_22')
// (11, 7, 'neigh_op_bnr_3')
// (11, 7, 'sp4_h_r_41')
// (11, 7, 'sp4_r_v_b_11')
// (11, 9, 'sp12_h_r_22')
// (12, 0, 'span12_vert_17')
// (12, 1, 'sp12_v_b_17')
// (12, 2, 'sp12_v_b_14')
// (12, 3, 'sp12_v_b_13')
// (12, 3, 'sp4_v_t_46')
// (12, 4, 'sp12_v_b_10')
// (12, 4, 'sp4_v_b_46')
// (12, 5, 'neigh_op_top_3')
// (12, 5, 'sp12_v_b_9')
// (12, 5, 'sp4_v_b_35')
// (12, 6, 'lutff_3/out')
// (12, 6, 'sp12_v_b_6')
// (12, 6, 'sp4_v_b_22')
// (12, 7, 'neigh_op_bot_3')
// (12, 7, 'sp12_v_b_5')
// (12, 7, 'sp4_h_l_41')
// (12, 7, 'sp4_v_b_11')
// (12, 8, 'sp12_v_b_2')
// (12, 9, 'sp12_h_l_22')
// (12, 9, 'sp12_v_b_1')
// (13, 5, 'logic_op_tnl_3')
// (13, 6, 'logic_op_lft_3')
// (13, 7, 'logic_op_bnl_3')

reg n16 = 0;
// (0, 9, 'span12_horz_10')
// (1, 9, 'sp12_h_r_13')
// (2, 9, 'sp12_h_r_14')
// (3, 8, 'sp4_h_r_7')
// (3, 9, 'sp12_h_r_17')
// (4, 7, 'sp4_h_r_4')
// (4, 8, 'sp4_h_r_18')
// (4, 9, 'sp12_h_r_18')
// (5, 7, 'local_g1_1')
// (5, 7, 'lutff_0/in_2')
// (5, 7, 'lutff_6/in_2')
// (5, 7, 'sp4_h_r_17')
// (5, 8, 'local_g2_7')
// (5, 8, 'local_g3_7')
// (5, 8, 'lutff_3/in_2')
// (5, 8, 'lutff_7/in_1')
// (5, 8, 'sp4_h_r_31')
// (5, 9, 'local_g0_5')
// (5, 9, 'local_g1_5')
// (5, 9, 'lutff_0/in_0')
// (5, 9, 'lutff_6/in_3')
// (5, 9, 'lutff_7/in_2')
// (5, 9, 'sp12_h_r_21')
// (6, 5, 'sp4_r_v_b_42')
// (6, 6, 'sp4_r_v_b_31')
// (6, 7, 'local_g3_2')
// (6, 7, 'lutff_4/in_3')
// (6, 7, 'sp4_h_r_28')
// (6, 7, 'sp4_r_v_b_18')
// (6, 7, 'sp4_r_v_b_43')
// (6, 8, 'sp4_h_r_42')
// (6, 8, 'sp4_r_v_b_30')
// (6, 8, 'sp4_r_v_b_7')
// (6, 9, 'local_g2_3')
// (6, 9, 'local_g3_3')
// (6, 9, 'lutff_0/in_2')
// (6, 9, 'lutff_1/in_1')
// (6, 9, 'lutff_5/in_2')
// (6, 9, 'neigh_op_tnr_3')
// (6, 9, 'sp12_h_r_22')
// (6, 9, 'sp4_r_v_b_19')
// (6, 10, 'neigh_op_rgt_3')
// (6, 10, 'sp4_r_v_b_6')
// (6, 11, 'neigh_op_bnr_3')
// (7, 1, 'sp12_v_t_22')
// (7, 2, 'sp12_v_b_22')
// (7, 3, 'sp12_v_b_21')
// (7, 4, 'sp12_v_b_18')
// (7, 4, 'sp4_v_t_42')
// (7, 5, 'sp12_v_b_17')
// (7, 5, 'sp4_v_b_42')
// (7, 6, 'sp12_v_b_14')
// (7, 6, 'sp4_v_b_31')
// (7, 6, 'sp4_v_t_43')
// (7, 7, 'local_g2_3')
// (7, 7, 'local_g3_3')
// (7, 7, 'lutff_0/in_3')
// (7, 7, 'lutff_2/in_2')
// (7, 7, 'lutff_5/in_1')
// (7, 7, 'sp12_v_b_13')
// (7, 7, 'sp4_h_r_41')
// (7, 7, 'sp4_v_b_18')
// (7, 7, 'sp4_v_b_43')
// (7, 8, 'local_g3_6')
// (7, 8, 'lutff_1/in_0')
// (7, 8, 'lutff_3/in_2')
// (7, 8, 'lutff_4/in_1')
// (7, 8, 'sp12_v_b_10')
// (7, 8, 'sp4_h_l_42')
// (7, 8, 'sp4_r_v_b_47')
// (7, 8, 'sp4_v_b_30')
// (7, 8, 'sp4_v_b_7')
// (7, 9, 'local_g1_3')
// (7, 9, 'local_g2_1')
// (7, 9, 'lutff_4/in_0')
// (7, 9, 'lutff_5/in_3')
// (7, 9, 'lutff_7/in_2')
// (7, 9, 'neigh_op_top_3')
// (7, 9, 'sp12_h_l_22')
// (7, 9, 'sp12_v_b_9')
// (7, 9, 'sp12_v_t_22')
// (7, 9, 'sp4_r_v_b_34')
// (7, 9, 'sp4_v_b_19')
// (7, 10, 'local_g0_3')
// (7, 10, 'lutff_3/in_2')
// (7, 10, 'lutff_3/out')
// (7, 10, 'sp12_v_b_22')
// (7, 10, 'sp12_v_b_6')
// (7, 10, 'sp4_r_v_b_23')
// (7, 10, 'sp4_v_b_6')
// (7, 11, 'neigh_op_bot_3')
// (7, 11, 'sp12_v_b_21')
// (7, 11, 'sp12_v_b_5')
// (7, 11, 'sp4_r_v_b_10')
// (7, 12, 'sp12_v_b_18')
// (7, 12, 'sp12_v_b_2')
// (7, 13, 'sp12_v_b_1')
// (7, 13, 'sp12_v_b_17')
// (7, 14, 'sp12_v_b_14')
// (7, 15, 'sp12_v_b_13')
// (7, 16, 'sp12_v_b_10')
// (7, 17, 'span12_vert_9')
// (8, 7, 'sp4_h_l_41')
// (8, 7, 'sp4_v_t_47')
// (8, 8, 'sp4_v_b_47')
// (8, 9, 'neigh_op_tnl_3')
// (8, 9, 'sp4_v_b_34')
// (8, 10, 'neigh_op_lft_3')
// (8, 10, 'sp4_v_b_23')
// (8, 11, 'neigh_op_bnl_3')
// (8, 11, 'sp4_v_b_10')

reg n17 = 0;
// (0, 9, 'span12_horz_5')
// (1, 9, 'sp12_h_r_6')
// (2, 9, 'sp12_h_r_9')
// (3, 9, 'sp12_h_r_10')
// (4, 9, 'sp12_h_r_13')
// (5, 6, 'sp4_r_v_b_41')
// (5, 6, 'sp4_r_v_b_46')
// (5, 7, 'local_g1_4')
// (5, 7, 'lutff_2/in_3')
// (5, 7, 'lutff_6/in_3')
// (5, 7, 'sp4_r_v_b_28')
// (5, 7, 'sp4_r_v_b_35')
// (5, 8, 'local_g3_1')
// (5, 8, 'local_g3_6')
// (5, 8, 'lutff_1/in_1')
// (5, 8, 'lutff_5/in_3')
// (5, 8, 'lutff_6/in_1')
// (5, 8, 'lutff_7/in_3')
// (5, 8, 'sp4_r_v_b_17')
// (5, 8, 'sp4_r_v_b_22')
// (5, 9, 'local_g0_6')
// (5, 9, 'local_g1_6')
// (5, 9, 'lutff_0/in_3')
// (5, 9, 'lutff_7/in_1')
// (5, 9, 'sp12_h_r_14')
// (5, 9, 'sp4_r_v_b_11')
// (5, 9, 'sp4_r_v_b_4')
// (6, 5, 'sp4_v_t_41')
// (6, 5, 'sp4_v_t_46')
// (6, 6, 'sp4_v_b_41')
// (6, 6, 'sp4_v_b_46')
// (6, 7, 'local_g2_4')
// (6, 7, 'lutff_4/in_0')
// (6, 7, 'sp4_v_b_28')
// (6, 7, 'sp4_v_b_35')
// (6, 8, 'sp4_v_b_17')
// (6, 8, 'sp4_v_b_22')
// (6, 9, 'local_g0_1')
// (6, 9, 'local_g0_3')
// (6, 9, 'local_g1_1')
// (6, 9, 'lutff_0/in_3')
// (6, 9, 'lutff_1/in_2')
// (6, 9, 'lutff_2/in_0')
// (6, 9, 'lutff_5/in_3')
// (6, 9, 'sp12_h_r_17')
// (6, 9, 'sp4_h_r_11')
// (6, 9, 'sp4_v_b_11')
// (6, 9, 'sp4_v_b_4')
// (7, 6, 'sp4_r_v_b_38')
// (7, 6, 'sp4_r_v_b_39')
// (7, 7, 'local_g0_3')
// (7, 7, 'lutff_2/in_3')
// (7, 7, 'lutff_5/in_2')
// (7, 7, 'sp4_r_v_b_26')
// (7, 7, 'sp4_r_v_b_27')
// (7, 8, 'local_g2_6')
// (7, 8, 'local_g2_7')
// (7, 8, 'lutff_1/in_2')
// (7, 8, 'lutff_3/in_0')
// (7, 8, 'lutff_4/in_0')
// (7, 8, 'sp4_r_v_b_14')
// (7, 8, 'sp4_r_v_b_15')
// (7, 9, 'local_g0_2')
// (7, 9, 'local_g1_2')
// (7, 9, 'lutff_3/in_2')
// (7, 9, 'lutff_4/in_1')
// (7, 9, 'lutff_7/in_3')
// (7, 9, 'sp12_h_r_18')
// (7, 9, 'sp4_h_r_22')
// (7, 9, 'sp4_r_v_b_2')
// (7, 9, 'sp4_r_v_b_3')
// (7, 10, 'local_g3_6')
// (7, 10, 'lutff_0/in_1')
// (7, 10, 'sp4_r_v_b_46')
// (7, 11, 'sp4_r_v_b_35')
// (7, 12, 'sp4_r_v_b_22')
// (7, 13, 'sp4_r_v_b_11')
// (8, 5, 'sp4_v_t_38')
// (8, 5, 'sp4_v_t_39')
// (8, 6, 'sp4_v_b_38')
// (8, 6, 'sp4_v_b_39')
// (8, 7, 'sp4_v_b_26')
// (8, 7, 'sp4_v_b_27')
// (8, 8, 'neigh_op_tnr_7')
// (8, 8, 'sp4_v_b_14')
// (8, 8, 'sp4_v_b_15')
// (8, 9, 'neigh_op_rgt_7')
// (8, 9, 'sp12_h_r_21')
// (8, 9, 'sp4_h_r_10')
// (8, 9, 'sp4_h_r_35')
// (8, 9, 'sp4_v_b_2')
// (8, 9, 'sp4_v_b_3')
// (8, 9, 'sp4_v_t_46')
// (8, 10, 'neigh_op_bnr_7')
// (8, 10, 'sp4_v_b_46')
// (8, 11, 'sp4_v_b_35')
// (8, 12, 'sp4_v_b_22')
// (8, 13, 'sp4_v_b_11')
// (9, 8, 'neigh_op_top_7')
// (9, 9, 'local_g0_7')
// (9, 9, 'lutff_4/in_3')
// (9, 9, 'lutff_7/out')
// (9, 9, 'sp12_h_r_22')
// (9, 9, 'sp4_h_r_23')
// (9, 9, 'sp4_h_r_46')
// (9, 10, 'neigh_op_bot_7')
// (10, 8, 'neigh_op_tnl_7')
// (10, 9, 'neigh_op_lft_7')
// (10, 9, 'sp12_h_l_22')
// (10, 9, 'sp4_h_l_46')
// (10, 9, 'sp4_h_r_34')
// (10, 10, 'neigh_op_bnl_7')
// (11, 6, 'sp4_r_v_b_41')
// (11, 7, 'local_g0_4')
// (11, 7, 'lutff_7/in_3')
// (11, 7, 'sp4_r_v_b_28')
// (11, 8, 'sp4_r_v_b_17')
// (11, 9, 'sp4_h_r_47')
// (11, 9, 'sp4_r_v_b_4')
// (12, 5, 'sp4_v_t_41')
// (12, 6, 'sp4_v_b_41')
// (12, 7, 'sp4_v_b_28')
// (12, 8, 'sp4_v_b_17')
// (12, 9, 'sp4_h_l_47')
// (12, 9, 'sp4_v_b_4')

wire tx;
// (0, 11, 'io_1/D_OUT_0')
// (0, 11, 'io_1/PAD')
// (0, 11, 'local_g0_1')
// (0, 11, 'span4_horz_41')
// (1, 11, 'sp4_h_l_41')
// (1, 11, 'sp4_h_r_8')
// (2, 11, 'sp4_h_r_21')
// (3, 11, 'sp4_h_r_32')
// (4, 8, 'sp4_r_v_b_38')
// (4, 9, 'neigh_op_tnr_7')
// (4, 9, 'sp4_r_v_b_27')
// (4, 10, 'neigh_op_rgt_7')
// (4, 10, 'sp4_r_v_b_14')
// (4, 11, 'neigh_op_bnr_7')
// (4, 11, 'sp4_h_r_45')
// (4, 11, 'sp4_r_v_b_3')
// (5, 7, 'sp4_v_t_38')
// (5, 8, 'sp4_v_b_38')
// (5, 9, 'neigh_op_top_7')
// (5, 9, 'sp4_v_b_27')
// (5, 10, 'lutff_7/out')
// (5, 10, 'sp4_v_b_14')
// (5, 11, 'neigh_op_bot_7')
// (5, 11, 'sp4_h_l_45')
// (5, 11, 'sp4_v_b_3')
// (6, 9, 'neigh_op_tnl_7')
// (6, 10, 'neigh_op_lft_7')
// (6, 11, 'neigh_op_bnl_7')

wire n19;
// (0, 12, 'span12_horz_2')
// (1, 12, 'sp12_h_r_5')
// (2, 12, 'sp12_h_r_6')
// (3, 12, 'sp12_h_r_9')
// (4, 12, 'sp12_h_r_10')
// (5, 11, 'neigh_op_tnr_3')
// (5, 12, 'neigh_op_rgt_3')
// (5, 12, 'sp12_h_r_13')
// (5, 12, 'sp4_h_r_11')
// (5, 13, 'neigh_op_bnr_3')
// (6, 11, 'neigh_op_top_3')
// (6, 12, 'lutff_3/out')
// (6, 12, 'sp12_h_r_14')
// (6, 12, 'sp4_h_r_22')
// (6, 13, 'neigh_op_bot_3')
// (7, 11, 'neigh_op_tnl_3')
// (7, 12, 'neigh_op_lft_3')
// (7, 12, 'sp12_h_r_17')
// (7, 12, 'sp4_h_r_35')
// (7, 13, 'neigh_op_bnl_3')
// (8, 12, 'local_g1_2')
// (8, 12, 'lutff_5/in_0')
// (8, 12, 'sp12_h_r_18')
// (8, 12, 'sp4_h_r_46')
// (8, 13, 'local_g3_1')
// (8, 13, 'lutff_3/in_3')
// (8, 13, 'sp4_r_v_b_41')
// (8, 14, 'sp4_r_v_b_28')
// (8, 15, 'sp4_r_v_b_17')
// (8, 16, 'sp4_r_v_b_4')
// (9, 12, 'sp12_h_r_21')
// (9, 12, 'sp4_h_l_46')
// (9, 12, 'sp4_v_t_41')
// (9, 13, 'sp4_v_b_41')
// (9, 14, 'sp4_v_b_28')
// (9, 15, 'sp4_v_b_17')
// (9, 16, 'sp4_v_b_4')
// (10, 12, 'sp12_h_r_22')
// (11, 12, 'sp12_h_l_22')

wire n20;
// (0, 13, 'span12_horz_6')
// (1, 13, 'sp12_h_r_9')
// (2, 13, 'sp12_h_r_10')
// (3, 13, 'sp12_h_r_13')
// (4, 13, 'sp12_h_r_14')
// (5, 13, 'sp12_h_r_17')
// (6, 13, 'sp12_h_r_18')
// (7, 12, 'neigh_op_tnr_7')
// (7, 13, 'neigh_op_rgt_7')
// (7, 13, 'sp12_h_r_21')
// (7, 14, 'neigh_op_bnr_7')
// (8, 12, 'neigh_op_top_7')
// (8, 13, 'local_g0_6')
// (8, 13, 'lutff_5/in_3')
// (8, 13, 'lutff_7/out')
// (8, 13, 'sp12_h_r_22')
// (8, 14, 'neigh_op_bot_7')
// (9, 12, 'neigh_op_tnl_7')
// (9, 13, 'neigh_op_lft_7')
// (9, 13, 'sp12_h_l_22')
// (9, 14, 'neigh_op_bnl_7')

wire n21;
// (1, 13, 'sp12_h_r_1')
// (2, 13, 'sp12_h_r_2')
// (3, 13, 'sp12_h_r_5')
// (4, 13, 'sp12_h_r_6')
// (4, 16, 'sp4_h_r_8')
// (5, 13, 'sp12_h_r_9')
// (5, 16, 'sp4_h_r_21')
// (6, 13, 'local_g1_2')
// (6, 13, 'lutff_7/in_2')
// (6, 13, 'sp12_h_r_10')
// (6, 16, 'local_g2_0')
// (6, 16, 'lutff_0/in_2')
// (6, 16, 'sp4_h_r_32')
// (7, 12, 'neigh_op_tnr_3')
// (7, 13, 'neigh_op_rgt_3')
// (7, 13, 'sp12_h_r_13')
// (7, 13, 'sp4_r_v_b_38')
// (7, 14, 'neigh_op_bnr_3')
// (7, 14, 'sp4_r_v_b_27')
// (7, 15, 'sp4_r_v_b_14')
// (7, 16, 'sp4_h_r_45')
// (7, 16, 'sp4_r_v_b_3')
// (8, 12, 'neigh_op_top_3')
// (8, 12, 'sp4_v_t_38')
// (8, 13, 'lutff_3/out')
// (8, 13, 'sp12_h_r_14')
// (8, 13, 'sp4_v_b_38')
// (8, 14, 'neigh_op_bot_3')
// (8, 14, 'sp4_v_b_27')
// (8, 15, 'local_g1_6')
// (8, 15, 'lutff_1/in_2')
// (8, 15, 'sp4_v_b_14')
// (8, 16, 'sp4_h_l_45')
// (8, 16, 'sp4_v_b_3')
// (9, 12, 'neigh_op_tnl_3')
// (9, 13, 'neigh_op_lft_3')
// (9, 13, 'sp12_h_r_17')
// (9, 14, 'neigh_op_bnl_3')
// (10, 13, 'sp12_h_r_18')
// (11, 13, 'sp12_h_r_21')
// (12, 13, 'sp12_h_r_22')
// (13, 13, 'span12_horz_22')

wire n22;
// (2, 5, 'sp4_h_r_8')
// (3, 5, 'sp4_h_r_21')
// (4, 4, 'neigh_op_tnr_1')
// (4, 5, 'neigh_op_rgt_1')
// (4, 5, 'sp4_h_r_32')
// (4, 5, 'sp4_h_r_7')
// (4, 6, 'neigh_op_bnr_1')
// (5, 2, 'sp4_r_v_b_38')
// (5, 3, 'sp4_r_v_b_27')
// (5, 4, 'neigh_op_top_1')
// (5, 4, 'sp4_r_v_b_14')
// (5, 5, 'local_g0_1')
// (5, 5, 'local_g3_5')
// (5, 5, 'lutff_1/out')
// (5, 5, 'lutff_3/in_2')
// (5, 5, 'lutff_global/s_r')
// (5, 5, 'sp4_h_r_18')
// (5, 5, 'sp4_h_r_45')
// (5, 5, 'sp4_r_v_b_3')
// (5, 6, 'neigh_op_bot_1')
// (6, 1, 'sp4_v_t_38')
// (6, 2, 'sp4_v_b_38')
// (6, 3, 'sp4_v_b_27')
// (6, 4, 'neigh_op_tnl_1')
// (6, 4, 'sp4_v_b_14')
// (6, 5, 'local_g0_1')
// (6, 5, 'lutff_1/in_0')
// (6, 5, 'neigh_op_lft_1')
// (6, 5, 'sp4_h_l_45')
// (6, 5, 'sp4_h_r_31')
// (6, 5, 'sp4_v_b_3')
// (6, 6, 'neigh_op_bnl_1')
// (7, 5, 'sp4_h_r_42')
// (7, 6, 'sp4_r_v_b_42')
// (7, 7, 'sp4_r_v_b_31')
// (7, 8, 'sp4_r_v_b_18')
// (7, 9, 'sp4_r_v_b_7')
// (7, 10, 'sp4_r_v_b_42')
// (7, 11, 'sp4_r_v_b_31')
// (7, 12, 'sp4_r_v_b_18')
// (7, 13, 'sp4_r_v_b_7')
// (8, 5, 'sp4_h_l_42')
// (8, 5, 'sp4_v_t_42')
// (8, 6, 'sp4_v_b_42')
// (8, 7, 'sp4_v_b_31')
// (8, 8, 'sp4_v_b_18')
// (8, 9, 'sp4_v_b_7')
// (8, 9, 'sp4_v_t_42')
// (8, 10, 'sp4_v_b_42')
// (8, 11, 'sp4_v_b_31')
// (8, 12, 'local_g0_2')
// (8, 12, 'lutff_5/in_1')
// (8, 12, 'sp4_v_b_18')
// (8, 13, 'sp4_v_b_7')

wire n23;
// (2, 6, 'sp4_h_r_5')
// (3, 6, 'sp4_h_r_16')
// (4, 6, 'sp4_h_r_29')
// (4, 7, 'sp4_r_v_b_47')
// (4, 8, 'sp4_r_v_b_34')
// (4, 9, 'sp4_r_v_b_23')
// (4, 10, 'sp4_r_v_b_10')
// (5, 6, 'sp4_h_r_40')
// (5, 6, 'sp4_v_t_47')
// (5, 7, 'local_g3_7')
// (5, 7, 'lutff_3/in_3')
// (5, 7, 'lutff_7/in_1')
// (5, 7, 'sp4_r_v_b_37')
// (5, 7, 'sp4_r_v_b_40')
// (5, 7, 'sp4_r_v_b_47')
// (5, 7, 'sp4_v_b_47')
// (5, 8, 'local_g3_2')
// (5, 8, 'lutff_5/in_2')
// (5, 8, 'lutff_6/in_3')
// (5, 8, 'sp4_r_v_b_24')
// (5, 8, 'sp4_r_v_b_29')
// (5, 8, 'sp4_r_v_b_34')
// (5, 8, 'sp4_v_b_34')
// (5, 9, 'local_g1_7')
// (5, 9, 'lutff_1/in_3')
// (5, 9, 'sp4_r_v_b_13')
// (5, 9, 'sp4_r_v_b_16')
// (5, 9, 'sp4_r_v_b_23')
// (5, 9, 'sp4_v_b_23')
// (5, 10, 'sp4_h_r_5')
// (5, 10, 'sp4_r_v_b_0')
// (5, 10, 'sp4_r_v_b_10')
// (5, 10, 'sp4_r_v_b_5')
// (5, 10, 'sp4_v_b_10')
// (6, 6, 'sp4_h_l_40')
// (6, 6, 'sp4_v_t_37')
// (6, 6, 'sp4_v_t_40')
// (6, 6, 'sp4_v_t_47')
// (6, 7, 'local_g2_5')
// (6, 7, 'lutff_0/in_3')
// (6, 7, 'sp4_v_b_37')
// (6, 7, 'sp4_v_b_40')
// (6, 7, 'sp4_v_b_47')
// (6, 8, 'local_g3_5')
// (6, 8, 'lutff_2/in_2')
// (6, 8, 'sp4_v_b_24')
// (6, 8, 'sp4_v_b_29')
// (6, 8, 'sp4_v_b_34')
// (6, 9, 'local_g0_0')
// (6, 9, 'local_g0_7')
// (6, 9, 'lutff_3/in_2')
// (6, 9, 'lutff_4/in_2')
// (6, 9, 'sp4_v_b_13')
// (6, 9, 'sp4_v_b_16')
// (6, 9, 'sp4_v_b_23')
// (6, 10, 'sp4_h_r_0')
// (6, 10, 'sp4_h_r_16')
// (6, 10, 'sp4_v_b_0')
// (6, 10, 'sp4_v_b_10')
// (6, 10, 'sp4_v_b_5')
// (7, 6, 'sp4_r_v_b_36')
// (7, 7, 'local_g0_1')
// (7, 7, 'local_g3_5')
// (7, 7, 'lutff_1/in_2')
// (7, 7, 'lutff_3/in_1')
// (7, 7, 'sp4_r_v_b_25')
// (7, 7, 'sp4_r_v_b_45')
// (7, 8, 'sp4_r_v_b_12')
// (7, 8, 'sp4_r_v_b_32')
// (7, 9, 'local_g3_4')
// (7, 9, 'lutff_3/in_0')
// (7, 9, 'neigh_op_tnr_4')
// (7, 9, 'sp4_r_v_b_1')
// (7, 9, 'sp4_r_v_b_21')
// (7, 10, 'neigh_op_rgt_4')
// (7, 10, 'sp4_h_r_13')
// (7, 10, 'sp4_h_r_29')
// (7, 10, 'sp4_r_v_b_40')
// (7, 10, 'sp4_r_v_b_8')
// (7, 11, 'neigh_op_bnr_4')
// (7, 11, 'sp4_r_v_b_29')
// (7, 12, 'sp4_r_v_b_16')
// (7, 13, 'sp4_r_v_b_5')
// (8, 5, 'sp4_v_t_36')
// (8, 6, 'sp4_v_b_36')
// (8, 6, 'sp4_v_t_45')
// (8, 7, 'sp4_v_b_25')
// (8, 7, 'sp4_v_b_45')
// (8, 8, 'sp4_v_b_12')
// (8, 8, 'sp4_v_b_32')
// (8, 9, 'neigh_op_top_4')
// (8, 9, 'sp4_v_b_1')
// (8, 9, 'sp4_v_b_21')
// (8, 9, 'sp4_v_t_40')
// (8, 10, 'lutff_4/out')
// (8, 10, 'sp4_h_r_24')
// (8, 10, 'sp4_h_r_40')
// (8, 10, 'sp4_v_b_40')
// (8, 10, 'sp4_v_b_8')
// (8, 11, 'neigh_op_bot_4')
// (8, 11, 'sp4_v_b_29')
// (8, 12, 'sp4_v_b_16')
// (8, 13, 'sp4_v_b_5')
// (9, 9, 'neigh_op_tnl_4')
// (9, 10, 'neigh_op_lft_4')
// (9, 10, 'sp4_h_l_40')
// (9, 10, 'sp4_h_r_37')
// (9, 11, 'neigh_op_bnl_4')
// (10, 10, 'sp4_h_l_37')

wire n24;
// (3, 5, 'sp4_h_r_11')
// (4, 5, 'sp4_h_r_22')
// (5, 4, 'neigh_op_tnr_7')
// (5, 5, 'neigh_op_rgt_7')
// (5, 5, 'sp4_h_r_35')
// (5, 6, 'neigh_op_bnr_7')
// (6, 2, 'sp4_r_v_b_40')
// (6, 3, 'sp4_r_v_b_29')
// (6, 4, 'neigh_op_top_7')
// (6, 4, 'sp4_r_v_b_16')
// (6, 5, 'lutff_7/out')
// (6, 5, 'sp4_h_r_46')
// (6, 5, 'sp4_r_v_b_5')
// (6, 6, 'neigh_op_bot_7')
// (7, 1, 'sp4_v_t_40')
// (7, 2, 'sp4_v_b_40')
// (7, 3, 'sp4_v_b_29')
// (7, 4, 'neigh_op_tnl_7')
// (7, 4, 'sp4_v_b_16')
// (7, 5, 'local_g1_5')
// (7, 5, 'lutff_global/s_r')
// (7, 5, 'neigh_op_lft_7')
// (7, 5, 'sp4_h_l_46')
// (7, 5, 'sp4_v_b_5')
// (7, 6, 'neigh_op_bnl_7')

wire n25;
// (3, 5, 'sp4_h_r_8')
// (4, 5, 'sp4_h_r_21')
// (5, 5, 'sp4_h_r_32')
// (6, 2, 'neigh_op_tnr_0')
// (6, 2, 'sp4_r_v_b_45')
// (6, 3, 'neigh_op_rgt_0')
// (6, 3, 'sp4_r_v_b_32')
// (6, 4, 'neigh_op_bnr_0')
// (6, 4, 'sp4_r_v_b_21')
// (6, 5, 'local_g2_0')
// (6, 5, 'local_g2_5')
// (6, 5, 'lutff_0/in_3')
// (6, 5, 'lutff_5/in_1')
// (6, 5, 'sp4_h_r_45')
// (6, 5, 'sp4_r_v_b_8')
// (7, 1, 'sp4_v_t_45')
// (7, 2, 'neigh_op_top_0')
// (7, 2, 'sp4_v_b_45')
// (7, 3, 'lutff_0/out')
// (7, 3, 'sp4_v_b_32')
// (7, 4, 'neigh_op_bot_0')
// (7, 4, 'sp4_v_b_21')
// (7, 5, 'sp4_h_l_45')
// (7, 5, 'sp4_v_b_8')
// (8, 2, 'neigh_op_tnl_0')
// (8, 3, 'neigh_op_lft_0')
// (8, 4, 'neigh_op_bnl_0')

wire n26;
// (3, 8, 'sp12_h_r_0')
// (4, 8, 'sp12_h_r_3')
// (5, 8, 'sp12_h_r_4')
// (6, 6, 'sp4_r_v_b_40')
// (6, 7, 'local_g0_5')
// (6, 7, 'lutff_2/in_3')
// (6, 7, 'neigh_op_tnr_0')
// (6, 7, 'sp4_r_v_b_29')
// (6, 8, 'local_g1_7')
// (6, 8, 'lutff_3/in_3')
// (6, 8, 'neigh_op_rgt_0')
// (6, 8, 'sp12_h_r_7')
// (6, 8, 'sp4_r_v_b_16')
// (6, 9, 'neigh_op_bnr_0')
// (6, 9, 'sp4_r_v_b_5')
// (7, 5, 'sp4_v_t_40')
// (7, 6, 'sp4_v_b_40')
// (7, 7, 'neigh_op_top_0')
// (7, 7, 'sp4_v_b_29')
// (7, 8, 'local_g2_0')
// (7, 8, 'lutff_0/out')
// (7, 8, 'lutff_7/in_3')
// (7, 8, 'sp12_h_r_8')
// (7, 8, 'sp4_v_b_16')
// (7, 9, 'neigh_op_bot_0')
// (7, 9, 'sp4_v_b_5')
// (8, 7, 'neigh_op_tnl_0')
// (8, 8, 'neigh_op_lft_0')
// (8, 8, 'sp12_h_r_11')
// (8, 9, 'neigh_op_bnl_0')
// (9, 8, 'sp12_h_r_12')
// (10, 8, 'sp12_h_r_15')
// (11, 8, 'sp12_h_r_16')
// (12, 8, 'sp12_h_r_19')
// (13, 8, 'span12_horz_19')

wire n27;
// (3, 8, 'sp4_h_r_10')
// (4, 7, 'neigh_op_tnr_1')
// (4, 8, 'neigh_op_rgt_1')
// (4, 8, 'sp4_h_r_23')
// (4, 9, 'neigh_op_bnr_1')
// (5, 7, 'neigh_op_top_1')
// (5, 8, 'local_g2_1')
// (5, 8, 'local_g2_2')
// (5, 8, 'lutff_1/out')
// (5, 8, 'lutff_2/in_1')
// (5, 8, 'lutff_4/in_2')
// (5, 8, 'sp4_h_r_34')
// (5, 9, 'neigh_op_bot_1')
// (6, 7, 'neigh_op_tnl_1')
// (6, 8, 'neigh_op_lft_1')
// (6, 8, 'sp4_h_r_47')
// (6, 9, 'neigh_op_bnl_1')
// (7, 8, 'sp4_h_l_47')

wire n28;
// (4, 3, 'sp4_r_v_b_40')
// (4, 4, 'sp4_r_v_b_29')
// (4, 5, 'neigh_op_tnr_3')
// (4, 5, 'sp4_r_v_b_16')
// (4, 6, 'neigh_op_rgt_3')
// (4, 6, 'sp4_r_v_b_5')
// (4, 7, 'neigh_op_bnr_3')
// (5, 0, 'span12_vert_17')
// (5, 1, 'sp12_v_b_17')
// (5, 2, 'sp12_v_b_14')
// (5, 2, 'sp4_v_t_40')
// (5, 3, 'sp12_v_b_13')
// (5, 3, 'sp4_v_b_40')
// (5, 4, 'sp12_v_b_10')
// (5, 4, 'sp4_v_b_29')
// (5, 5, 'neigh_op_top_3')
// (5, 5, 'sp12_v_b_9')
// (5, 5, 'sp4_v_b_16')
// (5, 6, 'local_g1_5')
// (5, 6, 'lutff_3/out')
// (5, 6, 'lutff_global/s_r')
// (5, 6, 'sp12_v_b_6')
// (5, 6, 'sp4_v_b_5')
// (5, 7, 'neigh_op_bot_3')
// (5, 7, 'sp12_v_b_5')
// (5, 8, 'sp12_v_b_2')
// (5, 9, 'sp12_v_b_1')
// (6, 5, 'neigh_op_tnl_3')
// (6, 6, 'neigh_op_lft_3')
// (6, 7, 'neigh_op_bnl_3')

wire n29;
// (4, 4, 'neigh_op_tnr_3')
// (4, 5, 'neigh_op_rgt_3')
// (4, 6, 'neigh_op_bnr_3')
// (5, 4, 'neigh_op_top_3')
// (5, 5, 'lutff_3/out')
// (5, 6, 'local_g1_3')
// (5, 6, 'lutff_global/cen')
// (5, 6, 'neigh_op_bot_3')
// (6, 4, 'neigh_op_tnl_3')
// (6, 5, 'neigh_op_lft_3')
// (6, 6, 'neigh_op_bnl_3')

reg n30 = 0;
// (4, 4, 'neigh_op_tnr_5')
// (4, 5, 'neigh_op_rgt_5')
// (4, 6, 'neigh_op_bnr_5')
// (5, 4, 'neigh_op_top_5')
// (5, 5, 'local_g0_5')
// (5, 5, 'local_g1_5')
// (5, 5, 'lutff_1/in_2')
// (5, 5, 'lutff_4/in_2')
// (5, 5, 'lutff_5/out')
// (5, 5, 'lutff_7/in_2')
// (5, 5, 'sp4_r_v_b_43')
// (5, 6, 'local_g0_6')
// (5, 6, 'lutff_7/in_1')
// (5, 6, 'neigh_op_bot_5')
// (5, 6, 'sp4_r_v_b_30')
// (5, 7, 'sp4_r_v_b_19')
// (5, 8, 'sp4_r_v_b_6')
// (6, 4, 'neigh_op_tnl_5')
// (6, 4, 'sp4_v_t_43')
// (6, 5, 'neigh_op_lft_5')
// (6, 5, 'sp4_v_b_43')
// (6, 6, 'neigh_op_bnl_5')
// (6, 6, 'sp4_v_b_30')
// (6, 7, 'sp4_v_b_19')
// (6, 8, 'sp4_v_b_6')

reg n31 = 0;
// (4, 4, 'neigh_op_tnr_7')
// (4, 5, 'neigh_op_rgt_7')
// (4, 6, 'neigh_op_bnr_7')
// (5, 4, 'neigh_op_top_7')
// (5, 5, 'local_g0_7')
// (5, 5, 'local_g1_7')
// (5, 5, 'lutff_1/in_3')
// (5, 5, 'lutff_4/in_3')
// (5, 5, 'lutff_7/in_3')
// (5, 5, 'lutff_7/out')
// (5, 6, 'local_g1_7')
// (5, 6, 'lutff_3/in_3')
// (5, 6, 'lutff_7/in_3')
// (5, 6, 'neigh_op_bot_7')
// (6, 4, 'neigh_op_tnl_7')
// (6, 5, 'neigh_op_lft_7')
// (6, 6, 'neigh_op_bnl_7')

reg n32 = 0;
// (4, 5, 'neigh_op_tnr_7')
// (4, 6, 'neigh_op_rgt_7')
// (4, 7, 'neigh_op_bnr_7')
// (5, 1, 'sp12_v_t_22')
// (5, 2, 'sp12_v_b_22')
// (5, 3, 'sp12_v_b_21')
// (5, 4, 'sp12_v_b_18')
// (5, 5, 'neigh_op_top_7')
// (5, 5, 'sp12_v_b_17')
// (5, 6, 'lutff_7/out')
// (5, 6, 'sp12_v_b_14')
// (5, 7, 'neigh_op_bot_7')
// (5, 7, 'sp12_v_b_13')
// (5, 8, 'sp12_v_b_10')
// (5, 9, 'sp12_v_b_9')
// (5, 10, 'local_g2_6')
// (5, 10, 'lutff_7/in_3')
// (5, 10, 'sp12_v_b_6')
// (5, 11, 'sp12_v_b_5')
// (5, 12, 'sp12_v_b_2')
// (5, 13, 'sp12_v_b_1')
// (6, 5, 'neigh_op_tnl_7')
// (6, 6, 'neigh_op_lft_7')
// (6, 7, 'neigh_op_bnl_7')

wire n33;
// (4, 6, 'neigh_op_tnr_0')
// (4, 7, 'neigh_op_rgt_0')
// (4, 8, 'neigh_op_bnr_0')
// (5, 6, 'neigh_op_top_0')
// (5, 7, 'local_g1_0')
// (5, 7, 'local_g2_0')
// (5, 7, 'lutff_0/out')
// (5, 7, 'lutff_3/in_2')
// (5, 7, 'lutff_5/in_3')
// (5, 8, 'neigh_op_bot_0')
// (6, 6, 'neigh_op_tnl_0')
// (6, 7, 'neigh_op_lft_0')
// (6, 8, 'neigh_op_bnl_0')

wire n34;
// (4, 6, 'neigh_op_tnr_1')
// (4, 7, 'neigh_op_rgt_1')
// (4, 8, 'neigh_op_bnr_1')
// (5, 6, 'neigh_op_top_1')
// (5, 7, 'lutff_1/out')
// (5, 8, 'neigh_op_bot_1')
// (6, 6, 'neigh_op_tnl_1')
// (6, 7, 'local_g0_1')
// (6, 7, 'lutff_1/in_2')
// (6, 7, 'neigh_op_lft_1')
// (6, 8, 'local_g3_1')
// (6, 8, 'lutff_4/in_0')
// (6, 8, 'neigh_op_bnl_1')

wire n35;
// (4, 6, 'neigh_op_tnr_2')
// (4, 7, 'neigh_op_rgt_2')
// (4, 8, 'neigh_op_bnr_2')
// (5, 6, 'neigh_op_top_2')
// (5, 7, 'local_g2_2')
// (5, 7, 'lutff_1/in_3')
// (5, 7, 'lutff_2/out')
// (5, 7, 'lutff_5/in_1')
// (5, 8, 'neigh_op_bot_2')
// (6, 6, 'neigh_op_tnl_2')
// (6, 7, 'neigh_op_lft_2')
// (6, 8, 'neigh_op_bnl_2')

wire n36;
// (4, 6, 'neigh_op_tnr_4')
// (4, 7, 'neigh_op_rgt_4')
// (4, 8, 'neigh_op_bnr_4')
// (5, 6, 'neigh_op_top_4')
// (5, 7, 'local_g0_4')
// (5, 7, 'lutff_4/out')
// (5, 7, 'lutff_7/in_3')
// (5, 8, 'neigh_op_bot_4')
// (6, 6, 'neigh_op_tnl_4')
// (6, 7, 'neigh_op_lft_4')
// (6, 8, 'local_g3_4')
// (6, 8, 'lutff_7/in_0')
// (6, 8, 'neigh_op_bnl_4')

wire n37;
// (4, 6, 'neigh_op_tnr_5')
// (4, 7, 'neigh_op_rgt_5')
// (4, 8, 'neigh_op_bnr_5')
// (5, 6, 'neigh_op_top_5')
// (5, 7, 'local_g2_5')
// (5, 7, 'lutff_5/out')
// (5, 7, 'lutff_7/in_2')
// (5, 8, 'neigh_op_bot_5')
// (6, 6, 'neigh_op_tnl_5')
// (6, 7, 'neigh_op_lft_5')
// (6, 8, 'neigh_op_bnl_5')

wire n38;
// (4, 6, 'neigh_op_tnr_6')
// (4, 7, 'neigh_op_rgt_6')
// (4, 8, 'neigh_op_bnr_6')
// (5, 6, 'neigh_op_top_6')
// (5, 7, 'local_g0_6')
// (5, 7, 'local_g1_6')
// (5, 7, 'lutff_3/in_1')
// (5, 7, 'lutff_4/in_3')
// (5, 7, 'lutff_6/out')
// (5, 8, 'neigh_op_bot_6')
// (6, 6, 'neigh_op_tnl_6')
// (6, 7, 'local_g0_6')
// (6, 7, 'lutff_0/in_0')
// (6, 7, 'neigh_op_lft_6')
// (6, 8, 'neigh_op_bnl_6')

wire n39;
// (4, 6, 'neigh_op_tnr_7')
// (4, 7, 'neigh_op_rgt_7')
// (4, 8, 'neigh_op_bnr_7')
// (5, 6, 'neigh_op_top_7')
// (5, 7, 'lutff_7/out')
// (5, 8, 'neigh_op_bot_7')
// (6, 6, 'neigh_op_tnl_7')
// (6, 7, 'local_g0_7')
// (6, 7, 'lutff_6/in_3')
// (6, 7, 'neigh_op_lft_7')
// (6, 8, 'neigh_op_bnl_7')

wire n40;
// (4, 6, 'sp4_h_r_10')
// (5, 6, 'sp4_h_r_23')
// (6, 6, 'sp4_h_r_34')
// (7, 6, 'sp4_h_r_47')
// (7, 7, 'local_g3_1')
// (7, 7, 'lutff_4/in_2')
// (7, 7, 'sp4_r_v_b_38')
// (7, 7, 'sp4_r_v_b_41')
// (7, 8, 'local_g0_3')
// (7, 8, 'lutff_0/in_3')
// (7, 8, 'lutff_6/in_1')
// (7, 8, 'sp4_r_v_b_27')
// (7, 8, 'sp4_r_v_b_28')
// (7, 9, 'neigh_op_tnr_2')
// (7, 9, 'sp4_r_v_b_14')
// (7, 9, 'sp4_r_v_b_17')
// (7, 10, 'neigh_op_rgt_2')
// (7, 10, 'sp4_r_v_b_3')
// (7, 10, 'sp4_r_v_b_4')
// (7, 11, 'neigh_op_bnr_2')
// (8, 6, 'sp4_h_l_47')
// (8, 6, 'sp4_v_t_38')
// (8, 6, 'sp4_v_t_41')
// (8, 7, 'sp4_v_b_38')
// (8, 7, 'sp4_v_b_41')
// (8, 8, 'local_g3_4')
// (8, 8, 'lutff_2/in_3')
// (8, 8, 'sp4_v_b_27')
// (8, 8, 'sp4_v_b_28')
// (8, 9, 'neigh_op_top_2')
// (8, 9, 'sp4_v_b_14')
// (8, 9, 'sp4_v_b_17')
// (8, 10, 'local_g1_2')
// (8, 10, 'lutff_0/in_1')
// (8, 10, 'lutff_2/out')
// (8, 10, 'sp4_v_b_3')
// (8, 10, 'sp4_v_b_4')
// (8, 11, 'neigh_op_bot_2')
// (9, 9, 'neigh_op_tnl_2')
// (9, 10, 'neigh_op_lft_2')
// (9, 11, 'neigh_op_bnl_2')

wire n41;
// (4, 7, 'neigh_op_tnr_0')
// (4, 8, 'neigh_op_rgt_0')
// (4, 9, 'neigh_op_bnr_0')
// (5, 5, 'sp4_r_v_b_36')
// (5, 6, 'sp4_r_v_b_25')
// (5, 7, 'neigh_op_top_0')
// (5, 7, 'sp4_r_v_b_12')
// (5, 8, 'local_g1_0')
// (5, 8, 'local_g2_0')
// (5, 8, 'lutff_0/out')
// (5, 8, 'lutff_2/in_2')
// (5, 8, 'lutff_4/in_3')
// (5, 8, 'sp4_r_v_b_1')
// (5, 9, 'neigh_op_bot_0')
// (6, 4, 'sp4_v_t_36')
// (6, 5, 'sp4_v_b_36')
// (6, 6, 'sp4_v_b_25')
// (6, 7, 'neigh_op_tnl_0')
// (6, 7, 'sp4_v_b_12')
// (6, 8, 'local_g1_1')
// (6, 8, 'lutff_0/in_0')
// (6, 8, 'neigh_op_lft_0')
// (6, 8, 'sp4_v_b_1')
// (6, 9, 'neigh_op_bnl_0')

wire n42;
// (4, 7, 'neigh_op_tnr_2')
// (4, 8, 'neigh_op_rgt_2')
// (4, 9, 'neigh_op_bnr_2')
// (5, 7, 'neigh_op_top_2')
// (5, 8, 'lutff_2/out')
// (5, 9, 'neigh_op_bot_2')
// (6, 7, 'neigh_op_tnl_2')
// (6, 8, 'local_g0_2')
// (6, 8, 'local_g1_2')
// (6, 8, 'lutff_1/in_1')
// (6, 8, 'lutff_6/in_1')
// (6, 8, 'neigh_op_lft_2')
// (6, 9, 'neigh_op_bnl_2')

wire n43;
// (4, 7, 'neigh_op_tnr_3')
// (4, 8, 'neigh_op_rgt_3')
// (4, 9, 'neigh_op_bnr_3')
// (5, 7, 'neigh_op_top_3')
// (5, 8, 'local_g1_3')
// (5, 8, 'lutff_3/out')
// (5, 8, 'lutff_5/in_1')
// (5, 8, 'lutff_6/in_0')
// (5, 9, 'neigh_op_bot_3')
// (6, 7, 'neigh_op_tnl_3')
// (6, 8, 'neigh_op_lft_3')
// (6, 9, 'neigh_op_bnl_3')

wire n44;
// (4, 7, 'neigh_op_tnr_4')
// (4, 8, 'neigh_op_rgt_4')
// (4, 9, 'neigh_op_bnr_4')
// (5, 7, 'neigh_op_top_4')
// (5, 8, 'lutff_4/out')
// (5, 9, 'neigh_op_bot_4')
// (6, 7, 'local_g3_4')
// (6, 7, 'lutff_6/in_1')
// (6, 7, 'neigh_op_tnl_4')
// (6, 8, 'neigh_op_lft_4')
// (6, 9, 'neigh_op_bnl_4')

wire n45;
// (4, 7, 'neigh_op_tnr_6')
// (4, 8, 'neigh_op_rgt_6')
// (4, 9, 'neigh_op_bnr_6')
// (5, 7, 'neigh_op_top_6')
// (5, 8, 'local_g1_6')
// (5, 8, 'lutff_2/in_3')
// (5, 8, 'lutff_6/out')
// (5, 9, 'neigh_op_bot_6')
// (6, 7, 'neigh_op_tnl_6')
// (6, 8, 'local_g1_6')
// (6, 8, 'lutff_3/in_2')
// (6, 8, 'neigh_op_lft_6')
// (6, 9, 'neigh_op_bnl_6')

wire n46;
// (4, 7, 'neigh_op_tnr_7')
// (4, 8, 'neigh_op_rgt_7')
// (4, 9, 'neigh_op_bnr_7')
// (5, 7, 'neigh_op_top_7')
// (5, 8, 'local_g0_7')
// (5, 8, 'lutff_0/in_3')
// (5, 8, 'lutff_7/out')
// (5, 9, 'neigh_op_bot_7')
// (6, 7, 'neigh_op_tnl_7')
// (6, 8, 'neigh_op_lft_7')
// (6, 9, 'neigh_op_bnl_7')

wire n47;
// (4, 7, 'sp4_h_r_11')
// (4, 7, 'sp4_r_v_b_38')
// (4, 8, 'sp4_r_v_b_27')
// (4, 9, 'sp4_h_r_9')
// (4, 9, 'sp4_r_v_b_14')
// (4, 10, 'sp4_r_v_b_3')
// (5, 6, 'sp4_v_t_38')
// (5, 7, 'local_g2_6')
// (5, 7, 'local_g3_6')
// (5, 7, 'lutff_1/in_2')
// (5, 7, 'lutff_4/in_2')
// (5, 7, 'sp4_h_r_22')
// (5, 7, 'sp4_v_b_38')
// (5, 8, 'local_g2_3')
// (5, 8, 'local_g3_3')
// (5, 8, 'lutff_0/in_2')
// (5, 8, 'lutff_1/in_2')
// (5, 8, 'sp4_v_b_27')
// (5, 9, 'sp4_h_r_2')
// (5, 9, 'sp4_h_r_20')
// (5, 9, 'sp4_v_b_14')
// (5, 10, 'sp4_h_r_3')
// (5, 10, 'sp4_v_b_3')
// (6, 7, 'local_g2_3')
// (6, 7, 'lutff_0/in_1')
// (6, 7, 'sp4_h_r_35')
// (6, 9, 'local_g1_7')
// (6, 9, 'local_g2_1')
// (6, 9, 'lutff_2/in_3')
// (6, 9, 'lutff_3/in_0')
// (6, 9, 'lutff_4/in_0')
// (6, 9, 'sp4_h_r_15')
// (6, 9, 'sp4_h_r_33')
// (6, 10, 'sp4_h_r_14')
// (7, 7, 'local_g2_6')
// (7, 7, 'lutff_1/in_1')
// (7, 7, 'sp4_h_r_46')
// (7, 7, 'sp4_r_v_b_43')
// (7, 8, 'local_g0_6')
// (7, 8, 'lutff_3/in_3')
// (7, 8, 'lutff_5/in_3')
// (7, 8, 'sp4_r_v_b_30')
// (7, 8, 'sp4_r_v_b_46')
// (7, 9, 'local_g3_3')
// (7, 9, 'lutff_3/in_1')
// (7, 9, 'neigh_op_tnr_3')
// (7, 9, 'sp4_h_r_26')
// (7, 9, 'sp4_h_r_44')
// (7, 9, 'sp4_r_v_b_19')
// (7, 9, 'sp4_r_v_b_35')
// (7, 10, 'neigh_op_rgt_3')
// (7, 10, 'sp4_h_r_27')
// (7, 10, 'sp4_r_v_b_22')
// (7, 10, 'sp4_r_v_b_38')
// (7, 10, 'sp4_r_v_b_6')
// (7, 11, 'neigh_op_bnr_3')
// (7, 11, 'sp4_r_v_b_11')
// (7, 11, 'sp4_r_v_b_27')
// (7, 12, 'sp4_r_v_b_14')
// (7, 13, 'sp4_r_v_b_3')
// (8, 6, 'sp4_v_t_43')
// (8, 7, 'sp4_h_l_46')
// (8, 7, 'sp4_v_b_43')
// (8, 7, 'sp4_v_t_46')
// (8, 8, 'sp4_v_b_30')
// (8, 8, 'sp4_v_b_46')
// (8, 9, 'neigh_op_top_3')
// (8, 9, 'sp4_h_l_44')
// (8, 9, 'sp4_h_r_39')
// (8, 9, 'sp4_v_b_19')
// (8, 9, 'sp4_v_b_35')
// (8, 9, 'sp4_v_t_38')
// (8, 10, 'lutff_3/out')
// (8, 10, 'sp4_h_r_38')
// (8, 10, 'sp4_r_v_b_39')
// (8, 10, 'sp4_v_b_22')
// (8, 10, 'sp4_v_b_38')
// (8, 10, 'sp4_v_b_6')
// (8, 11, 'neigh_op_bot_3')
// (8, 11, 'sp4_r_v_b_26')
// (8, 11, 'sp4_v_b_11')
// (8, 11, 'sp4_v_b_27')
// (8, 12, 'sp4_r_v_b_15')
// (8, 12, 'sp4_v_b_14')
// (8, 13, 'sp4_r_v_b_2')
// (8, 13, 'sp4_v_b_3')
// (9, 9, 'neigh_op_tnl_3')
// (9, 9, 'sp4_h_l_39')
// (9, 9, 'sp4_v_t_39')
// (9, 10, 'neigh_op_lft_3')
// (9, 10, 'sp4_h_l_38')
// (9, 10, 'sp4_v_b_39')
// (9, 11, 'neigh_op_bnl_3')
// (9, 11, 'sp4_v_b_26')
// (9, 12, 'sp4_v_b_15')
// (9, 13, 'sp4_v_b_2')

reg n48 = 0;
// (4, 7, 'sp4_h_r_8')
// (4, 9, 'sp4_h_r_6')
// (5, 7, 'local_g0_5')
// (5, 7, 'lutff_0/in_3')
// (5, 7, 'lutff_6/in_1')
// (5, 7, 'sp4_h_r_21')
// (5, 7, 'sp4_r_v_b_39')
// (5, 8, 'local_g0_2')
// (5, 8, 'local_g1_2')
// (5, 8, 'lutff_3/in_3')
// (5, 8, 'lutff_7/in_0')
// (5, 8, 'sp4_r_v_b_26')
// (5, 9, 'local_g1_3')
// (5, 9, 'lutff_0/in_2')
// (5, 9, 'lutff_6/in_2')
// (5, 9, 'lutff_7/in_3')
// (5, 9, 'sp4_h_r_19')
// (5, 9, 'sp4_r_v_b_15')
// (5, 10, 'sp4_r_v_b_2')
// (6, 6, 'sp4_v_t_39')
// (6, 7, 'local_g3_0')
// (6, 7, 'lutff_4/in_1')
// (6, 7, 'sp4_h_r_32')
// (6, 7, 'sp4_r_v_b_41')
// (6, 7, 'sp4_v_b_39')
// (6, 8, 'sp4_r_v_b_28')
// (6, 8, 'sp4_v_b_26')
// (6, 9, 'local_g2_2')
// (6, 9, 'local_g3_2')
// (6, 9, 'lutff_0/in_1')
// (6, 9, 'lutff_1/in_3')
// (6, 9, 'lutff_5/in_0')
// (6, 9, 'neigh_op_tnr_2')
// (6, 9, 'sp4_h_r_30')
// (6, 9, 'sp4_r_v_b_17')
// (6, 9, 'sp4_v_b_15')
// (6, 10, 'neigh_op_rgt_2')
// (6, 10, 'sp4_h_r_9')
// (6, 10, 'sp4_r_v_b_4')
// (6, 10, 'sp4_v_b_2')
// (6, 11, 'neigh_op_bnr_2')
// (7, 6, 'sp4_v_t_41')
// (7, 7, 'local_g2_1')
// (7, 7, 'lutff_0/in_1')
// (7, 7, 'lutff_2/in_1')
// (7, 7, 'lutff_5/in_0')
// (7, 7, 'sp4_h_r_45')
// (7, 7, 'sp4_v_b_41')
// (7, 8, 'local_g2_4')
// (7, 8, 'local_g3_4')
// (7, 8, 'lutff_1/in_3')
// (7, 8, 'lutff_3/in_1')
// (7, 8, 'lutff_4/in_3')
// (7, 8, 'sp4_r_v_b_45')
// (7, 8, 'sp4_v_b_28')
// (7, 9, 'local_g0_1')
// (7, 9, 'local_g0_3')
// (7, 9, 'local_g1_1')
// (7, 9, 'lutff_1/in_3')
// (7, 9, 'lutff_4/in_3')
// (7, 9, 'lutff_7/in_0')
// (7, 9, 'neigh_op_top_2')
// (7, 9, 'sp4_h_r_43')
// (7, 9, 'sp4_r_v_b_32')
// (7, 9, 'sp4_v_b_17')
// (7, 10, 'local_g0_2')
// (7, 10, 'lutff_2/in_2')
// (7, 10, 'lutff_2/out')
// (7, 10, 'sp4_h_r_20')
// (7, 10, 'sp4_r_v_b_21')
// (7, 10, 'sp4_r_v_b_37')
// (7, 10, 'sp4_v_b_4')
// (7, 11, 'neigh_op_bot_2')
// (7, 11, 'sp4_r_v_b_24')
// (7, 11, 'sp4_r_v_b_8')
// (7, 12, 'sp4_r_v_b_13')
// (7, 13, 'sp4_r_v_b_0')
// (8, 7, 'sp4_h_l_45')
// (8, 7, 'sp4_v_t_45')
// (8, 8, 'sp4_v_b_45')
// (8, 9, 'neigh_op_tnl_2')
// (8, 9, 'sp4_h_l_43')
// (8, 9, 'sp4_v_b_32')
// (8, 9, 'sp4_v_t_37')
// (8, 10, 'neigh_op_lft_2')
// (8, 10, 'sp4_h_r_33')
// (8, 10, 'sp4_v_b_21')
// (8, 10, 'sp4_v_b_37')
// (8, 11, 'neigh_op_bnl_2')
// (8, 11, 'sp4_v_b_24')
// (8, 11, 'sp4_v_b_8')
// (8, 12, 'sp4_v_b_13')
// (8, 13, 'sp4_v_b_0')
// (9, 10, 'sp4_h_r_44')
// (10, 10, 'sp4_h_l_44')

wire n49;
// (4, 7, 'sp4_r_v_b_36')
// (4, 8, 'neigh_op_tnr_6')
// (4, 8, 'sp4_r_v_b_25')
// (4, 9, 'neigh_op_rgt_6')
// (4, 9, 'sp4_r_v_b_12')
// (4, 10, 'neigh_op_bnr_6')
// (4, 10, 'sp4_r_v_b_1')
// (5, 6, 'sp4_v_t_36')
// (5, 7, 'local_g2_4')
// (5, 7, 'local_g3_4')
// (5, 7, 'lutff_1/in_1')
// (5, 7, 'lutff_5/in_2')
// (5, 7, 'sp4_v_b_36')
// (5, 8, 'local_g0_6')
// (5, 8, 'lutff_1/in_3')
// (5, 8, 'neigh_op_top_6')
// (5, 8, 'sp4_v_b_25')
// (5, 9, 'lutff_6/out')
// (5, 9, 'sp4_v_b_12')
// (5, 10, 'neigh_op_bot_6')
// (5, 10, 'sp4_v_b_1')
// (6, 8, 'neigh_op_tnl_6')
// (6, 9, 'local_g1_6')
// (6, 9, 'lutff_2/in_1')
// (6, 9, 'neigh_op_lft_6')
// (6, 10, 'neigh_op_bnl_6')

wire n50;
// (4, 8, 'neigh_op_tnr_0')
// (4, 9, 'neigh_op_rgt_0')
// (4, 10, 'neigh_op_bnr_0')
// (5, 8, 'local_g0_0')
// (5, 8, 'lutff_6/in_2')
// (5, 8, 'neigh_op_top_0')
// (5, 9, 'lutff_0/out')
// (5, 10, 'neigh_op_bot_0')
// (6, 8, 'local_g2_0')
// (6, 8, 'lutff_2/in_0')
// (6, 8, 'neigh_op_tnl_0')
// (6, 9, 'neigh_op_lft_0')
// (6, 10, 'neigh_op_bnl_0')

wire n51;
// (4, 8, 'neigh_op_tnr_1')
// (4, 9, 'neigh_op_rgt_1')
// (4, 10, 'neigh_op_bnr_1')
// (5, 8, 'local_g0_1')
// (5, 8, 'local_g1_1')
// (5, 8, 'lutff_2/in_0')
// (5, 8, 'lutff_4/in_1')
// (5, 8, 'neigh_op_top_1')
// (5, 9, 'lutff_1/out')
// (5, 10, 'neigh_op_bot_1')
// (6, 8, 'local_g2_1')
// (6, 8, 'lutff_5/in_0')
// (6, 8, 'neigh_op_tnl_1')
// (6, 9, 'neigh_op_lft_1')
// (6, 10, 'neigh_op_bnl_1')

wire n52;
// (4, 8, 'neigh_op_tnr_7')
// (4, 9, 'neigh_op_rgt_7')
// (4, 10, 'neigh_op_bnr_7')
// (5, 8, 'neigh_op_top_7')
// (5, 9, 'local_g0_7')
// (5, 9, 'lutff_1/in_2')
// (5, 9, 'lutff_7/out')
// (5, 10, 'neigh_op_bot_7')
// (6, 8, 'neigh_op_tnl_7')
// (6, 9, 'neigh_op_lft_7')
// (6, 10, 'neigh_op_bnl_7')

wire n53;
// (4, 8, 'sp4_h_r_2')
// (4, 8, 'sp4_h_r_8')
// (5, 8, 'sp4_h_r_15')
// (5, 8, 'sp4_h_r_21')
// (6, 2, 'sp4_r_v_b_39')
// (6, 3, 'sp4_r_v_b_26')
// (6, 4, 'sp4_r_v_b_15')
// (6, 5, 'sp4_r_v_b_2')
// (6, 6, 'sp4_r_v_b_43')
// (6, 6, 'sp4_r_v_b_47')
// (6, 7, 'local_g1_6')
// (6, 7, 'local_g2_2')
// (6, 7, 'lutff_2/in_2')
// (6, 7, 'lutff_3/in_2')
// (6, 7, 'sp4_r_v_b_30')
// (6, 7, 'sp4_r_v_b_34')
// (6, 8, 'local_g2_2')
// (6, 8, 'local_g3_0')
// (6, 8, 'lutff_0/in_3')
// (6, 8, 'lutff_3/in_1')
// (6, 8, 'neigh_op_tnr_3')
// (6, 8, 'sp4_h_r_26')
// (6, 8, 'sp4_h_r_32')
// (6, 8, 'sp4_r_v_b_19')
// (6, 8, 'sp4_r_v_b_23')
// (6, 9, 'neigh_op_rgt_3')
// (6, 9, 'sp4_r_v_b_10')
// (6, 9, 'sp4_r_v_b_6')
// (6, 10, 'neigh_op_bnr_3')
// (7, 1, 'sp4_v_t_39')
// (7, 2, 'sp4_v_b_39')
// (7, 3, 'sp4_v_b_26')
// (7, 4, 'sp4_v_b_15')
// (7, 5, 'sp4_v_b_2')
// (7, 5, 'sp4_v_t_43')
// (7, 5, 'sp4_v_t_47')
// (7, 6, 'sp4_v_b_43')
// (7, 6, 'sp4_v_b_47')
// (7, 7, 'local_g3_7')
// (7, 7, 'lutff_3/in_3')
// (7, 7, 'sp4_r_v_b_47')
// (7, 7, 'sp4_v_b_30')
// (7, 7, 'sp4_v_b_34')
// (7, 8, 'neigh_op_top_3')
// (7, 8, 'sp4_h_r_39')
// (7, 8, 'sp4_h_r_45')
// (7, 8, 'sp4_r_v_b_34')
// (7, 8, 'sp4_v_b_19')
// (7, 8, 'sp4_v_b_23')
// (7, 9, 'lutff_3/out')
// (7, 9, 'sp4_r_v_b_23')
// (7, 9, 'sp4_r_v_b_39')
// (7, 9, 'sp4_v_b_10')
// (7, 9, 'sp4_v_b_6')
// (7, 10, 'neigh_op_bot_3')
// (7, 10, 'sp4_r_v_b_10')
// (7, 10, 'sp4_r_v_b_26')
// (7, 11, 'sp4_r_v_b_15')
// (7, 12, 'sp4_r_v_b_2')
// (8, 6, 'sp4_v_t_47')
// (8, 7, 'sp4_v_b_47')
// (8, 8, 'neigh_op_tnl_3')
// (8, 8, 'sp4_h_l_39')
// (8, 8, 'sp4_h_l_45')
// (8, 8, 'sp4_v_b_34')
// (8, 8, 'sp4_v_t_39')
// (8, 9, 'neigh_op_lft_3')
// (8, 9, 'sp4_v_b_23')
// (8, 9, 'sp4_v_b_39')
// (8, 10, 'neigh_op_bnl_3')
// (8, 10, 'sp4_v_b_10')
// (8, 10, 'sp4_v_b_26')
// (8, 11, 'sp4_v_b_15')
// (8, 12, 'sp4_v_b_2')

wire n54;
// (5, 4, 'neigh_op_tnr_0')
// (5, 5, 'local_g2_0')
// (5, 5, 'lutff_3/in_3')
// (5, 5, 'neigh_op_rgt_0')
// (5, 6, 'neigh_op_bnr_0')
// (6, 4, 'neigh_op_top_0')
// (6, 5, 'local_g0_0')
// (6, 5, 'lutff_0/out')
// (6, 5, 'lutff_1/in_1')
// (6, 6, 'neigh_op_bot_0')
// (7, 4, 'neigh_op_tnl_0')
// (7, 5, 'neigh_op_lft_0')
// (7, 6, 'neigh_op_bnl_0')

wire n55;
// (5, 4, 'neigh_op_tnr_1')
// (5, 4, 'sp4_r_v_b_47')
// (5, 5, 'local_g2_2')
// (5, 5, 'lutff_global/cen')
// (5, 5, 'neigh_op_rgt_1')
// (5, 5, 'sp4_r_v_b_34')
// (5, 6, 'neigh_op_bnr_1')
// (5, 6, 'sp4_r_v_b_23')
// (5, 7, 'sp4_r_v_b_10')
// (6, 3, 'sp4_v_t_47')
// (6, 4, 'neigh_op_top_1')
// (6, 4, 'sp4_v_b_47')
// (6, 5, 'lutff_1/out')
// (6, 5, 'sp4_v_b_34')
// (6, 6, 'neigh_op_bot_1')
// (6, 6, 'sp4_v_b_23')
// (6, 7, 'sp4_v_b_10')
// (7, 4, 'neigh_op_tnl_1')
// (7, 5, 'neigh_op_lft_1')
// (7, 6, 'neigh_op_bnl_1')

wire n56;
// (5, 4, 'neigh_op_tnr_3')
// (5, 5, 'neigh_op_rgt_3')
// (5, 6, 'neigh_op_bnr_3')
// (6, 4, 'neigh_op_top_3')
// (6, 5, 'lutff_3/out')
// (6, 6, 'neigh_op_bot_3')
// (7, 4, 'neigh_op_tnl_3')
// (7, 5, 'local_g1_3')
// (7, 5, 'lutff_global/cen')
// (7, 5, 'neigh_op_lft_3')
// (7, 6, 'neigh_op_bnl_3')

wire n57;
// (5, 4, 'neigh_op_tnr_4')
// (5, 5, 'neigh_op_rgt_4')
// (5, 6, 'neigh_op_bnr_4')
// (6, 4, 'neigh_op_top_4')
// (6, 5, 'local_g1_4')
// (6, 5, 'lutff_4/out')
// (6, 5, 'lutff_5/in_0')
// (6, 6, 'neigh_op_bot_4')
// (7, 4, 'neigh_op_tnl_4')
// (7, 5, 'neigh_op_lft_4')
// (7, 6, 'neigh_op_bnl_4')

wire n58;
// (5, 4, 'neigh_op_tnr_5')
// (5, 5, 'neigh_op_rgt_5')
// (5, 6, 'neigh_op_bnr_5')
// (6, 4, 'neigh_op_top_5')
// (6, 5, 'local_g0_5')
// (6, 5, 'local_g1_5')
// (6, 5, 'lutff_1/in_3')
// (6, 5, 'lutff_3/in_2')
// (6, 5, 'lutff_5/out')
// (6, 6, 'neigh_op_bot_5')
// (7, 4, 'neigh_op_tnl_5')
// (7, 5, 'neigh_op_lft_5')
// (7, 6, 'neigh_op_bnl_5')

wire n59;
// (5, 5, 'neigh_op_tnr_0')
// (5, 6, 'neigh_op_rgt_0')
// (5, 7, 'neigh_op_bnr_0')
// (6, 5, 'neigh_op_top_0')
// (6, 6, 'local_g0_0')
// (6, 6, 'lutff_0/out')
// (6, 6, 'lutff_7/in_1')
// (6, 7, 'neigh_op_bot_0')
// (7, 5, 'neigh_op_tnl_0')
// (7, 6, 'neigh_op_lft_0')
// (7, 7, 'neigh_op_bnl_0')

wire n60;
// (5, 5, 'neigh_op_tnr_2')
// (5, 6, 'neigh_op_rgt_2')
// (5, 7, 'neigh_op_bnr_2')
// (6, 5, 'neigh_op_top_2')
// (6, 6, 'local_g0_2')
// (6, 6, 'lutff_2/out')
// (6, 6, 'lutff_5/in_3')
// (6, 7, 'neigh_op_bot_2')
// (7, 5, 'neigh_op_tnl_2')
// (7, 6, 'neigh_op_lft_2')
// (7, 7, 'neigh_op_bnl_2')

wire n61;
// (5, 5, 'neigh_op_tnr_4')
// (5, 6, 'neigh_op_rgt_4')
// (5, 7, 'neigh_op_bnr_4')
// (6, 5, 'neigh_op_top_4')
// (6, 6, 'local_g1_4')
// (6, 6, 'lutff_2/in_1')
// (6, 6, 'lutff_4/out')
// (6, 7, 'neigh_op_bot_4')
// (7, 5, 'neigh_op_tnl_4')
// (7, 6, 'neigh_op_lft_4')
// (7, 7, 'neigh_op_bnl_4')

wire n62;
// (5, 5, 'neigh_op_tnr_5')
// (5, 6, 'local_g2_5')
// (5, 6, 'lutff_7/in_2')
// (5, 6, 'neigh_op_rgt_5')
// (5, 7, 'neigh_op_bnr_5')
// (6, 5, 'neigh_op_top_5')
// (6, 6, 'lutff_5/out')
// (6, 7, 'neigh_op_bot_5')
// (7, 5, 'neigh_op_tnl_5')
// (7, 6, 'neigh_op_lft_5')
// (7, 7, 'neigh_op_bnl_5')

wire n63;
// (5, 5, 'neigh_op_tnr_7')
// (5, 6, 'neigh_op_rgt_7')
// (5, 7, 'neigh_op_bnr_7')
// (6, 5, 'neigh_op_top_7')
// (6, 6, 'local_g0_7')
// (6, 6, 'lutff_5/in_0')
// (6, 6, 'lutff_7/out')
// (6, 7, 'neigh_op_bot_7')
// (7, 5, 'neigh_op_tnl_7')
// (7, 6, 'neigh_op_lft_7')
// (7, 7, 'neigh_op_bnl_7')

wire n64;
// (5, 5, 'sp4_r_v_b_40')
// (5, 6, 'neigh_op_tnr_0')
// (5, 6, 'sp4_r_v_b_29')
// (5, 7, 'neigh_op_rgt_0')
// (5, 7, 'sp4_r_v_b_16')
// (5, 8, 'neigh_op_bnr_0')
// (5, 8, 'sp4_r_v_b_5')
// (6, 4, 'sp4_v_t_40')
// (6, 5, 'sp4_v_b_40')
// (6, 6, 'neigh_op_top_0')
// (6, 6, 'sp4_v_b_29')
// (6, 7, 'local_g2_0')
// (6, 7, 'lutff_0/out')
// (6, 7, 'lutff_3/in_3')
// (6, 7, 'sp4_v_b_16')
// (6, 8, 'local_g1_5')
// (6, 8, 'lutff_5/in_3')
// (6, 8, 'neigh_op_bot_0')
// (6, 8, 'sp4_v_b_5')
// (7, 6, 'neigh_op_tnl_0')
// (7, 7, 'neigh_op_lft_0')
// (7, 8, 'neigh_op_bnl_0')

wire n65;
// (5, 6, 'neigh_op_tnr_1')
// (5, 7, 'neigh_op_rgt_1')
// (5, 8, 'neigh_op_bnr_1')
// (6, 6, 'neigh_op_top_1')
// (6, 7, 'local_g1_1')
// (6, 7, 'lutff_1/out')
// (6, 7, 'lutff_5/in_1')
// (6, 7, 'lutff_6/in_0')
// (6, 8, 'neigh_op_bot_1')
// (7, 6, 'neigh_op_tnl_1')
// (7, 7, 'neigh_op_lft_1')
// (7, 8, 'neigh_op_bnl_1')

wire n66;
// (5, 6, 'neigh_op_tnr_2')
// (5, 7, 'neigh_op_rgt_2')
// (5, 8, 'neigh_op_bnr_2')
// (6, 6, 'neigh_op_top_2')
// (6, 7, 'local_g0_2')
// (6, 7, 'lutff_2/out')
// (6, 7, 'lutff_6/in_2')
// (6, 7, 'lutff_7/in_3')
// (6, 8, 'neigh_op_bot_2')
// (7, 6, 'neigh_op_tnl_2')
// (7, 7, 'neigh_op_lft_2')
// (7, 8, 'neigh_op_bnl_2')

wire n67;
// (5, 6, 'neigh_op_tnr_3')
// (5, 7, 'neigh_op_rgt_3')
// (5, 8, 'neigh_op_bnr_3')
// (6, 0, 'span12_vert_18')
// (6, 1, 'sp12_v_b_18')
// (6, 2, 'sp12_v_b_17')
// (6, 3, 'sp12_v_b_14')
// (6, 4, 'sp12_v_b_13')
// (6, 5, 'sp12_v_b_10')
// (6, 6, 'neigh_op_top_3')
// (6, 6, 'sp12_v_b_9')
// (6, 7, 'local_g0_3')
// (6, 7, 'lutff_3/out')
// (6, 7, 'lutff_5/in_2')
// (6, 7, 'sp12_v_b_6')
// (6, 8, 'local_g2_5')
// (6, 8, 'lutff_1/in_2')
// (6, 8, 'neigh_op_bot_3')
// (6, 8, 'sp12_v_b_5')
// (6, 9, 'sp12_v_b_2')
// (6, 10, 'sp12_v_b_1')
// (7, 6, 'neigh_op_tnl_3')
// (7, 7, 'neigh_op_lft_3')
// (7, 8, 'neigh_op_bnl_3')

wire n68;
// (5, 6, 'neigh_op_tnr_4')
// (5, 7, 'neigh_op_rgt_4')
// (5, 8, 'neigh_op_bnr_4')
// (6, 0, 'span12_vert_20')
// (6, 1, 'sp12_v_b_20')
// (6, 2, 'sp12_v_b_19')
// (6, 3, 'sp12_v_b_16')
// (6, 4, 'sp12_v_b_15')
// (6, 5, 'sp12_v_b_12')
// (6, 6, 'neigh_op_top_4')
// (6, 6, 'sp12_v_b_11')
// (6, 7, 'local_g0_4')
// (6, 7, 'lutff_0/in_2')
// (6, 7, 'lutff_4/out')
// (6, 7, 'sp12_v_b_8')
// (6, 8, 'local_g2_7')
// (6, 8, 'lutff_2/in_1')
// (6, 8, 'neigh_op_bot_4')
// (6, 8, 'sp12_v_b_7')
// (6, 9, 'sp12_v_b_4')
// (6, 10, 'sp12_v_b_3')
// (6, 11, 'sp12_v_b_0')
// (7, 6, 'neigh_op_tnl_4')
// (7, 7, 'neigh_op_lft_4')
// (7, 8, 'neigh_op_bnl_4')

reg n69 = 0;
// (5, 6, 'neigh_op_tnr_5')
// (5, 7, 'neigh_op_rgt_5')
// (5, 8, 'neigh_op_bnr_5')
// (6, 6, 'local_g1_5')
// (6, 6, 'lutff_4/in_0')
// (6, 6, 'neigh_op_top_5')
// (6, 7, 'lutff_5/out')
// (6, 8, 'neigh_op_bot_5')
// (7, 6, 'neigh_op_tnl_5')
// (7, 7, 'neigh_op_lft_5')
// (7, 8, 'neigh_op_bnl_5')

reg n70 = 0;
// (5, 6, 'neigh_op_tnr_6')
// (5, 7, 'neigh_op_rgt_6')
// (5, 8, 'neigh_op_bnr_6')
// (6, 6, 'local_g1_6')
// (6, 6, 'lutff_0/in_1')
// (6, 6, 'neigh_op_top_6')
// (6, 7, 'lutff_6/out')
// (6, 8, 'neigh_op_bot_6')
// (7, 6, 'neigh_op_tnl_6')
// (7, 7, 'neigh_op_lft_6')
// (7, 8, 'neigh_op_bnl_6')

reg n71 = 0;
// (5, 6, 'neigh_op_tnr_7')
// (5, 7, 'neigh_op_rgt_7')
// (5, 8, 'neigh_op_bnr_7')
// (6, 2, 'sp12_v_t_22')
// (6, 3, 'sp12_v_b_22')
// (6, 4, 'sp12_v_b_21')
// (6, 5, 'sp12_v_b_18')
// (6, 6, 'local_g2_1')
// (6, 6, 'lutff_7/in_2')
// (6, 6, 'neigh_op_top_7')
// (6, 6, 'sp12_v_b_17')
// (6, 7, 'lutff_7/out')
// (6, 7, 'sp12_v_b_14')
// (6, 8, 'neigh_op_bot_7')
// (6, 8, 'sp12_v_b_13')
// (6, 9, 'sp12_v_b_10')
// (6, 10, 'sp12_v_b_9')
// (6, 11, 'sp12_v_b_6')
// (6, 12, 'sp12_v_b_5')
// (6, 13, 'sp12_v_b_2')
// (6, 14, 'sp12_v_b_1')
// (7, 6, 'neigh_op_tnl_7')
// (7, 7, 'neigh_op_lft_7')
// (7, 8, 'neigh_op_bnl_7')

wire n72;
// (5, 7, 'neigh_op_tnr_0')
// (5, 8, 'neigh_op_rgt_0')
// (5, 9, 'neigh_op_bnr_0')
// (6, 7, 'neigh_op_top_0')
// (6, 8, 'local_g0_0')
// (6, 8, 'lutff_0/out')
// (6, 8, 'lutff_7/in_1')
// (6, 9, 'neigh_op_bot_0')
// (7, 7, 'neigh_op_tnl_0')
// (7, 8, 'neigh_op_lft_0')
// (7, 9, 'neigh_op_bnl_0')

wire n73;
// (5, 7, 'neigh_op_tnr_2')
// (5, 8, 'neigh_op_rgt_2')
// (5, 9, 'neigh_op_bnr_2')
// (6, 7, 'local_g1_2')
// (6, 7, 'lutff_7/in_2')
// (6, 7, 'neigh_op_top_2')
// (6, 8, 'lutff_2/out')
// (6, 9, 'neigh_op_bot_2')
// (7, 7, 'neigh_op_tnl_2')
// (7, 8, 'neigh_op_lft_2')
// (7, 9, 'neigh_op_bnl_2')

wire n74;
// (5, 7, 'neigh_op_tnr_3')
// (5, 8, 'neigh_op_rgt_3')
// (5, 9, 'neigh_op_bnr_3')
// (6, 0, 'span12_vert_21')
// (6, 1, 'sp12_v_b_21')
// (6, 2, 'sp12_v_b_18')
// (6, 3, 'sp12_v_b_17')
// (6, 4, 'sp12_v_b_14')
// (6, 5, 'sp12_v_b_13')
// (6, 6, 'sp12_v_b_10')
// (6, 7, 'neigh_op_top_3')
// (6, 7, 'sp12_v_b_9')
// (6, 8, 'lutff_3/out')
// (6, 8, 'sp12_v_b_6')
// (6, 9, 'local_g2_5')
// (6, 9, 'lutff_6/in_3')
// (6, 9, 'neigh_op_bot_3')
// (6, 9, 'sp12_v_b_5')
// (6, 10, 'sp12_v_b_2')
// (6, 11, 'sp12_v_b_1')
// (7, 7, 'neigh_op_tnl_3')
// (7, 8, 'neigh_op_lft_3')
// (7, 9, 'neigh_op_bnl_3')

wire n75;
// (5, 7, 'neigh_op_tnr_4')
// (5, 8, 'neigh_op_rgt_4')
// (5, 9, 'neigh_op_bnr_4')
// (6, 7, 'neigh_op_top_4')
// (6, 8, 'local_g1_4')
// (6, 8, 'lutff_1/in_0')
// (6, 8, 'lutff_4/out')
// (6, 8, 'lutff_6/in_3')
// (6, 9, 'neigh_op_bot_4')
// (7, 7, 'neigh_op_tnl_4')
// (7, 8, 'neigh_op_lft_4')
// (7, 9, 'neigh_op_bnl_4')

wire n76;
// (5, 7, 'neigh_op_tnr_5')
// (5, 8, 'neigh_op_rgt_5')
// (5, 9, 'neigh_op_bnr_5')
// (6, 7, 'neigh_op_top_5')
// (6, 8, 'lutff_5/out')
// (6, 9, 'local_g1_5')
// (6, 9, 'lutff_6/in_2')
// (6, 9, 'neigh_op_bot_5')
// (7, 7, 'neigh_op_tnl_5')
// (7, 8, 'neigh_op_lft_5')
// (7, 9, 'neigh_op_bnl_5')

reg n77 = 0;
// (5, 7, 'neigh_op_tnr_6')
// (5, 8, 'neigh_op_rgt_6')
// (5, 9, 'neigh_op_bnr_6')
// (6, 6, 'local_g2_5')
// (6, 6, 'lutff_4/in_1')
// (6, 6, 'sp4_r_v_b_37')
// (6, 7, 'neigh_op_top_6')
// (6, 7, 'sp4_r_v_b_24')
// (6, 8, 'lutff_6/out')
// (6, 8, 'sp4_r_v_b_13')
// (6, 9, 'neigh_op_bot_6')
// (6, 9, 'sp4_r_v_b_0')
// (7, 5, 'sp4_v_t_37')
// (7, 6, 'sp4_v_b_37')
// (7, 7, 'neigh_op_tnl_6')
// (7, 7, 'sp4_v_b_24')
// (7, 8, 'neigh_op_lft_6')
// (7, 8, 'sp4_v_b_13')
// (7, 9, 'neigh_op_bnl_6')
// (7, 9, 'sp4_v_b_0')

reg n78 = 0;
// (5, 7, 'neigh_op_tnr_7')
// (5, 8, 'neigh_op_rgt_7')
// (5, 9, 'neigh_op_bnr_7')
// (6, 3, 'sp12_v_t_22')
// (6, 4, 'sp12_v_b_22')
// (6, 5, 'sp12_v_b_21')
// (6, 6, 'local_g2_2')
// (6, 6, 'lutff_0/in_2')
// (6, 6, 'sp12_v_b_18')
// (6, 7, 'neigh_op_top_7')
// (6, 7, 'sp12_v_b_17')
// (6, 8, 'lutff_7/out')
// (6, 8, 'sp12_v_b_14')
// (6, 9, 'neigh_op_bot_7')
// (6, 9, 'sp12_v_b_13')
// (6, 10, 'sp12_v_b_10')
// (6, 11, 'sp12_v_b_9')
// (6, 12, 'sp12_v_b_6')
// (6, 13, 'sp12_v_b_5')
// (6, 14, 'sp12_v_b_2')
// (6, 15, 'sp12_v_b_1')
// (7, 7, 'neigh_op_tnl_7')
// (7, 8, 'neigh_op_lft_7')
// (7, 9, 'neigh_op_bnl_7')

wire n79;
// (5, 8, 'neigh_op_tnr_0')
// (5, 9, 'neigh_op_rgt_0')
// (5, 10, 'neigh_op_bnr_0')
// (6, 8, 'neigh_op_top_0')
// (6, 8, 'sp4_r_v_b_44')
// (6, 9, 'local_g0_2')
// (6, 9, 'local_g1_0')
// (6, 9, 'lutff_0/out')
// (6, 9, 'lutff_3/in_3')
// (6, 9, 'lutff_4/in_1')
// (6, 9, 'sp4_r_v_b_33')
// (6, 10, 'neigh_op_bot_0')
// (6, 10, 'sp4_r_v_b_20')
// (6, 11, 'sp4_r_v_b_9')
// (7, 7, 'sp4_v_t_44')
// (7, 8, 'neigh_op_tnl_0')
// (7, 8, 'sp4_v_b_44')
// (7, 9, 'neigh_op_lft_0')
// (7, 9, 'sp4_v_b_33')
// (7, 10, 'neigh_op_bnl_0')
// (7, 10, 'sp4_v_b_20')
// (7, 11, 'sp4_v_b_9')

wire n80;
// (5, 8, 'neigh_op_tnr_1')
// (5, 9, 'neigh_op_rgt_1')
// (5, 10, 'neigh_op_bnr_1')
// (6, 8, 'neigh_op_top_1')
// (6, 9, 'local_g3_1')
// (6, 9, 'lutff_1/out')
// (6, 9, 'lutff_2/in_2')
// (6, 9, 'lutff_3/in_1')
// (6, 10, 'neigh_op_bot_1')
// (7, 8, 'neigh_op_tnl_1')
// (7, 9, 'neigh_op_lft_1')
// (7, 10, 'neigh_op_bnl_1')

wire n81;
// (5, 8, 'neigh_op_tnr_2')
// (5, 9, 'neigh_op_rgt_2')
// (5, 10, 'neigh_op_bnr_2')
// (6, 8, 'neigh_op_top_2')
// (6, 9, 'local_g1_2')
// (6, 9, 'lutff_2/out')
// (6, 9, 'lutff_6/in_1')
// (6, 10, 'neigh_op_bot_2')
// (7, 8, 'neigh_op_tnl_2')
// (7, 9, 'neigh_op_lft_2')
// (7, 10, 'neigh_op_bnl_2')

wire n82;
// (5, 8, 'neigh_op_tnr_3')
// (5, 9, 'neigh_op_rgt_3')
// (5, 10, 'neigh_op_bnr_3')
// (6, 8, 'local_g0_3')
// (6, 8, 'local_g1_3')
// (6, 8, 'lutff_2/in_3')
// (6, 8, 'lutff_4/in_2')
// (6, 8, 'lutff_7/in_2')
// (6, 8, 'neigh_op_top_3')
// (6, 9, 'lutff_3/out')
// (6, 10, 'neigh_op_bot_3')
// (7, 8, 'neigh_op_tnl_3')
// (7, 9, 'neigh_op_lft_3')
// (7, 10, 'neigh_op_bnl_3')

wire n83;
// (5, 8, 'neigh_op_tnr_4')
// (5, 9, 'neigh_op_rgt_4')
// (5, 9, 'sp4_r_v_b_40')
// (5, 10, 'neigh_op_bnr_4')
// (5, 10, 'sp4_r_v_b_29')
// (5, 11, 'sp4_r_v_b_16')
// (5, 12, 'sp4_r_v_b_5')
// (6, 1, 'sp12_v_t_23')
// (6, 2, 'sp12_v_b_23')
// (6, 3, 'sp12_v_b_20')
// (6, 4, 'sp12_v_b_19')
// (6, 5, 'sp12_v_b_16')
// (6, 6, 'sp12_v_b_15')
// (6, 7, 'sp12_v_b_12')
// (6, 8, 'local_g0_4')
// (6, 8, 'local_g2_3')
// (6, 8, 'lutff_4/in_3')
// (6, 8, 'lutff_5/in_1')
// (6, 8, 'neigh_op_top_4')
// (6, 8, 'sp12_v_b_11')
// (6, 8, 'sp4_h_r_10')
// (6, 8, 'sp4_v_t_40')
// (6, 9, 'lutff_4/out')
// (6, 9, 'sp12_v_b_8')
// (6, 9, 'sp4_v_b_40')
// (6, 10, 'neigh_op_bot_4')
// (6, 10, 'sp12_v_b_7')
// (6, 10, 'sp4_v_b_29')
// (6, 11, 'sp12_v_b_4')
// (6, 11, 'sp4_v_b_16')
// (6, 12, 'sp12_v_b_3')
// (6, 12, 'sp4_v_b_5')
// (6, 13, 'sp12_v_b_0')
// (7, 8, 'local_g0_7')
// (7, 8, 'lutff_2/in_3')
// (7, 8, 'neigh_op_tnl_4')
// (7, 8, 'sp4_h_r_23')
// (7, 9, 'neigh_op_lft_4')
// (7, 10, 'neigh_op_bnl_4')
// (8, 8, 'sp4_h_r_34')
// (9, 8, 'sp4_h_r_47')
// (10, 8, 'sp4_h_l_47')

wire n84;
// (5, 8, 'neigh_op_tnr_5')
// (5, 9, 'neigh_op_rgt_5')
// (5, 10, 'neigh_op_bnr_5')
// (6, 8, 'neigh_op_top_5')
// (6, 9, 'local_g0_5')
// (6, 9, 'lutff_4/in_3')
// (6, 9, 'lutff_5/out')
// (6, 10, 'neigh_op_bot_5')
// (7, 8, 'neigh_op_tnl_5')
// (7, 9, 'neigh_op_lft_5')
// (7, 10, 'neigh_op_bnl_5')

reg n85 = 0;
// (5, 8, 'neigh_op_tnr_6')
// (5, 9, 'neigh_op_rgt_6')
// (5, 10, 'neigh_op_bnr_6')
// (6, 3, 'sp12_v_t_23')
// (6, 4, 'sp12_v_b_23')
// (6, 5, 'sp12_v_b_20')
// (6, 6, 'local_g3_3')
// (6, 6, 'lutff_5/in_1')
// (6, 6, 'sp12_v_b_19')
// (6, 7, 'sp12_v_b_16')
// (6, 8, 'neigh_op_top_6')
// (6, 8, 'sp12_v_b_15')
// (6, 9, 'lutff_6/out')
// (6, 9, 'sp12_v_b_12')
// (6, 10, 'neigh_op_bot_6')
// (6, 10, 'sp12_v_b_11')
// (6, 11, 'sp12_v_b_8')
// (6, 12, 'sp12_v_b_7')
// (6, 13, 'sp12_v_b_4')
// (6, 14, 'sp12_v_b_3')
// (6, 15, 'sp12_v_b_0')
// (7, 8, 'neigh_op_tnl_6')
// (7, 9, 'neigh_op_lft_6')
// (7, 10, 'neigh_op_bnl_6')

wire n86;
// (5, 11, 'neigh_op_tnr_5')
// (5, 12, 'neigh_op_rgt_5')
// (5, 13, 'neigh_op_bnr_5')
// (6, 11, 'neigh_op_top_5')
// (6, 12, 'local_g1_5')
// (6, 12, 'lutff_5/out')
// (6, 12, 'lutff_7/in_3')
// (6, 13, 'neigh_op_bot_5')
// (7, 11, 'neigh_op_tnl_5')
// (7, 12, 'local_g0_5')
// (7, 12, 'lutff_0/in_1')
// (7, 12, 'neigh_op_lft_5')
// (7, 13, 'neigh_op_bnl_5')

reg n87 = 0;
// (5, 11, 'neigh_op_tnr_7')
// (5, 12, 'neigh_op_rgt_7')
// (5, 13, 'neigh_op_bnr_7')
// (6, 11, 'neigh_op_top_7')
// (6, 12, 'local_g0_7')
// (6, 12, 'lutff_3/in_0')
// (6, 12, 'lutff_7/in_2')
// (6, 12, 'lutff_7/out')
// (6, 13, 'neigh_op_bot_7')
// (7, 11, 'neigh_op_tnl_7')
// (7, 12, 'local_g0_7')
// (7, 12, 'lutff_1/in_2')
// (7, 12, 'neigh_op_lft_7')
// (7, 13, 'neigh_op_bnl_7')

reg n88 = 0;
// (5, 12, 'neigh_op_tnr_7')
// (5, 13, 'neigh_op_rgt_7')
// (5, 14, 'neigh_op_bnr_7')
// (6, 12, 'local_g1_7')
// (6, 12, 'lutff_3/in_3')
// (6, 12, 'lutff_5/in_3')
// (6, 12, 'neigh_op_top_7')
// (6, 13, 'local_g1_7')
// (6, 13, 'lutff_7/in_3')
// (6, 13, 'lutff_7/out')
// (6, 14, 'neigh_op_bot_7')
// (7, 12, 'neigh_op_tnl_7')
// (7, 13, 'neigh_op_lft_7')
// (7, 14, 'neigh_op_bnl_7')

wire n89;
// (6, 1, 'neigh_op_tnr_0')
// (6, 1, 'sp4_r_v_b_29')
// (6, 2, 'neigh_op_rgt_0')
// (6, 2, 'sp4_r_v_b_16')
// (6, 3, 'neigh_op_bnr_0')
// (6, 3, 'sp4_r_v_b_5')
// (7, 0, 'span4_vert_29')
// (7, 1, 'neigh_op_top_0')
// (7, 1, 'sp4_v_b_29')
// (7, 2, 'lutff_0/out')
// (7, 2, 'sp4_v_b_16')
// (7, 3, 'local_g1_5')
// (7, 3, 'lutff_3/in_3')
// (7, 3, 'neigh_op_bot_0')
// (7, 3, 'sp4_v_b_5')
// (8, 1, 'neigh_op_tnl_0')
// (8, 2, 'neigh_op_lft_0')
// (8, 3, 'neigh_op_bnl_0')

reg n90 = 0;
// (6, 1, 'neigh_op_tnr_2')
// (6, 2, 'neigh_op_rgt_2')
// (6, 3, 'neigh_op_bnr_2')
// (7, 1, 'neigh_op_top_2')
// (7, 2, 'local_g0_2')
// (7, 2, 'lutff_2/in_2')
// (7, 2, 'lutff_2/out')
// (7, 3, 'local_g0_2')
// (7, 3, 'lutff_5/in_1')
// (7, 3, 'neigh_op_bot_2')
// (8, 1, 'neigh_op_tnl_2')
// (8, 2, 'local_g1_2')
// (8, 2, 'lutff_1/in_2')
// (8, 2, 'neigh_op_lft_2')
// (8, 3, 'neigh_op_bnl_2')

reg n91 = 0;
// (6, 1, 'neigh_op_tnr_4')
// (6, 2, 'neigh_op_rgt_4')
// (6, 3, 'neigh_op_bnr_4')
// (7, 1, 'neigh_op_top_4')
// (7, 2, 'local_g1_4')
// (7, 2, 'lutff_2/in_3')
// (7, 2, 'lutff_4/in_3')
// (7, 2, 'lutff_4/out')
// (7, 3, 'local_g1_4')
// (7, 3, 'lutff_5/in_0')
// (7, 3, 'neigh_op_bot_4')
// (8, 1, 'neigh_op_tnl_4')
// (8, 2, 'local_g1_4')
// (8, 2, 'lutff_0/in_1')
// (8, 2, 'neigh_op_lft_4')
// (8, 3, 'neigh_op_bnl_4')

wire n92;
// (6, 2, 'neigh_op_tnr_1')
// (6, 3, 'neigh_op_rgt_1')
// (6, 4, 'neigh_op_bnr_1')
// (7, 2, 'neigh_op_top_1')
// (7, 2, 'sp4_r_v_b_46')
// (7, 3, 'local_g0_0')
// (7, 3, 'lutff_0/in_2')
// (7, 3, 'lutff_1/out')
// (7, 3, 'lutff_6/in_2')
// (7, 3, 'sp4_r_v_b_35')
// (7, 4, 'neigh_op_bot_1')
// (7, 4, 'sp4_r_v_b_22')
// (7, 5, 'sp4_r_v_b_11')
// (8, 1, 'sp4_v_t_46')
// (8, 2, 'neigh_op_tnl_1')
// (8, 2, 'sp4_v_b_46')
// (8, 3, 'neigh_op_lft_1')
// (8, 3, 'sp4_v_b_35')
// (8, 4, 'neigh_op_bnl_1')
// (8, 4, 'sp4_v_b_22')
// (8, 5, 'sp4_v_b_11')

wire n93;
// (6, 2, 'neigh_op_tnr_2')
// (6, 3, 'neigh_op_rgt_2')
// (6, 4, 'neigh_op_bnr_2')
// (7, 2, 'neigh_op_top_2')
// (7, 3, 'local_g1_2')
// (7, 3, 'lutff_2/out')
// (7, 3, 'lutff_3/in_2')
// (7, 4, 'neigh_op_bot_2')
// (8, 2, 'neigh_op_tnl_2')
// (8, 3, 'neigh_op_lft_2')
// (8, 4, 'neigh_op_bnl_2')

wire n94;
// (6, 2, 'neigh_op_tnr_3')
// (6, 3, 'neigh_op_rgt_3')
// (6, 3, 'sp4_r_v_b_38')
// (6, 4, 'neigh_op_bnr_3')
// (6, 4, 'sp4_r_v_b_27')
// (6, 5, 'local_g2_6')
// (6, 5, 'lutff_0/in_2')
// (6, 5, 'lutff_5/in_3')
// (6, 5, 'sp4_r_v_b_14')
// (6, 6, 'sp4_r_v_b_3')
// (7, 2, 'neigh_op_top_3')
// (7, 2, 'sp4_v_t_38')
// (7, 3, 'local_g1_3')
// (7, 3, 'lutff_3/out')
// (7, 3, 'lutff_4/in_0')
// (7, 3, 'sp4_v_b_38')
// (7, 4, 'neigh_op_bot_3')
// (7, 4, 'sp4_v_b_27')
// (7, 5, 'sp4_v_b_14')
// (7, 6, 'sp4_v_b_3')
// (8, 2, 'neigh_op_tnl_3')
// (8, 3, 'neigh_op_lft_3')
// (8, 4, 'neigh_op_bnl_3')

wire n95;
// (6, 2, 'neigh_op_tnr_5')
// (6, 3, 'neigh_op_rgt_5')
// (6, 4, 'neigh_op_bnr_5')
// (7, 2, 'neigh_op_top_5')
// (7, 3, 'local_g0_5')
// (7, 3, 'lutff_0/in_3')
// (7, 3, 'lutff_5/out')
// (7, 3, 'lutff_6/in_3')
// (7, 4, 'neigh_op_bot_5')
// (8, 2, 'neigh_op_tnl_5')
// (8, 3, 'neigh_op_lft_5')
// (8, 4, 'neigh_op_bnl_5')

wire n96;
// (6, 2, 'neigh_op_tnr_6')
// (6, 3, 'neigh_op_rgt_6')
// (6, 4, 'neigh_op_bnr_6')
// (7, 2, 'neigh_op_top_6')
// (7, 3, 'local_g1_6')
// (7, 3, 'lutff_4/in_1')
// (7, 3, 'lutff_6/out')
// (7, 4, 'neigh_op_bot_6')
// (8, 2, 'neigh_op_tnl_6')
// (8, 3, 'neigh_op_lft_6')
// (8, 4, 'neigh_op_bnl_6')

wire n97;
// (6, 3, 'neigh_op_tnr_7')
// (6, 4, 'neigh_op_rgt_7')
// (6, 5, 'neigh_op_bnr_7')
// (7, 3, 'local_g1_7')
// (7, 3, 'lutff_3/in_1')
// (7, 3, 'neigh_op_top_7')
// (7, 4, 'lutff_7/out')
// (7, 5, 'neigh_op_bot_7')
// (8, 3, 'neigh_op_tnl_7')
// (8, 4, 'neigh_op_lft_7')
// (8, 5, 'neigh_op_bnl_7')

reg n98 = 0;
// (6, 4, 'neigh_op_tnr_2')
// (6, 5, 'local_g3_2')
// (6, 5, 'lutff_4/in_1')
// (6, 5, 'neigh_op_rgt_2')
// (6, 6, 'local_g1_2')
// (6, 6, 'lutff_0/in_3')
// (6, 6, 'lutff_4/in_3')
// (6, 6, 'neigh_op_bnr_2')
// (7, 4, 'neigh_op_top_2')
// (7, 5, 'local_g0_2')
// (7, 5, 'lutff_2/in_2')
// (7, 5, 'lutff_2/out')
// (7, 6, 'neigh_op_bot_2')
// (8, 4, 'neigh_op_tnl_2')
// (8, 5, 'neigh_op_lft_2')
// (8, 6, 'neigh_op_bnl_2')

reg n99 = 0;
// (6, 4, 'neigh_op_tnr_4')
// (6, 5, 'local_g3_4')
// (6, 5, 'lutff_4/in_3')
// (6, 5, 'neigh_op_rgt_4')
// (6, 5, 'sp4_r_v_b_40')
// (6, 6, 'local_g0_4')
// (6, 6, 'local_g0_5')
// (6, 6, 'lutff_2/in_2')
// (6, 6, 'lutff_5/in_2')
// (6, 6, 'neigh_op_bnr_4')
// (6, 6, 'sp4_r_v_b_29')
// (6, 7, 'sp4_r_v_b_16')
// (6, 8, 'sp4_r_v_b_5')
// (7, 4, 'neigh_op_top_4')
// (7, 4, 'sp4_v_t_40')
// (7, 5, 'local_g0_4')
// (7, 5, 'local_g1_4')
// (7, 5, 'lutff_0/in_1')
// (7, 5, 'lutff_4/in_3')
// (7, 5, 'lutff_4/out')
// (7, 5, 'lutff_7/in_3')
// (7, 5, 'sp4_v_b_40')
// (7, 6, 'neigh_op_bot_4')
// (7, 6, 'sp4_v_b_29')
// (7, 7, 'sp4_v_b_16')
// (7, 8, 'sp4_v_b_5')
// (8, 4, 'neigh_op_tnl_4')
// (8, 5, 'neigh_op_lft_4')
// (8, 6, 'neigh_op_bnl_4')

reg n100 = 0;
// (6, 4, 'neigh_op_tnr_7')
// (6, 5, 'local_g3_7')
// (6, 5, 'lutff_4/in_2')
// (6, 5, 'neigh_op_rgt_7')
// (6, 5, 'sp4_r_v_b_46')
// (6, 6, 'local_g1_7')
// (6, 6, 'local_g2_3')
// (6, 6, 'lutff_2/in_3')
// (6, 6, 'lutff_4/in_2')
// (6, 6, 'lutff_7/in_3')
// (6, 6, 'neigh_op_bnr_7')
// (6, 6, 'sp4_r_v_b_35')
// (6, 7, 'sp4_r_v_b_22')
// (6, 8, 'sp4_r_v_b_11')
// (7, 4, 'neigh_op_top_7')
// (7, 4, 'sp4_v_t_46')
// (7, 5, 'local_g0_7')
// (7, 5, 'lutff_1/in_2')
// (7, 5, 'lutff_7/in_2')
// (7, 5, 'lutff_7/out')
// (7, 5, 'sp4_v_b_46')
// (7, 6, 'neigh_op_bot_7')
// (7, 6, 'sp4_v_b_35')
// (7, 7, 'sp4_v_b_22')
// (7, 8, 'sp4_v_b_11')
// (8, 4, 'neigh_op_tnl_7')
// (8, 5, 'neigh_op_lft_7')
// (8, 6, 'neigh_op_bnl_7')

wire n101;
// (6, 4, 'sp4_r_v_b_43')
// (6, 5, 'sp4_r_v_b_30')
// (6, 6, 'neigh_op_tnr_3')
// (6, 6, 'sp4_r_v_b_19')
// (6, 7, 'neigh_op_rgt_3')
// (6, 7, 'sp4_r_v_b_6')
// (6, 8, 'neigh_op_bnr_3')
// (7, 3, 'sp4_v_t_43')
// (7, 4, 'sp4_v_b_43')
// (7, 5, 'sp4_v_b_30')
// (7, 6, 'neigh_op_top_3')
// (7, 6, 'sp4_v_b_19')
// (7, 7, 'local_g1_6')
// (7, 7, 'lutff_3/out')
// (7, 7, 'lutff_7/in_2')
// (7, 7, 'sp4_v_b_6')
// (7, 8, 'neigh_op_bot_3')
// (8, 6, 'neigh_op_tnl_3')
// (8, 7, 'neigh_op_lft_3')
// (8, 8, 'neigh_op_bnl_3')

reg n102 = 0;
// (6, 6, 'local_g3_7')
// (6, 6, 'lutff_2/in_0')
// (6, 6, 'neigh_op_tnr_7')
// (6, 7, 'neigh_op_rgt_7')
// (6, 8, 'neigh_op_bnr_7')
// (7, 6, 'neigh_op_top_7')
// (7, 7, 'lutff_7/out')
// (7, 8, 'neigh_op_bot_7')
// (8, 6, 'neigh_op_tnl_7')
// (8, 7, 'neigh_op_lft_7')
// (8, 8, 'neigh_op_bnl_7')

wire n103;
// (6, 6, 'neigh_op_tnr_0')
// (6, 6, 'sp4_r_v_b_45')
// (6, 7, 'neigh_op_rgt_0')
// (6, 7, 'sp4_r_v_b_32')
// (6, 8, 'neigh_op_bnr_0')
// (6, 8, 'sp4_r_v_b_21')
// (6, 9, 'sp4_r_v_b_8')
// (7, 5, 'sp4_v_t_45')
// (7, 6, 'neigh_op_top_0')
// (7, 6, 'sp4_v_b_45')
// (7, 7, 'local_g1_0')
// (7, 7, 'lutff_0/out')
// (7, 7, 'lutff_4/in_1')
// (7, 7, 'sp4_v_b_32')
// (7, 8, 'local_g1_5')
// (7, 8, 'lutff_0/in_2')
// (7, 8, 'neigh_op_bot_0')
// (7, 8, 'sp4_v_b_21')
// (7, 9, 'sp4_v_b_8')
// (8, 6, 'neigh_op_tnl_0')
// (8, 7, 'neigh_op_lft_0')
// (8, 8, 'neigh_op_bnl_0')

wire n104;
// (6, 6, 'neigh_op_tnr_2')
// (6, 7, 'neigh_op_rgt_2')
// (6, 8, 'neigh_op_bnr_2')
// (7, 6, 'neigh_op_top_2')
// (7, 7, 'local_g2_2')
// (7, 7, 'lutff_1/in_3')
// (7, 7, 'lutff_2/out')
// (7, 8, 'neigh_op_bot_2')
// (8, 6, 'neigh_op_tnl_2')
// (8, 7, 'neigh_op_lft_2')
// (8, 8, 'neigh_op_bnl_2')

wire n105;
// (6, 6, 'neigh_op_tnr_5')
// (6, 7, 'neigh_op_rgt_5')
// (6, 8, 'neigh_op_bnr_5')
// (7, 6, 'neigh_op_top_5')
// (7, 7, 'local_g0_5')
// (7, 7, 'lutff_1/in_0')
// (7, 7, 'lutff_3/in_0')
// (7, 7, 'lutff_5/out')
// (7, 8, 'neigh_op_bot_5')
// (8, 6, 'neigh_op_tnl_5')
// (8, 7, 'neigh_op_lft_5')
// (8, 8, 'neigh_op_bnl_5')

wire n106;
// (6, 6, 'sp4_r_v_b_46')
// (6, 7, 'local_g3_3')
// (6, 7, 'lutff_3/in_1')
// (6, 7, 'lutff_7/in_1')
// (6, 7, 'neigh_op_tnr_3')
// (6, 7, 'sp4_r_v_b_35')
// (6, 8, 'local_g3_3')
// (6, 8, 'local_g3_6')
// (6, 8, 'lutff_3/in_0')
// (6, 8, 'lutff_6/in_0')
// (6, 8, 'neigh_op_rgt_3')
// (6, 8, 'sp4_r_v_b_22')
// (6, 9, 'neigh_op_bnr_3')
// (6, 9, 'sp4_r_v_b_11')
// (7, 5, 'sp4_r_v_b_42')
// (7, 5, 'sp4_v_t_46')
// (7, 6, 'sp4_r_v_b_31')
// (7, 6, 'sp4_v_b_46')
// (7, 7, 'local_g3_2')
// (7, 7, 'lutff_3/in_2')
// (7, 7, 'neigh_op_top_3')
// (7, 7, 'sp4_r_v_b_18')
// (7, 7, 'sp4_v_b_35')
// (7, 8, 'lutff_3/out')
// (7, 8, 'sp4_r_v_b_7')
// (7, 8, 'sp4_v_b_22')
// (7, 9, 'neigh_op_bot_3')
// (7, 9, 'sp4_v_b_11')
// (8, 4, 'sp4_v_t_42')
// (8, 5, 'sp4_v_b_42')
// (8, 6, 'sp4_v_b_31')
// (8, 7, 'neigh_op_tnl_3')
// (8, 7, 'sp4_v_b_18')
// (8, 8, 'neigh_op_lft_3')
// (8, 8, 'sp4_v_b_7')
// (8, 9, 'neigh_op_bnl_3')

wire n107;
// (6, 7, 'neigh_op_tnr_1')
// (6, 8, 'neigh_op_rgt_1')
// (6, 9, 'neigh_op_bnr_1')
// (7, 7, 'neigh_op_top_1')
// (7, 8, 'local_g0_1')
// (7, 8, 'lutff_1/out')
// (7, 8, 'lutff_5/in_2')
// (7, 9, 'neigh_op_bot_1')
// (8, 7, 'neigh_op_tnl_1')
// (8, 8, 'neigh_op_lft_1')
// (8, 9, 'neigh_op_bnl_1')

wire n108;
// (6, 7, 'neigh_op_tnr_2')
// (6, 8, 'neigh_op_rgt_2')
// (6, 9, 'neigh_op_bnr_2')
// (7, 7, 'local_g0_2')
// (7, 7, 'lutff_7/in_3')
// (7, 7, 'neigh_op_top_2')
// (7, 8, 'lutff_2/out')
// (7, 9, 'neigh_op_bot_2')
// (8, 7, 'neigh_op_tnl_2')
// (8, 8, 'neigh_op_lft_2')
// (8, 9, 'neigh_op_bnl_2')

wire n109;
// (6, 7, 'neigh_op_tnr_4')
// (6, 8, 'neigh_op_rgt_4')
// (6, 9, 'neigh_op_bnr_4')
// (7, 7, 'neigh_op_top_4')
// (7, 8, 'local_g0_4')
// (7, 8, 'lutff_4/out')
// (7, 8, 'lutff_6/in_0')
// (7, 9, 'neigh_op_bot_4')
// (8, 7, 'neigh_op_tnl_4')
// (8, 8, 'neigh_op_lft_4')
// (8, 9, 'neigh_op_bnl_4')

wire n110;
// (6, 7, 'neigh_op_tnr_5')
// (6, 8, 'neigh_op_rgt_5')
// (6, 9, 'neigh_op_bnr_5')
// (7, 7, 'neigh_op_top_5')
// (7, 8, 'local_g0_5')
// (7, 8, 'lutff_5/out')
// (7, 8, 'lutff_6/in_3')
// (7, 8, 'lutff_7/in_2')
// (7, 9, 'neigh_op_bot_5')
// (8, 7, 'neigh_op_tnl_5')
// (8, 8, 'neigh_op_lft_5')
// (8, 9, 'neigh_op_bnl_5')

wire n111;
// (6, 7, 'neigh_op_tnr_6')
// (6, 8, 'local_g2_6')
// (6, 8, 'lutff_6/in_2')
// (6, 8, 'neigh_op_rgt_6')
// (6, 9, 'neigh_op_bnr_6')
// (7, 7, 'neigh_op_top_6')
// (7, 8, 'lutff_6/out')
// (7, 9, 'neigh_op_bot_6')
// (8, 7, 'neigh_op_tnl_6')
// (8, 8, 'neigh_op_lft_6')
// (8, 9, 'neigh_op_bnl_6')

wire n112;
// (6, 7, 'neigh_op_tnr_7')
// (6, 8, 'local_g3_7')
// (6, 8, 'lutff_1/in_3')
// (6, 8, 'lutff_7/in_3')
// (6, 8, 'neigh_op_rgt_7')
// (6, 9, 'neigh_op_bnr_7')
// (7, 7, 'neigh_op_top_7')
// (7, 8, 'lutff_7/out')
// (7, 9, 'neigh_op_bot_7')
// (8, 7, 'neigh_op_tnl_7')
// (8, 8, 'neigh_op_lft_7')
// (8, 9, 'neigh_op_bnl_7')

wire n113;
// (6, 8, 'neigh_op_tnr_1')
// (6, 9, 'neigh_op_rgt_1')
// (6, 10, 'neigh_op_bnr_1')
// (7, 8, 'neigh_op_top_1')
// (7, 9, 'lutff_1/out')
// (7, 10, 'neigh_op_bot_1')
// (8, 8, 'neigh_op_tnl_1')
// (8, 9, 'local_g1_1')
// (8, 9, 'lutff_2/in_2')
// (8, 9, 'neigh_op_lft_1')
// (8, 10, 'neigh_op_bnl_1')

wire n114;
// (6, 8, 'neigh_op_tnr_2')
// (6, 9, 'neigh_op_rgt_2')
// (6, 10, 'neigh_op_bnr_2')
// (7, 8, 'neigh_op_top_2')
// (7, 9, 'lutff_2/out')
// (7, 10, 'neigh_op_bot_2')
// (8, 8, 'neigh_op_tnl_2')
// (8, 9, 'local_g0_2')
// (8, 9, 'local_g1_2')
// (8, 9, 'lutff_1/in_1')
// (8, 9, 'lutff_2/in_1')
// (8, 9, 'lutff_5/in_1')
// (8, 9, 'neigh_op_lft_2')
// (8, 10, 'neigh_op_bnl_2')

wire n115;
// (6, 8, 'neigh_op_tnr_4')
// (6, 9, 'neigh_op_rgt_4')
// (6, 10, 'neigh_op_bnr_4')
// (7, 8, 'local_g1_4')
// (7, 8, 'lutff_0/in_1')
// (7, 8, 'neigh_op_top_4')
// (7, 9, 'lutff_4/out')
// (7, 10, 'neigh_op_bot_4')
// (8, 8, 'local_g2_4')
// (8, 8, 'lutff_2/in_2')
// (8, 8, 'neigh_op_tnl_4')
// (8, 9, 'neigh_op_lft_4')
// (8, 10, 'local_g2_4')
// (8, 10, 'lutff_0/in_2')
// (8, 10, 'neigh_op_bnl_4')

wire n116;
// (6, 8, 'neigh_op_tnr_5')
// (6, 9, 'neigh_op_rgt_5')
// (6, 10, 'neigh_op_bnr_5')
// (7, 8, 'neigh_op_top_5')
// (7, 9, 'lutff_5/out')
// (7, 10, 'neigh_op_bot_5')
// (8, 8, 'neigh_op_tnl_5')
// (8, 9, 'local_g0_5')
// (8, 9, 'lutff_3/in_2')
// (8, 9, 'neigh_op_lft_5')
// (8, 10, 'neigh_op_bnl_5')

wire n117;
// (6, 8, 'neigh_op_tnr_7')
// (6, 9, 'neigh_op_rgt_7')
// (6, 10, 'neigh_op_bnr_7')
// (7, 8, 'neigh_op_top_7')
// (7, 9, 'local_g1_7')
// (7, 9, 'lutff_3/in_3')
// (7, 9, 'lutff_7/out')
// (7, 10, 'neigh_op_bot_7')
// (8, 8, 'neigh_op_tnl_7')
// (8, 9, 'neigh_op_lft_7')
// (8, 10, 'neigh_op_bnl_7')

reg n118 = 0;
// (6, 9, 'neigh_op_tnr_4')
// (6, 10, 'neigh_op_rgt_4')
// (6, 11, 'neigh_op_bnr_4')
// (7, 9, 'neigh_op_top_4')
// (7, 10, 'local_g0_4')
// (7, 10, 'lutff_4/in_2')
// (7, 10, 'lutff_4/out')
// (7, 11, 'neigh_op_bot_4')
// (8, 9, 'neigh_op_tnl_4')
// (8, 10, 'local_g0_4')
// (8, 10, 'local_g1_4')
// (8, 10, 'lutff_1/in_3')
// (8, 10, 'lutff_2/in_0')
// (8, 10, 'lutff_3/in_3')
// (8, 10, 'lutff_4/in_1')
// (8, 10, 'neigh_op_lft_4')
// (8, 11, 'neigh_op_bnl_4')

reg n119 = 0;
// (6, 9, 'neigh_op_tnr_5')
// (6, 10, 'neigh_op_rgt_5')
// (6, 11, 'neigh_op_bnr_5')
// (7, 9, 'neigh_op_top_5')
// (7, 10, 'local_g0_5')
// (7, 10, 'lutff_5/in_2')
// (7, 10, 'lutff_5/out')
// (7, 11, 'neigh_op_bot_5')
// (8, 9, 'neigh_op_tnl_5')
// (8, 10, 'local_g0_5')
// (8, 10, 'local_g1_5')
// (8, 10, 'lutff_2/in_3')
// (8, 10, 'lutff_3/in_0')
// (8, 10, 'lutff_4/in_0')
// (8, 10, 'lutff_6/in_3')
// (8, 10, 'neigh_op_lft_5')
// (8, 11, 'neigh_op_bnl_5')

reg n120 = 0;
// (6, 9, 'neigh_op_tnr_6')
// (6, 10, 'neigh_op_rgt_6')
// (6, 11, 'neigh_op_bnr_6')
// (7, 9, 'neigh_op_top_6')
// (7, 10, 'local_g0_6')
// (7, 10, 'lutff_6/in_2')
// (7, 10, 'lutff_6/out')
// (7, 11, 'neigh_op_bot_6')
// (8, 9, 'neigh_op_tnl_6')
// (8, 10, 'local_g0_6')
// (8, 10, 'local_g1_6')
// (8, 10, 'lutff_2/in_1')
// (8, 10, 'lutff_3/in_1')
// (8, 10, 'lutff_4/in_2')
// (8, 10, 'lutff_5/in_3')
// (8, 10, 'neigh_op_lft_6')
// (8, 11, 'neigh_op_bnl_6')

reg n121 = 0;
// (6, 9, 'neigh_op_tnr_7')
// (6, 10, 'neigh_op_rgt_7')
// (6, 11, 'neigh_op_bnr_7')
// (7, 9, 'neigh_op_top_7')
// (7, 10, 'local_g0_7')
// (7, 10, 'lutff_7/in_2')
// (7, 10, 'lutff_7/out')
// (7, 11, 'neigh_op_bot_7')
// (8, 9, 'neigh_op_tnl_7')
// (8, 10, 'local_g0_7')
// (8, 10, 'local_g1_7')
// (8, 10, 'lutff_2/in_2')
// (8, 10, 'lutff_3/in_2')
// (8, 10, 'lutff_4/in_3')
// (8, 10, 'lutff_7/in_3')
// (8, 10, 'neigh_op_lft_7')
// (8, 11, 'neigh_op_bnl_7')

wire led;
// (6, 9, 'sp4_h_r_9')
// (7, 9, 'sp4_h_r_20')
// (8, 8, 'neigh_op_tnr_6')
// (8, 8, 'sp4_r_v_b_41')
// (8, 9, 'neigh_op_rgt_6')
// (8, 9, 'sp4_h_r_33')
// (8, 9, 'sp4_r_v_b_28')
// (8, 10, 'neigh_op_bnr_6')
// (8, 10, 'sp4_r_v_b_17')
// (8, 11, 'local_g1_4')
// (8, 11, 'lutff_5/in_2')
// (8, 11, 'sp4_r_v_b_4')
// (9, 7, 'sp4_v_t_41')
// (9, 8, 'neigh_op_top_6')
// (9, 8, 'sp4_v_b_41')
// (9, 9, 'lutff_6/out')
// (9, 9, 'sp4_h_r_44')
// (9, 9, 'sp4_v_b_28')
// (9, 10, 'neigh_op_bot_6')
// (9, 10, 'sp4_v_b_17')
// (9, 11, 'sp4_v_b_4')
// (10, 8, 'neigh_op_tnl_6')
// (10, 9, 'neigh_op_lft_6')
// (10, 9, 'sp4_h_l_44')
// (10, 9, 'sp4_h_r_9')
// (10, 10, 'neigh_op_bnl_6')
// (11, 9, 'sp4_h_r_20')
// (12, 9, 'sp4_h_r_33')
// (13, 9, 'io_1/D_OUT_0')
// (13, 9, 'io_1/PAD')
// (13, 9, 'local_g0_1')
// (13, 9, 'span4_horz_33')

reg n123 = 0;
// (6, 11, 'neigh_op_tnr_2')
// (6, 12, 'local_g2_2')
// (6, 12, 'lutff_3/in_1')
// (6, 12, 'neigh_op_rgt_2')
// (6, 13, 'neigh_op_bnr_2')
// (7, 11, 'neigh_op_top_2')
// (7, 12, 'local_g0_2')
// (7, 12, 'lutff_2/in_2')
// (7, 12, 'lutff_2/out')
// (7, 13, 'neigh_op_bot_2')
// (8, 11, 'neigh_op_tnl_2')
// (8, 12, 'neigh_op_lft_2')
// (8, 13, 'neigh_op_bnl_2')

reg n124 = 0;
// (6, 11, 'neigh_op_tnr_3')
// (6, 12, 'local_g2_3')
// (6, 12, 'lutff_3/in_2')
// (6, 12, 'neigh_op_rgt_3')
// (6, 13, 'neigh_op_bnr_3')
// (7, 11, 'neigh_op_top_3')
// (7, 12, 'local_g0_3')
// (7, 12, 'lutff_3/in_2')
// (7, 12, 'lutff_3/out')
// (7, 13, 'neigh_op_bot_3')
// (8, 11, 'neigh_op_tnl_3')
// (8, 12, 'neigh_op_lft_3')
// (8, 13, 'neigh_op_bnl_3')

reg n125 = 0;
// (6, 11, 'neigh_op_tnr_4')
// (6, 12, 'neigh_op_rgt_4')
// (6, 13, 'neigh_op_bnr_4')
// (7, 11, 'neigh_op_top_4')
// (7, 12, 'local_g0_4')
// (7, 12, 'lutff_4/in_2')
// (7, 12, 'lutff_4/out')
// (7, 13, 'neigh_op_bot_4')
// (8, 11, 'neigh_op_tnl_4')
// (8, 12, 'local_g0_4')
// (8, 12, 'local_g1_4')
// (8, 12, 'lutff_4/in_0')
// (8, 12, 'lutff_7/in_0')
// (8, 12, 'neigh_op_lft_4')
// (8, 13, 'neigh_op_bnl_4')

reg n126 = 0;
// (6, 11, 'neigh_op_tnr_5')
// (6, 12, 'neigh_op_rgt_5')
// (6, 13, 'neigh_op_bnr_5')
// (7, 11, 'neigh_op_top_5')
// (7, 12, 'local_g2_5')
// (7, 12, 'lutff_5/in_2')
// (7, 12, 'lutff_5/out')
// (7, 13, 'neigh_op_bot_5')
// (8, 11, 'neigh_op_tnl_5')
// (8, 12, 'local_g0_5')
// (8, 12, 'local_g1_5')
// (8, 12, 'lutff_4/in_1')
// (8, 12, 'lutff_7/in_1')
// (8, 12, 'neigh_op_lft_5')
// (8, 13, 'neigh_op_bnl_5')

reg n127 = 0;
// (6, 11, 'neigh_op_tnr_6')
// (6, 12, 'neigh_op_rgt_6')
// (6, 13, 'neigh_op_bnr_6')
// (7, 11, 'neigh_op_top_6')
// (7, 12, 'local_g0_6')
// (7, 12, 'lutff_6/in_2')
// (7, 12, 'lutff_6/out')
// (7, 13, 'neigh_op_bot_6')
// (8, 11, 'neigh_op_tnl_6')
// (8, 12, 'local_g0_6')
// (8, 12, 'local_g1_6')
// (8, 12, 'lutff_4/in_2')
// (8, 12, 'lutff_7/in_2')
// (8, 12, 'neigh_op_lft_6')
// (8, 13, 'neigh_op_bnl_6')

reg n128 = 0;
// (6, 11, 'neigh_op_tnr_7')
// (6, 12, 'neigh_op_rgt_7')
// (6, 13, 'neigh_op_bnr_7')
// (7, 11, 'neigh_op_top_7')
// (7, 12, 'local_g2_7')
// (7, 12, 'lutff_7/in_2')
// (7, 12, 'lutff_7/out')
// (7, 13, 'neigh_op_bot_7')
// (8, 11, 'neigh_op_tnl_7')
// (8, 12, 'neigh_op_lft_7')
// (8, 13, 'local_g3_7')
// (8, 13, 'lutff_5/in_1')
// (8, 13, 'neigh_op_bnl_7')

reg n129 = 0;
// (6, 12, 'neigh_op_tnr_0')
// (6, 13, 'neigh_op_rgt_0')
// (6, 14, 'neigh_op_bnr_0')
// (7, 12, 'neigh_op_top_0')
// (7, 13, 'local_g0_0')
// (7, 13, 'lutff_0/in_2')
// (7, 13, 'lutff_0/out')
// (7, 14, 'neigh_op_bot_0')
// (8, 12, 'local_g2_0')
// (8, 12, 'local_g3_0')
// (8, 12, 'lutff_4/in_3')
// (8, 12, 'lutff_7/in_3')
// (8, 12, 'neigh_op_tnl_0')
// (8, 13, 'neigh_op_lft_0')
// (8, 14, 'neigh_op_bnl_0')

reg n130 = 0;
// (6, 12, 'neigh_op_tnr_1')
// (6, 13, 'neigh_op_rgt_1')
// (6, 14, 'neigh_op_bnr_1')
// (7, 12, 'neigh_op_top_1')
// (7, 13, 'local_g0_1')
// (7, 13, 'lutff_1/in_2')
// (7, 13, 'lutff_1/out')
// (7, 14, 'neigh_op_bot_1')
// (8, 12, 'neigh_op_tnl_1')
// (8, 13, 'local_g0_1')
// (8, 13, 'local_g1_1')
// (8, 13, 'lutff_0/in_1')
// (8, 13, 'lutff_1/in_1')
// (8, 13, 'neigh_op_lft_1')
// (8, 14, 'neigh_op_bnl_1')

reg n131 = 0;
// (6, 12, 'neigh_op_tnr_2')
// (6, 13, 'neigh_op_rgt_2')
// (6, 14, 'neigh_op_bnr_2')
// (7, 12, 'neigh_op_top_2')
// (7, 13, 'local_g0_2')
// (7, 13, 'lutff_2/in_2')
// (7, 13, 'lutff_2/out')
// (7, 14, 'neigh_op_bot_2')
// (8, 12, 'neigh_op_tnl_2')
// (8, 13, 'local_g0_2')
// (8, 13, 'local_g1_2')
// (8, 13, 'lutff_0/in_2')
// (8, 13, 'lutff_1/in_2')
// (8, 13, 'neigh_op_lft_2')
// (8, 14, 'neigh_op_bnl_2')

reg n132 = 0;
// (6, 12, 'neigh_op_tnr_3')
// (6, 13, 'neigh_op_rgt_3')
// (6, 14, 'neigh_op_bnr_3')
// (7, 12, 'neigh_op_top_3')
// (7, 13, 'local_g0_3')
// (7, 13, 'lutff_3/in_2')
// (7, 13, 'lutff_3/out')
// (7, 14, 'neigh_op_bot_3')
// (8, 12, 'neigh_op_tnl_3')
// (8, 13, 'local_g0_3')
// (8, 13, 'lutff_5/in_2')
// (8, 13, 'neigh_op_lft_3')
// (8, 14, 'neigh_op_bnl_3')

reg n133 = 0;
// (6, 12, 'neigh_op_tnr_4')
// (6, 13, 'neigh_op_rgt_4')
// (6, 14, 'neigh_op_bnr_4')
// (7, 12, 'neigh_op_top_4')
// (7, 13, 'local_g0_4')
// (7, 13, 'lutff_4/in_2')
// (7, 13, 'lutff_4/out')
// (7, 14, 'neigh_op_bot_4')
// (8, 12, 'neigh_op_tnl_4')
// (8, 13, 'local_g0_4')
// (8, 13, 'local_g1_4')
// (8, 13, 'lutff_0/in_3')
// (8, 13, 'lutff_1/in_3')
// (8, 13, 'neigh_op_lft_4')
// (8, 14, 'neigh_op_bnl_4')

reg n134 = 0;
// (6, 12, 'neigh_op_tnr_5')
// (6, 13, 'neigh_op_rgt_5')
// (6, 14, 'neigh_op_bnr_5')
// (7, 12, 'neigh_op_top_5')
// (7, 13, 'local_g0_5')
// (7, 13, 'lutff_5/in_2')
// (7, 13, 'lutff_5/out')
// (7, 14, 'neigh_op_bot_5')
// (8, 12, 'neigh_op_tnl_5')
// (8, 13, 'local_g1_5')
// (8, 13, 'lutff_7/in_1')
// (8, 13, 'neigh_op_lft_5')
// (8, 14, 'neigh_op_bnl_5')

reg n135 = 0;
// (6, 12, 'neigh_op_tnr_6')
// (6, 13, 'neigh_op_rgt_6')
// (6, 14, 'neigh_op_bnr_6')
// (7, 12, 'neigh_op_top_6')
// (7, 13, 'local_g0_6')
// (7, 13, 'lutff_6/in_2')
// (7, 13, 'lutff_6/out')
// (7, 14, 'neigh_op_bot_6')
// (8, 12, 'neigh_op_tnl_6')
// (8, 13, 'local_g1_6')
// (8, 13, 'lutff_7/in_2')
// (8, 13, 'neigh_op_lft_6')
// (8, 14, 'neigh_op_bnl_6')

reg n136 = 0;
// (6, 12, 'neigh_op_tnr_7')
// (6, 13, 'neigh_op_rgt_7')
// (6, 14, 'neigh_op_bnr_7')
// (7, 12, 'neigh_op_top_7')
// (7, 13, 'local_g0_7')
// (7, 13, 'lutff_7/in_2')
// (7, 13, 'lutff_7/out')
// (7, 14, 'neigh_op_bot_7')
// (8, 12, 'neigh_op_tnl_7')
// (8, 13, 'local_g1_7')
// (8, 13, 'lutff_7/in_3')
// (8, 13, 'neigh_op_lft_7')
// (8, 14, 'neigh_op_bnl_7')

reg n137 = 0;
// (7, 1, 'neigh_op_tnr_2')
// (7, 2, 'neigh_op_rgt_2')
// (7, 2, 'sp4_r_v_b_36')
// (7, 3, 'local_g1_1')
// (7, 3, 'lutff_0/in_0')
// (7, 3, 'lutff_4/in_2')
// (7, 3, 'neigh_op_bnr_2')
// (7, 3, 'sp4_r_v_b_25')
// (7, 4, 'sp4_r_v_b_12')
// (7, 5, 'sp4_r_v_b_1')
// (8, 1, 'neigh_op_top_2')
// (8, 1, 'sp4_v_t_36')
// (8, 2, 'local_g0_2')
// (8, 2, 'lutff_2/in_2')
// (8, 2, 'lutff_2/out')
// (8, 2, 'sp4_v_b_36')
// (8, 3, 'neigh_op_bot_2')
// (8, 3, 'sp4_v_b_25')
// (8, 4, 'sp4_v_b_12')
// (8, 5, 'sp4_v_b_1')
// (9, 1, 'neigh_op_tnl_2')
// (9, 2, 'neigh_op_lft_2')
// (9, 3, 'neigh_op_bnl_2')

reg n138 = 0;
// (7, 1, 'neigh_op_tnr_3')
// (7, 2, 'neigh_op_rgt_3')
// (7, 3, 'local_g0_3')
// (7, 3, 'lutff_1/in_2')
// (7, 3, 'neigh_op_bnr_3')
// (8, 1, 'neigh_op_top_3')
// (8, 2, 'local_g0_3')
// (8, 2, 'lutff_3/in_2')
// (8, 2, 'lutff_3/out')
// (8, 3, 'neigh_op_bot_3')
// (9, 1, 'neigh_op_tnl_3')
// (9, 2, 'neigh_op_lft_3')
// (9, 3, 'neigh_op_bnl_3')

reg n139 = 0;
// (7, 1, 'neigh_op_tnr_4')
// (7, 2, 'local_g2_4')
// (7, 2, 'lutff_0/in_0')
// (7, 2, 'neigh_op_rgt_4')
// (7, 3, 'neigh_op_bnr_4')
// (8, 1, 'neigh_op_top_4')
// (8, 2, 'local_g0_4')
// (8, 2, 'lutff_4/in_2')
// (8, 2, 'lutff_4/out')
// (8, 3, 'neigh_op_bot_4')
// (9, 1, 'neigh_op_tnl_4')
// (9, 2, 'neigh_op_lft_4')
// (9, 3, 'neigh_op_bnl_4')

reg n140 = 0;
// (7, 1, 'neigh_op_tnr_5')
// (7, 2, 'local_g2_5')
// (7, 2, 'lutff_0/in_1')
// (7, 2, 'neigh_op_rgt_5')
// (7, 3, 'neigh_op_bnr_5')
// (8, 1, 'neigh_op_top_5')
// (8, 2, 'local_g0_5')
// (8, 2, 'lutff_5/in_2')
// (8, 2, 'lutff_5/out')
// (8, 3, 'neigh_op_bot_5')
// (9, 1, 'neigh_op_tnl_5')
// (9, 2, 'neigh_op_lft_5')
// (9, 3, 'neigh_op_bnl_5')

reg n141 = 0;
// (7, 1, 'neigh_op_tnr_6')
// (7, 2, 'local_g2_6')
// (7, 2, 'lutff_0/in_2')
// (7, 2, 'neigh_op_rgt_6')
// (7, 3, 'neigh_op_bnr_6')
// (8, 1, 'neigh_op_top_6')
// (8, 2, 'local_g0_6')
// (8, 2, 'lutff_6/in_2')
// (8, 2, 'lutff_6/out')
// (8, 3, 'neigh_op_bot_6')
// (9, 1, 'neigh_op_tnl_6')
// (9, 2, 'neigh_op_lft_6')
// (9, 3, 'neigh_op_bnl_6')

reg n142 = 0;
// (7, 1, 'neigh_op_tnr_7')
// (7, 2, 'local_g2_7')
// (7, 2, 'lutff_0/in_3')
// (7, 2, 'neigh_op_rgt_7')
// (7, 3, 'neigh_op_bnr_7')
// (8, 1, 'neigh_op_top_7')
// (8, 2, 'local_g0_7')
// (8, 2, 'lutff_7/in_2')
// (8, 2, 'lutff_7/out')
// (8, 3, 'neigh_op_bot_7')
// (9, 1, 'neigh_op_tnl_7')
// (9, 2, 'neigh_op_lft_7')
// (9, 3, 'neigh_op_bnl_7')

reg n143 = 0;
// (7, 2, 'neigh_op_tnr_0')
// (7, 3, 'local_g3_0')
// (7, 3, 'lutff_0/in_1')
// (7, 3, 'lutff_4/in_3')
// (7, 3, 'neigh_op_rgt_0')
// (7, 4, 'neigh_op_bnr_0')
// (8, 2, 'neigh_op_top_0')
// (8, 3, 'local_g0_0')
// (8, 3, 'lutff_0/in_2')
// (8, 3, 'lutff_0/out')
// (8, 4, 'neigh_op_bot_0')
// (9, 2, 'neigh_op_tnl_0')
// (9, 3, 'neigh_op_lft_0')
// (9, 4, 'neigh_op_bnl_0')

reg n144 = 0;
// (7, 2, 'neigh_op_tnr_1')
// (7, 3, 'local_g3_1')
// (7, 3, 'lutff_1/in_3')
// (7, 3, 'neigh_op_rgt_1')
// (7, 4, 'neigh_op_bnr_1')
// (8, 2, 'neigh_op_top_1')
// (8, 3, 'local_g0_1')
// (8, 3, 'lutff_1/in_2')
// (8, 3, 'lutff_1/out')
// (8, 4, 'neigh_op_bot_1')
// (9, 2, 'neigh_op_tnl_1')
// (9, 3, 'neigh_op_lft_1')
// (9, 4, 'neigh_op_bnl_1')

reg n145 = 0;
// (7, 2, 'neigh_op_tnr_2')
// (7, 3, 'local_g3_2')
// (7, 3, 'lutff_5/in_2')
// (7, 3, 'neigh_op_rgt_2')
// (7, 4, 'neigh_op_bnr_2')
// (8, 2, 'neigh_op_top_2')
// (8, 3, 'local_g0_2')
// (8, 3, 'lutff_2/in_2')
// (8, 3, 'lutff_2/out')
// (8, 4, 'neigh_op_bot_2')
// (9, 2, 'neigh_op_tnl_2')
// (9, 3, 'neigh_op_lft_2')
// (9, 4, 'neigh_op_bnl_2')

reg n146 = 0;
// (7, 2, 'neigh_op_tnr_3')
// (7, 3, 'local_g3_3')
// (7, 3, 'lutff_5/in_3')
// (7, 3, 'neigh_op_rgt_3')
// (7, 4, 'neigh_op_bnr_3')
// (8, 2, 'neigh_op_top_3')
// (8, 3, 'local_g0_3')
// (8, 3, 'lutff_3/in_2')
// (8, 3, 'lutff_3/out')
// (8, 4, 'neigh_op_bot_3')
// (9, 2, 'neigh_op_tnl_3')
// (9, 3, 'neigh_op_lft_3')
// (9, 4, 'neigh_op_bnl_3')

reg n147 = 0;
// (7, 2, 'neigh_op_tnr_4')
// (7, 3, 'local_g2_4')
// (7, 3, 'lutff_2/in_0')
// (7, 3, 'neigh_op_rgt_4')
// (7, 4, 'neigh_op_bnr_4')
// (8, 2, 'neigh_op_top_4')
// (8, 3, 'local_g0_4')
// (8, 3, 'lutff_4/in_2')
// (8, 3, 'lutff_4/out')
// (8, 4, 'neigh_op_bot_4')
// (9, 2, 'neigh_op_tnl_4')
// (9, 3, 'neigh_op_lft_4')
// (9, 4, 'neigh_op_bnl_4')

reg n148 = 0;
// (7, 2, 'neigh_op_tnr_5')
// (7, 3, 'local_g2_5')
// (7, 3, 'lutff_2/in_1')
// (7, 3, 'neigh_op_rgt_5')
// (7, 4, 'neigh_op_bnr_5')
// (8, 2, 'neigh_op_top_5')
// (8, 3, 'local_g0_5')
// (8, 3, 'lutff_5/in_2')
// (8, 3, 'lutff_5/out')
// (8, 4, 'neigh_op_bot_5')
// (9, 2, 'neigh_op_tnl_5')
// (9, 3, 'neigh_op_lft_5')
// (9, 4, 'neigh_op_bnl_5')

reg n149 = 0;
// (7, 2, 'neigh_op_tnr_6')
// (7, 3, 'local_g2_6')
// (7, 3, 'lutff_2/in_2')
// (7, 3, 'neigh_op_rgt_6')
// (7, 4, 'neigh_op_bnr_6')
// (8, 2, 'neigh_op_top_6')
// (8, 3, 'local_g0_6')
// (8, 3, 'lutff_6/in_2')
// (8, 3, 'lutff_6/out')
// (8, 4, 'neigh_op_bot_6')
// (9, 2, 'neigh_op_tnl_6')
// (9, 3, 'neigh_op_lft_6')
// (9, 4, 'neigh_op_bnl_6')

reg n150 = 0;
// (7, 2, 'neigh_op_tnr_7')
// (7, 3, 'local_g2_7')
// (7, 3, 'lutff_2/in_3')
// (7, 3, 'neigh_op_rgt_7')
// (7, 4, 'neigh_op_bnr_7')
// (8, 2, 'neigh_op_top_7')
// (8, 3, 'local_g0_7')
// (8, 3, 'lutff_7/in_2')
// (8, 3, 'lutff_7/out')
// (8, 4, 'neigh_op_bot_7')
// (9, 2, 'neigh_op_tnl_7')
// (9, 3, 'neigh_op_lft_7')
// (9, 4, 'neigh_op_bnl_7')

reg n151 = 0;
// (7, 3, 'neigh_op_tnr_0')
// (7, 4, 'local_g3_0')
// (7, 4, 'lutff_7/in_0')
// (7, 4, 'neigh_op_rgt_0')
// (7, 5, 'neigh_op_bnr_0')
// (8, 3, 'neigh_op_top_0')
// (8, 4, 'local_g0_0')
// (8, 4, 'lutff_0/in_2')
// (8, 4, 'lutff_0/out')
// (8, 5, 'neigh_op_bot_0')
// (9, 3, 'neigh_op_tnl_0')
// (9, 4, 'neigh_op_lft_0')
// (9, 5, 'neigh_op_bnl_0')

reg n152 = 0;
// (7, 3, 'neigh_op_tnr_1')
// (7, 4, 'local_g3_1')
// (7, 4, 'lutff_7/in_1')
// (7, 4, 'neigh_op_rgt_1')
// (7, 5, 'neigh_op_bnr_1')
// (8, 3, 'neigh_op_top_1')
// (8, 4, 'local_g0_1')
// (8, 4, 'lutff_1/in_2')
// (8, 4, 'lutff_1/out')
// (8, 5, 'neigh_op_bot_1')
// (9, 3, 'neigh_op_tnl_1')
// (9, 4, 'neigh_op_lft_1')
// (9, 5, 'neigh_op_bnl_1')

reg n153 = 0;
// (7, 3, 'neigh_op_tnr_2')
// (7, 4, 'local_g3_2')
// (7, 4, 'lutff_7/in_2')
// (7, 4, 'neigh_op_rgt_2')
// (7, 5, 'neigh_op_bnr_2')
// (8, 3, 'neigh_op_top_2')
// (8, 4, 'local_g0_2')
// (8, 4, 'lutff_2/in_2')
// (8, 4, 'lutff_2/out')
// (8, 5, 'neigh_op_bot_2')
// (9, 3, 'neigh_op_tnl_2')
// (9, 4, 'neigh_op_lft_2')
// (9, 5, 'neigh_op_bnl_2')

reg n154 = 0;
// (7, 3, 'neigh_op_tnr_3')
// (7, 4, 'local_g3_3')
// (7, 4, 'lutff_7/in_3')
// (7, 4, 'neigh_op_rgt_3')
// (7, 5, 'neigh_op_bnr_3')
// (8, 3, 'neigh_op_top_3')
// (8, 4, 'local_g0_3')
// (8, 4, 'lutff_3/in_2')
// (8, 4, 'lutff_3/out')
// (8, 5, 'neigh_op_bot_3')
// (9, 3, 'neigh_op_tnl_3')
// (9, 4, 'neigh_op_lft_3')
// (9, 5, 'neigh_op_bnl_3')

wire n155;
// (7, 5, 'lutff_1/cout')
// (7, 5, 'lutff_2/in_3')

reg n156 = 0;
// (7, 5, 'neigh_op_tnr_2')
// (7, 6, 'neigh_op_rgt_2')
// (7, 7, 'neigh_op_bnr_2')
// (8, 5, 'neigh_op_top_2')
// (8, 6, 'local_g0_2')
// (8, 6, 'lutff_2/in_2')
// (8, 6, 'lutff_2/out')
// (8, 7, 'local_g0_2')
// (8, 7, 'lutff_1/in_1')
// (8, 7, 'neigh_op_bot_2')
// (9, 5, 'neigh_op_tnl_2')
// (9, 6, 'neigh_op_lft_2')
// (9, 7, 'neigh_op_bnl_2')

reg n157 = 0;
// (7, 5, 'neigh_op_tnr_3')
// (7, 6, 'neigh_op_rgt_3')
// (7, 7, 'neigh_op_bnr_3')
// (8, 5, 'neigh_op_top_3')
// (8, 6, 'local_g0_3')
// (8, 6, 'lutff_3/in_2')
// (8, 6, 'lutff_3/out')
// (8, 7, 'local_g0_3')
// (8, 7, 'lutff_1/in_2')
// (8, 7, 'neigh_op_bot_3')
// (9, 5, 'neigh_op_tnl_3')
// (9, 6, 'neigh_op_lft_3')
// (9, 7, 'neigh_op_bnl_3')

reg n158 = 0;
// (7, 5, 'neigh_op_tnr_7')
// (7, 6, 'neigh_op_rgt_7')
// (7, 7, 'neigh_op_bnr_7')
// (8, 5, 'neigh_op_top_7')
// (8, 6, 'local_g0_7')
// (8, 6, 'local_g1_7')
// (8, 6, 'lutff_0/in_1')
// (8, 6, 'lutff_7/in_3')
// (8, 6, 'lutff_7/out')
// (8, 7, 'local_g1_7')
// (8, 7, 'lutff_1/in_3')
// (8, 7, 'lutff_7/in_3')
// (8, 7, 'neigh_op_bot_7')
// (9, 5, 'neigh_op_tnl_7')
// (9, 6, 'neigh_op_lft_7')
// (9, 7, 'neigh_op_bnl_7')

wire n159;
// (7, 6, 'neigh_op_tnr_1')
// (7, 7, 'neigh_op_rgt_1')
// (7, 8, 'neigh_op_bnr_1')
// (8, 6, 'neigh_op_top_1')
// (8, 7, 'lutff_1/out')
// (8, 8, 'neigh_op_bot_1')
// (9, 6, 'neigh_op_tnl_1')
// (9, 7, 'local_g0_1')
// (9, 7, 'lutff_3/in_2')
// (9, 7, 'neigh_op_lft_1')
// (9, 8, 'neigh_op_bnl_1')

reg n160 = 0;
// (7, 6, 'neigh_op_tnr_7')
// (7, 7, 'neigh_op_rgt_7')
// (7, 8, 'neigh_op_bnr_7')
// (8, 5, 'sp4_r_v_b_39')
// (8, 6, 'local_g1_2')
// (8, 6, 'lutff_1/in_2')
// (8, 6, 'neigh_op_top_7')
// (8, 6, 'sp4_r_v_b_26')
// (8, 7, 'local_g0_7')
// (8, 7, 'lutff_1/in_0')
// (8, 7, 'lutff_7/in_2')
// (8, 7, 'lutff_7/out')
// (8, 7, 'sp4_r_v_b_15')
// (8, 8, 'neigh_op_bot_7')
// (8, 8, 'sp4_r_v_b_2')
// (9, 4, 'sp4_v_t_39')
// (9, 5, 'sp4_v_b_39')
// (9, 6, 'neigh_op_tnl_7')
// (9, 6, 'sp4_v_b_26')
// (9, 7, 'neigh_op_lft_7')
// (9, 7, 'sp4_v_b_15')
// (9, 8, 'neigh_op_bnl_7')
// (9, 8, 'sp4_v_b_2')

wire n161;
// (7, 7, 'neigh_op_tnr_2')
// (7, 8, 'local_g2_2')
// (7, 8, 'lutff_2/in_2')
// (7, 8, 'lutff_6/in_2')
// (7, 8, 'neigh_op_rgt_2')
// (7, 9, 'neigh_op_bnr_2')
// (8, 7, 'neigh_op_top_2')
// (8, 8, 'lutff_2/out')
// (8, 9, 'neigh_op_bot_2')
// (9, 7, 'neigh_op_tnl_2')
// (9, 8, 'neigh_op_lft_2')
// (9, 9, 'neigh_op_bnl_2')

wire n162;
// (7, 9, 'neigh_op_tnr_0')
// (7, 10, 'neigh_op_rgt_0')
// (7, 11, 'neigh_op_bnr_0')
// (8, 6, 'sp12_v_t_23')
// (8, 7, 'sp12_v_b_23')
// (8, 8, 'sp12_v_b_20')
// (8, 9, 'neigh_op_top_0')
// (8, 9, 'sp12_v_b_19')
// (8, 10, 'lutff_0/out')
// (8, 10, 'sp12_v_b_16')
// (8, 11, 'local_g1_0')
// (8, 11, 'lutff_5/in_0')
// (8, 11, 'neigh_op_bot_0')
// (8, 11, 'sp12_v_b_15')
// (8, 12, 'sp12_v_b_12')
// (8, 13, 'sp12_v_b_11')
// (8, 14, 'sp12_v_b_8')
// (8, 15, 'local_g3_7')
// (8, 15, 'lutff_1/in_1')
// (8, 15, 'sp12_v_b_7')
// (8, 16, 'sp12_v_b_4')
// (8, 17, 'span12_vert_3')
// (9, 9, 'neigh_op_tnl_0')
// (9, 10, 'neigh_op_lft_0')
// (9, 11, 'neigh_op_bnl_0')

wire n163;
// (7, 9, 'neigh_op_tnr_1')
// (7, 10, 'neigh_op_rgt_1')
// (7, 11, 'neigh_op_bnr_1')
// (8, 8, 'sp4_r_v_b_43')
// (8, 9, 'local_g0_6')
// (8, 9, 'lutff_4/in_2')
// (8, 9, 'neigh_op_top_1')
// (8, 9, 'sp4_r_v_b_30')
// (8, 10, 'lutff_1/out')
// (8, 10, 'sp4_r_v_b_19')
// (8, 11, 'neigh_op_bot_1')
// (8, 11, 'sp4_r_v_b_6')
// (9, 7, 'sp4_v_t_43')
// (9, 8, 'sp4_v_b_43')
// (9, 9, 'neigh_op_tnl_1')
// (9, 9, 'sp4_v_b_30')
// (9, 10, 'neigh_op_lft_1')
// (9, 10, 'sp4_v_b_19')
// (9, 11, 'neigh_op_bnl_1')
// (9, 11, 'sp4_v_b_6')

wire n164;
// (7, 9, 'neigh_op_tnr_5')
// (7, 10, 'neigh_op_rgt_5')
// (7, 11, 'neigh_op_bnr_5')
// (8, 9, 'local_g1_5')
// (8, 9, 'lutff_6/in_2')
// (8, 9, 'neigh_op_top_5')
// (8, 10, 'lutff_5/out')
// (8, 11, 'neigh_op_bot_5')
// (9, 9, 'neigh_op_tnl_5')
// (9, 10, 'neigh_op_lft_5')
// (9, 11, 'neigh_op_bnl_5')

wire n165;
// (7, 9, 'neigh_op_tnr_6')
// (7, 10, 'neigh_op_rgt_6')
// (7, 11, 'neigh_op_bnr_6')
// (8, 9, 'local_g1_6')
// (8, 9, 'lutff_5/in_2')
// (8, 9, 'neigh_op_top_6')
// (8, 10, 'lutff_6/out')
// (8, 11, 'neigh_op_bot_6')
// (9, 9, 'neigh_op_tnl_6')
// (9, 10, 'neigh_op_lft_6')
// (9, 11, 'neigh_op_bnl_6')

wire n166;
// (7, 9, 'neigh_op_tnr_7')
// (7, 10, 'neigh_op_rgt_7')
// (7, 11, 'neigh_op_bnr_7')
// (8, 9, 'local_g0_7')
// (8, 9, 'lutff_7/in_2')
// (8, 9, 'neigh_op_top_7')
// (8, 10, 'lutff_7/out')
// (8, 11, 'neigh_op_bot_7')
// (9, 9, 'neigh_op_tnl_7')
// (9, 10, 'neigh_op_lft_7')
// (9, 11, 'neigh_op_bnl_7')

wire n167;
// (7, 10, 'lutff_1/cout')
// (7, 10, 'lutff_2/in_3')

wire n168;
// (7, 10, 'lutff_2/cout')
// (7, 10, 'lutff_3/in_3')

wire n169;
// (7, 10, 'lutff_3/cout')
// (7, 10, 'lutff_4/in_3')

wire n170;
// (7, 10, 'lutff_4/cout')
// (7, 10, 'lutff_5/in_3')

wire n171;
// (7, 10, 'lutff_5/cout')
// (7, 10, 'lutff_6/in_3')

wire n172;
// (7, 10, 'lutff_6/cout')
// (7, 10, 'lutff_7/in_3')

wire n173;
// (7, 11, 'neigh_op_tnr_4')
// (7, 11, 'sp4_r_v_b_37')
// (7, 12, 'neigh_op_rgt_4')
// (7, 12, 'sp4_r_v_b_24')
// (7, 13, 'neigh_op_bnr_4')
// (7, 13, 'sp4_r_v_b_13')
// (7, 14, 'sp4_r_v_b_0')
// (8, 10, 'sp4_v_t_37')
// (8, 11, 'neigh_op_top_4')
// (8, 11, 'sp4_v_b_37')
// (8, 12, 'lutff_4/out')
// (8, 12, 'sp4_v_b_24')
// (8, 13, 'local_g0_5')
// (8, 13, 'lutff_1/in_0')
// (8, 13, 'neigh_op_bot_4')
// (8, 13, 'sp4_v_b_13')
// (8, 14, 'sp4_v_b_0')
// (9, 11, 'neigh_op_tnl_4')
// (9, 12, 'neigh_op_lft_4')
// (9, 13, 'neigh_op_bnl_4')

wire n174;
// (7, 11, 'neigh_op_tnr_5')
// (7, 12, 'neigh_op_rgt_5')
// (7, 13, 'neigh_op_bnr_5')
// (8, 11, 'local_g1_5')
// (8, 11, 'lutff_5/in_3')
// (8, 11, 'neigh_op_top_5')
// (8, 12, 'lutff_5/out')
// (8, 13, 'neigh_op_bot_5')
// (9, 11, 'neigh_op_tnl_5')
// (9, 12, 'neigh_op_lft_5')
// (9, 13, 'neigh_op_bnl_5')

wire n175;
// (7, 11, 'neigh_op_tnr_7')
// (7, 12, 'neigh_op_rgt_7')
// (7, 13, 'neigh_op_bnr_7')
// (8, 11, 'neigh_op_top_7')
// (8, 12, 'local_g0_7')
// (8, 12, 'lutff_5/in_2')
// (8, 12, 'lutff_7/out')
// (8, 13, 'neigh_op_bot_7')
// (9, 11, 'neigh_op_tnl_7')
// (9, 12, 'neigh_op_lft_7')
// (9, 13, 'neigh_op_bnl_7')

wire n176;
// (7, 12, 'lutff_1/cout')
// (7, 12, 'lutff_2/in_3')

wire n177;
// (7, 12, 'lutff_2/cout')
// (7, 12, 'lutff_3/in_3')

wire n178;
// (7, 12, 'lutff_3/cout')
// (7, 12, 'lutff_4/in_3')

wire n179;
// (7, 12, 'lutff_4/cout')
// (7, 12, 'lutff_5/in_3')

wire n180;
// (7, 12, 'lutff_5/cout')
// (7, 12, 'lutff_6/in_3')

wire n181;
// (7, 12, 'lutff_6/cout')
// (7, 12, 'lutff_7/in_3')

wire n182;
// (7, 12, 'lutff_7/cout')
// (7, 13, 'carry_in')
// (7, 13, 'carry_in_mux')
// (7, 13, 'lutff_0/in_3')

wire n183;
// (7, 12, 'neigh_op_tnr_0')
// (7, 13, 'neigh_op_rgt_0')
// (7, 14, 'neigh_op_bnr_0')
// (8, 10, 'sp4_r_v_b_36')
// (8, 11, 'sp4_r_v_b_25')
// (8, 12, 'local_g2_4')
// (8, 12, 'lutff_5/in_3')
// (8, 12, 'neigh_op_top_0')
// (8, 12, 'sp4_r_v_b_12')
// (8, 13, 'lutff_0/out')
// (8, 13, 'sp4_r_v_b_1')
// (8, 14, 'neigh_op_bot_0')
// (9, 9, 'sp4_v_t_36')
// (9, 10, 'sp4_v_b_36')
// (9, 11, 'sp4_v_b_25')
// (9, 12, 'neigh_op_tnl_0')
// (9, 12, 'sp4_v_b_12')
// (9, 13, 'neigh_op_lft_0')
// (9, 13, 'sp4_v_b_1')
// (9, 14, 'neigh_op_bnl_0')

wire n184;
// (7, 12, 'neigh_op_tnr_1')
// (7, 13, 'neigh_op_rgt_1')
// (7, 14, 'neigh_op_bnr_1')
// (8, 12, 'neigh_op_top_1')
// (8, 13, 'local_g2_1')
// (8, 13, 'lutff_1/out')
// (8, 13, 'lutff_3/in_2')
// (8, 14, 'neigh_op_bot_1')
// (9, 12, 'neigh_op_tnl_1')
// (9, 13, 'neigh_op_lft_1')
// (9, 14, 'neigh_op_bnl_1')

wire n185;
// (7, 12, 'neigh_op_tnr_5')
// (7, 13, 'neigh_op_rgt_5')
// (7, 14, 'neigh_op_bnr_5')
// (8, 10, 'sp4_r_v_b_46')
// (8, 11, 'local_g0_0')
// (8, 11, 'lutff_5/in_1')
// (8, 11, 'sp4_r_v_b_35')
// (8, 12, 'neigh_op_top_5')
// (8, 12, 'sp4_r_v_b_22')
// (8, 13, 'local_g3_5')
// (8, 13, 'lutff_3/in_1')
// (8, 13, 'lutff_5/out')
// (8, 13, 'sp4_r_v_b_11')
// (8, 14, 'neigh_op_bot_5')
// (9, 9, 'sp4_v_t_46')
// (9, 10, 'sp4_v_b_46')
// (9, 11, 'sp4_v_b_35')
// (9, 12, 'neigh_op_tnl_5')
// (9, 12, 'sp4_v_b_22')
// (9, 13, 'neigh_op_lft_5')
// (9, 13, 'sp4_v_b_11')
// (9, 14, 'neigh_op_bnl_5')

wire n186;
// (7, 13, 'lutff_0/cout')
// (7, 13, 'lutff_1/in_3')

wire n187;
// (7, 13, 'lutff_1/cout')
// (7, 13, 'lutff_2/in_3')

wire n188;
// (7, 13, 'lutff_2/cout')
// (7, 13, 'lutff_3/in_3')

wire n189;
// (7, 13, 'lutff_3/cout')
// (7, 13, 'lutff_4/in_3')

wire n190;
// (7, 13, 'lutff_4/cout')
// (7, 13, 'lutff_5/in_3')

wire n191;
// (7, 13, 'lutff_5/cout')
// (7, 13, 'lutff_6/in_3')

wire n192;
// (7, 13, 'lutff_6/cout')
// (7, 13, 'lutff_7/in_3')

wire n193;
// (8, 2, 'lutff_1/cout')
// (8, 2, 'lutff_2/in_3')

wire n194;
// (8, 2, 'lutff_2/cout')
// (8, 2, 'lutff_3/in_3')

wire n195;
// (8, 2, 'lutff_3/cout')
// (8, 2, 'lutff_4/in_3')

wire n196;
// (8, 2, 'lutff_4/cout')
// (8, 2, 'lutff_5/in_3')

wire n197;
// (8, 2, 'lutff_5/cout')
// (8, 2, 'lutff_6/in_3')

wire n198;
// (8, 2, 'lutff_6/cout')
// (8, 2, 'lutff_7/in_3')

wire n199;
// (8, 2, 'lutff_7/cout')
// (8, 3, 'carry_in')
// (8, 3, 'carry_in_mux')
// (8, 3, 'lutff_0/in_3')

wire n200;
// (8, 3, 'lutff_0/cout')
// (8, 3, 'lutff_1/in_3')

wire n201;
// (8, 3, 'lutff_1/cout')
// (8, 3, 'lutff_2/in_3')

wire n202;
// (8, 3, 'lutff_2/cout')
// (8, 3, 'lutff_3/in_3')

wire n203;
// (8, 3, 'lutff_3/cout')
// (8, 3, 'lutff_4/in_3')

wire n204;
// (8, 3, 'lutff_4/cout')
// (8, 3, 'lutff_5/in_3')

wire n205;
// (8, 3, 'lutff_5/cout')
// (8, 3, 'lutff_6/in_3')

wire n206;
// (8, 3, 'lutff_6/cout')
// (8, 3, 'lutff_7/in_3')

wire n207;
// (8, 3, 'lutff_7/cout')
// (8, 4, 'carry_in')
// (8, 4, 'carry_in_mux')
// (8, 4, 'lutff_0/in_3')

wire n208;
// (8, 4, 'lutff_0/cout')
// (8, 4, 'lutff_1/in_3')

wire n209;
// (8, 4, 'lutff_1/cout')
// (8, 4, 'lutff_2/in_3')

wire n210;
// (8, 4, 'lutff_2/cout')
// (8, 4, 'lutff_3/in_3')

wire btn2;
// (8, 5, 'sp4_r_v_b_40')
// (8, 5, 'sp4_r_v_b_46')
// (8, 6, 'sp4_r_v_b_29')
// (8, 6, 'sp4_r_v_b_35')
// (8, 7, 'sp4_r_v_b_16')
// (8, 7, 'sp4_r_v_b_22')
// (8, 8, 'sp4_r_v_b_11')
// (8, 8, 'sp4_r_v_b_5')
// (8, 9, 'sp4_r_v_b_40')
// (8, 10, 'sp4_r_v_b_29')
// (8, 11, 'sp4_r_v_b_16')
// (8, 12, 'sp4_r_v_b_5')
// (9, 4, 'sp4_h_r_5')
// (9, 4, 'sp4_v_t_40')
// (9, 4, 'sp4_v_t_46')
// (9, 5, 'sp4_v_b_40')
// (9, 5, 'sp4_v_b_46')
// (9, 6, 'sp4_v_b_29')
// (9, 6, 'sp4_v_b_35')
// (9, 7, 'local_g0_6')
// (9, 7, 'local_g1_0')
// (9, 7, 'lutff_3/in_0')
// (9, 7, 'lutff_7/in_3')
// (9, 7, 'sp4_v_b_16')
// (9, 7, 'sp4_v_b_22')
// (9, 8, 'sp4_v_b_11')
// (9, 8, 'sp4_v_b_5')
// (9, 8, 'sp4_v_t_40')
// (9, 9, 'local_g2_0')
// (9, 9, 'lutff_6/in_0')
// (9, 9, 'sp4_v_b_40')
// (9, 10, 'sp4_v_b_29')
// (9, 11, 'sp4_v_b_16')
// (9, 12, 'sp4_v_b_5')
// (10, 4, 'sp4_h_r_16')
// (10, 9, 'sp4_h_r_1')
// (11, 4, 'sp4_h_r_29')
// (11, 9, 'local_g0_4')
// (11, 9, 'lutff_0/in_0')
// (11, 9, 'sp4_h_r_12')
// (12, 3, 'neigh_op_tnr_0')
// (12, 3, 'neigh_op_tnr_4')
// (12, 4, 'neigh_op_rgt_0')
// (12, 4, 'neigh_op_rgt_4')
// (12, 4, 'sp4_h_r_40')
// (12, 5, 'neigh_op_bnr_0')
// (12, 5, 'neigh_op_bnr_4')
// (12, 9, 'sp4_h_r_25')
// (13, 1, 'span4_vert_t_12')
// (13, 2, 'span4_vert_b_12')
// (13, 3, 'span4_vert_b_8')
// (13, 4, 'io_0/D_IN_0')
// (13, 4, 'io_0/PAD')
// (13, 4, 'span4_horz_40')
// (13, 4, 'span4_vert_b_4')
// (13, 5, 'span4_vert_b_0')
// (13, 5, 'span4_vert_t_12')
// (13, 6, 'span4_vert_b_12')
// (13, 7, 'span4_vert_b_8')
// (13, 8, 'span4_vert_b_4')
// (13, 9, 'span4_horz_25')
// (13, 9, 'span4_vert_b_0')

wire n212;
// (8, 6, 'lutff_1/cout')
// (8, 6, 'lutff_2/in_3')

wire n213;
// (8, 6, 'lutff_2/cout')
// (8, 6, 'lutff_3/in_3')

reg n214 = 0;
// (8, 6, 'neigh_op_tnr_7')
// (8, 7, 'neigh_op_rgt_7')
// (8, 8, 'neigh_op_bnr_7')
// (9, 6, 'neigh_op_top_7')
// (9, 7, 'local_g1_7')
// (9, 7, 'lutff_3/in_1')
// (9, 7, 'lutff_7/out')
// (9, 8, 'neigh_op_bot_7')
// (10, 6, 'neigh_op_tnl_7')
// (10, 7, 'neigh_op_lft_7')
// (10, 8, 'neigh_op_bnl_7')

wire n215;
// (8, 8, 'neigh_op_tnr_1')
// (8, 9, 'local_g2_1')
// (8, 9, 'lutff_1/in_2')
// (8, 9, 'neigh_op_rgt_1')
// (8, 10, 'neigh_op_bnr_1')
// (9, 8, 'neigh_op_top_1')
// (9, 9, 'lutff_1/out')
// (9, 10, 'neigh_op_bot_1')
// (10, 8, 'neigh_op_tnl_1')
// (10, 9, 'neigh_op_lft_1')
// (10, 10, 'neigh_op_bnl_1')

wire n216;
// (8, 8, 'neigh_op_tnr_4')
// (8, 9, 'local_g3_4')
// (8, 9, 'lutff_0/in_1')
// (8, 9, 'neigh_op_rgt_4')
// (8, 10, 'neigh_op_bnr_4')
// (9, 8, 'neigh_op_top_4')
// (9, 9, 'local_g1_4')
// (9, 9, 'lutff_4/out')
// (9, 9, 'lutff_7/in_0')
// (9, 10, 'neigh_op_bot_4')
// (10, 8, 'neigh_op_tnl_4')
// (10, 9, 'neigh_op_lft_4')
// (10, 10, 'neigh_op_bnl_4')

wire n217;
// (8, 9, 'lutff_7/cout')
// (8, 10, 'carry_in')
// (8, 10, 'carry_in_mux')
// (8, 10, 'lutff_0/in_3')

wire n218;
// (8, 10, 'neigh_op_tnr_4')
// (8, 11, 'neigh_op_rgt_4')
// (8, 12, 'neigh_op_bnr_4')
// (9, 8, 'sp4_r_v_b_44')
// (9, 9, 'local_g2_1')
// (9, 9, 'lutff_6/in_3')
// (9, 9, 'sp4_r_v_b_33')
// (9, 10, 'neigh_op_top_4')
// (9, 10, 'sp4_r_v_b_20')
// (9, 11, 'lutff_4/out')
// (9, 11, 'sp4_r_v_b_9')
// (9, 12, 'neigh_op_bot_4')
// (10, 7, 'sp4_v_t_44')
// (10, 8, 'sp4_v_b_44')
// (10, 9, 'sp4_v_b_33')
// (10, 10, 'neigh_op_tnl_4')
// (10, 10, 'sp4_v_b_20')
// (10, 11, 'neigh_op_lft_4')
// (10, 11, 'sp4_v_b_9')
// (10, 12, 'neigh_op_bnl_4')

reg n219 = 0;
// (8, 10, 'neigh_op_tnr_6')
// (8, 11, 'neigh_op_rgt_6')
// (8, 12, 'neigh_op_bnr_6')
// (9, 10, 'neigh_op_top_6')
// (9, 11, 'local_g0_6')
// (9, 11, 'lutff_4/in_0')
// (9, 11, 'lutff_6/in_2')
// (9, 11, 'lutff_6/out')
// (9, 12, 'local_g1_6')
// (9, 12, 'lutff_1/in_2')
// (9, 12, 'neigh_op_bot_6')
// (10, 10, 'neigh_op_tnl_6')
// (10, 11, 'neigh_op_lft_6')
// (10, 12, 'neigh_op_bnl_6')

reg n220 = 0;
// (8, 10, 'neigh_op_tnr_7')
// (8, 11, 'neigh_op_rgt_7')
// (8, 12, 'neigh_op_bnr_7')
// (9, 10, 'neigh_op_top_7')
// (9, 11, 'local_g0_7')
// (9, 11, 'local_g1_7')
// (9, 11, 'lutff_4/in_1')
// (9, 11, 'lutff_6/in_3')
// (9, 11, 'lutff_7/in_3')
// (9, 11, 'lutff_7/out')
// (9, 12, 'local_g0_7')
// (9, 12, 'lutff_0/in_1')
// (9, 12, 'neigh_op_bot_7')
// (10, 10, 'neigh_op_tnl_7')
// (10, 11, 'neigh_op_lft_7')
// (10, 12, 'neigh_op_bnl_7')

reg n221 = 0;
// (8, 11, 'neigh_op_tnr_2')
// (8, 12, 'neigh_op_rgt_2')
// (8, 13, 'neigh_op_bnr_2')
// (9, 11, 'local_g0_2')
// (9, 11, 'lutff_4/in_2')
// (9, 11, 'neigh_op_top_2')
// (9, 12, 'local_g0_2')
// (9, 12, 'lutff_2/in_2')
// (9, 12, 'lutff_2/out')
// (9, 13, 'neigh_op_bot_2')
// (10, 11, 'neigh_op_tnl_2')
// (10, 12, 'neigh_op_lft_2')
// (10, 13, 'neigh_op_bnl_2')

reg n222 = 0;
// (8, 11, 'neigh_op_tnr_3')
// (8, 12, 'neigh_op_rgt_3')
// (8, 13, 'neigh_op_bnr_3')
// (9, 11, 'local_g0_3')
// (9, 11, 'lutff_4/in_3')
// (9, 11, 'neigh_op_top_3')
// (9, 12, 'local_g0_3')
// (9, 12, 'lutff_3/in_2')
// (9, 12, 'lutff_3/out')
// (9, 13, 'neigh_op_bot_3')
// (10, 11, 'neigh_op_tnl_3')
// (10, 12, 'neigh_op_lft_3')
// (10, 13, 'neigh_op_bnl_3')

reg n223 = 0;
// (9, 9, 'local_g1_0')
// (9, 9, 'lutff_6/in_1')
// (9, 9, 'sp4_h_r_8')
// (10, 8, 'neigh_op_tnr_0')
// (10, 9, 'neigh_op_rgt_0')
// (10, 9, 'sp4_h_r_21')
// (10, 10, 'neigh_op_bnr_0')
// (11, 8, 'neigh_op_top_0')
// (11, 9, 'lutff_0/out')
// (11, 9, 'sp4_h_r_32')
// (11, 10, 'neigh_op_bot_0')
// (12, 8, 'neigh_op_tnl_0')
// (12, 9, 'neigh_op_lft_0')
// (12, 9, 'sp4_h_r_45')
// (12, 10, 'neigh_op_bnl_0')
// (13, 9, 'span4_horz_45')

wire n224;
// (9, 12, 'lutff_1/cout')
// (9, 12, 'lutff_2/in_3')

wire n225;
// (9, 12, 'lutff_2/cout')
// (9, 12, 'lutff_3/in_3')

wire btn3;
// (11, 6, 'sp4_h_r_0')
// (12, 3, 'neigh_op_tnr_2')
// (12, 3, 'neigh_op_tnr_6')
// (12, 4, 'neigh_op_rgt_2')
// (12, 4, 'neigh_op_rgt_6')
// (12, 5, 'neigh_op_bnr_2')
// (12, 5, 'neigh_op_bnr_6')
// (12, 6, 'local_g1_5')
// (12, 6, 'lutff_3/in_3')
// (12, 6, 'sp4_h_r_13')
// (13, 2, 'span4_vert_t_14')
// (13, 3, 'span4_vert_b_14')
// (13, 4, 'io_1/D_IN_0')
// (13, 4, 'io_1/PAD')
// (13, 4, 'span4_vert_b_10')
// (13, 5, 'span4_vert_b_6')
// (13, 6, 'span4_horz_13')
// (13, 6, 'span4_vert_b_2')

wire btn4;
// (12, 5, 'neigh_op_tnr_0')
// (12, 5, 'neigh_op_tnr_4')
// (12, 6, 'local_g3_0')
// (12, 6, 'lutff_3/in_2')
// (12, 6, 'neigh_op_rgt_0')
// (12, 6, 'neigh_op_rgt_4')
// (12, 7, 'neigh_op_bnr_0')
// (12, 7, 'neigh_op_bnr_4')
// (13, 6, 'io_0/D_IN_0')
// (13, 6, 'io_0/PAD')

wire n228;
// (8, 6, 'lutff_0/cout')

wire n229;
// (8, 9, 'lutff_5/cout')

wire n230;
// (8, 9, 'lutff_0/cout')

wire n231;
// (7, 5, 'lutff_0/cout')

wire n232;
// (8, 9, 'lutff_2/cout')

wire n233;
// (9, 12, 'lutff_0/cout')

wire n234;
// (8, 9, 'lutff_4/cout')

wire n235;
// (7, 12, 'lutff_0/cout')

wire n236;
// (8, 9, 'lutff_6/cout')

wire n237;
// (8, 9, 'lutff_1/cout')

wire n238;
// (7, 10, 'lutff_0/cout')

wire n239;
// (8, 9, 'lutff_3/cout')

wire n240;
// (8, 2, 'lutff_0/cout')

wire n241;
// (8, 6, 'lutff_0/out')

wire n242;
// (8, 6, 'lutff_0/lout')

wire n243;
// (8, 6, 'carry_in_mux')

// Carry-In for (8 6)
assign n243 = 1;

wire n244;
// (9, 12, 'lutff_1/out')

wire n245;
// (9, 12, 'lutff_1/lout')

wire n246;
// (6, 8, 'lutff_4/lout')

wire n247;
// (6, 7, 'lutff_6/lout')

wire n248;
// (6, 9, 'lutff_3/lout')

wire n249;
// (7, 3, 'lutff_5/lout')

wire n250;
// (8, 9, 'lutff_5/out')

wire n251;
// (8, 9, 'lutff_5/lout')

wire n252;
// (8, 3, 'lutff_1/lout')

wire n253;
// (6, 6, 'lutff_4/lout')

wire n254;
// (7, 13, 'lutff_0/lout')

wire n255;
// (5, 5, 'lutff_3/lout')

wire n256;
// (5, 7, 'lutff_0/lout')

wire n257;
// (7, 7, 'lutff_2/lout')

wire n258;
// (8, 10, 'lutff_6/lout')

wire n259;
// (8, 11, 'lutff_5/lout')

wire n260;
// (8, 2, 'lutff_2/lout')

wire n261;
// (7, 10, 'lutff_4/lout')

wire n262;
// (7, 12, 'lutff_1/out')

wire n263;
// (7, 12, 'lutff_1/lout')

wire n264;
// (9, 11, 'lutff_4/lout')

wire n265;
// (8, 6, 'lutff_2/lout')

wire n266;
// (9, 12, 'lutff_3/lout')

wire n267;
// (6, 8, 'lutff_6/lout')

wire n268;
// (5, 9, 'lutff_0/lout')

wire n269;
// (6, 9, 'lutff_5/lout')

wire n270;
// (7, 9, 'lutff_2/lout')

wire n271;
// (8, 9, 'lutff_7/out')

wire n272;
// (8, 9, 'lutff_7/lout')

wire n273;
// (9, 9, 'lutff_4/lout')

wire n274;
// (5, 8, 'lutff_4/lout')

wire n275;
// (7, 8, 'lutff_6/lout')

wire n276;
// (8, 13, 'lutff_7/lout')

wire n277;
// (7, 13, 'lutff_2/lout')

wire n278;
// (5, 5, 'lutff_5/lout')

wire n279;
// (5, 7, 'lutff_2/lout')

wire n280;
// (7, 5, 'lutff_7/lout')

wire n281;
// (7, 7, 'lutff_4/lout')

wire n282;
// (8, 2, 'lutff_4/lout')

wire n283;
// (8, 4, 'lutff_1/lout')

wire n284;
// (7, 10, 'lutff_6/lout')

wire n285;
// (7, 12, 'lutff_3/lout')

wire n286;
// (6, 7, 'lutff_1/lout')

wire n287;
// (7, 3, 'lutff_0/lout')

wire n288;
// (7, 2, 'lutff_2/lout')

wire n289;
// (9, 11, 'lutff_6/lout')

wire n290;
// (8, 9, 'lutff_0/out')

wire n291;
// (8, 9, 'lutff_0/lout')

wire n292;
// (8, 9, 'carry_in_mux')

// Carry-In for (8 9)
assign n292 = 1;

wire n293;
// (5, 6, 'lutff_3/lout')

wire n294;
// (5, 8, 'lutff_6/lout')

wire n295;
// (8, 13, 'lutff_0/lout')

wire n296;
// (6, 5, 'lutff_3/lout')

wire n297;
// (7, 13, 'lutff_4/lout')

wire n298;
// (7, 5, 'lutff_0/out')

wire n299;
// (7, 5, 'lutff_0/lout')

wire n300;
// (7, 5, 'carry_in_mux')

// Carry-In for (7 5)
assign n300 = 1;

wire n301;
// (5, 5, 'lutff_7/lout')

wire n302;
// (8, 10, 'lutff_1/lout')

wire n303;
// (8, 2, 'lutff_6/lout')

wire n304;
// (8, 4, 'lutff_3/lout')

wire n305;
// (6, 8, 'lutff_1/lout')

wire n306;
// (6, 7, 'lutff_3/lout')

wire n307;
// (6, 9, 'lutff_0/lout')

wire n308;
// (7, 2, 'lutff_4/lout')

wire n309;
// (7, 3, 'lutff_2/lout')

wire n310;
// (8, 9, 'lutff_2/out')

wire n311;
// (8, 9, 'lutff_2/lout')

wire n312;
// (7, 12, 'lutff_5/lout')

wire n313;
// (7, 8, 'lutff_1/lout')

wire n314;
// (5, 9, 'lutff_7/lout')

wire n315;
// (6, 5, 'lutff_5/lout')

wire n316;
// (7, 5, 'lutff_2/lout')

wire n317;
// (8, 10, 'lutff_3/lout')

wire n318;
// (7, 10, 'lutff_1/out')

wire n319;
// (7, 10, 'lutff_1/lout')

wire n320;
// (9, 12, 'lutff_0/out')

wire n321;
// (9, 12, 'lutff_0/lout')

wire n322;
// (9, 12, 'carry_in_mux')

// Carry-In for (9 12)
assign n322 = 1;

wire n323;
// (6, 8, 'lutff_3/lout')

wire n324;
// (7, 3, 'lutff_4/lout')

wire n325;
// (6, 7, 'lutff_5/lout')

wire n326;
// (6, 9, 'lutff_2/lout')

wire n327;
// (7, 12, 'lutff_7/lout')

wire n328;
// (8, 7, 'lutff_7/lout')

wire n329;
// (5, 6, 'lutff_7/lout')

wire n330;
// (8, 9, 'lutff_4/out')

wire n331;
// (8, 9, 'lutff_4/lout')

wire n332;
// (5, 8, 'lutff_1/lout')

wire n333;
// (11, 7, 'lutff_7/lout')

wire n334;
// (7, 8, 'lutff_3/lout')

wire n335;
// (8, 3, 'lutff_3/lout')

wire n336;
// (6, 5, 'lutff_7/lout')

wire n337;
// (8, 2, 'lutff_1/out')

wire n338;
// (8, 2, 'lutff_1/lout')

wire n339;
// (6, 12, 'lutff_3/lout')

wire n340;
// (7, 10, 'lutff_3/lout')

wire n341;
// (8, 12, 'lutff_5/lout')

wire n342;
// (7, 12, 'lutff_0/out')

wire n343;
// (7, 12, 'lutff_0/lout')

wire n344;
// (7, 12, 'carry_in_mux')

// Carry-In for (7 12)
assign n344 = 1;

wire n345;
// (8, 6, 'lutff_1/out')

wire n346;
// (8, 6, 'lutff_1/lout')

wire n347;
// (9, 12, 'lutff_2/lout')

wire n348;
// (6, 7, 'lutff_7/lout')

wire n349;
// (6, 9, 'lutff_4/lout')

wire n350;
// (8, 9, 'lutff_6/out')

wire n351;
// (8, 9, 'lutff_6/lout')

wire n352;
// (5, 8, 'lutff_3/lout')

wire n353;
// (7, 8, 'lutff_5/lout')

wire n354;
// (6, 16, 'lutff_0/lout')

wire n355;
// (7, 9, 'lutff_4/lout')

wire n356;
// (6, 5, 'lutff_0/lout')

wire n357;
// (9, 9, 'lutff_6/lout')

wire n358;
// (8, 3, 'lutff_5/lout')

wire n359;
// (11, 9, 'lutff_0/lout')

wire n360;
// (5, 7, 'lutff_4/lout')

wire n361;
// (6, 12, 'lutff_5/lout')

wire n362;
// (7, 10, 'lutff_5/lout')

wire n363;
// (7, 12, 'lutff_2/lout')

wire n364;
// (6, 7, 'lutff_0/lout')

wire n365;
// (8, 12, 'lutff_7/lout')

wire n366;
// (8, 6, 'lutff_3/lout')

wire n367;
// (6, 9, 'lutff_6/lout')

wire n368;
// (7, 4, 'lutff_7/lout')

wire n369;
// (5, 8, 'lutff_5/lout')

wire n370;
// (7, 8, 'lutff_7/lout')

wire n371;
// (8, 3, 'lutff_7/lout')

wire n372;
// (7, 13, 'lutff_6/lout')

wire n373;
// (5, 7, 'lutff_6/lout')

wire n374;
// (6, 12, 'lutff_7/lout')

wire n375;
// (7, 10, 'lutff_7/lout')

wire n376;
// (7, 12, 'lutff_4/lout')

wire n377;
// (6, 7, 'lutff_2/lout')

wire n378;
// (8, 9, 'lutff_1/out')

wire n379;
// (8, 9, 'lutff_1/lout')

wire n380;
// (7, 8, 'lutff_0/lout')

wire n381;
// (5, 8, 'lutff_7/lout')

wire n382;
// (8, 13, 'lutff_1/lout')

wire n383;
// (5, 9, 'lutff_6/lout')

wire n384;
// (9, 9, 'lutff_1/lout')

wire n385;
// (8, 3, 'lutff_0/lout')

wire n386;
// (6, 5, 'lutff_4/lout')

wire n387;
// (7, 5, 'lutff_4/lout')

wire n388;
// (7, 7, 'lutff_1/lout')

wire n389;
// (7, 10, 'lutff_0/out')

wire n390;
// (7, 10, 'lutff_0/lout')

wire n391;
// (7, 10, 'carry_in_mux')

// Carry-In for (7 10)
assign n391 = 1;

wire n392;
// (8, 10, 'lutff_5/lout')

wire n393;
// (9, 7, 'lutff_3/lout')

wire n394;
// (8, 15, 'lutff_1/lout')

wire n395;
// (5, 10, 'lutff_7/lout')

wire n396;
// (6, 7, 'lutff_4/lout')

wire n397;
// (8, 9, 'lutff_3/out')

wire n398;
// (8, 9, 'lutff_3/lout')

wire n399;
// (6, 8, 'lutff_5/lout')

wire n400;
// (5, 8, 'lutff_0/lout')

wire n401;
// (7, 3, 'lutff_6/lout')

wire n402;
// (7, 8, 'lutff_2/lout')

wire n403;
// (8, 13, 'lutff_3/lout')

wire n404;
// (7, 9, 'lutff_1/lout')

wire n405;
// (8, 3, 'lutff_2/lout')

wire n406;
// (6, 6, 'lutff_5/lout')

wire n407;
// (7, 13, 'lutff_1/lout')

wire n408;
// (5, 5, 'lutff_4/lout')

wire n409;
// (5, 7, 'lutff_1/lout')

wire n410;
// (7, 7, 'lutff_3/lout')

wire n411;
// (7, 10, 'lutff_2/lout')

wire n412;
// (8, 10, 'lutff_7/lout')

wire n413;
// (8, 12, 'lutff_4/lout')

wire n414;
// (8, 2, 'lutff_3/lout')

wire n415;
// (8, 4, 'lutff_0/lout')

wire n416;
// (5, 8, 'lutff_2/lout')

wire n417;
// (6, 8, 'lutff_7/lout')

wire n418;
// (5, 9, 'lutff_1/lout')

wire n419;
// (7, 8, 'lutff_4/lout')

wire n420;
// (7, 9, 'lutff_3/lout')

wire n421;
// (8, 13, 'lutff_5/lout')

wire n422;
// (8, 3, 'lutff_4/lout')

wire n423;
// (6, 6, 'lutff_7/lout')

wire n424;
// (7, 13, 'lutff_3/lout')

wire n425;
// (8, 10, 'lutff_0/lout')

wire n426;
// (5, 7, 'lutff_3/lout')

wire n427;
// (7, 7, 'lutff_5/lout')

wire n428;
// (9, 7, 'lutff_7/lout')

wire n429;
// (7, 2, 'lutff_0/lout')

wire n430;
// (8, 2, 'lutff_5/lout')

wire n431;
// (8, 4, 'lutff_2/lout')

wire n432;
// (8, 7, 'lutff_1/lout')

wire n433;
// (6, 8, 'lutff_0/lout')

wire n434;
// (7, 3, 'lutff_1/lout')

wire n435;
// (9, 11, 'lutff_7/lout')

wire n436;
// (8, 8, 'lutff_2/lout')

wire n437;
// (6, 5, 'lutff_1/lout')

wire n438;
// (7, 9, 'lutff_5/lout')

wire n439;
// (6, 6, 'lutff_0/lout')

wire n440;
// (9, 9, 'lutff_7/lout')

wire n441;
// (8, 3, 'lutff_6/lout')

wire n442;
// (7, 13, 'lutff_5/lout')

wire n443;
// (7, 5, 'lutff_1/out')

wire n444;
// (7, 5, 'lutff_1/lout')

wire n445;
// (8, 10, 'lutff_2/lout')

wire n446;
// (5, 7, 'lutff_5/lout')

wire n447;
// (7, 7, 'lutff_7/lout')

wire n448;
// (8, 2, 'lutff_7/lout')

wire n449;
// (6, 8, 'lutff_2/lout')

wire n450;
// (7, 3, 'lutff_3/lout')

wire n451;
// (6, 9, 'lutff_1/lout')

wire n452;
// (7, 12, 'lutff_6/lout')

wire n453;
// (8, 6, 'lutff_7/lout')

wire n454;
// (7, 9, 'lutff_7/lout')

wire n455;
// (6, 6, 'lutff_2/lout')

wire n456;
// (12, 6, 'lutff_3/lout')

wire n457;
// (5, 5, 'lutff_1/lout')

wire n458;
// (7, 13, 'lutff_7/lout')

wire n459;
// (7, 7, 'lutff_0/lout')

wire n460;
// (8, 10, 'lutff_4/lout')

wire n461;
// (5, 7, 'lutff_7/lout')

wire n462;
// (8, 2, 'lutff_0/out')

wire n463;
// (8, 2, 'lutff_0/lout')

wire n464;
// (8, 2, 'carry_in_mux')

// Carry-In for (8 2)
assign n464 = 1;

wire n465;
// (6, 13, 'lutff_7/lout')

assign n242 = /* LUT    8  6  0 */ 1'b0;
assign n245 = /* LUT    9 12  1 */ 1'b0;
assign n251 = /* LUT    8  9  5 */ 1'b0;
assign n263 = /* LUT    7 12  1 */ 1'b0;
assign n272 = /* LUT    8  9  7 */ 1'b0;
assign n291 = /* LUT    8  9  0 */ 1'b0;
assign n299 = /* LUT    7  5  0 */ 1'b0;
assign n311 = /* LUT    8  9  2 */ 1'b0;
assign n319 = /* LUT    7 10  1 */ 1'b0;
assign n321 = /* LUT    9 12  0 */ 1'b0;
assign n331 = /* LUT    8  9  4 */ 1'b0;
assign n338 = /* LUT    8  2  1 */ 1'b0;
assign n343 = /* LUT    7 12  0 */ 1'b0;
assign n346 = /* LUT    8  6  1 */ 1'b0;
assign n351 = /* LUT    8  9  6 */ 1'b0;
assign n379 = /* LUT    8  9  1 */ 1'b0;
assign n390 = /* LUT    7 10  0 */ 1'b0;
assign n398 = /* LUT    8  9  3 */ 1'b0;
assign n444 = /* LUT    7  5  1 */ 1'b0;
assign n463 = /* LUT    8  2  0 */ 1'b0;
assign n246 = /* LUT    6  8  4 */ (n83 ? (n82 ? (n13 ? !n34 : 1'b0) : 1'b0) : 1'b0);
assign n247 = /* LUT    6  7  6 */ (n39 ? (n66 ? (n44 ? !n65 : 1'b1) : 1'b1) : 1'b1);
assign n248 = /* LUT    6  9  3 */ (n79 ? (n23 ? 1'b0 : (n80 ? !n47 : 1'b1)) : (n80 ? !n47 : 1'b1));
assign n249 = /* LUT    7  3  5 */ (n146 ? 1'b0 : (n145 ? 1'b0 : (n90 ? 1'b0 : !n91)));
assign n252 = /* LUT    8  3  1 */ (n200 ? !n144 : n144);
assign n253 = /* LUT    6  6  4 */ (n98 ? (n100 ? 1'b1 : n77) : (n100 ? 1'b0 : n69));
assign n254 = /* LUT    7 13  0 */ (n182 ? !n129 : n129);
assign n255 = /* LUT    5  5  3 */ (n54 ? !n22 : 1'b0);
assign n256 = /* LUT    5  7  0 */ (n48 ? (n16 ? 1'b0 : !n10) : 1'b0);
assign n257 = /* LUT    7  7  2 */ (n17 ? (n16 ? (n48 ? !n10 : 1'b0) : 1'b0) : 1'b0);
assign n258 = /* LUT    8 10  6 */ !n119;
assign n259 = /* LUT    8 11  5 */ (n174 ? (led ? (n185 ? !n162 : 1'b0) : 1'b0) : 1'b0);
assign n260 = /* LUT    8  2  2 */ (n193 ? !n137 : n137);
assign n261 = /* LUT    7 10  4 */ (n169 ? !n118 : n118);
assign n264 = /* LUT    9 11  4 */ (n222 ? (n221 ? (n220 ? !n219 : 1'b0) : 1'b0) : 1'b0);
assign n265 = /* LUT    8  6  2 */ (n212 ? !n156 : n156);
assign n266 = /* LUT    9 12  3 */ (n225 ? !n222 : n222);
assign n267 = /* LUT    6  8  6 */ (n75 ? (n111 ? (n42 ? n106 : 1'b1) : 1'b1) : 1'b1);
assign n268 = /* LUT    5  9  0 */ (n17 ? (n48 ? 1'b1 : (n10 ? 1'b1 : n16)) : (n48 ? (n10 ? 1'b1 : n16) : (n10 ? n16 : 1'b1)));
assign n269 = /* LUT    6  9  5 */ (n17 ? (n16 ? (n10 ? !n48 : 1'b0) : 1'b0) : 1'b0);
assign n270 = /* LUT    7  9  2 */ 1'b1;
assign n273 = /* LUT    9  9  4 */ !n17;
assign n274 = /* LUT    5  8  4 */ (n41 ? 1'b0 : (n27 ? 1'b0 : !n51));
assign n275 = /* LUT    7  8  6 */ (n110 ? 1'b0 : (n161 ? 1'b0 : (n40 ? n109 : 1'b1)));
assign n276 = /* LUT    8 13  7 */ (n136 ? 1'b0 : (n135 ? 1'b0 : !n134));
assign n277 = /* LUT    7 13  2 */ (n187 ? !n131 : n131);
assign n278 = /* LUT    5  5  5 */ n9;
assign n279 = /* LUT    5  7  2 */ (n17 ? 1'b0 : !n10);
assign n280 = /* LUT    7  5  7 */ (n99 ? !n100 : n100);
assign n281 = /* LUT    7  7  4 */ (n12 ? 1'b0 : (n40 ? n103 : 1'b1));
assign n282 = /* LUT    8  2  4 */ (n195 ? !n139 : n139);
assign n283 = /* LUT    8  4  1 */ (n208 ? !n152 : n152);
assign n284 = /* LUT    7 10  6 */ (n171 ? !n120 : n120);
assign n285 = /* LUT    7 12  3 */ (n177 ? !n124 : n124);
assign n286 = /* LUT    6  7  1 */ (n13 ? !n34 : 1'b0);
assign n287 = /* LUT    7  3  0 */ (n95 ? (n92 ? (n143 ? 1'b0 : !n137) : 1'b0) : 1'b0);
assign n288 = /* LUT    7  2  2 */ (n91 ? !n90 : n90);
assign n289 = /* LUT    9 11  6 */ (n220 ? !n219 : n219);
assign n293 = /* LUT    5  6  3 */ !n31;
assign n294 = /* LUT    5  8  6 */ (n23 ? (n50 ? (n17 ? !n43 : 1'b1) : 1'b0) : 1'b1);
assign n295 = /* LUT    8 13  0 */ (n133 ? 1'b0 : (n131 ? 1'b0 : !n130));
assign n296 = /* LUT    6  5  3 */ (n6 ? 1'b1 : n58);
assign n297 = /* LUT    7 13  4 */ (n189 ? !n133 : n133);
assign n301 = /* LUT    5  5  7 */ (n31 ? !n30 : n30);
assign n302 = /* LUT    8 10  1 */ !n118;
assign n303 = /* LUT    8  2  6 */ (n197 ? !n141 : n141);
assign n304 = /* LUT    8  4  3 */ (n210 ? !n154 : n154);
assign n305 = /* LUT    6  8  1 */ (n112 ? (n67 ? (n42 ? n75 : 1'b0) : 1'b0) : 1'b0);
assign n306 = /* LUT    6  7  3 */ (n64 ? (n53 ? !n106 : 1'b0) : 1'b0);
assign n307 = /* LUT    6  9  0 */ (n17 ? (n16 ? (n48 ? 1'b0 : !n10) : 1'b0) : 1'b0);
assign n308 = /* LUT    7  2  4 */ !n91;
assign n309 = /* LUT    7  3  2 */ (n150 ? 1'b0 : (n149 ? 1'b0 : (n148 ? 1'b0 : !n147)));
assign n312 = /* LUT    7 12  5 */ (n179 ? !n126 : n126);
assign n313 = /* LUT    7  8  1 */ (n48 ? (n17 ? (n10 ? !n16 : n16) : (n10 ? n16 : 1'b1)) : (n17 ? 1'b1 : (n10 ? 1'b1 : n16)));
assign n314 = /* LUT    5  9  7 */ (n48 ? (n16 ? (n17 ? 1'b1 : n10) : 1'b1) : (n16 ? 1'b1 : (n17 ? !n10 : 1'b1)));
assign n315 = /* LUT    6  5  5 */ (n94 ? (n9 ? (n25 ? !n57 : 1'b0) : 1'b0) : 1'b0);
assign n316 = /* LUT    7  5  2 */ (n155 ? !n98 : n98);
assign n317 = /* LUT    8 10  3 */ (n118 ? (n121 ? 1'b0 : (n120 ? 1'b0 : !n119)) : 1'b0);
assign n323 = /* LUT    6  8  3 */ (n26 ? (n45 ? (n53 ? !n106 : 1'b0) : 1'b0) : 1'b0);
assign n324 = /* LUT    7  3  4 */ (n143 ? (n137 ? (n96 ? n94 : 1'b0) : 1'b0) : 1'b0);
assign n325 = /* LUT    6  7  5 */ (n11 ? (n67 ? !n65 : 1'b1) : 1'b1);
assign n326 = /* LUT    6  9  2 */ (n47 ? (n80 ? 1'b0 : (n49 ? n17 : 1'b1)) : 1'b1);
assign n327 = /* LUT    7 12  7 */ (n181 ? !n128 : n128);
assign n328 = /* LUT    8  7  7 */ (n158 ? !n160 : n160);
assign n329 = /* LUT    5  6  7 */ (n31 ? (n62 ? !n30 : 1'b0) : 1'b1);
assign n332 = /* LUT    5  8  1 */ (n49 ? (n47 ? !n17 : 1'b0) : 1'b0);
assign n333 = /* LUT   11  7  7 */ (n17 ? !n10 : n10);
assign n334 = /* LUT    7  8  3 */ (n47 ? (n16 ? (n48 ? !n17 : 1'b0) : 1'b0) : 1'b0);
assign n335 = /* LUT    8  3  3 */ (n202 ? !n146 : n146);
assign n336 = /* LUT    6  5  7 */ !n9;
assign n339 = /* LUT    6 12  3 */ (n88 ? (n124 ? 1'b0 : (n123 ? 1'b0 : !n87)) : 1'b0);
assign n340 = /* LUT    7 10  3 */ (n168 ? !n16 : n16);
assign n341 = /* LUT    8 12  5 */ (n183 ? (n175 ? (n22 ? n19 : 1'b0) : 1'b0) : 1'b0);
assign n347 = /* LUT    9 12  2 */ (n224 ? !n221 : n221);
assign n348 = /* LUT    6  7  7 */ (n66 ? (n73 ? n106 : 1'b1) : 1'b1);
assign n349 = /* LUT    6  9  4 */ (n84 ? (n23 ? 1'b0 : (n79 ? !n47 : 1'b1)) : (n79 ? !n47 : 1'b1));
assign n352 = /* LUT    5  8  3 */ (n48 ? !n16 : 1'b0);
assign n353 = /* LUT    7  8  5 */ (n47 ? !n107 : 1'b0);
assign n354 = /* LUT    6 16  0 */ (n3 ? 1'b1 : n21);
assign n355 = /* LUT    7  9  4 */ (n48 ? (n10 ? (n17 ? 1'b0 : !n16) : 1'b0) : 1'b0);
assign n356 = /* LUT    6  5  0 */ (n25 ? n94 : 1'b0);
assign n357 = /* LUT    9  9  6 */ (n218 ? (n15 ? (n223 ? !btn2 : btn2) : 1'b0) : 1'b0);
assign n358 = /* LUT    8  3  5 */ (n204 ? !n148 : n148);
assign n359 = /* LUT   11  9  0 */ btn2;
assign n360 = /* LUT    5  7  4 */ (n38 ? n47 : 1'b0);
assign n361 = /* LUT    6 12  5 */ !n88;
assign n362 = /* LUT    7 10  5 */ (n170 ? !n119 : n119);
assign n363 = /* LUT    7 12  2 */ (n176 ? !n123 : n123);
assign n364 = /* LUT    6  7  0 */ (n23 ? (n68 ? (n47 ? !n38 : 1'b1) : 1'b0) : (n47 ? !n38 : 1'b1));
assign n365 = /* LUT    8 12  7 */ (n129 ? 1'b0 : (n127 ? 1'b0 : (n126 ? 1'b0 : !n125)));
assign n366 = /* LUT    8  6  3 */ (n213 ? !n157 : n157);
assign n367 = /* LUT    6  9  6 */ (n74 ? (n76 ? !n81 : 1'b1) : 1'b1);
assign n368 = /* LUT    7  4  7 */ (n154 ? 1'b0 : (n153 ? 1'b0 : (n152 ? 1'b0 : !n151)));
assign n369 = /* LUT    5  8  5 */ (n17 ? (n23 ? n43 : 1'b0) : 1'b0);
assign n370 = /* LUT    7  8  7 */ (n26 ? !n110 : 1'b0);
assign n371 = /* LUT    8  3  7 */ (n206 ? !n150 : n150);
assign n372 = /* LUT    7 13  6 */ (n191 ? !n135 : n135);
assign n373 = /* LUT    5  7  6 */ (n17 ? (n16 ? 1'b0 : (n48 ? 1'b0 : !n10)) : 1'b0);
assign n374 = /* LUT    6 12  7 */ (n86 ? !n87 : n87);
assign n375 = /* LUT    7 10  7 */ (n172 ? !n121 : n121);
assign n376 = /* LUT    7 12  4 */ (n178 ? !n125 : n125);
assign n377 = /* LUT    6  7  2 */ (n26 ? n53 : 1'b0);
assign n380 = /* LUT    7  8  0 */ (n40 ? (n103 ? !n115 : 1'b0) : 1'b1);
assign n381 = /* LUT    5  8  7 */ (n17 ? (n10 ? (n16 ? !n48 : n48) : 1'b0) : 1'b0);
assign n382 = /* LUT    8 13  1 */ (n133 ? (n131 ? (n130 ? n173 : 1'b0) : 1'b0) : 1'b0);
assign n383 = /* LUT    5  9  6 */ (n16 ? !n48 : 1'b0);
assign n384 = /* LUT    9  9  1 */ !n10;
assign n385 = /* LUT    8  3  0 */ (n199 ? !n143 : n143);
assign n386 = /* LUT    6  5  4 */ (n99 ? (n100 ? n98 : 1'b0) : 1'b0);
assign n387 = /* LUT    7  5  4 */ !n99;
assign n388 = /* LUT    7  7  1 */ (n104 ? (n23 ? 1'b0 : (n47 ? !n105 : 1'b1)) : (n47 ? !n105 : 1'b1));
assign n392 = /* LUT    8 10  5 */ !n120;
assign n393 = /* LUT    9  7  3 */ (n15 ? (n159 ? (n214 ? !btn2 : btn2) : 1'b1) : 1'b1);
assign n394 = /* LUT    8 15  1 */ (n3 ? 1'b1 : (n21 ? !n162 : 1'b0));
assign n395 = /* LUT    5 10  7 */ !n32;
assign n396 = /* LUT    6  7  4 */ (n16 ? (n10 ? (n48 ? !n17 : 1'b1) : (n48 ? 1'b1 : n17)) : (n10 ? (n48 ? n17 : 1'b1) : 1'b1));
assign n399 = /* LUT    6  8  5 */ (n64 ? (n13 ? (n83 ? !n51 : 1'b0) : 1'b0) : 1'b0);
assign n400 = /* LUT    5  8  0 */ (n46 ? n47 : 1'b0);
assign n401 = /* LUT    7  3  6 */ (n95 ? n92 : 1'b0);
assign n402 = /* LUT    7  8  2 */ (n83 ? (n161 ? 1'b0 : (n14 ? n10 : 1'b1)) : 1'b0);
assign n403 = /* LUT    8 13  3 */ (n19 ? (n184 ? n185 : 1'b0) : 1'b0);
assign n404 = /* LUT    7  9  1 */ !n48;
assign n405 = /* LUT    8  3  2 */ (n201 ? !n145 : n145);
assign n406 = /* LUT    6  6  5 */ (n60 ? (n99 ? 1'b1 : !n85) : (n99 ? 1'b0 : !n63));
assign n407 = /* LUT    7 13  1 */ (n186 ? !n130 : n130);
assign n408 = /* LUT    5  5  4 */ (n31 ? !n30 : 1'b0);
assign n409 = /* LUT    5  7  1 */ (n35 ? (n47 ? n49 : 1'b0) : 1'b0);
assign n410 = /* LUT    7  7  3 */ (n53 ? (n106 ? 1'b0 : (n23 ? !n105 : 1'b1)) : 1'b0);
assign n411 = /* LUT    7 10  2 */ (n167 ? !n48 : n48);
assign n412 = /* LUT    8 10  7 */ !n121;
assign n413 = /* LUT    8 12  4 */ (n129 ? (n127 ? (n126 ? n125 : 1'b0) : 1'b0) : 1'b0);
assign n414 = /* LUT    8  2  3 */ (n194 ? !n138 : n138);
assign n415 = /* LUT    8  4  0 */ (n207 ? !n151 : n151);
assign n416 = /* LUT    5  8  2 */ (n45 ? (n41 ? 1'b0 : (n27 ? 1'b0 : !n51)) : 1'b0);
assign n417 = /* LUT    6  8  7 */ (n112 ? (n82 ? (n72 ? n36 : 1'b1) : 1'b1) : 1'b1);
assign n418 = /* LUT    5  9  1 */ (n23 ? !n52 : 1'b0);
assign n419 = /* LUT    7  8  4 */ (n48 ? (n10 ? 1'b1 : n16) : (n10 ? n16 : (n16 ? 1'b1 : !n17)));
assign n420 = /* LUT    7  9  3 */ (n117 ? (n17 ? !n47 : !n23) : 1'b1);
assign n421 = /* LUT    8 13  5 */ (n20 ? (n132 ? 1'b0 : !n128) : 1'b0);
assign n422 = /* LUT    8  3  4 */ (n203 ? !n147 : n147);
assign n423 = /* LUT    6  6  7 */ (n100 ? n71 : n59);
assign n424 = /* LUT    7 13  3 */ (n188 ? !n132 : n132);
assign n425 = /* LUT    8 10  0 */ (n217 ? 1'b0 : (n115 ? !n40 : 1'b1));
assign n426 = /* LUT    5  7  3 */ (n23 ? (n33 ? 1'b1 : n38) : 1'b0);
assign n427 = /* LUT    7  7  5 */ (n10 ? (n17 ? 1'b0 : (n16 ? 1'b0 : !n48)) : 1'b0);
assign n428 = /* LUT    9  7  7 */ !btn2;
assign n429 = /* LUT    7  2  0 */ (n142 ? 1'b0 : (n141 ? 1'b0 : (n140 ? 1'b0 : !n139)));
assign n430 = /* LUT    8  2  5 */ (n196 ? !n140 : n140);
assign n431 = /* LUT    8  4  2 */ (n209 ? !n153 : n153);
assign n432 = /* LUT    8  7  1 */ (n158 ? (n157 ? (n156 ? !n160 : 1'b0) : 1'b0) : 1'b0);
assign n433 = /* LUT    6  8  0 */ (n53 ? (n13 ? (n14 ? 1'b0 : !n41) : 1'b0) : 1'b0);
assign n434 = /* LUT    7  3  1 */ (n144 ? 1'b0 : !n138);
assign n435 = /* LUT    9 11  7 */ !n220;
assign n436 = /* LUT    8  8  2 */ (n40 ? n115 : 1'b0);
assign n437 = /* LUT    6  5  1 */ (n58 ? 1'b0 : (n6 ? 1'b1 : (n54 ? !n22 : 1'b0)));
assign n438 = /* LUT    7  9  5 */ !n16;
assign n439 = /* LUT    6  6  0 */ (n98 ? n78 : n70);
assign n440 = /* LUT    9  9  7 */ n216;
assign n441 = /* LUT    8  3  6 */ (n205 ? !n149 : n149);
assign n442 = /* LUT    7 13  5 */ (n190 ? !n134 : n134);
assign n445 = /* LUT    8 10  2 */ (n119 ? (n121 ? 1'b0 : (n120 ? 1'b0 : !n118)) : 1'b0);
assign n446 = /* LUT    5  7  5 */ (n33 ? 1'b0 : (n49 ? !n35 : 1'b1));
assign n447 = /* LUT    7  7  7 */ (n108 ? !n101 : 1'b1);
assign n448 = /* LUT    8  2  7 */ (n198 ? !n142 : n142);
assign n449 = /* LUT    6  8  2 */ (n82 ? (n23 ? (n68 ? n50 : 1'b0) : 1'b1) : 1'b0);
assign n450 = /* LUT    7  3  3 */ (n89 ? (n93 ? n97 : 1'b0) : 1'b0);
assign n451 = /* LUT    6  9  1 */ (n48 ? (n17 ? 1'b0 : (n16 ? 1'b0 : !n10)) : 1'b0);
assign n452 = /* LUT    7 12  6 */ (n180 ? !n127 : n127);
assign n453 = /* LUT    8  6  7 */ !n158;
assign n454 = /* LUT    7  9  7 */ (n17 ? (n16 ? (n10 ? 1'b0 : n48) : (n10 ? !n48 : 1'b0)) : (n16 ? n10 : 1'b0));
assign n455 = /* LUT    6  6  2 */ (n100 ? (n99 ? (n61 ? 1'b1 : !n102) : n61) : (n99 ? !n61 : 1'b0));
assign n456 = /* LUT   12  6  3 */ (btn3 ? !btn4 : 1'b0);
assign n457 = /* LUT    5  5  1 */ (n31 ? 1'b0 : !n30);
assign n458 = /* LUT    7 13  7 */ (n192 ? !n136 : n136);
assign n459 = /* LUT    7  7  0 */ (n16 ? 1'b1 : (n10 ? n48 : 1'b0));
assign n460 = /* LUT    8 10  4 */ (n121 ? 1'b0 : (n120 ? 1'b0 : (n118 ? 1'b0 : !n119)));
assign n461 = /* LUT    5  7  7 */ (n36 ? 1'b0 : (n37 ? 1'b1 : !n23));
assign n465 = /* LUT    6 13  7 */ (n88 ? n21 : 1'b1);
assign n228 = /* CARRY  8  6  0 */ (n158 & 1'b0) | ((n158 | 1'b0) & n243);
assign n224 = /* CARRY  9 12  1 */ (1'b0 & n219) | ((1'b0 | n219) & n233);
assign n229 = /* CARRY  8  9  5 */ (n114 & n165) | ((n114 | n165) & n234);
assign n201 = /* CARRY  8  3  1 */ (1'b0 & n144) | ((1'b0 | n144) & n200);
assign n186 = /* CARRY  7 13  0 */ (1'b0 & n129) | ((1'b0 | n129) & n182);
assign n194 = /* CARRY  8  2  2 */ (1'b0 & n137) | ((1'b0 | n137) & n193);
assign n170 = /* CARRY  7 10  4 */ (1'b0 & n118) | ((1'b0 | n118) & n169);
assign n176 = /* CARRY  7 12  1 */ (1'b0 & n87) | ((1'b0 | n87) & n235);
assign n213 = /* CARRY  8  6  2 */ (1'b0 & n156) | ((1'b0 | n156) & n212);
assign n217 = /* CARRY  8  9  7 */ (1'b0 & n166) | ((1'b0 | n166) & n236);
assign n188 = /* CARRY  7 13  2 */ (1'b0 & n131) | ((1'b0 | n131) & n187);
assign n196 = /* CARRY  8  2  4 */ (1'b0 & n139) | ((1'b0 | n139) & n195);
assign n209 = /* CARRY  8  4  1 */ (1'b0 & n152) | ((1'b0 | n152) & n208);
assign n172 = /* CARRY  7 10  6 */ (1'b0 & n120) | ((1'b0 | n120) & n171);
assign n178 = /* CARRY  7 12  3 */ (1'b0 & n124) | ((1'b0 | n124) & n177);
assign n230 = /* CARRY  8  9  0 */ (n216 & 1'b0) | ((n216 | 1'b0) & n292);
assign n190 = /* CARRY  7 13  4 */ (1'b0 & n133) | ((1'b0 | n133) & n189);
assign n231 = /* CARRY  7  5  0 */ (n99 & 1'b0) | ((n99 | 1'b0) & n300);
assign n198 = /* CARRY  8  2  6 */ (1'b0 & n141) | ((1'b0 | n141) & n197);
assign n232 = /* CARRY  8  9  2 */ (n114 & n113) | ((n114 | n113) & n237);
assign n180 = /* CARRY  7 12  5 */ (1'b0 & n126) | ((1'b0 | n126) & n179);
assign n167 = /* CARRY  7 10  1 */ (1'b0 & n10) | ((1'b0 | n10) & n238);
assign n233 = /* CARRY  9 12  0 */ (n220 & 1'b0) | ((n220 | 1'b0) & n322);
assign n182 = /* CARRY  7 12  7 */ (1'b0 & n128) | ((1'b0 | n128) & n181);
assign n234 = /* CARRY  8  9  4 */ (1'b0 & n163) | ((1'b0 | n163) & n239);
assign n203 = /* CARRY  8  3  3 */ (1'b0 & n146) | ((1'b0 | n146) & n202);
assign n193 = /* CARRY  8  2  1 */ (1'b0 & n90) | ((1'b0 | n90) & n240);
assign n169 = /* CARRY  7 10  3 */ (1'b0 & n16) | ((1'b0 | n16) & n168);
assign n235 = /* CARRY  7 12  0 */ (n86 & 1'b0) | ((n86 | 1'b0) & n344);
assign n212 = /* CARRY  8  6  1 */ (1'b0 & n160) | ((1'b0 | n160) & n228);
assign n225 = /* CARRY  9 12  2 */ (1'b0 & n221) | ((1'b0 | n221) & n224);
assign n236 = /* CARRY  8  9  6 */ (1'b0 & n164) | ((1'b0 | n164) & n229);
assign n205 = /* CARRY  8  3  5 */ (1'b0 & n148) | ((1'b0 | n148) & n204);
assign n171 = /* CARRY  7 10  5 */ (1'b0 & n119) | ((1'b0 | n119) & n170);
assign n177 = /* CARRY  7 12  2 */ (1'b0 & n123) | ((1'b0 | n123) & n176);
assign n207 = /* CARRY  8  3  7 */ (1'b0 & n150) | ((1'b0 | n150) & n206);
assign n192 = /* CARRY  7 13  6 */ (1'b0 & n135) | ((1'b0 | n135) & n191);
assign n179 = /* CARRY  7 12  4 */ (1'b0 & n125) | ((1'b0 | n125) & n178);
assign n237 = /* CARRY  8  9  1 */ (n114 & n215) | ((n114 | n215) & n230);
assign n200 = /* CARRY  8  3  0 */ (1'b0 & n143) | ((1'b0 | n143) & n199);
assign n238 = /* CARRY  7 10  0 */ (n17 & 1'b0) | ((n17 | 1'b0) & n391);
assign n239 = /* CARRY  8  9  3 */ (1'b0 & n116) | ((1'b0 | n116) & n232);
assign n202 = /* CARRY  8  3  2 */ (1'b0 & n145) | ((1'b0 | n145) & n201);
assign n187 = /* CARRY  7 13  1 */ (1'b0 & n130) | ((1'b0 | n130) & n186);
assign n168 = /* CARRY  7 10  2 */ (1'b0 & n48) | ((1'b0 | n48) & n167);
assign n195 = /* CARRY  8  2  3 */ (1'b0 & n138) | ((1'b0 | n138) & n194);
assign n208 = /* CARRY  8  4  0 */ (1'b0 & n151) | ((1'b0 | n151) & n207);
assign n204 = /* CARRY  8  3  4 */ (1'b0 & n147) | ((1'b0 | n147) & n203);
assign n189 = /* CARRY  7 13  3 */ (1'b0 & n132) | ((1'b0 | n132) & n188);
assign n197 = /* CARRY  8  2  5 */ (1'b0 & n140) | ((1'b0 | n140) & n196);
assign n210 = /* CARRY  8  4  2 */ (1'b0 & n153) | ((1'b0 | n153) & n209);
assign n206 = /* CARRY  8  3  6 */ (1'b0 & n149) | ((1'b0 | n149) & n205);
assign n191 = /* CARRY  7 13  5 */ (1'b0 & n134) | ((1'b0 | n134) & n190);
assign n155 = /* CARRY  7  5  1 */ (1'b0 & n100) | ((1'b0 | n100) & n231);
assign n199 = /* CARRY  8  2  7 */ (1'b0 & n142) | ((1'b0 | n142) & n198);
assign n181 = /* CARRY  7 12  6 */ (1'b0 & n127) | ((1'b0 | n127) & n180);
assign n240 = /* CARRY  8  2  0 */ (n91 & 1'b0) | ((n91 | 1'b0) & n464);
/* FF  8  6  0 */ assign n241 = n242;
/* FF  9 12  1 */ assign n244 = n245;
/* FF  6  8  4 */ assign n75 = n246;
/* FF  6  7  6 */ always @(posedge clk) if (n6) n70 <= n7 ? 1'b0 : n247;
/* FF  6  9  3 */ assign n82 = n248;
/* FF  7  3  5 */ assign n95 = n249;
/* FF  8  9  5 */ assign n250 = n251;
/* FF  8  3  1 */ always @(posedge clk) if (1'b1) n144 <= n1 ? 1'b0 : n252;
/* FF  6  6  4 */ assign n61 = n253;
/* FF  7 13  0 */ always @(posedge clk) if (1'b1) n129 <= n5 ? 1'b0 : n254;
/* FF  5  5  3 */ assign n29 = n255;
/* FF  5  7  0 */ assign n33 = n256;
/* FF  7  7  2 */ assign n104 = n257;
/* FF  8 10  6 */ assign n165 = n258;
/* FF  8 11  5 */ assign n6 = n259;
/* FF  8  2  2 */ always @(posedge clk) if (1'b1) n137 <= n1 ? 1'b0 : n260;
/* FF  7 10  4 */ always @(posedge clk) if (n2) n118 <= n3 ? 1'b0 : n261;
/* FF  7 12  1 */ assign n262 = n263;
/* FF  9 11  4 */ assign n218 = n264;
/* FF  8  6  2 */ always @(posedge clk) if (btn1) n156 <= 1'b0 ? 1'b0 : n265;
/* FF  9 12  3 */ always @(posedge clk) if (btn1) n222 <= 1'b0 ? 1'b0 : n266;
/* FF  6  8  6 */ always @(posedge clk) if (n6) n77 <= n7 ? 1'b0 : n267;
/* FF  5  9  0 */ assign n50 = n268;
/* FF  6  9  5 */ assign n84 = n269;
/* FF  7  9  2 */ assign n114 = n270;
/* FF  8  9  7 */ assign n271 = n272;
/* FF  9  9  4 */ assign n216 = n273;
/* FF  5  8  4 */ assign n44 = n274;
/* FF  7  8  6 */ assign n111 = n275;
/* FF  8 13  7 */ assign n20 = n276;
/* FF  7 13  2 */ always @(posedge clk) if (1'b1) n131 <= n5 ? 1'b0 : n277;
/* FF  5  5  5 */ always @(posedge clk) if (n55) n30 <= n22 ? 1'b1 : n278;
/* FF  5  7  2 */ assign n35 = n279;
/* FF  7  5  7 */ always @(posedge clk) if (n56) n100 <= n24 ? 1'b0 : n280;
/* FF  7  7  4 */ assign n11 = n281;
/* FF  8  2  4 */ always @(posedge clk) if (1'b1) n139 <= n1 ? 1'b0 : n282;
/* FF  8  4  1 */ always @(posedge clk) if (1'b1) n152 <= n1 ? 1'b0 : n283;
/* FF  7 10  6 */ always @(posedge clk) if (n2) n120 <= n3 ? 1'b0 : n284;
/* FF  7 12  3 */ always @(posedge clk) if (1'b1) n124 <= n5 ? 1'b0 : n285;
/* FF  6  7  1 */ assign n65 = n286;
/* FF  7  3  0 */ assign n25 = n287;
/* FF  7  2  2 */ always @(posedge clk) if (1'b1) n90 <= n1 ? 1'b0 : n288;
/* FF  9 11  6 */ always @(posedge clk) if (btn1) n219 <= 1'b0 ? 1'b0 : n289;
/* FF  8  9  0 */ assign n290 = n291;
/* FF  5  6  3 */ assign n28 = n293;
/* FF  5  8  6 */ assign n45 = n294;
/* FF  8 13  0 */ assign n183 = n295;
/* FF  6  5  3 */ assign n56 = n296;
/* FF  7 13  4 */ always @(posedge clk) if (1'b1) n133 <= n5 ? 1'b0 : n297;
/* FF  7  5  0 */ assign n298 = n299;
/* FF  5  5  7 */ always @(posedge clk) if (n55) n31 <= n22 ? 1'b0 : n301;
/* FF  8 10  1 */ assign n163 = n302;
/* FF  8  2  6 */ always @(posedge clk) if (1'b1) n141 <= n1 ? 1'b0 : n303;
/* FF  8  4  3 */ always @(posedge clk) if (1'b1) n154 <= n1 ? 1'b0 : n304;
/* FF  6  8  1 */ assign n7 = n305;
/* FF  6  7  3 */ assign n67 = n306;
/* FF  6  9  0 */ assign n79 = n307;
/* FF  7  2  4 */ always @(posedge clk) if (1'b1) n91 <= n1 ? 1'b0 : n308;
/* FF  7  3  2 */ assign n93 = n309;
/* FF  8  9  2 */ assign n310 = n311;
/* FF  7 12  5 */ always @(posedge clk) if (1'b1) n126 <= n5 ? 1'b0 : n312;
/* FF  7  8  1 */ assign n107 = n313;
/* FF  5  9  7 */ assign n52 = n314;
/* FF  6  5  5 */ assign n58 = n315;
/* FF  7  5  2 */ always @(posedge clk) if (n56) n98 <= n24 ? 1'b0 : n316;
/* FF  8 10  3 */ assign n47 = n317;
/* FF  7 10  1 */ assign n318 = n319;
/* FF  9 12  0 */ assign n320 = n321;
/* FF  6  8  3 */ assign n74 = n323;
/* FF  7  3  4 */ assign n1 = n324;
/* FF  6  7  5 */ always @(posedge clk) if (n6) n69 <= n7 ? 1'b0 : n325;
/* FF  6  9  2 */ assign n81 = n326;
/* FF  7 12  7 */ always @(posedge clk) if (1'b1) n128 <= n5 ? 1'b0 : n327;
/* FF  8  7  7 */ always @(posedge clk) if (btn1) n160 <= 1'b0 ? 1'b0 : n328;
/* FF  5  6  7 */ always @(posedge clk) if (n29) n32 <= n28 ? 1'b1 : n329;
/* FF  8  9  4 */ assign n330 = n331;
/* FF  5  8  1 */ assign n27 = n332;
/* FF 11  7  7 */ always @(posedge clk) if (n2) n10 <= n3 ? 1'b0 : n333;
/* FF  7  8  3 */ assign n106 = n334;
/* FF  8  3  3 */ always @(posedge clk) if (1'b1) n146 <= n1 ? 1'b0 : n335;
/* FF  6  5  7 */ assign n24 = n336;
/* FF  8  2  1 */ assign n337 = n338;
/* FF  6 12  3 */ assign n19 = n339;
/* FF  7 10  3 */ always @(posedge clk) if (n2) n16 <= n3 ? 1'b0 : n340;
/* FF  8 12  5 */ assign n174 = n341;
/* FF  7 12  0 */ assign n342 = n343;
/* FF  8  6  1 */ assign n345 = n346;
/* FF  9 12  2 */ always @(posedge clk) if (btn1) n221 <= 1'b0 ? 1'b0 : n347;
/* FF  6  7  7 */ always @(posedge clk) if (n6) n71 <= n7 ? 1'b0 : n348;
/* FF  6  9  4 */ assign n83 = n349;
/* FF  8  9  6 */ assign n350 = n351;
/* FF  5  8  3 */ assign n43 = n352;
/* FF  7  8  5 */ assign n110 = n353;
/* FF  6 16  0 */ assign n5 = n354;
/* FF  7  9  4 */ assign n115 = n355;
/* FF  6  5  0 */ assign n54 = n356;
/* FF  9  9  6 */ assign led = n357;
/* FF  8  3  5 */ always @(posedge clk) if (1'b1) n148 <= n1 ? 1'b0 : n358;
/* FF 11  9  0 */ always @(posedge clk) if (1'b1) n223 <= 1'b0 ? 1'b0 : n359;
/* FF  5  7  4 */ assign n36 = n360;
/* FF  6 12  5 */ assign n86 = n361;
/* FF  7 10  5 */ always @(posedge clk) if (n2) n119 <= n3 ? 1'b0 : n362;
/* FF  7 12  2 */ always @(posedge clk) if (1'b1) n123 <= n5 ? 1'b0 : n363;
/* FF  6  7  0 */ assign n64 = n364;
/* FF  8 12  7 */ assign n175 = n365;
/* FF  8  6  3 */ always @(posedge clk) if (btn1) n157 <= 1'b0 ? 1'b0 : n366;
/* FF  6  9  6 */ always @(posedge clk) if (n6) n85 <= n7 ? 1'b0 : n367;
/* FF  7  4  7 */ assign n97 = n368;
/* FF  5  8  5 */ assign n14 = n369;
/* FF  7  8  7 */ assign n112 = n370;
/* FF  8  3  7 */ always @(posedge clk) if (1'b1) n150 <= n1 ? 1'b0 : n371;
/* FF  7 13  6 */ always @(posedge clk) if (1'b1) n135 <= n5 ? 1'b0 : n372;
/* FF  5  7  6 */ assign n38 = n373;
/* FF  6 12  7 */ always @(posedge clk) if (1'b1) n87 <= n5 ? 1'b0 : n374;
/* FF  7 10  7 */ always @(posedge clk) if (n2) n121 <= n3 ? 1'b0 : n375;
/* FF  7 12  4 */ always @(posedge clk) if (1'b1) n125 <= n5 ? 1'b0 : n376;
/* FF  6  7  2 */ assign n66 = n377;
/* FF  8  9  1 */ assign n378 = n379;
/* FF  7  8  0 */ assign n26 = n380;
/* FF  5  8  7 */ assign n46 = n381;
/* FF  8 13  1 */ assign n184 = n382;
/* FF  5  9  6 */ assign n49 = n383;
/* FF  9  9  1 */ assign n215 = n384;
/* FF  8  3  0 */ always @(posedge clk) if (1'b1) n143 <= n1 ? 1'b0 : n385;
/* FF  6  5  4 */ assign n57 = n386;
/* FF  7  5  4 */ always @(posedge clk) if (n56) n99 <= n24 ? 1'b0 : n387;
/* FF  7  7  1 */ assign n13 = n388;
/* FF  7 10  0 */ assign n389 = n390;
/* FF  8 10  5 */ assign n164 = n392;
/* FF  9  7  3 */ assign n3 = n393;
/* FF  8 15  1 */ assign n2 = n394;
/* FF  5 10  7 */ assign tx = n395;
/* FF  6  7  4 */ assign n68 = n396;
/* FF  8  9  3 */ assign n397 = n398;
/* FF  6  8  5 */ assign n76 = n399;
/* FF  5  8  0 */ assign n41 = n400;
/* FF  7  3  6 */ assign n96 = n401;
/* FF  7  8  2 */ assign n108 = n402;
/* FF  8 13  3 */ assign n21 = n403;
/* FF  7  9  1 */ assign n113 = n404;
/* FF  8  3  2 */ always @(posedge clk) if (1'b1) n145 <= n1 ? 1'b0 : n405;
/* FF  6  6  5 */ assign n62 = n406;
/* FF  7 13  1 */ always @(posedge clk) if (1'b1) n130 <= n5 ? 1'b0 : n407;
/* FF  5  5  4 */ assign n9 = n408;
/* FF  5  7  1 */ assign n34 = n409;
/* FF  7  7  3 */ assign n101 = n410;
/* FF  7 10  2 */ always @(posedge clk) if (n2) n48 <= n3 ? 1'b0 : n411;
/* FF  8 10  7 */ assign n166 = n412;
/* FF  8 12  4 */ assign n173 = n413;
/* FF  8  2  3 */ always @(posedge clk) if (1'b1) n138 <= n1 ? 1'b0 : n414;
/* FF  8  4  0 */ always @(posedge clk) if (1'b1) n151 <= n1 ? 1'b0 : n415;
/* FF  5  8  2 */ assign n42 = n416;
/* FF  6  8  7 */ always @(posedge clk) if (n6) n78 <= n7 ? 1'b0 : n417;
/* FF  5  9  1 */ assign n51 = n418;
/* FF  7  8  4 */ assign n109 = n419;
/* FF  7  9  3 */ assign n53 = n420;
/* FF  8 13  5 */ assign n185 = n421;
/* FF  8  3  4 */ always @(posedge clk) if (1'b1) n147 <= n1 ? 1'b0 : n422;
/* FF  6  6  7 */ assign n63 = n423;
/* FF  7 13  3 */ always @(posedge clk) if (1'b1) n132 <= n5 ? 1'b0 : n424;
/* FF  8 10  0 */ assign n162 = n425;
/* FF  5  7  3 */ assign n12 = n426;
/* FF  7  7  5 */ assign n105 = n427;
/* FF  9  7  7 */ always @(posedge clk) if (1'b1) n214 <= 1'b0 ? 1'b0 : n428;
/* FF  7  2  0 */ assign n89 = n429;
/* FF  8  2  5 */ always @(posedge clk) if (1'b1) n140 <= n1 ? 1'b0 : n430;
/* FF  8  4  2 */ always @(posedge clk) if (1'b1) n153 <= n1 ? 1'b0 : n431;
/* FF  8  7  1 */ assign n159 = n432;
/* FF  6  8  0 */ assign n72 = n433;
/* FF  7  3  1 */ assign n92 = n434;
/* FF  9 11  7 */ always @(posedge clk) if (btn1) n220 <= 1'b0 ? 1'b0 : n435;
/* FF  8  8  2 */ assign n161 = n436;
/* FF  6  5  1 */ assign n55 = n437;
/* FF  7  9  5 */ assign n116 = n438;
/* FF  6  6  0 */ assign n59 = n439;
/* FF  9  9  7 */ always @(posedge clk) if (n2) n17 <= n3 ? 1'b0 : n440;
/* FF  8  3  6 */ always @(posedge clk) if (1'b1) n149 <= n1 ? 1'b0 : n441;
/* FF  7 13  5 */ always @(posedge clk) if (1'b1) n134 <= n5 ? 1'b0 : n442;
/* FF  7  5  1 */ assign n443 = n444;
/* FF  8 10  2 */ assign n40 = n445;
/* FF  5  7  5 */ assign n37 = n446;
/* FF  7  7  7 */ always @(posedge clk) if (n6) n102 <= n7 ? 1'b0 : n447;
/* FF  8  2  7 */ always @(posedge clk) if (1'b1) n142 <= n1 ? 1'b0 : n448;
/* FF  6  8  2 */ assign n73 = n449;
/* FF  7  3  3 */ assign n94 = n450;
/* FF  6  9  1 */ assign n80 = n451;
/* FF  7 12  6 */ always @(posedge clk) if (1'b1) n127 <= n5 ? 1'b0 : n452;
/* FF  8  6  7 */ always @(posedge clk) if (btn1) n158 <= 1'b0 ? 1'b0 : n453;
/* FF  7  9  7 */ assign n117 = n454;
/* FF  6  6  2 */ assign n60 = n455;
/* FF 12  6  3 */ assign n15 = n456;
/* FF  5  5  1 */ assign n22 = n457;
/* FF  7 13  7 */ always @(posedge clk) if (1'b1) n136 <= n5 ? 1'b0 : n458;
/* FF  7  7  0 */ assign n103 = n459;
/* FF  8 10  4 */ assign n23 = n460;
/* FF  5  7  7 */ assign n39 = n461;
/* FF  8  2  0 */ assign n462 = n463;
/* FF  6 13  7 */ always @(posedge clk) if (1'b1) n88 <= n3 ? 1'b0 : n465;

endmodule

