From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Fri, 21 Apr 2017 16:47:32 -0300
Subject: [PATCH v4 1/4] KEYS: Insert incompressible bytes to reserve
	space in bzImage
In-Reply-To: <34372BAD-2FE2-458D-9331-AA277B1764C7@linux.vnet.ibm.com>
References: <1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1492727320-26194-2-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<20170420231332.GA10262@khazad-dum.debian.net>
	<34372BAD-2FE2-458D-9331-AA277B1764C7@linux.vnet.ibm.com>
Message-ID: <20170421194732.GB23671@khazad-dum.debian.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 20 Apr 2017, Mehmet Kayaalp wrote:
> > On Apr 20, 2017, at 7:13 PM, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > On Thu, 20 Apr 2017, Mehmet Kayaalp wrote:
> >> Include a random filled binary in vmlinux at the space reserved with
> >> CONFIG_SYSTEM_EXTRA_CERTIFICATE. This results in an uncompressed reserved

...

> > Alternatively, you could ship a static file with random data that has
> > been tested to be uncompressible "enough" for every currently supported
> > compression engine, maybe with a bit of a safety margin just in case a
> > future compression engine does somewhat better...
> 
> The seed makes it static for a given size, and I tested it to be
> incompressible. But I don't know about the safety margin. Even without the

If you tested the result to be incompressible enough, it is fine with me.

> compression, the reserved size is not accurate. If you reserve 4096 bytes,
> the DER encoded certificate inserted is not going to be exactly 4096 either
> (for reference, the built-in certificate is 1346 bytes). Compression makes it 
> a little more inaccurate, but is over-provisioning several hundreds of bytes 
> a concern when the bzImage is several megabytes?

Maybe for embedded, but in that case any overprovisioning would already
be too much, and one has to fix the issue in some other way.

-- 
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
