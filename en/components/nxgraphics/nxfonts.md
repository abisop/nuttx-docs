# NX Fonts Support (`NXFONTS`)

## NXFONTS types

## Wide Font Support

Question:

    > My team is trying the nuttx graphics with chinese fonts, but nx seems not
    > support fonts quantity more than 256 chars, right?

Answer:

    NuttX currently only uses fonts with 7-bit and 8-bit character sets. But
    I believe that that limitation is mostly arbitrary. It should be a simple
    extension to the font subsystem to use 16-bit fonts.

### Adding 16-Bit Font support

#### Current 7/8-bit Font Implementation

All of critical font interfaces allow for 16-bit character sets:

``` C
FAR const struct nx_fontbitmap_s *nxf_getbitmap(NXHANDLE handle, uint16_t ch)
```

The character code is only used to look-up of a glyph in a table. There
is a definition that controls the width of the character set:
CONFIG\_NXFONTS\_CHARBITS. This currently defaults to 7 but all existing
fonts support 8-bits.

My first guess is that the only thing that would have to change is that
single file nxfonts\_bitmaps.c (and the function nxf\_getglyphset() in
the file nxfonts\_getfont.c) . nxfonts\_bitmaps.c is used to
auto-generate 7/8-bit font data sents. Here is how that works:

  - Each 7-8 bit file is described by a header file like, for example,
    nxfonts\_sans17x22.h.
  - At build time each of these header files is used to create a C file,
    like, nxfonts\_bitmaps\_sans17x22.c.
  - It creates the C file (like nxfonts\_bitmaps\_sans17x22.c) by
    compiling nxfonts\_bitmaps.c and including nxfonts\_sans17x22.h to
    create the font dataset at build time.

The function nxf\_getglyphset() in the file nxfonts\_getfont.c selects
the 7-bit font range (codes \< 128) or the 8-bit range (code \>= 128 \>
256). The fonts are kept in simple arrays splitting the data up into
ranges of values lets you above the non-printable codes at the beginning
and end of each range. There is even a comment in the code there
"Someday, perhaps 16-bit fonts will go here".

#### Adding Wide Fonts

To add a single wide font, the easiest way would be to simply add the
final .C file without going through the C auto-generation step. That
should be VERY easy. (But since it has never been used with larger
character sets, I am sure that there are bugs and things that need to be
fixed).

If you want to add many wide fonts, then perhaps you would have to
create a new version of the C auto-generation logic. That would require
more effort.

I am willing to help and advise. Having good wide character support in
the NuttX graphics would be an important improvement to NuttX. This is
not a lot of code nor is it very difficult code so you should not let it
be an obstacle for you.

### Font Storage Issues

One potential problem may be the amount of memory required by fonts with
thousands of characters. If you have a lot of flash, it may not be a
problem, but on many microcontrollers it will be quite limiting.

Options are:

  - **Font Compression** Addition of some font compression algorithm in
    NuttX. However, Chinese character bitmaps do not compress well: Many
    of them contain so much data that there is not much of anything to
    compress. Some actually expand under certain compression algorithms.
  - **Mass Storage** A better option would be put the wide the fonts in
    file system, in NAND or serial FLASH or on an SD card. In this case,
    additional logic would be required to (1) format a font binary file
    and to (2) access the font binary from the file system as needed.
