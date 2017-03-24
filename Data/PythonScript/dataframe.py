#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pandas as pd


def df(dataset):
    # export order
    order = ['n_time', 'pose_x', 'pose_y', 'pose_theta', 'cov_11', 'cov_12', 'cov_13', 'cov_21', 'cov_22', 'cov_23',
             'cov_31', 'cov_32', 'cov_33', 'tick_L', 'tick_R']

    # generate data frame
    data = pd.DataFrame.from_records(dataset, columns=order)

    # list parametrs to eliminate duplicates
    param = ['pose_x', 'pose_y', 'pose_theta', 'cov_11', 'cov_12', 'cov_13', 'cov_21', 'cov_22', 'cov_23',
             'cov_31', 'cov_32', 'cov_33']
    # print preview whitout duplicate, uncomment to debugging
    # print data.drop_duplicates(subset=list, keep='first').to_string(index=True)
    data = data.drop_duplicates(subset=param, keep='last')
    # possibiy dublicate in time gnerate 'inf' value in matlab
    param2 = ['n_time']
    no_duplicates = data.drop_duplicates(subset=param2, keep='last')

    # return correct dataframe without duplicates
    return no_duplicates.to_string(index=False)


def originalset(dataset):
    # export order
    order = ['n_time', 'pose_x', 'pose_y', 'pose_theta', 'cov_11', 'cov_12', 'cov_13', 'cov_21', 'cov_22', 'cov_23',
             'cov_31', 'cov_32', 'cov_33', 'tick_L', 'tick_R']

    # generate data frame
    data = pd.DataFrame.from_records(dataset, columns=order)

    # return correct dataframe without duplicates
    return data.to_string(index=False)
