From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Fri, 26 Jan 2018 16:15:13 -0200
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <alpine.LRH.2.00.1801260739120.8259@sjc-ads-6991.cisco.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
	<0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
	<20180126103132.7szs5lj5ppm7eyy6@khazad-dum.debian.net>
	<alpine.LRH.2.00.1801260739120.8259@sjc-ads-6991.cisco.com>
Message-ID: <20180126181512.hnotac2lpxkj4ruv@khazad-dum.debian.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On Fri, 26 Jan 2018, Victor Kamensky wrote:
> On Fri, 26 Jan 2018, Henrique de Moraes Holschuh wrote:
> > On Thu, 25 Jan 2018, Rob Landley wrote:
> > > That said, I don't think -h newcx should emit (or recognize) the
> > > "TRAILER!!!1!" entry. That's kinda silly in-band signaling for 2018:
> > > files have a length, pipes provide EOF, and each cpiox entry starts with
> > > 6 bytes of c_magic anyway.
> 
> My understanding that TRAILER is really used on tape devices,
> there is no notion of file end in this case, it is just a stream of bytes
> from char device.

TRAILER is really used anywhere you can have several cpio archives
concatenated, which is the exact case of a Linux initramfs, not just
tape.

The initramfs format takes *one or more* cpio archives, concatenated.
Each archive may be independently compressed (using whatever supported
compression method), or uncompressed[1].  EOF or size information can
only tell you where the entire concatenated archive ends, not where each
"segment" (independent cpio archive that was concatenated into the
whole) ends.

TRAILER is the only decent way to know the concatenation points.
Knowing where these points are is necessary for the kernel, due to the
way hardlink encoding is done on cpio archives: one has to reset the
state of the hardlink-tracking table between cpio archives that were
concatenated, for safety (and sysadmin sanity) reasons.

[1] for the special case when one includes an "early initramfs" section
for firmware (microcode, etc) updates, the archive(s) containing the
firmware data must be uncompressed, and these archives must come before
compressed archives in the concatenation.

-- 
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
