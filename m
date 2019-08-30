Return-Path: <SRS0=wEfZ=W2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F52C3A59B
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Aug 2019 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC9023407
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Aug 2019 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3Pr2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:47:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59580 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbfH3Pr2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Aug 2019 11:47:28 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i3j7R-0007T1-0P; Fri, 30 Aug 2019 16:47:21 +0100
Date:   Fri, 30 Aug 2019 16:47:20 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Joern Engel <joern@lazybastard.org>,
        linux-mtd@lists.infradead.org
Message-ID: <20190830154720.eekfjt6c4jzvlbfz@decadent.org.uk>
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2t5f3x5aksjeqpl"
Content-Disposition: inline
In-Reply-To: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH 2/2] mtd: phram,slram: Disable when the kernel is locked down
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--r2t5f3x5aksjeqpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These drivers allow mapping arbitrary memory ranges as MTD devices.
This should be disabled to preserve the kernel's integrity when it is
locked down.

* Add the HWPARAM flag to the module parameters
* When slram is built-in, it uses __setup() to read kernel parameters,
  so add an explicit check security_locked_down() check

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Matthew Garrett <mjg59@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Joern Engel <joern@lazybastard.org>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/devices/phram.c | 6 +++++-
 drivers/mtd/devices/slram.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index c467286ca007..9c18b4bb2ed9 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -294,7 +294,11 @@ static int phram_param_call(const char *val, const str=
uct kernel_param *kp)
 #endif
 }
=20
-module_param_call(phram, phram_param_call, NULL, NULL, 000);
+static const struct kernel_param_ops phram_param_ops =3D {
+	.set =3D phram_param_call
+};
+__module_param_call(MODULE_PARAM_PREFIX, phram, &phram_param_ops, NULL,
+		    000, -1, KERNEL_PARAM_FL_HWPARAM | hwparam_iomem);
 MODULE_PARM_DESC(phram, "Memory region to map. \"phram=3D<name>,<start>,<l=
ength>\"");
=20
=20
diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 28131a127d06..d92a2461e2ce 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -43,6 +43,7 @@
 #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/security.h>
=20
 #include <linux/mtd/mtd.h>
=20
@@ -65,7 +66,7 @@ typedef struct slram_mtd_list {
 #ifdef MODULE
 static char *map[SLRAM_MAX_DEVICES_PARAMS];
=20
-module_param_array(map, charp, NULL, 0);
+module_param_hw_array(map, charp, iomem, NULL, 0);
 MODULE_PARM_DESC(map, "List of memory regions to map. \"map=3D<name>, <sta=
rt>, <length / end>\"");
 #else
 static char *map;
@@ -281,11 +282,17 @@ static int __init init_slram(void)
 #ifndef MODULE
 	char *devstart;
 	char *devlength;
+	int ret;
=20
 	if (!map) {
 		E("slram: not enough parameters.\n");
 		return(-EINVAL);
 	}
+
+	ret =3D security_locked_down(LOCKDOWN_MODULE_PARAMETERS);
+	if (ret)
+		return ret;
+
 	while (map) {
 		devname =3D devstart =3D devlength =3D NULL;
=20

--r2t5f3x5aksjeqpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1pRQgACgkQ57/I7JWG
EQky4w//f9aD0LvA83V3Xs9vTI9OkxLhLzgXazInwgg2N0l4WjPGmtGtSybKzxKM
L+lgfLV5iXGmUJjFqjRu5QvWx7ZkUhJnkA/LnZgSnuJjRTf2auVASxqk5KXdfeYz
MK9d3kT9iUPSv/5N21fxO3hDZyOGYzBKFcEtzT100ny6Q1Gm8VLZn2an0j2YxPLz
Bz8/XAb+KdTRQvvSJS4Pl/00LYIppZg8IaukYVorjC7z0XHaSo7dDh47bC+ea320
p7R1EMON+eCXqXmja88tR3aVcntYcxk8+rEtR9hlcwyVSzHPta/Pwe+2Nrp5m5g0
yJabwkHRZk9/sHJnwhixJQ6j7a2SAD7FPriyijSlnOsOk+b2kHsFCkn6HGgKHhNX
xAABgln6PGwEej2HBger/25ZIvm3XmqE2SFTnx8m0YbQyVUIQnC5RT7fzwCy5cYb
6Sex57lcZL3MaSjioH3+U7W5aq56WLoWuxOPXt01Qq0GqmoM0+nG6wE6VmnDHJmF
NsKKSOWtCP1d/ZhtWHVpnXrzdYbrqMF8WX1n6NKN6885mi2c5v5+9CR44t+3zBT6
HdJFquw3CsppA1NGqoT5OrkrxojExiJdfRlcQ1MgZRhskk562PBC1N5/KcEtMbIz
DnSA0WxIpaoSQbpy07UvdqjkbUf+P0D+mTO+SIrgZoqyI9pES28=
=IHMt
-----END PGP SIGNATURE-----

--r2t5f3x5aksjeqpl--
