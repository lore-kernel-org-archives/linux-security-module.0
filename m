Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84534C64ED8
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Feb 2023 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjB0NaV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Feb 2023 08:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjB0NaU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Feb 2023 08:30:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72B1C333;
        Mon, 27 Feb 2023 05:30:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso2513081wmq.1;
        Mon, 27 Feb 2023 05:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFcLuNGDXQuyOnVO2R+JXVCbdwMZAzVtZ7IE1BQUtfk=;
        b=qEeupzemYwm9xf62vEojB/np/HC0dKy3smNvse38Ia5ybsLHGh1cBzvyYANE2iCiRt
         VR0vofZ039Bcuko7Bp4r9g0zWD6vzsDj+1JvJPEV5gCtzIh6I+0Wm2yH3IF2yssA2mOA
         lBib3Uo+hvp4vHcXEwsiBLoEDPze048JD8oN1BRHEgk5OqOrnozvSq4PxrEaBcu0A39W
         e1nKh2OipWVVSXp3GNgqKQb937JP1rQcR55MIPe+vW2VuAZfe+suHUXnVIIo0gpe/VTL
         QaSms161+HRwyXGXraHACY6cCiGjPXM8BDnDynedPiOEQ+re18HIis72gxpeDPGUzPHW
         U7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tFcLuNGDXQuyOnVO2R+JXVCbdwMZAzVtZ7IE1BQUtfk=;
        b=0XQV+ANSbPI6RloDhetQ6iXsGbcAnfZPkLVCterXtiasZaFvJsK51NYYK7TO4WzWas
         79PBUbMlWzaJqrAtK9ljL6bDBEc8yAyzVrqkVe6wfBOBhZJ1KJrJlIMece0dBLSY5eR8
         mwIK+iUlVNLSGqYa1Bv/ae0Ib2R3R9stKWoEl9hlvd2UJkfn1+fzJkPoTHOsEyNMFwSh
         WQGKVoV7vOAjFXtDSN3NprckEL1w7MaZf8xgrKVXGJgY5l5MSri431ea3OjzKZJ/ooNv
         Cj0KzZVqMKMWTQYPTxP1gu7t6szK/HxzV5+E+m6um+d235cdqH443H1qxDvBdmU+GA/J
         W7Jg==
X-Gm-Message-State: AO0yUKViohBDJHqjrwyEmiThwB3pWqZzA9K/c5HHEtVM4XxgAcNdwhYr
        KKR0zgveCCBbv6iJfl4TkLo=
X-Google-Smtp-Source: AK7set/Tmtmw3yADZDHdMGyvQh+h8pbNkD9tChe0tw6HIuyFAbqlrKhKXBc4CccSv2YsbbYC2+deww==
X-Received: by 2002:a05:600c:994:b0:3eb:39e0:3530 with SMTP id w20-20020a05600c099400b003eb39e03530mr3797987wmp.41.1677504617797;
        Mon, 27 Feb 2023 05:30:17 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003e209b45f6bsm13591471wmq.29.2023.02.27.05.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:30:17 -0800 (PST)
Message-ID: <d9656d65-5ab2-bdb7-ffda-b37b8cad4fab@gmail.com>
Date:   Mon, 27 Feb 2023 14:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230221165205.4231-1-gnoack3000@gmail.com>
 <f46d3b7f-71bf-7a5e-90b5-ab433f7253cd@gmail.com>
 <796789c7-24bd-f1f1-c402-c88b46253008@digikod.net>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <796789c7-24bd-f1f1-c402-c88b46253008@digikod.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f9C9O1lM0gpSg8AAk04fE5W7"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f9C9O1lM0gpSg8AAk04fE5W7
Content-Type: multipart/mixed; boundary="------------72jaJVdXLbETANq2pw0V5vsS";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
 =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Message-ID: <d9656d65-5ab2-bdb7-ffda-b37b8cad4fab@gmail.com>
Subject: Re: [PATCH v4] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
References: <20230221165205.4231-1-gnoack3000@gmail.com>
 <f46d3b7f-71bf-7a5e-90b5-ab433f7253cd@gmail.com>
 <796789c7-24bd-f1f1-c402-c88b46253008@digikod.net>
In-Reply-To: <796789c7-24bd-f1f1-c402-c88b46253008@digikod.net>

--------------72jaJVdXLbETANq2pw0V5vsS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl,

On 2/27/23 12:02, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> On 25/02/2023 00:00, Alex Colomar wrote:
>> Hi G=C3=BCnther,
>>
>> On 2/21/23 17:52, G=C3=BCnther Noack wrote:
>> [...]
>>
>> Sorry for taking so much time in looking into this!
>>
>>> + *
>>> + *   * The reparented file may not gain more access rights in the de=
stination
>>> + *     directory than it previously had in the source directory.  If=
 this is
>>> + *     attempted, the operation results in an ``EXDEV`` error.
>>> + *
>>> + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` r=
ight for the
>>> + *     respective file type must be granted for the destination dire=
ctory.
>>> + *     Otherwise, the operation results in an ``EACCES`` error.
>>> + *
>>> + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for =
the
>>> + *     respective file type must be granted for the source directory=
=2E  Otherwise,
>>> + *     the operation results in an ``EACCES`` error.
>>> + *
>>> + *   If multiple requirements are not met, the ``EACCES`` error code=
 takes
>>> + *   precedence over ``EXDEV``.
>>
>> Is this something worth guaranteeing, or just an implementation detail=

>> that may easily change?
>=20
> There is a deliberate effort to keep this error priority to be able to =

> know if a rename or link action can be replaced with a file copy, which=
=20
> is useful e.g., for `mv`.

Thanks.  Then it LGTM.

Cheers!

Alex


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------72jaJVdXLbETANq2pw0V5vsS--

--------------f9C9O1lM0gpSg8AAk04fE5W7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmP8sGgACgkQnowa+77/
2zKPwBAAiZ7IQVrmxNxpTVhj9o97f15oT1aS1jdAoVYJUhrTtgJslux7m2f6km+l
p8VFnGF3yy1cGBEzAXDanWOwCnvhRseON/FzvcShUrUQXrgZE7+qcpmF2dH8h72/
7/AotE1s9WtmIg5MFSMVGLJ2O6qYuHXi9Q1UkDv5ym5YSm483XY3jR8H+XqLr5QW
Lcrp+Ii2yi0/hI/G1e/WakdwHhGcdykBbZEy2OLWU+Zd7gT9QJ0SemunhUfJ9k6W
a4YIcRGhx8FRMqJ+DEwAuVmZZlIOH+Wndbq1xKhUT6P9GyabzaQ/eKPmmYEP0tP+
dVuchGm/OgZi1UpeLbz9oXfDPr5GNLguF6ifO240a/VpV2UmqyEbkXQ9fs3XxuJK
SrxTOdWZ8LQFUZ3wCHrjwG/K75Fjdbxni4WW0KD4KF947VVkT0543lOGu4cgi7Mz
GhCi833154R+CO+bnt00FFjbw0LWZvwJL5goTnTUG/y2vy+cKEp+frSP/i87ZMDU
3xgW3+fi7EIJgWlj+VNnXTRY8KOkL/nakhOXej36EVc/fnXDOgH+EVHZnZyVpMRH
rkAY6me4sksJYqJpux09mHUS24NU+zVViXCyt8gzWVwQ6xLvgguVSWCmbJ+gya4o
J+Syg2uQb3O/MJqpR0Gu7OinzrGlYQ/A5VXuqaAY9CweiEEEBXE=
=L3cG
-----END PGP SIGNATURE-----

--------------f9C9O1lM0gpSg8AAk04fE5W7--
