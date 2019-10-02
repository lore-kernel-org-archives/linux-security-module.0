Return-Path: <SRS0=xhHr=X3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D2C4360C
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Oct 2019 22:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF340217D7
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Oct 2019 22:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mXxRnK8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfJBWWn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:22:43 -0400
Received: from ozlabs.org ([203.11.71.1]:56985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBWWn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Oct 2019 18:22:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46k9cb4jpQz9s4Y;
        Thu,  3 Oct 2019 08:22:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570054961;
        bh=I5rcRGkTOPJqI2zMlAEW1yzljeTKBOnMAyQxEg711C4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mXxRnK8jvYNmndDY+1NX2PS2JlcvWZrn9HLGwosZMU1NlTGjRVKHURSMJQu/j8VUC
         i88nHSClRUkzOocH1QCoI8ELpbvIPsO6zoUQPrq2m86d1xdGed9JW966yrulOJQpg4
         e4B5xZa2H2+WhfI/7bGc+8JzNfsgVNg5XGrHx9KPDIM2o9q3UzNkuYRsoVnakKMelw
         alk55LRmFUP7dhWerLrZS6ECut3M1MrYJqWhLfXFciNDRZW+ZVAFwXU/ut07cDHktO
         InBY4eQWF0v1p/YPc/ujRp6zJoS3XK1tQ+7CBI5AmY2SHEqav1mHNas3w1hGmyR27/
         1bfDaIdF0dZ/Q==
Date:   Thu, 3 Oct 2019 08:22:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
Message-ID: <20191003082237.42d9b671@canb.auug.org.au>
In-Reply-To: <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp>
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
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g_x1=pl0/Hbh6Ij/tztjE2K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/g_x1=pl0/Hbh6Ij/tztjE2K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tetsuo,

On Fri, 13 Sep 2019 22:41:24 +0900 Tetsuo Handa <penguin-kernel@i-love.saku=
ra.ne.jp> wrote:
>
> Can you add https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.git#master
> into the list for linux-next.git tree?

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/g_x1=pl0/Hbh6Ij/tztjE2K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2VIy0ACgkQAVBC80lX
0GyYzgf+P9g2o+c3+5ZKgPVfVN0GDsOCMVjm4RYCucUsBooU9yjYuPaauPZuLp6k
ALizB6ExuxW4G2gzvv2k55dk6N6rRz75YAnAgC4GRU9HrPHybhHTGHlKzwbcVx7i
O6rNaZRYoq1ZEUinnrjooPYC3QyKis5hoNl9be/aYC+HW13EP8mDWepwAOeMqrzs
a6ecEIoHQvbPxV8vwchiRct1nZwNwZQ3CCPbwfYeWuV8qHwJ3nEloV392U6vrs8t
JwMmZGYCcsXaeNMWv4F2yh44K5PzBjNFcE0zY76Dv+VGR3AzKGRnXYLeAvr7QcnB
S3r0JzUH0zUdQhbBIfNsfQr1sh2XOQ==
=VNT9
-----END PGP SIGNATURE-----

--Sig_/g_x1=pl0/Hbh6Ij/tztjE2K--
