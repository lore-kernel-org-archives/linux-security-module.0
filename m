Return-Path: <SRS0=gDDV=6W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BBFC47247
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 01:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB725208E4
	for <linux-security-module@archiver.kernel.org>; Fri,  8 May 2020 01:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NucDWMIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEHBVa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 21:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726495AbgEHBVa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 21:21:30 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C0C05BD43;
        Thu,  7 May 2020 18:21:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JCGC0TrHz9sSk;
        Fri,  8 May 2020 11:21:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588900885;
        bh=fn1FAITXWrHoD5p0YkLk4NDvgXCTxZCopaiWSoAE24M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NucDWMIHzyEWKhv2Jpz5V57pCJSGVwKFECNyZ49I5pY1ukFXmrdSaz/00q2KpJDbG
         EWLv3FYAKffEQaBXd+sOR9qlvTBznRmAqjavXEhcZjrKMl21SATXigYcr4tbNlyzQh
         LO51vcA7p09iXpAntaH3rroJpzap350FUwdpbwPhGyiGuMajhFMQvdhcwTjZk4XvX6
         G0uZxVdYMDn1xLuA7ffyANP3YNjHI4Dm3OcCE7Iyy/sdLK4IVaRP0dKDCAajrN0BVY
         oKN7dnuctm+yzNgINA/ovWbnsNKaMaQHaqsWKxt52evUDbcrR1oWWSEzL2otnQG0AY
         Py7s4KqVpoUUA==
Date:   Fri, 8 May 2020 11:21:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     madhuparnabhowmik10@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paulmck@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] integrity: evm: Fix RCU list related warnings.
Message-ID: <20200508112121.6f665d74@canb.auug.org.au>
In-Reply-To: <1588897421.5685.152.camel@linux.ibm.com>
References: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
        <20200508101402.267ca0f2@canb.auug.org.au>
        <1588897421.5685.152.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.D+o4SMW3l1UQxFqbqJwcNG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--Sig_/.D+o4SMW3l1UQxFqbqJwcNG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Thu, 07 May 2020 20:23:41 -0400 Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Sorry for the delay in pushing this and other fixes to the next-
> integrity branch. =C2=A0It's in my next-integrity-testing branch.

OK, thanks.

> This isn't a bug per-se, just annotating the reason for the lack of
> locking.

Yes, but these warnings stop the syzbot's testing in its tracks :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/.D+o4SMW3l1UQxFqbqJwcNG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl60tBEACgkQAVBC80lX
0Gy1kQf7BffVVaIpxbElKwALAau8rs7TlHqdions0ViHqWb9XbhY3sNQ1phj1nt5
QORcaLptQ5HmVAVz227Gdg15fnkJPeHg0/w5rUHyzV7f8PePzYE9wZGVvOik+9Sg
1d1QxHj8AHnRM+Ag+zCc7erThznlgkSKnMOWHonbV73Li9C9aGYE9jTE3L7rFcuh
b1AN0cliyojwb4E9bIbadn3fSUXivHKR0kHFcx5OFLZmsimBVjMYI19tZQm1RslG
HYHdEDBG2uGLgVRF6O53nj4FMTVNHJuMNa/gSJU/FgZIF5vAGnSuEE6od7LhT++3
+/bdVfFcjwWMKQ447SfxBZXwlos1Mg==
=FC49
-----END PGP SIGNATURE-----

--Sig_/.D+o4SMW3l1UQxFqbqJwcNG--
