From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Thu, 20 Apr 2017 20:22:29 -0400
Subject: [PATCH v4 1/4] KEYS: Insert incompressible bytes to reserve space
	in bzImage
In-Reply-To: <20170420231332.GA10262@khazad-dum.debian.net>
References: <1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1492727320-26194-2-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<20170420231332.GA10262@khazad-dum.debian.net>
Message-ID: <34372BAD-2FE2-458D-9331-AA277B1764C7@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Apr 20, 2017, at 7:13 PM, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> 
> On Thu, 20 Apr 2017, Mehmet Kayaalp wrote:
>> Include a random filled binary in vmlinux at the space reserved with
>> CONFIG_SYSTEM_EXTRA_CERTIFICATE. This results in an uncompressed reserved
> 
> Random data is not always going to be completely incompressible.  And
> just how much it could be compressed also depends on the compression
> engine.

It's almost impossible to compress random data. The compression 
algorithm is looking for a pattern, and there is none. Plus, the format of 
the compression adds an overhead.

    for n in `seq 8 24`; do \
    perl -e 'srand(0); printf("%c", int(rand(256))) for (1..(1<<$ARGV[0]))' \
    $n | bzip2 -9 -c -v > /dev/null; \
    done
  (stdin):  0.615:1, 13.000 bits/byte, -62.50% saved, 256 in, 416 out.
  (stdin):  0.760:1, 10.531 bits/byte, -31.64% saved, 512 in, 674 out.
  (stdin):  0.780:1, 10.250 bits/byte, -28.12% saved, 1024 in, 1312 out.
  (stdin):  0.831:1,  9.629 bits/byte, -20.36% saved, 2048 in, 2465 out.
  (stdin):  0.895:1,  8.939 bits/byte, -11.74% saved, 4096 in, 4577 out.
  (stdin):  0.947:1,  8.449 bits/byte, -5.62% saved, 8192 in, 8652 out.
  (stdin):  0.972:1,  8.232 bits/byte, -2.90% saved, 16384 in, 16859 out.
  (stdin):  0.985:1,  8.122 bits/byte, -1.52% saved, 32768 in, 33266 out.
  (stdin):  0.990:1,  8.079 bits/byte, -0.99% saved, 65536 in, 66187 out.
  (stdin):  0.993:1,  8.060 bits/byte, -0.75% saved, 131072 in, 132055 out.
  (stdin):  0.994:1,  8.048 bits/byte, -0.60% saved, 262144 in, 263720 out.
  (stdin):  0.995:1,  8.042 bits/byte, -0.53% saved, 524288 in, 527067 out.
  (stdin):  0.996:1,  8.036 bits/byte, -0.45% saved, 1048576 in, 1053269 out.
  (stdin):  0.996:1,  8.036 bits/byte, -0.45% saved, 2097152 in, 2106558 out.
  (stdin):  0.996:1,  8.035 bits/byte, -0.44% saved, 4194304 in, 4212741 out.
  (stdin):  0.996:1,  8.035 bits/byte, -0.44% saved, 8388608 in, 8425198 out.
  (stdin):  0.996:1,  8.035 bits/byte, -0.44% saved, 16777216 in, 16850429 out.

> Failures here would be quite annoying, even if they would be rare (not
> just due to the randomness factor, but also depending on just how
> overprovisioned the space reserved for the extra certificate was when
> compared with the real certificate size).

I wanted to avoid the randomness with the seed. For a given size, you 
will get the same random payload. There will be over-provisioning, but
primarily because we don't know the size of the certificate to be inserted,
and how much it will compress.

> Maybe it would be safer if you test it for incompressability once you
> generated the random data (using the same compression engine that the
> image will use)?  If it fails, add some overprovisioning and retry...

The actual amount of over-provisioning will depend on the size and the
compressibility of the certificate to be inserted. If you have a longer CN,
it will compress more.

> Alternatively, you could ship a static file with random data that has
> been tested to be uncompressible "enough" for every currently supported
> compression engine, maybe with a bit of a safety margin just in case a
> future compression engine does somewhat better...

The seed makes it static for a given size, and I tested it to be
incompressible. But I don't know about the safety margin. Even without the
compression, the reserved size is not accurate. If you reserve 4096 bytes,
the DER encoded certificate inserted is not going to be exactly 4096 either
(for reference, the built-in certificate is 1346 bytes). Compression makes it 
a little more inaccurate, but is over-provisioning several hundreds of bytes 
a concern when the bzImage is several megabytes?

Unless you have a compression method that detects how the pseudo-random 
bytes are generated and encodes the recipe to generate it again, you can't 
achieve positive compression rates. I'm sure there is a proof for true random
generation involving the Shannon entropy. 

>  Henrique Holschuh

Mehmet

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
