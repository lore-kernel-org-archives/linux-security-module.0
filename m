Return-Path: <SRS0=xhHr=X3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B75C4360C
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Oct 2019 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CBF222BE
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Oct 2019 22:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WA0EGMUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJBWZr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:25:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBWZq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Oct 2019 18:25:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46k9h839bPz9sN1;
        Thu,  3 Oct 2019 08:25:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570055144;
        bh=5F3yOR0bmW3ouqVx4pf6U+ZCPWzBAV6g6y7UGFVV+Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WA0EGMUePzcp+WogcKNby1RwDQ/aVqLtnHbdrihx6Vy8gqEjuUbPtu1SZho/bkA+W
         nneAs4EQjBUoYUsYayPy/8Gtxxufk51HdC6R6Zsb6/jeHtbUW+fQG0s6PZ4N+MmLJu
         MJ8h3HtYHhW7Ck13EEbFfIsSjxqmzK3GFMBbdiiuDNosjfjUaKS3TS0y58v8rrt6gH
         aN6E04q785zZLL4oNtUJ+Q90b+oePA03tWapTxpXQs1yid6fqmJL87A4avb4gK0O6y
         /YjGMJCwm6kw3HB+SmEvgVTIrwivVKrF/k1GHizZTYTe9noqmXn2BlBI0FA5VIrWDR
         xgfEBj9NBhi0A==
Date:   Thu, 3 Oct 2019 08:25:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
Message-ID: <20191003082543.5e1e25dd@canb.auug.org.au>
In-Reply-To: <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp>
References: <0000000000004f43fa058a97f4d3@google.com>
        <201906060520.x565Kd8j017983@www262.sakura.ne.jp>
        <1b5722cc-adbc-035d-5ca1-9aa56e70d312@I-love.SAKURA.ne.jp>
        <a4ed1778-8b73-49d1-0ff0-59d9c6ac0af8@I-love.SAKURA.ne.jp>
        <20190618204933.GE17978@ZenIV.linux.org.uk>
        <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
        <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
        <alpine.LRH.2.21.1907061944050.2662@namei.org>
        <alpine.LRH.2.21.1907061949040.2662@namei.org>
        <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
        <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp>
        <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au>
        <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S.1i3Bsngmv4bP0LfpnwO4z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/S.1i3Bsngmv4bP0LfpnwO4z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tetsuo,

On Wed, 2 Oct 2019 19:50:48 +0900 Tetsuo Handa <penguin-kernel@i-love.sakur=
a.ne.jp> wrote:
>
> On 2019/09/14 16:36, Stephen Rothwell wrote:
> >=20
> > I am on vacation until after the merge window closes, so I will add it =
then.
> > Please remind me if I don't. =20
>=20
> Did you return from the vacation?

I knew I'd missed one (but I have too much email :-().

I don't think the back merges of Linus' tree add anything useful to
your tree.  At this point it probably makes sense to just rebase the
single patch onto v5.4-rc1 and then not back merge Linus' tree at all
(unless some really complex conflict arises).
--=20
Cheers,
Stephen Rothwell

--Sig_/S.1i3Bsngmv4bP0LfpnwO4z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2VI+cACgkQAVBC80lX
0GzjuQf+Nv0uCgSclrxv1CaknxthZtvyIGF0LKhJk7l0aLdI0IFKReWeOT/q31Yn
FQ4YBgt/aIS3aQ+Ur31Ih7pCe/19j/bS277/dt/r9j2L/0c9gN2L/4ZTAR6HTT6K
jkgJhf3VN60xy6jcaKNrK8XYBZwJSyfdh0f6a4qqyf2TgfMjRSFXKky6S/epJCHc
RDWrRP499KTeNQnWCkA319UqIP1AtpS8er7VDCQMV8zKhFOxctaqPwsJUtVLFLei
7WipMMMXTVt/k5eH1ntSPp2DtXK1iUjrYpo152P7C4Hl4UrBN7dxNR+M+P6eDwRt
EV4vQMv+Y7i2mrrsZIyG87sfz+9JAQ==
=nexe
-----END PGP SIGNATURE-----

--Sig_/S.1i3Bsngmv4bP0LfpnwO4z--
