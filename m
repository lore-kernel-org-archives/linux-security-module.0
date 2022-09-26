Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A0DC32771
	for <linux-security-module@archiver.kernel.org>; Mon, 26 Sep 2022 15:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiIZPiI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiIZPgH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 26 Sep 2022 11:36:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057CE62F9
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 07:23:47 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id v128so5318672ioe.12
        for <linux-security-module@vger.kernel.org>; Mon, 26 Sep 2022 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kIxzSh32ZVzphdsD+DOvu1BKLk/rMxIpNYXpOXpLsXQ=;
        b=Xw2JWQvXvBaa39QaWnD8IZ1BkMpoBwA/PcccGsYLe0MXYLPgvGbEpEy+mzGKp7SaCP
         Uy5acvPh24E64fHEEBKHuYZboQ5sesE5s3vnlo5JAMjYPqnUbpNhtGplyhNrzqNqu2d4
         o2rfujeFzkcS5ErpC1YZwGV8Gao4zi+EvHLiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kIxzSh32ZVzphdsD+DOvu1BKLk/rMxIpNYXpOXpLsXQ=;
        b=AdUli1gHSJs7LjTgwwd52rJiajzs/EuuQC5w2In4vw8c2o0E+MASNK8qqfxQcLuz4H
         ftsjaVpZqw81Bz3CECZuDQdrMaMGUs3IV3vwa5OVJKd5O+qw/N9U5RvjGqk9aG0augDt
         /vXchdG4TDR5XyzBJ/NxC30x2ajty6ssCpIclFjAvWDigD/R+e0L7g9kR/ES2DVPvzYG
         n96dolxK7l8TMShmRPozWVRP6jrxBvkhoTBQgRt/1F6v2D4LUs+WEjFKfWTsEE2K3Af5
         zifXDO5tIpNv5k9ZOKCz3FDfgiH718kj4zhWng8Za79iZhsbsvBLH51NQ7bqCDFNBSSC
         Lz+w==
X-Gm-Message-State: ACrzQf3f3oAe54cAwSbRUjKi/GLjCbeCPIjrQMkrjdpK65iuFKulLK+n
        rbeeFbjgM1Kf3YRrI/ji1GxBEFWLMuE3oVi7icUFew==
X-Google-Smtp-Source: AMsMyM5chIxI2+IX0tE33JAnHcsD21HIJvnngF4wU9Ohx/so/Jdi1msShm5+oDQv7ua25UM8WOuT7wbTtdYLziSoGso=
X-Received: by 2002:a02:6d4b:0:b0:35a:40a6:5730 with SMTP id
 e11-20020a026d4b000000b0035a40a65730mr12096840jaf.198.1664202226430; Mon, 26
 Sep 2022 07:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220824015852.32257-1-jeffxu@chromium.org> <ccadad07-53a6-e86e-602b-1d5615a5f9e4@digikod.net>
In-Reply-To: <ccadad07-53a6-e86e-602b-1d5615a5f9e4@digikod.net>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 26 Sep 2022 07:23:35 -0700
Message-ID: <CABi2SkWfTvA+40K+=LkPnGxvL_tKGbuaMog3ZC-ohmkVGgmsug@mail.gmail.com>
Subject: Re: [PATCH v5] selftests/landlock: Skip overlayfs tests not supported
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 25, 2022 at 1:23 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> As discussed for the v4, the next version of this patch needs a
> TEST_F_FORK() fix.
>
I can make TEST_F_FORK() to be skipped when SKIP() is called
in FIXTURE_SETUP(), but this makes FIXTURE_TEARDOWN()
complicated, because SKIP() can be called after any resource
creation failure in the FIXTURE_SETUP().

Another (better) option:  add generic FIXTURE_CONFIG_CHECK()
FIXTURE_CONFIG_CHECK() checks the runtime configuration for
current FIXTURE, if the configuration is not met, the whole test will be
skipped, including FIXTURE_SETUP()/TEARDOWN(), TEST_F_FORK(),
so there is no resource clear up issue after test.

> Please add a link to the previous patch (lore.kernel.org) for each new
> version.
>
>
> On 24/08/2022 03:58, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > overlayfs can be disabled in the kernel configuration (which is the cas=
e
> > for chromeOS), causing related tests to fail.  Skip such tests when an
> > overlayfs mount operation failed because the running kernel doesn't
> > support this file system.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> > ---
> >   tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++-=
-
> >   1 file changed, 51 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 21a2ce8fa739..645304d9fe98 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -11,6 +11,7 @@
> >   #include <fcntl.h>
> >   #include <linux/landlock.h>
> >   #include <sched.h>
> > +#include <stdio.h>
> >   #include <string.h>
> >   #include <sys/capability.h>
> >   #include <sys/mount.h>
> > @@ -169,6 +170,42 @@ static int remove_path(const char *const path)
> >       return err;
> >   }
> >
> > +static bool fgrep(FILE *file, const char *str)
> > +{
> > +     char line[32];
> > +     int str_len =3D strlen(str);
> > +
> > +     while (!feof(file)) {
> > +             if (!fgets(line, sizeof(line), file))
> > +                     break;
> > +             if (strncmp(line, str, str_len))
> > +                     continue;
> > +
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static bool supports_overlayfs(void)
> > +{
> > +     bool ret;
> > +     FILE *file =3D fopen("/proc/filesystems", "r");
> > +
> > +     /*
> > +      * A failed attempt to open /proc/filesystems
> > +      * implies that the file system is supported (default
> > +      * behavior). This can help detect such unattended issue
> > +      * (which should not happen)."
> > +      */
> > +     if (!file)
> > +             return true;
> > +
> > +     ret =3D fgrep(file, "nodev\toverlay\n");
> > +     fclose(file);
> > +     return ret;
> > +}
> > +
> >   static void prepare_layout(struct __test_metadata *const _metadata)
> >   {
> >       disable_caps(_metadata);
> > @@ -3404,6 +3441,8 @@ FIXTURE(layout2_overlay) {};
> >
> >   FIXTURE_SETUP(layout2_overlay)
> >   {
> > +     int ret, err;
> > +
> >       prepare_layout(_metadata);
> >
> >       create_directory(_metadata, LOWER_BASE);
> > @@ -3431,11 +3470,20 @@ FIXTURE_SETUP(layout2_overlay)
> >       create_directory(_metadata, MERGE_DATA);
> >       set_cap(_metadata, CAP_SYS_ADMIN);
> >       set_cap(_metadata, CAP_DAC_OVERRIDE);
> > -     ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
> > -                        "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_=
DATA
> > -                        ",workdir=3D" UPPER_WORK));
> > +
> > +     ret =3D mount("overlay", MERGE_DATA, "overlay", 0,
> > +                "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
> > +                ",workdir=3D" UPPER_WORK);
> > +     err =3D errno;
> >       clear_cap(_metadata, CAP_DAC_OVERRIDE);
> >       clear_cap(_metadata, CAP_SYS_ADMIN);
> > +
> > +     if (ret =3D=3D -1) {
> > +             ASSERT_EQ(ENODEV, err);
> > +             ASSERT_FALSE(supports_overlayfs());
> > +             SKIP(return, "overlayfs is not supported");
> > +     }
> > +     ASSERT_EQ(0, ret);
> >   }
> >
> >   FIXTURE_TEARDOWN(layout2_overlay)
> >
> > base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
