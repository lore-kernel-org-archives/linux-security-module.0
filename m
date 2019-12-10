Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11225C00454
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1E9205C9
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 23:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xosg+lWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLJXCZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:02:25 -0500
Received: from ozlabs.org ([203.11.71.1]:45165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfLJXCV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 18:02:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47XbDT4jqKz9sP6;
        Wed, 11 Dec 2019 10:02:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576018938;
        bh=2e7cHXoDx8ZiGh3K35Wg17/+KPrkBHct/lD4smwVHfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xosg+lWziAL1ePe3DSOOTHOCMj+YGYBLplxX5d8Qd7KlEB3baZBFSY+kGct/djcTZ
         EDmIvELQJ/Pg3J4dLgk0NiDniBlEw6mhhJ7/BKcAi/VqxaSsmOQiiw5ldN65pXSXr8
         0oGF99dyFz715sDzYjvcPN6n0++gloEgoWwKph/oVVWbToB2JXz9wL6a9lNQQ5CZlb
         e3i2aZjaAW0iP5WpP+S/va9tnxvzVze0kIYtfPJNjnacDXafFYwhnFdjQo7RbsBvvr
         o16FKbRPT7DOHnrlcgdqCImPkTHpVd6J38gduZ3S0mLC8+oaja0xLRjQ92lzIHyWsT
         qv4Sk5vuD/JTQ==
Date:   Wed, 11 Dec 2019 10:02:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
Message-ID: <20191211100215.2c0aec54@canb.auug.org.au>
In-Reply-To: <457927e7-2cec-3933-3e5c-67ebd29d8a52@i-love.sakura.ne.jp>
References: <0000000000004f43fa058a97f4d3@google.com>
        <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
        <alpine.LRH.2.21.1907061944050.2662@namei.org>
        <alpine.LRH.2.21.1907061949040.2662@namei.org>
        <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
        <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp>
        <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au>
        <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp>
        <20191003082543.5e1e25dd@canb.auug.org.au>
        <b175f451-4e76-84aa-48fa-e3ee9490c579@i-love.sakura.ne.jp>
        <d5cbd24b-531d-e9d0-f784-e6447129741d@i-love.sakura.ne.jp>
        <alpine.LRH.2.21.1911211818320.3625@namei.org>
        <cba33548-91dc-42b4-ef96-43642ebc3427@i-love.sakura.ne.jp>
        <b7263da2-d56d-0f27-a7e5-03541ff8a0c1@i-love.sakura.ne.jp>
        <579b10bb-990f-ae4c-8098-b39e56a4c475@i-love.sakura.ne.jp>
        <alpine.LRH.2.21.1912100837160.4379@namei.org>
        <457927e7-2cec-3933-3e5c-67ebd29d8a52@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/75_F.aV60fI1Qse6fToPlO.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/75_F.aV60fI1Qse6fToPlO.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tetsuo,

On Tue, 10 Dec 2019 19:21:08 +0900 Tetsuo Handa <penguin-kernel@i-love.saku=
ra.ne.jp> wrote:
>
> On 2019/12/10 6:37, James Morris wrote:
> > On Wed, 4 Dec 2019, Tetsuo Handa wrote:
> >  =20
> >>
> >> I decided to drop tomoyo_get_socket_name(). Will you pick up the follo=
wing commit?
> >>
> >> commit c39593ab0500fcd6db290b311c120349927ddc04
> >> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Date:   Mon Nov 25 10:46:51 2019 +0900
> >>
> >>     tomoyo: Don't use nifty names on sockets.
> >> =20
> >  =20
> >>From where? =20
> >=20
> > Please send a patch.
> >  =20
>=20
> Patch is at https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1 and was test=
ed on linux-next.git .
> But if you pick up c39593ab0500, what do I need to do (in order to avoid =
trying to apply the same
> patch) ? Could you explain me (using command line) how I can send only c3=
9593ab0500 to linux.git ?
> https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits has only ma=
ster branch.
>=20
> c39593ab0500 (HEAD -> master, origin/master) tomoyo: Don't use nifty name=
s on sockets.
> cbf8353d474c Merge branch 'master' of https://scm.osdn.net/gitroot/tomoyo=
/tomoyo-test1
> fd46afeac605 Revert "tomoyo: Don't check open/getattr permission on socke=
ts."
> 19768fdc4025 Revert "printk: Monitor change of console loglevel."
> 07fca3f339d7 printk: Monitor change of console loglevel.
> df8aec8cd8b2 tomoyo: Don't check open/getattr permission on sockets.
> 219d54332a09 (tag: v5.4, upstream/master) Linux 5.4

You should start by cleaning up your tree:

remove

fd46afeac605 Revert "tomoyo: Don't check open/getattr permission on sockets=
."
19768fdc4025 Revert "printk: Monitor change of console loglevel."
07fca3f339d7 printk: Monitor change of console loglevel.
df8aec8cd8b2 tomoyo: Don't check open/getattr permission on sockets.

since they end up cancelling each other out

cbf8353d474c Merge branch 'master' of https://scm.osdn.net/gitroot/tomoyo/t=
omoyo-test1

only introduces these commits:

79c8ca578dbf Revert "printk: Monitor change of console loglevel."
23641a048089 printk: Monitor change of console loglevel.
a5f9bda81cb4 tomoyo: Don't check open/getattr permission on sockets.

and the first 2 above cancel each other out.

so you are left with these:

c39593ab0500 tomoyo: Don't use nifty names on sockets.
a5f9bda81cb4 tomoyo: Don't check open/getattr permission on sockets.

you should rebase these onto v5.5-rc1.

If you want James to just take the first of these, then the easiest way
is probably to just send him a patch that you generate using "git
format-patch" and then remove it from your tree.

Since there are no other changes to the only file affected by that
commit since v5.4, you could just do this:

$ git format-patch -o <some file> -1 c39593ab0500

and then <some file> to James using your email client.

Having done that, you should just do this (and forget the cleanups
above):

$ git checkout master
$ git remote update upstream
$ git reset --hard upstream/master
$ git cherry-pick a5f9bda81cb4
$ git push -f origin master

After that you will have a nice clean tree (based on Linus' tree) to
continue development on that just contains the one patch "tomoyo: Don't
check open/getattr permission on sockets."

If, however, you intend to only send patche via James tree, then you
should be using his tree
(git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
branch next-testing) as your upstream tree, not Linus' tree.  Then you
can ask him to merge your tree before the merge window opens during
each cycle.  You may want to rebase your tree on top of James tree
after he applies your patch from above.

--=20
Cheers,
Stephen Rothwell

--Sig_/75_F.aV60fI1Qse6fToPlO.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3wI/cACgkQAVBC80lX
0Gyt6wf+MTeyQ+N0Tzd4tbsykrogltUyfyS7IysunB9D8nIUriYZtB8KKoVwjSYm
4bJ6zFK3xuLkfaHBxvnvERP6fgYO3dZjyMyf81cz7fZpCsdsO+XJ6+8Kyqt+lNom
4vQ858NyeTXrP6GE80YulO11Dn9xxlUE2Enh8Vdo5ZOh9+uwvdMTls3cZxyWaZ+U
Lm8BBMvfA88NEGV4nXtEhYl6n0EQfxy8aghEjGZsv068SjVwDSaGWNrjQ9dbPrAw
S0F4tUhPiyUOk/LUHVE6vJBFJEbrizRGrwD0tbjTQMsytDIDP4gIoOQCB4Q0y8gO
o7m6XRO3iqNCteJkyKVKUYKNETEPLA==
=AhAV
-----END PGP SIGNATURE-----

--Sig_/75_F.aV60fI1Qse6fToPlO.--
