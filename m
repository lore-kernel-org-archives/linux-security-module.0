From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Thu, 20 Apr 2017 20:13:32 -0300
Subject: [PATCH v4 1/4] KEYS: Insert incompressible bytes to reserve
	space in bzImage
In-Reply-To: <1492727320-26194-2-git-send-email-mkayaalp@linux.vnet.ibm.com>
References: <1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1492727320-26194-2-git-send-email-mkayaalp@linux.vnet.ibm.com>
Message-ID: <20170420231332.GA10262@khazad-dum.debian.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 20 Apr 2017, Mehmet Kayaalp wrote:
> Include a random filled binary in vmlinux at the space reserved with
> CONFIG_SYSTEM_EXTRA_CERTIFICATE. This results in an uncompressed reserved

Random data is not always going to be completely incompressible.  And
just how much it could be compressed also depends on the compression
engine.

Failures here would be quite annoying, even if they would be rare (not
just due to the randomness factor, but also depending on just how
overprovisioned the space reserved for the extra certificate was when
compared with the real certificate size).

Maybe it would be safer if you test it for incompressability once you
generated the random data (using the same compression engine that the
image will use)?  If it fails, add some overprovisioning and retry...

Alternatively, you could ship a static file with random data that has
been tested to be uncompressible "enough" for every currently supported
compression engine, maybe with a bit of a safety margin just in case a
future compression engine does somewhat better...

-- 
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
