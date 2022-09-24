Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0522AC6FA83
	for <linux-security-module@archiver.kernel.org>; Sat, 24 Sep 2022 09:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIXJuT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 24 Sep 2022 05:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXJuS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Sep 2022 05:50:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F4883E2;
        Sat, 24 Sep 2022 02:50:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l10so2171983plb.10;
        Sat, 24 Sep 2022 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Qu6J/Np7CyGXvxdy1WEsoRBKNP9MUebckId19E1O+qw=;
        b=ouMv/jcmIFd+wXoEmnrG7gUExNUPY1WKPaBIaoVWbgTRnVtx1fZhrSs69G1s1ai93b
         UMop3mpmyE3N4uYbbcWacqnKLBgk5We2aqXVR2ggu9kzQ8XQ91nVvG44KpCZqSpNMI0o
         viM6vF7gai+8A+sOsvV6jYOlNyxNe4KID/849evCshByRxgUApuYZ6ribX1KfekBnXkf
         FpKMer8X0C3kwvYl02vtwZMM1vBVUgHff71c+uELRuIWmm6QZyQtxQXA70Iqu39WbCB0
         RSogVkpeofkExuDeHZ+R944lfm7Ty+BrtxpKxQVOvEzeJ0WCnLy7802czbUjyYrRAL3D
         zC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Qu6J/Np7CyGXvxdy1WEsoRBKNP9MUebckId19E1O+qw=;
        b=exzmnhRn6krpttbjNxnTb3EtXvPfNmT/iDtcxLUU+XGeAXgB/ZAiJep3QSrqhvXurS
         natwnSFNtEhzBAQtvbKTlvt9hnWHXbK1EgOs21cRkQfb3oAX0qJjxfJ8WTmAZyJYpkQh
         eDd6miVo5CEZGZh5ap4Tk72PunmB1vQYUiryqFF3RyNSNK3k4tgqqPOzzI/O6lCleHkH
         KUc8kilFMXn/gxbkLtVyFT6qsK1Oi2wy5WEwkfjZIbrdFFtMRpODk5imymxmr7FO84Pr
         Leq6+RUHIVM9d4tXay65jN3W/PskUvMg04UtBTPXDiYgEoEha5dpCG2l3H92eabzuvV1
         Ze4Q==
X-Gm-Message-State: ACrzQf26p6Zcj9L8qObbZcCC1ItIwxZdITqZ8eAtaNUPeL7i2FUFTKDY
        Muf8cQSzTBD7P6F7NPRu6jQ=
X-Google-Smtp-Source: AMsMyM6qiR4a68RH2tbaa9pMv18t31Jt51AA5s+F4rV3Et/4mHEOZTwsHZPjRxDsSAsoMmIK+c1uLg==
X-Received: by 2002:a17:902:d143:b0:178:456b:8444 with SMTP id t3-20020a170902d14300b00178456b8444mr12630999plt.137.1664013015701;
        Sat, 24 Sep 2022 02:50:15 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id d14-20020a63d64e000000b00434abd19eeasm7096811pgj.78.2022.09.24.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:50:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 80D1A1037EC; Sat, 24 Sep 2022 16:50:11 +0700 (WIB)
Date:   Sat, 24 Sep 2022 16:50:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 3/3] landlock: Fix documentation style
Message-ID: <Yy7S07GpqZEY4J8n@debian.me>
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-4-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Np6QvTUB9ytRaqPk"
Content-Disposition: inline
In-Reply-To: <20220923154207.3311629-4-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


--Np6QvTUB9ytRaqPk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 05:42:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> It seems that all code should use double backquotes, which is also used
> to convert "%" defines.  Let's use an homogeneous style and remove all
> use of simple backquotes (which should only be used for emphasis).
>=20

A little nit: the kernel log content at the opening paragraph should
also be in inline code:

---- >8 ----
diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index cec780c2f4973c..5dbd577b5f58b7 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -19,10 +19,10 @@ unexpected/malicious behaviors in user space applicatio=
ns.  Landlock empowers
 any process, including unprivileged ones, to securely restrict themselves.
=20
 We can quickly make sure that Landlock is enabled in the running system by
-looking for "landlock: Up and running" in kernel logs (as root): ``dmesg |=
 grep
-landlock || journalctl -kg landlock`` .  Developers can also easily check =
for
-Landlock support with a :ref:`related system call <landlock_abi_versions>`=
=2E  If
-Landlock is not currently supported, we need to :ref:`configure the kernel
+looking for ``landlock: Up and running`` in kernel logs (as root): ``dmesg=
 |=20
+grep landlock || journalctl -kg landlock`` .  Developers can also easily c=
heck
+for Landlock support with a :ref:`related system call <landlock_abi_versio=
ns>`.
+If Landlock is not currently supported, we need to :ref:`configure the ker=
nel
 appropriately <kernel_support>`.
=20
 Landlock rules

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Np6QvTUB9ytRaqPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYy7SzAAKCRD2uYlJVVFO
o93WAP9Dmy+H01lBMrvmJQ+3o2w0eDtxv1wDMPbExYjPNG/mWgEAzCvvM8yLF9fb
QsaKWnJb2XhrVoT7tLeqKZ5qTuZD7Qg=
=I8p6
-----END PGP SIGNATURE-----

--Np6QvTUB9ytRaqPk--
