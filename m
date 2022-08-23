Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8608DC38142
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Aug 2022 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiHWXsE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Aug 2022 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiHWXsC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Aug 2022 19:48:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166E98B986
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 16:47:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gt3so17983247ejb.12
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 16:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=CXJMUF4P7N+pDCAmcyuPyGGhaql7Ss7bn4D6Hlx/lEE=;
        b=GzfIIE4SOBWVIqTnDuL2m5t2xgbJF+C3g/pvtlTkktc2WPwuI4o14lHOCNn7Mih52Z
         oDyHSeUmNlLWZhNbUmN6r78sXccxa8u0YiiVVWdETWs/68qOmc1EuzqDCDh/1rJWSh2s
         +tVb7VQI4knyfKuaxPWD3F+hb0zxwNGSro6W9kX2B7nTQjjMcDCIlOJSuGR029mdUigT
         DUhZ0CB6897JoMZ69XbGakD9xMCBXFgLgC9t0AgEkWH7p3IppyuNrgdCF0JNmqdigz1d
         wee1vK5UGJMyaMtGPs6938hUbbJ2Bv1b8Xuu4B7DHeDIPAO4VEKeYw4l5I2kNvgPjdbh
         J0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=CXJMUF4P7N+pDCAmcyuPyGGhaql7Ss7bn4D6Hlx/lEE=;
        b=h8hAX9eeEO7jHMVHXx+V+sVfm3tKfOycF6ZhXbapYYf0mHxVyzHtjYUNwsz7rDfWfQ
         pkfxfbj9+Yn2mvcpSH/t6MwsGsVHoXTcab4H5XyXiB+aj5LEk99OVYqeLw2gKP0kcD6a
         V9bV5ZGoFuw0m5K3Ju6kI8fFklyyLxRwb36YJz33N2XEIJECuLpODztULHLF68KqtdGy
         G8fEUUYdywre1R2FUcl7yfdSfiSzaTZUMT+1Kve8wUb5qWysOzMBRN70s//SSiTRz9CX
         uIEI8UGQvmDN7e5qQQN9bfs5V88Jx95bP6tFp41bTWNF+DdsyJXkpnhNtK4/kyShaqUN
         QM9A==
X-Gm-Message-State: ACgBeo3JP3V7TZpxhZv4EC+mlGvNmGi5cOa1+D4faTjxy1+2j9cKlkV+
        wrysxk3zuA/ufqqLvu1ExHacfzOphasJLtlYCHurxQ==
X-Google-Smtp-Source: AA6agR473vnLU4iuVHg6wtccQA2Q+yMr67Kj/dfYa6ca0rWgCiz2FoBqmbZt33A7e6h4O9b77b7kynC4/X1pK/TtSr4=
X-Received: by 2002:a17:907:7629:b0:73d:8d3e:4389 with SMTP id
 jy9-20020a170907762900b0073d8d3e4389mr1165194ejc.565.1661298474840; Tue, 23
 Aug 2022 16:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220823010216.2653012-1-jeffxu@google.com> <32d37192-8290-4e8d-32c6-f6992ec2f3ec@digikod.net>
In-Reply-To: <32d37192-8290-4e8d-32c6-f6992ec2f3ec@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 23 Aug 2022 16:47:18 -0700
Message-ID: <CALmYWFsf-Nh6azOV5rVrv+U2sKFME9ubbF6iuGO7mFes=asEQQ@mail.gmail.com>
Subject: Re: [PATCH v4] selftests/landlock: skip overlayfs test when kernel
 not support it
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     jorgelo@chromium.org, linux-security-module@vger.kernel.org,
        groeck@chromium.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> I guess this is because of the TEST_F_FORK() helper which doesn't handle
> well the skipped with error tests, hence the parent test process trying
> to execute the teardown and unmounting something which is not mounted it
> its namespace, and the duplicated messages.

