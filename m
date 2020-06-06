Return-Path: <SRS0=zBV4=7T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DBC433E0
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Jun 2020 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368A6207BC
	for <linux-security-module@archiver.kernel.org>; Sat,  6 Jun 2020 20:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ujw/CXcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgFFUXs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 6 Jun 2020 16:23:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48227 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgFFUXs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jun 2020 16:23:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fWDs6pRWz9sSJ;
        Sun,  7 Jun 2020 06:23:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591475024;
        bh=/RVXKQNc7s6J+iFWqBZTikTiD7cWlh4s8IU4wXky4ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ujw/CXcGXRg7uulVD2dSq3PpkU8cRyGAtG3eKdsL6KSyvPUbyaSxkvEIgKVP0/8Tf
         BGKGKeE00SmCXeiSGCT38iR5Gaozf01/5Rr+/NT5irGCtCfeKT12r/1xuAyBo9i5at
         xzye2cVN9vy8D/cfDdH80R72QcKN9DuJRIjbZDDFaYgbQHL8y7p/6Ysw8S305az0ut
         vjDj+bNMtnIZnPyxG7P/emG1G7WdM/ophvkezDHMCwRRcwp++gsrANbYCZo7po2yZZ
         SJ6nCaauhJNpV6nLEZj71g6h9EShmU6H4qNnF5ToMOtY01oBlKwnxRa/+xtIveaeCf
         +VWZIlxswJaUQ==
Date:   Sun, 7 Jun 2020 06:23:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Amol Grover <frextrite@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND] device_cgroup: Fix RCU list debugging warning
Message-ID: <20200607062340.7be7e8d5@canb.auug.org.au>
In-Reply-To: <20200406105950.GA2285@workstation-kernel-dev>
References: <20200406105950.GA2285@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=4E5uuXbBLm=HNgyYa1bbKp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/=4E5uuXbBLm=HNgyYa1bbKp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 6 Apr 2020 16:29:50 +0530 Amol Grover <frextrite@gmail.com> wrote:
>
> exceptions may be traversed using list_for_each_entry_rcu()
> outside of an RCU read side critical section BUT under the
> protection of decgroup_mutex. Hence add the corresponding
> lockdep expression to fix the following false-positive
> warning:
>=20
> [    2.304417] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    2.304418] WARNING: suspicious RCU usage
> [    2.304420] 5.5.4-stable #17 Tainted: G            E
> [    2.304422] -----------------------------
> [    2.304424] security/device_cgroup.c:355 RCU-list traversed in non-rea=
der section!!
>=20
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  security/device_cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index 7d0f8f7431ff..b7da9e0970d9 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -352,7 +352,8 @@ static bool match_exception_partial(struct list_head =
*exceptions, short type,
>  {
>  	struct dev_exception_item *ex;
> =20
> -	list_for_each_entry_rcu(ex, exceptions, list) {
> +	list_for_each_entry_rcu(ex, exceptions, list,
> +				lockdep_is_held(&devcgroup_mutex)) {
>  		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
>  			continue;
>  		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
> --=20
> 2.24.1
>=20

I have been carrying the above patch in linux-next for some time now.
I have been carrying it because it fixes problems for syzbot (see the
third warning in
https://lore.kernel.org/linux-next/CACT4Y+YnjK+kq0pfb5fe-q1bqe2T1jq_mvKHf--=
Z80Z3wkyK1Q@mail.gmail.com/).
Is there some reason it has not been applied to some tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/=4E5uuXbBLm=HNgyYa1bbKp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7b+0wACgkQAVBC80lX
0GzuJwf/WmJQJu3VennV8Qzz2T7XZJ1yVPI3ujaTP0dwRTnQsl+XlRyVOJlTXksK
b6B8R+G28atgvCEa5Is7aZqUkcqj4VXuaHAWwVGA5WjlJ6BMTm1Bm3gDXBXexQKP
kiTO0XbbGBK5mOqeS33+ZWOURxm5znDNRdjoHIa0h1OvH/bRxCOneUxi9EuKWf/Z
2r1jpYHP4oGhwfBxJBDK8QH5tfTif8nI3yX/gSyrqlQIvNr9dvhTWx9F3jzczRvB
lf/f1vwU5cKZz9Wt+8q1Xv1EJjDKZpdQ1wPeKZwFtx7uGpCXWGYCxLqJV6nPCQGq
/W4O6dBrKbTNd4lu2zdIJeGCo25iBg==
=dIss
-----END PGP SIGNATURE-----

--Sig_/=4E5uuXbBLm=HNgyYa1bbKp--
