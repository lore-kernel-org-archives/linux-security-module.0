Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC6EC6FA83
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 01:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiIZBJk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 25 Sep 2022 21:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIZBJ2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Sep 2022 21:09:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA926135;
        Sun, 25 Sep 2022 18:09:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w13so4873170plp.1;
        Sun, 25 Sep 2022 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=gpyFS2GovJ62Jxn/MX5ctG2nQx4pe32nEqoDh4PLRQA=;
        b=NM3dSZCOaNST66bk2A50aVjJlRigRgq7c+DNyLlmUXJ8D+HGEFRuT6vCn+A+0KqqL+
         uVzXMnog+1FLXIzWU3FFkYH+xO0Vw7AVRlnqQu2jz2K47lMQcu3n67Qad1Xfy+otDcjp
         8sHAWqL4y545M8O0qHBITXz5wLk3XKGGIlnveICNtncDojgdQqXwVwfaF4mXf3sxmPdT
         t1x3fy6PNktQgjwy2WLzg5ddMjk9OnDcZvi68NnI9i4LsDc3F58zNzfj4ZKU4nTC8YBC
         8sfdWOOA5aONY2tWY3cP3/O+bAQIPnJmodrG5UQKdsTwVnlhBJ09O19jvgBs1mIcWoIO
         PZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gpyFS2GovJ62Jxn/MX5ctG2nQx4pe32nEqoDh4PLRQA=;
        b=aTyOPM3tUt4GQIWX3s1I6P6ZE3a0XvqNfRIMnjIru4RMm7+aiT4DQ8tToVFKXzz/Dt
         RZj6vBkwTGK4NTTWncABmCrniSPCkWXgcdx3WP8qdTYrq7nXa0q05ysoLwwUhv5nRMY+
         Z3MHUJ+X4HPfdanld3Eydw24IZ0Puyy5DiFM/AzxcCEd9IWojhjBLYioWvkMiXJHW9gy
         1PdQ1dnBYIDj+nUxJRe1H6g/KrVeKWlt2ONrzIeQhEBA8rdv2KWa7joA2KfFa0XCGAH0
         Tf7sYlGnCu+Rgorq2bL+PBSn8QrwF9WGvBrocdFIZ+0dcVRMa+ZItYLoxH9koNPjbvZJ
         zlSg==
X-Gm-Message-State: ACrzQf1VhY+x9NnlOyZ2MhMKQhmgvGX8p6qDRWxrqRBxSsYhJIbJr9W7
        bX7bGTx4bp8HTCaH0wOXrXrwyLDKRGg=
X-Google-Smtp-Source: AMsMyM7Bnt8Poi2aAoDNTzsy3TyxBtI3cwrj190YUuX0PIHcA54buL3EEkOYDEfYSDkBYtHfs1FoZQ==
X-Received: by 2002:a17:902:e74b:b0:178:2976:41b0 with SMTP id p11-20020a170902e74b00b00178297641b0mr19598217plf.105.1664154567211;
        Sun, 25 Sep 2022 18:09:27 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 14-20020a630b0e000000b00438ce2800e5sm9581348pgl.7.2022.09.25.18.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 18:09:26 -0700 (PDT)
Message-ID: <9055c684-bfd0-10b2-7209-7b9898f05a88@gmail.com>
Date:   Mon, 26 Sep 2022 10:09:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     alx.manpages@gmail.com, corbet@lwn.net, gnoack3000@gmail.com,
        jmorris@namei.org, konstantin.meskhidze@huawei.com,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        mic@digikod.net, paul@paul-moore.com, serge@hallyn.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <Yy8GNAAmq6t6Kt66@debian.me>
Subject: Re: [PATCH v1 2/3] landlock: Slightly improve documentation and fix
 spelling
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <Yy8GNAAmq6t6Kt66@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 24 Sep 2022 20:29:24 +0700, Bagas Sanjaya wrote:
> On Fri, Sep 23, 2022 at 05:42:06PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
>> Now that we have more than one ABI version, make limitation explanatio=
n
>> more consistent by replacing "ABI 1" with "ABI < 2".  This also
>> indicates which ABIs support such past limitation.
>>=20
>=20
> Hi,
>=20
> I think grammar and reference link on userspace documentation can be
> improved, like:
>=20
> ---- >8 ----
>=20
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documenta=
tion/admin-guide/cgroup-v1/memory.rst
> index 2cc502a75ef640..c49454900edb12 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -1,3 +1,5 @@
> +.. _cgroup-v1-memory:
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  Memory Resource Controller
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/fi=
lesystems/overlayfs.rst
> index 4c76fda076454c..dbeddb6851e6c9 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -3,6 +3,8 @@
>  Written by: Neil Brown
>  Please see MAINTAINERS file for where to send questions.
> =20
> +.. _overlayfs:
> +
>  Overlay Filesystem
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentatio=
n/filesystems/sharedsubtree.rst
> index d83395354250d9..cbc20658bd0c07 100644
> --- a/Documentation/filesystems/sharedsubtree.rst
> +++ b/Documentation/filesystems/sharedsubtree.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
> =20
> +.. _shared-subtrees:
> +
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Shared Subtrees
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[...]

> @@ -203,42 +204,40 @@ etc.).
>  Bind mounts and OverlayFS
>  -------------------------
> =20
> -Landlock enables to restrict access to file hierarchies, which means t=
hat these
> -access rights can be propagated with bind mounts (cf.
> -Documentation/filesystems/sharedsubtree.rst) but not with
> -Documentation/filesystems/overlayfs.rst.
> +Landlock can restrict access to file hierarchies, which means that the=
se
> +access rights can be propagated with bind mounts (see
> +:ref:`shared-subtrees`) but not with :ref:`OverlayFS <overlayfs>`.

Wait!
Bagas, your suggestion is _against_ the preference of kernel documentatio=
n.
See https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#cross-re=
ferencing

Or do you have some good reason to add labels at the beginning of
rst docs?

        Thanks, Akira

[...]
