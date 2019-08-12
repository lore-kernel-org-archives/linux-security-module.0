Return-Path: <SRS0=E17M=WI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22AC0650F
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Aug 2019 00:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04B2084D
	for <linux-security-module@archiver.kernel.org>; Mon, 12 Aug 2019 00:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHLA2h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 11 Aug 2019 20:28:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36268 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfHLA2h (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 11 Aug 2019 20:28:37 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwyCQ-0006Uw-8J; Mon, 12 Aug 2019 01:28:34 +0100
Date:   Mon, 12 Aug 2019 01:28:34 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Reinhard Karcher <reinhard.karcher@gmx.net>,
        934304@bugs.debian.org
Message-ID: <20190812002833.2zij7tfsqtpvqu3a@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mww77wncbtnfwvu7"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] tracefs: Fix potential null dereference in
 default_file_open()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--mww77wncbtnfwvu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "open" operation in struct file_operations is optional, and
ftrace_event_id_fops does not set it.  In default_file_open(), after
all other checks have passed, return 0 if the underlying struct
file_operations does not implement open.

Fixes: 757ff7244358 ("tracefs: Restrict tracefs when the kernel is =E2=80=
=A6")
References: https://bugs.debian.org/934304
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/tracefs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 34da48036e08..761af8ce4015 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -42,6 +42,8 @@ static int default_open_file(struct inode *inode, struct =
file *filp)
 		return ret;
=20
 	real_fops =3D dentry->d_fsdata;
+	if (!real_fops->open)
+		return 0;
 	return real_fops->open(inode, filp);
 }
=20

--mww77wncbtnfwvu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl1Qsq0ACgkQ57/I7JWG
EQmbcQ/9HmlyXyYK4D0LGsF0m6vg9D4oQV2RUlOPguhwIVLn3YAQTIPwOd82Lwb4
k+LxGKpdA4BQcYxzr/ldYpJoUK9m1RxlI2qI7Jz4Dm3eQJKcVEHxWhtFmwsnn4Hw
4m9/4bb4RRJ3zzil5gcxo6/cJEjzZSfqR3ZoUtXGxAMzJbhGSxBlQgn4ZWvEm7WR
d6kV6FO0FLWtQUQWBnTr2x89otSv99K5sjXdBPk6Mj4Bs3Fib8Y6m9Cp9fhn436t
vaOiX39Bw6j+cq/fbrPiLmmzPvurQrvf7hlsC2zVpVLttotqFZ/3Fiy8YRahVGn3
DqrTxJtdzF8nGTIzqL6k0TVbpc7AZ53B/Vi/v9DGqc1j/np/YPiJFwEEmVWCMmEm
AUoIRCCbTUAIvyZa+bYeceR1urI5hmZLlb25ls6YNgbvDIz/jh1NQxY8Ju0lFc+J
kkRSS1qbbW4z1NKXPfQvvpPQi2G6TK9INi1OTFQeDJWvOKSZyQFhBjxs7wYKe9ES
6gNrNmHtgry8JZ5yxpLBZkPKytbRK0+YT6alHS0VvqM9JmbI2GF/J6NCpsLAadk6
F4ic/Yfd3vYboSDmgedRjRX4hul0hNeq8YslMf/irW6+yD6RSjK2EwEtBnWEGrRB
nAzs4LEvMMarMOzC/KQD/Q8hi0wHCd0d995d8nUeeOL3QXsAq4s=
=lJvB
-----END PGP SIGNATURE-----

--mww77wncbtnfwvu7--
