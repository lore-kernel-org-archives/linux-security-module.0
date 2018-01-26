From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Fri, 26 Jan 2018 08:31:32 -0200
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
	<0725a45f-45ee-7346-12ee-c3cc4b862654@landley.net>
Message-ID: <20180126103132.7szs5lj5ppm7eyy6@khazad-dum.debian.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 25 Jan 2018, Rob Landley wrote:
> That said, I don't think -h newcx should emit (or recognize) the
> "TRAILER!!!1!" entry. That's kinda silly in-band signaling for 2018:
> files have a length, pipes provide EOF, and each cpiox entry starts with
> 6 bytes of c_magic anyway. (I stopped toybox from producing the TRAILER
> entry back in june, toybox commit 32550751997d, and the kernel consumes
> the resulting cpio just fine. All the trailer does is prevent you from
> concatenating cpio files, which is a feature multiple people asked me for.)

Not in the kernel.  What TRAILER does in the kernel is to act as a
barrier for the hardlink creation state, which IS a good thing.  You
could just specify it as such for "newcx".

The kernel will continue reading for more entries after TRAILER, so
concatenation is not broken by TRAILER.  It is also insensitive to
NUL-padding length (as long as it is 4-byte aligned), which is another
nice feature you could specify for "newcx".

Also, the kernel does something nothing in userspace ever tried to,
AFAIK: it detects compression signatures along with the CPIO header
signatures, and thus it can take several compressed and uncompressed
archives concatenater together (and the compressor doesn't need to be
the same, either).

-- 
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
