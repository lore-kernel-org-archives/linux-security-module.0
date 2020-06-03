Return-Path: <SRS0=cN3+=7Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12765C433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 01:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B1020734
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 01:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GQiPquiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFCBvd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:51:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgFCBvd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 21:51:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49cBhx5rd9z9sT5;
        Wed,  3 Jun 2020 11:51:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591149091;
        bh=IXTHTQo8gDO7SUTW6DoR71nhmx/eHsJgQ/H+8J4HtFs=;
        h=Date:From:To:Cc:Subject:From;
        b=GQiPquiRjfonEs5XfrIIkpJ7OUyvGd3owEWInsOz3v4YojQVmInZYv5uJ4kJWc9hc
         BcGLf6GdKEjYm626Ra4cjRvwulQmsgiabli+76FEC3yj16XWysLcpYUgII4+wxEvhb
         jKCDY2dZPgsnk0D4lPTASXG6lr7Xi8G28Sg4vV0yOfguC5UGLcxqHu9KZaX02a2vdF
         5bucn/9CUMH90NeQrIUqE3/2yxmKDdf1rsKxpp/82izPSH+ENzNgp/mwx2Sd70rMla
         6PH/EboyMF3tTpd0LLdPhh5vkfUWdiHLkb6dlPFI727SMW3OBBPoBzYaDvAQsjc19h
         LvbuhTqJvUjtA==
Date:   Wed, 3 Jun 2020 11:51:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: linux-next: build failure after merge of the overlayfs tree
Message-ID: <20200603115127.28b01992@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U+hxjZ8=pu2.z0OP9GUGsK3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/U+hxjZ8=pu2.z0OP9GUGsK3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the overlayfs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "security_file_ioctl" [fs/overlayfs/overlay.ko] undefined!

Caused by commit

  b5940870e166 ("ovl: call secutiry hook in ovl_real_ioctl()")

I have applied this patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 3 Jun 2020 11:44:19 +1000
Subject: [PATCH] export security_file_ioctl

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/security.c b/security/security.c
index 51de970fbb1e..077ac86faacf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1459,6 +1459,7 @@ int security_file_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
 {
 	return call_int_hook(file_ioctl, 0, file, cmd, arg);
 }
+EXPORT_SYMBOL_GPL(security_file_ioctl);
=20
 static inline unsigned long mmap_prot(struct file *file, unsigned long pro=
t)
 {
--=20
2.26.2

--=20
Cheers,
Stephen Rothwell

--Sig_/U+hxjZ8=pu2.z0OP9GUGsK3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7XAh8ACgkQAVBC80lX
0Gz9bwf/dL+jSQtXGVI6j6OZ9SMNBjPPIGl17qVT5JtvHuBoMyRRrJuCfcWdmC6r
/o3NwyIA5NR0E0ZLt9Zak1o6nRuRq7t68onDAJ7CB5IG5N4bPdyvZXEtDHNzD+CB
zLjgzE2xbvX5d5eMJzL4XVHd0GuR3GnErf+V3ucaCDPoVKGXJhQS9gOFMXRyEw75
0K/ziimdRBG9Twtfo+sSaidszv+KHZELl1/pZLdAN9XujCSGFuFlZYju4OslszLB
2K44N4Kkqg4PrAyD48eUH92z7whgy2lJ2m58JWCQEaYge83Fz9IYnnSNBvcZ/MnC
s1cY5ZqfIlnLpzFXdTT3104up6v+pQ==
=T6mB
-----END PGP SIGNATURE-----

--Sig_/U+hxjZ8=pu2.z0OP9GUGsK3--
