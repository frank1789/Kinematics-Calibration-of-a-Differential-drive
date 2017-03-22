#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import sys
import tkinter as tk
from tkinter import filedialog
from dataframe import df, originalset


def multifilelaoader():
    root = tk.Tk()
    root.withdraw()
    file_path = filedialog.askopenfilenames()
    for x in file_path:
        print x
    return file_path


# count number of line in file input
def numberline(p_input):
    f = open(p_input, "r")
    n_line = len(f.readlines())
    f.close()
    return n_line


# regex filename
def newnamefile(p_name, p_inputfile):
    tmp = re.split(r"\/", p_inputfile)
    m = re.search(r"(\w+).(\w+)", tmp[5])
    # extract the entire namefile.ext
    complete_name = m.group(0)  # The entire match
    # extract namefile
    name = m.group(1)  # The first parenthesized subgroup.
    # extract extension
    ext = m.group(2)  # The second parenthesized subgroup.
    namefile = str(p_name) + "_" + name + "." + ext
    print ("New file created: "), namefile
    return namefile


# print line readed
def printerline(plines, pinput_file):
    for i in range(0, pinput_file, 1):
        print ("l " + str(i + 1) + ': ' + str(plines[i]))


# perform regex on line of file, return a dictionary
def generatedataset(plines, pinput_file):
    # pre allocate variable and split information
    n_time = []
    pose_x = []
    pose_y = []
    pose_theta = []
    cov_11 = []
    cov_12 = []
    cov_13 = []
    cov_21 = []
    cov_22 = []
    cov_23 = []
    cov_31 = []
    cov_32 = []
    cov_33 = []
    tick_L = []
    tick_R = []

    # define pattern for regex and cycle for all lines
    pattern = " \| "
    for n in range(2, pinput_file, 1):
        # regex to divide information in local variable
        new_data = re.split(pattern, str(plines[n]).replace('\n', ''))
        # fill the variables with splitted information
        n_time.append(int(new_data[0]))
        pose_x.append(float(new_data[1]))
        pose_y.append(float(new_data[2]))
        pose_theta.append(float(new_data[3]))
        cov_11.append(float(new_data[4]))
        cov_12.append(float(new_data[5]))
        cov_13.append(float(new_data[6]))
        cov_21.append(float(new_data[7]))
        cov_22.append(float(new_data[8]))
        cov_23.append(float(new_data[9]))
        cov_31.append(float(new_data[10]))
        cov_32.append(float(new_data[11]))
        cov_33.append(float(new_data[12]))
        tick_L.append(int(new_data[13]))
        tick_R.append(int(new_data[14]))

    # invert value of left encoder
    for j in range(0, len(tick_L), 1):
        tick_L[j] = - (tick_L[j])

    for j in range(0, len(tick_L), 1):
        tick_R[j] = abs(tick_R[j])

    # give "-" sign to pose.theta
    for z in range(0, len(pose_theta), 1):
        pose_theta[z] = - pose_theta[z]

    # set dictionary for dataset
    dataset = {'n_time': n_time,
               'pose_x': pose_x,
               'pose_y': pose_y,
               'pose_theta': pose_theta,
               'cov_11': cov_11,
               'cov_12': cov_12,
               'cov_13': cov_13,
               'cov_21': cov_21,
               'cov_22': cov_22,
               'cov_23': cov_23,
               'cov_31': cov_31,
               'cov_32': cov_32,
               'cov_33': cov_33,
               'tick_L': tick_L,
               'tick_R': tick_R}

    return dataset


# MAIN FUNCTION
if __name__ == "__main__":

    for input_file in multifilelaoader():
        # read the content of file
        file_open = open(input_file, "r")
        text = file_open.read()

        # # divide text in lines
        lines = text.splitlines(True)
        # print type(lines)  # for debugging, comment to avoid print
        # printerline(lines, numberline(input_file))

        rewrite = originalset(generatedataset(lines, numberline(input_file)))
        # rewrite dataset file
        print "Rewriting of the file..."
        out_file = open(newnamefile("rew", input_file), "w")
        out_file.write(rewrite)
        out_file.close()
        print "Done!"

        # create new dataset correct format
        newdataset = df(generatedataset(lines, numberline(input_file)))
        print "Writing new file..."
        # create new dataset file
        out_file = open(newnamefile("new", input_file), "w")
        out_file.write(newdataset)
        out_file.close()
        print "Done!"

    # auto exit script
    print "ALL DONE..."
    sys.exit()