> This may be related to commit 63e6b2a42342 ("selftests/harness: Run
> TEARDOWN for ASSERT failures").

> Can you fix TEST_F_FORK() for skipped tests please?

> We should merge TEST_F_FORK() within kselftest_harness.h with a follow
> up patch though.

OK. That can be after I worked on pt_test.

Would you like me to move supports_overlayfs() to the beginning of
layout2_overlay in this Patch ?
then there is nothing to cleanup.

> On 23/08/2022 03:02, jeffxu@google.com wrote:
> > From: Jeff Xu <jeffxu@google.com>
>
> This is not consistent with your Signed-off-by email.

Sure, will try to switch to send patch via jeffxu@chromium.org


On Tue, Aug 23, 2022 at 8:28 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> This looks good overall. You'll find some nitpicking review below.
>
> I found that there is an issue with the skipped test, and especially the
> teardown parts:
>
> > #  RUN           layout2_overlay.no_restriction ...
> > #      SKIP      overlayfs is not supported
> > # fs_test.c:3537:no_restriction:Expected 0 (0) =3D=3D test_open(merge_f=
l1, O_RDONLY) (2)
> > # fs_test.c:3512:no_restriction:Expected 0 (0) =3D=3D umount(MERGE_DATA=
) (-1)
>
> These messages seem OK=E2=80=A6
>
> > # fs_test.c:3496:no_restriction:Expected 0 (0) =3D=3D umount(LOWER_BASE=
) (-1)
> > # fs_test.c:3507:no_restriction:Expected 0 (0) =3D=3D umount(UPPER_BASE=
) (-1)
>
> =E2=80=A6but these two should not happen because the tmpfs should still b=
e mounted.
>
>
> > #            OK  layout2_overlay.no_restriction
> > ok 58 # SKIP overlayfs is not supported
> > #  RUN           layout2_overlay.same_content_different_file ...
> > # fs_test.c:3512:no_restriction:Expected 0 (0) =3D=3D umount(MERGE_DATA=
) (-1)
>
> These is some inconsistencies here too.
>
> > # fs_test.c:230:no_restriction:Expected 0 (0) =3D=3D umount(TMP_DIR) (-=
1)
> > #      SKIP      overlayfs is not supported
> > # fs_test.c:3723:same_content_different_file:Expected 0 (0) =3D=3D test=
_open(path_entry, O_RDWR) (2)
> > # fs_test.c:3496:same_content_different_file:Expected 0 (0) =3D=3D umou=
nt(LOWER_BASE) (-1)
> > # fs_test.c:3498:same_content_different_file:Expected 0 (0) =3D=3D remo=
ve_path(LOWER_BASE) (16)
> > # fs_test.c:3507:same_content_different_file:Expected 0 (0) =3D=3D umou=
nt(UPPER_BASE) (-1)
> > # fs_test.c:3509:same_content_different_file:Expected 0 (0) =3D=3D remo=
ve_path(UPPER_BASE) (16)
> > # fs_test.c:3512:same_content_different_file:Expected 0 (0) =3D=3D umou=
nt(MERGE_DATA) (-1)
> > # fs_test.c:230:same_content_different_file:Expected 0 (0) =3D=3D umoun=
t(TMP_DIR) (-1)
> > # fs_test.c:232:same_content_different_file:Expected 0 (0) =3D=3D remov=
e_path(TMP_DIR) (16)
> > # fs_test.c:3512:same_content_different_file:Expected 0 (0) =3D=3D umou=
nt(MERGE_DATA) (-1)
>
> I guess this is because of the TEST_F_FORK() helper which doesn't handle
> well the skipped with error tests, hence the parent test process trying
> to execute the teardown and unmounting something which is not mounted it
> its namespace, and the duplicated messages.
>
> This may be related to commit 63e6b2a42342 ("selftests/harness: Run
> TEARDOWN for ASSERT failures").
>
> Can you fix TEST_F_FORK() for skipped tests please?
>
> We should merge TEST_F_FORK() within kselftest_harness.h with a follow
> up patch though.
>
>
> On 23/08/2022 03:02, jeffxu@google.com wrote:
> > From: Jeff Xu <jeffxu@google.com>
>
> This is not consistent with your Signed-off-by email.
>
> >
> > Overlayfs can be disabled in kernel config, causing related tests to fa=
il.
> > Add check for overlayfs=E2=80=99s supportability at runtime, so we can =
call SKIP()
> > when needed.
>
> selftests/landlock: Skip overlayfs tests when not supported
>
> overlayfs can be disabled in the kernel configuration (which is the case
> for chromeOS), causing related tests to fail.  Skip such tests when an
> overlayfs mount operation failed because the running kernel doesn't
> support this file system.
>
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> > ---
> >   tools/testing/selftests/landlock/fs_test.c | 53 ++++++++++++++++++++-=
-
> >   1 file changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 21a2ce8fa739..aaece185579d 100644
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
> > @@ -62,6 +63,7 @@ static const char dir_s3d1[] =3D TMP_DIR "/s3d1";
> >   static const char dir_s3d2[] =3D TMP_DIR "/s3d1/s3d2";
> >   static const char dir_s3d3[] =3D TMP_DIR "/s3d1/s3d2/s3d3";
> >
> > +static const char proc_filesystems[] =3D "/proc/filesystems";
>
> No need for this global variable, just use the string in the fopen() call=
.
>
>
> >   /*
> >    * layout1 hierarchy:
> >    *
> > @@ -169,6 +171,42 @@ static int remove_path(const char *const path)
> >       return err;
> >   }
> >
> > +static bool fgrep(FILE *inf, const char *str)
>
> const char *const str
>
> s/inf/file/
>
>
> > +{
> > +     char line[32];
> > +     int slen =3D strlen(str);
>
> s/slen/str_len/
>
> > +
> > +     while (!feof(inf)) {
> > +             if (!fgets(line, sizeof(line), inf))
> > +                     break;
> > +             if (strncmp(line, str, slen))
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
> > +     bool ret =3D false;
>
> No need to set it to "false" (which should be "true" BTW).
>
>
> > +     FILE *inf =3D fopen(proc_filesystems, "r");
>
> s/inf/filename/
>
> > +
> > +     /*
> > +      * If fopen fails, return supported.
> > +      * This helps to detect missing file (shall not
> > +      * happen).
>
> "A failed attempt to open /proc/filesystems implies that the file
> system is supported (default behavior). This can help detect such
> unattended issue (which should not happen)."
>
>
> > +      */
> > +     if (!inf)
> > +             return true;
> > +
> > +     ret =3D fgrep(inf, "nodev\toverlay\n");
> > +     fclose(inf);
> > +
>
> You can remove this newline.
>
> > +     return ret;
> > +}
> > +
> >   static void prepare_layout(struct __test_metadata *const _metadata)
> >   {
> >       disable_caps(_metadata);
> > @@ -3404,6 +3442,8 @@ FIXTURE(layout2_overlay) {};
> >
> >   FIXTURE_SETUP(layout2_overlay)
> >   {
> > +     int rc;
>
> s/rc/ret/
>
> int ret, err;
>
> > +
> >       prepare_layout(_metadata);
> >
> >       create_directory(_metadata, LOWER_BASE);
> > @@ -3431,11 +3471,18 @@ FIXTURE_SETUP(layout2_overlay)
> >       create_directory(_metadata, MERGE_DATA);
> >       set_cap(_metadata, CAP_SYS_ADMIN);
> >       set_cap(_metadata, CAP_DAC_OVERRIDE);
> > -     ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
> > -                        "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_=
DATA
> > -                        ",workdir=3D" UPPER_WORK));
> > +
> > +     rc =3D mount("overlay", MERGE_DATA, "overlay", 0,
> > +                "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
> > +                ",workdir=3D" UPPER_WORK);
>
> err =3D errno;
>
> >       clear_cap(_metadata, CAP_DAC_OVERRIDE);
> >       clear_cap(_metadata, CAP_SYS_ADMIN);
> > +
> > +     if (rc < 0) {
>
> if (ret =3D=3D -1) {
>
> > +             ASSERT_EQ(ENODEV, errno);
>
> ASSERT_EQ(ENODEV, err);
>
> > +             ASSERT_FALSE(supports_overlayfs());
> > +             SKIP(return, "overlayfs is not supported");
> > +     }
>
> ASSERT_EQ(0, ret);
>
> >   }
> >
> >   FIXTURE_TEARDOWN(layout2_overlay)
> >
> > base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
