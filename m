Return-Path: <SRS0=ORYe=B3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5FC433E3
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Aug 2020 02:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCACF207FF
	for <linux-security-module@archiver.kernel.org>; Mon, 17 Aug 2020 02:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y5P7UBdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgHQCHo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgHQCHm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 16 Aug 2020 22:07:42 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BAC061786;
        Sun, 16 Aug 2020 19:07:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BVHVt2tgsz9sTK;
        Mon, 17 Aug 2020 12:07:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597630055;
        bh=NUVL7wCS3C8AjNkO2+T076Su0229oneQ8GpXoq1sVvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5P7UBdUOrLfq15c3+yrX4hNJWlKwBdrKEbO8tlxw0ZVi2cZFHtIr+yJ4e8YPwmzR
         g46Pt4KUM4u7jB+Mv9FqHIDw1vwRlBY7kasTmjYHk0L5KQRHDJz/qG1FQh+pDLwZ6D
         W6aVMYc/yWy9CLPsDlep0dlgdut718OAA4BgbZqLhKZ3y/CNVKrH0/hZ/nxdGf/v25
         qBIJqNXV+/Y254JsnPQD0UU8KReuWTA5iQ4icYxTxEsyWRrtleh0QpEVOFpDKdUnG3
         H2IIqDFGIVPF8tlY6sUHJFalhjnD3/cImvI4GJNx2bwyDYu9tPq4IoXediWbO4L4y1
         N97kpC0IJMJJQ==
Date:   Mon, 17 Aug 2020 12:07:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Amol Grover <frextrite@gmail.com>, James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND] device_cgroup: Fix RCU list debugging warning
Message-ID: <20200817120731.218e1bc5@canb.auug.org.au>
In-Reply-To: <20200608041734.GA10911@mail.hallyn.com>
References: <20200406105950.GA2285@workstation-kernel-dev>
        <20200607062340.7be7e8d5@canb.auug.org.au>
        <20200607190840.GG4455@paulmck-ThinkPad-P72>
        <20200608041734.GA10911@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//6LbZg5fP0ZKmOnWMaIHeAu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_//6LbZg5fP0ZKmOnWMaIHeAu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 7 Jun 2020 23:17:34 -0500 "Serge E. Hallyn" <serge@hallyn.com> wrot=
e:
> On Sun, Jun 07, 2020 at 12:08:40PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 07, 2020 at 06:23:40AM +1000, Stephen Rothwell wrote: =20
> > >=20
> > > On Mon, 6 Apr 2020 16:29:50 +0530 Amol Grover <frextrite@gmail.com> w=
rote: =20
> > > >
> > > > exceptions may be traversed using list_for_each_entry_rcu()
> > > > outside of an RCU read side critical section BUT under the
> > > > protection of decgroup_mutex. Hence add the corresponding
> > > > lockdep expression to fix the following false-positive
> > > > warning:
> > > >=20
> > > > [    2.304417] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [    2.304418] WARNING: suspicious RCU usage
> > > > [    2.304420] 5.5.4-stable #17 Tainted: G            E
> > > > [    2.304422] -----------------------------
> > > > [    2.304424] security/device_cgroup.c:355 RCU-list traversed in n=
on-reader section!!
> > > >=20
> > > > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > > > ---
> > > >  security/device_cgroup.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> > > > index 7d0f8f7431ff..b7da9e0970d9 100644
> > > > --- a/security/device_cgroup.c
> > > > +++ b/security/device_cgroup.c
> > > > @@ -352,7 +352,8 @@ static bool match_exception_partial(struct list=
_head *exceptions, short type,
> > > >  {
> > > >  	struct dev_exception_item *ex;
> > > > =20
> > > > -	list_for_each_entry_rcu(ex, exceptions, list) {
> > > > +	list_for_each_entry_rcu(ex, exceptions, list,
> > > > +				lockdep_is_held(&devcgroup_mutex)) {
> > > >  		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
> > > >  			continue;
> > > >  		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
> > >=20
> > > I have been carrying the above patch in linux-next for some time now.
> > > I have been carrying it because it fixes problems for syzbot (see the
> > > third warning in
> > > https://lore.kernel.org/linux-next/CACT4Y+YnjK+kq0pfb5fe-q1bqe2T1jq_m=
vKHf--Z80Z3wkyK1Q@mail.gmail.com/).
> > > Is there some reason it has not been applied to some tree? =20
> >=20
> > The RCU changes on which this patch depends have long since made it to
> > mainline, so it can go up any tree.  I can take it if no one else will,
> > but it might be better going in via the security tree.
>=20
> James, do you mind pulling it in?

I am still carrying this patch.  Has it been superceded, or is it still
necessary?

--=20
Cheers,
Stephen Rothwell

--Sig_//6LbZg5fP0ZKmOnWMaIHeAu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl855mMACgkQAVBC80lX
0Gz3+Qf7B8fFdkNeo/Cqcxhz3GWuAnNd4IeG9m8dsl67F77sOJ7U8WNnX95ZsmAw
TWCTwMDVm07rUAoqBu6uz3GxgpYTpP8lM/j4Q37kSuR3xVb6spXMyIM4J3hHC2Tz
J9pHZyBomsYrRdcAMIY2WumPPo2euve4S1MesruCJLvcA7kRrgsO3VMtPMdY72LC
5xFffg3NVRvkrJb4njqABLk9SgQObnMzBQdXYpKEy3b2XTGtQHb0T8JMc101xrnA
PxlA2JQP2T7h/HEDuK4+Nm2PbeNonAviErZjnTvRpAP6krQ9YM0wdxPVmfaFjoa3
5X0NEOx5ikRI+XktkfuPmLUeiAzmYQ==
=Nz8C
-----END PGP SIGNATURE-----

--Sig_//6LbZg5fP0ZKmOnWMaIHeAu--
