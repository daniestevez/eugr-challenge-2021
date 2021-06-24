# EU GNU Radio Days 2021 challenge solution

For the European GNU Radio Days 2021, Jean-Michel Friedt, as part of the
organizing team set up a signal decoding challenge based on GPS signals. The
challenge was posted about one month in advance of the conference. The price to
the two best solutions was two USRP B205mini's kindly provided by NI, who
sponsored the conference.

The description of the challenge can be seen
[here](https://gnuradio-eu-21.sciencesconf.org/resource/page/id/3).

I managed to solve this challenge shortly after it was published, and sent
Jean-Michel a Jupyter notebook explaining my solution. Jean-Michel liked this
approach and invited me present my solution at the conference. This presentation
can be watched in the
[recording of the conference
livestream](https://youtu.be/iXshTqIpgKk?t=17353). This also includes some
comments from Jean-Michel regarding the challenge.

In this repository I publish all the material that I used as part of my
solution, together with the original scripts that Jean-Michel used to generate
the IQ file (he has shared them after we presented the solution in the
conference).

The repository is organized as follows:

* `EU GNU Radio Days 2021 challenge.ipynb` - The Jupyter notebook which I used
  to analyse the signal and write the report of my solution. This is what I
  presented in the conference.

* `eugr_challenge.grc` - A GNU Radio flowgraph which was used to demodulate the
  BPSK signal and do some additional measurements.

* `avg_pwr.f32`, `costas_freq.f32`, `symbols.f32` - The output files produced by
  the GNU Radio flowgraph. These are provided so that the Jupyter notebook can
  be run directly, without having to re-run the flowgraph.

* `setup/` - The files that Jean-Michel used to set-up the challenge and
  generate the IQ signal.


