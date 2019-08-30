Return-Path: <SRS0=wEfZ=W2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB06C3A59B
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Aug 2019 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866BE23407
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Aug 2019 15:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3Ppx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:45:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59562 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727304AbfH3Ppx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Aug 2019 11:45:53 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1i3j5x-0007Pk-B7; Fri, 30 Aug 2019 16:45:49 +0100
Date:   Fri, 30 Aug 2019 16:45:49 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Message-ID: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gl44f56bttykni5p"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH 1/2] staging: comedi: Restrict COMEDI_DEVCONFIG when the
 kernel is locked down
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--gl44f56bttykni5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The COMEDI_DEVCONFIG ioctl can be used to configure I/O addresses and
other hardware settings for non plug-and-play devices such as ISA
cards.  This should be disabled to preserve the kernel's integrity
when it is locked down.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Matthew Garrett <mjg59@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 drivers/staging/comedi/comedi_fops.c | 6 ++++++
 include/linux/security.h             | 1 +
 security/lockdown/lockdown.c         | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/=
comedi_fops.c
index f6d1287c7b83..fdf030e53035 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -27,6 +27,7 @@
=20
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
=20
 #include "comedi_internal.h"
=20
@@ -813,11 +814,16 @@ static int do_devconfig_ioctl(struct comedi_device *d=
ev,
 			      struct comedi_devconfig __user *arg)
 {
 	struct comedi_devconfig it;
+	int ret;
=20
 	lockdep_assert_held(&dev->mutex);
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
+	ret =3D security_locked_down(LOCKDOWN_COMEDI_DEVCONFIG);
+	if (ret)
+		return ret;
+
 	if (!arg) {
 		if (is_device_busy(dev))
 			return -EBUSY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 429f9f03372b..b16365dccfc5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -113,6 +113,7 @@ enum lockdown_reason {
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
+	LOCKDOWN_COMEDI_DEVCONFIG,
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_DEBUGFS,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0068cec77c05..971bb99b9051 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MA=
X+1] =3D {
 	[LOCKDOWN_ACPI_TABLES] =3D "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] =3D "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] =3D "reconfiguration of serial port IO",
+	[LOCKDOWN_COMEDI_DEVCONFIG] =3D "reconfiguration of Comedi legacy device",
 	[LOCKDOWN_MODULE_PARAMETERS] =3D "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] =3D "unsafe mmio",
 	[LOCKDOWN_DEBUGFS] =3D "debugfs access",


--gl44f56bttykni5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1pRJ8ACgkQ57/I7JWG
EQkNRA/+JbL0WWf0adBhwhIcIsqLeSrOAS+1q2y/SjuoOblrDppPhwL5G3NKfZQj
tJbtP9o/fQPFLN2/qcGQVcHnQQ7BPlJTlE70RX5OaliUAupxoetG7UfaYBFC6YBs
IRLIUzjf1wwXCIaIVcZQbBNGjAkF0Y9LyxO2q2p8BDyaBIC63dFovbrBB8RNRQSv
Fs57/Io3duvZ+5uAmFFAux1QC3SxerzMDLfx69Cs6IBqZl2gLtWPqcp17KJvftez
xRr6T9EQw8HkE6pKq1O83d2OO9kpkfxClTCjjKR+ssNi4XKnSstBeR0GmrXRAE6Z
+r28HGOXv5WijBiFmjZoYZ1TTQihVPW5bnWJOxpJBswP4g+BeA1oviyQK2NSe6ZI
quhNNkE5FxoerRs08vuUwTTnQRScTR4q++STWAJS5Kgl1LdT3rXWQQU9uMUxBVvy
5IMa9sxCLexv9F9RQuZNAFfo5/PfXKcewllxKkknUMujrSY0DulLpxHb6SMJs3BK
8/PGSRplrijhj3smandQhHksUEp5JqsVqvyxcJq7QfVQ5i0oOBiQongrx7E9ROL8
+OtTq9KkSkjUtLyC1QVd86C+vFRFn51Q6HfaNKYi5XQrLrWzrDlRiMz6TGSZ/C8t
0BiJySTgifjW+YgSxcVSXRSiOqQ1lsUft/OgKEBV1wWS7DlJ11Q=
=xyF+
-----END PGP SIGNATURE-----

--gl44f56bttykni5p--
