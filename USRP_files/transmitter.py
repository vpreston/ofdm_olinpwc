#!/usr/bin/env python
##################################################
# Gnuradio Python Flow Graph
# Title: Transmitter
# Generated: Tue Apr  5 21:51:59 2016
##################################################

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import uhd
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser
import time

class transmitter(gr.top_block):

    def __init__(self):
        gr.top_block.__init__(self, "Transmitter")

        ##################################################
        # Variables
        ##################################################
        self.samp_rate = samp_rate = 250e3

        ##################################################
        # Blocks
        ##################################################
        self.olin_usrp11 = uhd.usrp_sink(
        	device_addr="",
        	stream_args=uhd.stream_args(
        		cpu_format="fc32",
        		channels=range(1),
        	),
        )
        self.olin_usrp11.set_samp_rate(samp_rate)
        self.olin_usrp11.set_center_freq(2.4855e9, 0)
        self.olin_usrp11.set_gain(20, 0)
        self.blocks_file_source_0 = blocks.file_source(gr.sizeof_gr_complex*1, "/home/vpreston/Documents/WirelessComms/ofdm_olinpwc/transmitter.dat", False)

        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_file_source_0, 0), (self.olin_usrp11, 0))


# QT sink close method reimplementation

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.olin_usrp11.set_samp_rate(self.samp_rate)

if __name__ == '__main__':
    parser = OptionParser(option_class=eng_option, usage="%prog: [options]")
    (options, args) = parser.parse_args()
    tb = transmitter()
    tb.start()
    raw_input('Press Enter to quit: ')
    tb.stop()
    tb.wait()

