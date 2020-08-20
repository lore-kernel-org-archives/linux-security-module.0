Return-Path: <SRS0=ujXN=B6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE9C433E1
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1186620674
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 22:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="twbOspkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHTWiv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgHTWiu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Aug 2020 18:38:50 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70102C061385;
        Thu, 20 Aug 2020 15:38:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BXfh26lXPz9sPB;
        Fri, 21 Aug 2020 08:38:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1597963123;
        bh=F1zcYsdZEtWVf/zph6DxdSSfdnjlkS+N4xOJss6GUmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=twbOspkkBIkYtrG22l8cHZJMJ874DskZKQSqUK/BojIL90zIYlRaszfuWRwzfeyK9
         HvAP/5WyOgFxt8eEsZrsc1+YPGInbkR5J68Rf8oLW52dh6rMauQpPwmUyAwmNWFyZX
         iLmgngRaeYPOMYGLkKSLxCKcXfsKrpYHinTUIMSA/pEtoMOH2z/jL5W6DZadhAP5hn
         ufpw1rO/nlW2VbIZDXV32TLdVwGe5lJsKlnG+MugFuPMgA0SmUC9WUBKaqdN2n8k/M
         ane0XFbh+mu6rDjRT0iAW3xk+j427833EGIWtWdEcDObxxVOvdQaW41EwchCp4oZci
         lvytoweLXSwBw==
Date:   Fri, 21 Aug 2020 08:38:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Morris <jmorris@namei.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND] device_cgroup: Fix RCU list debugging warning
Message-ID: <20200821083841.2ff9e0c3@canb.auug.org.au>
In-Reply-To: <alpine.LRH.2.21.2008210427590.29407@namei.org>
References: <20200406105950.GA2285@workstation-kernel-dev>
        <20200607062340.7be7e8d5@canb.auug.org.au>
        <20200607190840.GG4455@paulmck-ThinkPad-P72>
        <20200608041734.GA10911@mail.hallyn.com>
        <20200817120731.218e1bc5@canb.auug.org.au>
        <alpine.LRH.2.21.2008210427590.29407@namei.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a_eM9dyE5z92OcSM1Vl5uSN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/a_eM9dyE5z92OcSM1Vl5uSN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, 21 Aug 2020 04:28:34 +1000 (AEST) James Morris <jmorris@namei.org> =
wrote:
>
> On Mon, 17 Aug 2020, Stephen Rothwell wrote:
>=20
> > > > mainline, so it can go up any tree.  I can take it if no one else w=
ill,
> > > > but it might be better going in via the security tree. =20
> > >=20
> > > James, do you mind pulling it in? =20
> >=20
> > I am still carrying this patch.  Has it been superceded, or is it still
> > necessary? =20
>=20
> It appears to be necessary.
>=20
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git =
fixes-v5.9

Thanks, I have dropped my copy.

--=20
Cheers,
Stephen Rothwell

--Sig_/a_eM9dyE5z92OcSM1Vl5uSN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8++3EACgkQAVBC80lX
0GyaTAf+IaxI9JhgNTkeBKSvhvhEo7K22MCpbRAH+wHik1W7k/hlpLkHMBuHfkIZ
NlRQFvJkPc950k5rSeWxE0+/53XCK2lnnp7tThfD0Xh8YyOk6kXX+kNhzfNAHFSn
a66Fm7lsC8jtjicjGx9QN//v/ZsEn96vQsCECZ60Hll9iIG4tMOEqD4wdoHNVshH
GyzzvPYAw0SLakK06GC0v8Xxsk8587SeGaTYG0SDyo1Fx955poQqfeMbwIWNXP4K
Qt7QI4yKli5iDBLmWeQnhVpEiZea5p1oUfttOBp10zlhcWXm8ewZKzk6zG/0+lXu
+v5s3BQf4z2bdOg4hsz18vLQ7f7BeQ==
=gRVV
-----END PGP SIGNATURE-----

--Sig_/a_eM9dyE5z92OcSM1Vl5uSN--
