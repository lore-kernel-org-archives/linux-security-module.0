Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB48DC19F2D
	for <linux-security-module@archiver.kernel.org>; Sat, 13 Aug 2022 10:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiHMKB1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiHMKB0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 13 Aug 2022 06:01:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450C7675
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 03:01:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ha11so3019625pjb.2
        for <linux-security-module@vger.kernel.org>; Sat, 13 Aug 2022 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=rXjZq7TyJRpGA36wuNWeax0N/DTCuezFM2I6n+kaOFc=;
        b=uludQ0lLYxsMsamFFMGEAF4NjuSBTl68G7b7d5T0Xyrr1vKPHVnSigosbzHsNWpJ6c
         lnun7Gx5kbIHOBuPvWXq/znBa6WjZh6uG+avVo3AtMmdq8io6sddwwKHRAkQ+S7vq2eN
         A/Pou91K9q3DcouiBrvJRDkTzd6GtgxnNDt8HTi3XXlHiDBoI8FYWGvak7noJLaoqHQq
         fjvj83QfEkS3s38zh/DRL/tHYz901CKghNoqoIKn/mRAvXgvIcKvb+ZW8emMfm5MZGyo
         /s3fYXOxL8Y5m0xY4qz7twAk94MjBZulAuxffst0EQEGfOfw0c7eEVh5Dc+njTqxPd9U
         MnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rXjZq7TyJRpGA36wuNWeax0N/DTCuezFM2I6n+kaOFc=;
        b=pp7no9V8a9UMMD8q2Vng51OwKyaiIkqENsao/Vs+lC8HbEN0po5GHxNp22GjS7uZkg
         88FkJGR5OjTvsBZOLZ5O/3NJ1s1OoXKE6CuJBnYKy4cSGCbGzoowPmrM0Zi8MwJrBN5Q
         xTDPmPBTKDTZooz++l6az/38q9zjjLX7/ZYWbWhd3SbV+nXH1f1YVbxkJwOv4IOsxthP
         oJBeAtLOjaSR02qpomDl9bBesm86yiqZ2VTb2+KCCmQ0O99lUEAGRzQfOfVWfRV7Jb3H
         R/Rh27bES4aKoPSGwXWw9aT/5d/93s45QItdZAkGtzqEFIO4m09v0EY+T+IPDB9/FOwR
         S29g==
X-Gm-Message-State: ACgBeo2zxAFV3nrsKs8tdQxtJixJnjuSWh3nemBgrHirIklAKB1sPAYT
        ShwrXHihcsOGYZJ6C+lPWOBD8zKHzfBcZ3y39IzwYw==
X-Google-Smtp-Source: AA6agR6APTL3EkQhR9XXVJ4cdNRgW1zCMot4F0nMgyVJDj6msnWklnLNGrD42dX8QV/lT+YbFRlDfGnOgAuMQ+FfteY=
X-Received: by 2002:a17:902:8683:b0:171:3114:7678 with SMTP id
 g3-20020a170902868300b0017131147678mr7861379plo.172.1660384883745; Sat, 13
 Aug 2022 03:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
In-Reply-To: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Sat, 13 Aug 2022 12:01:12 +0200
Message-ID: <CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: fix broken include of linux/landlock.h
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Tim.Bird@sony.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 3 Aug 2022 at 22:14, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Revert part of the earlier changes to fix the kselftest build when
> using a sub-directory from the top of the tree as this broke the
> landlock test build as a side-effect when building with "make -C
> tools/testing/selftests/landlock".
>
> Reported-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers depende=
ncy")
> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Building with this patch doesn't work, it gives this output:
make[3]: Entering directory
'/home/anders/src/kernel/next/tools/testing/selftests/landlock'
make[3]: Leaving directory
'/home/anders/src/kernel/next/tools/testing/selftests/landlock'
make[3]: *** No rule to make target
'/home/anders/.cache/tuxmake/builds/78/build/kselftest/landlock/base_test',
needed by 'all'.  Stop.

I'm building like this:
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-12
--kconfig defconfig kselftest

which translates into this make command:
make --silent --keep-going --jobs=3D32
O=3D/home/anders/.cache/tuxmake/builds/78/build
INSTALL_PATH=3D/home/anders/.cache/tuxmake/builds/78/build/kselftest_instal=
l
ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- kselftest-install

building without this patch works, see below:

make[3]: Entering directory
'/home/anders/src/kernel/next/tools/testing/selftests/landlock'
x86_64-linux-gnu-gcc -Wall -O2 -isystem
/home/anders/.cache/tuxmake/builds/77/build/usr/include    base_test.c
 -o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/base_tes=
t
-lcap
x86_64-linux-gnu-gcc -Wall -O2 -isystem
/home/anders/.cache/tuxmake/builds/77/build/usr/include    fs_test.c
-o /home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/fs_test
-lcap
x86_64-linux-gnu-gcc -Wall -O2 -isystem
/home/anders/.cache/tuxmake/builds/77/build/usr/include
ptrace_test.c  -o
/home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/ptrace_test
-lcap
x86_64-linux-gnu-gcc -Wall -O2 -isystem
/home/anders/.cache/tuxmake/builds/77/build/usr/include    true.c  -o
/home/anders/.cache/tuxmake/builds/77/build/kselftest/landlock/true
-static
make[3]: Leaving directory
'/home/anders/src/kernel/next/tools/testing/selftests/landlock'

Cheers,
Anders

> ---
>  tools/testing/selftests/landlock/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/se=
lftests/landlock/Makefile
> index a6959df28eb0..02868ac3bc71 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -9,10 +9,13 @@ TEST_GEN_PROGS :=3D $(src_test:.c=3D)
>  TEST_GEN_PROGS_EXTENDED :=3D true
>
>  OVERRIDE_TARGETS :=3D 1
> +top_srcdir :=3D ../../../..
>  include ../lib.mk
>
> +khdr_dir =3D $(top_srcdir)/usr/include
> +
>  $(OUTPUT)/true: true.c
>         $(LINK.c) $< $(LDLIBS) -o $@ -static
>
> -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
> -       $(LINK.c) $< $(LDLIBS) -o $@ -lcap
> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_har=
ness.h common.h
> +       $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
> --
> 2.30.2
>
