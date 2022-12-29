Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B243EC3DA7A
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiL2Uc7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiL2Uc6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 15:32:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE612140F1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:32:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so12052792pjk.3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEwPVLeOtoB1iNnsWWkewrvZ78opy54HwtaE+dnLOwg=;
        b=Sk73RSfcUKH3cxUht3Xyz5vDG7Myi2DfkyTLWUyckufStIJlYykfL+1hE42TV2ei/f
         5lsm9I8spfLVd4D5EI/3xYADYSrXSwbW/RclU+6TaOtisT7v5NWeVmjas/U6BH6h5y4R
         OpWWhPR/UWkFFjUKDQYOnrlE+qk2jmWb/QXB9DAPwaYaCyU0XaeRjTdNQMnwalG3DAR8
         S80npGXB8ZOK7xCSMmJu1AVL2Y3c8dRqCdeCuKDdzlkYXrd7jnHOQxW8gFVWX2ZF4mO9
         NB1LX7IqxbB2jYpeFGeBnhkhmUWe07SfSYQfM1Nj/vsP23ymIoMIyDzA5R7nJV2fVuo/
         9kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEwPVLeOtoB1iNnsWWkewrvZ78opy54HwtaE+dnLOwg=;
        b=Y/hDGFovargonpw11AZ+SbUg/AcrXbAN0mcTHo0QW/2bZ7FutYlec2KOhUl51CVz5q
         MC80/LRr1kNh0GSGYSgiNRE4iXuIxE0sRM8cKUx8EeHiC5t0Dpl0oLtWrRWA4lPQJXvf
         ZNvrTYyV1XwISauvIoYJ0hGW6FqTW5/PsX8uHpxblLuH8zCdkt0ecCvT5QidYqXU/eLI
         A1T6xps4h0fWeq/zl3qnxA/4tfb73I5jSql0vC3iOb2qbQAMx122jbFqST2v0k6lqrrv
         OVajmsexWX5xuzwvFjb86qWu2VTcd4MneCmxC1bCE8aI/WeF/coZk/F9ZQTGjeL0ZL4B
         IxVA==
X-Gm-Message-State: AFqh2kpiW0y3lMh+HMUx1il2ZTm+c1EKJquPJIYBRFtk3Qxl5iw54BJ7
        wqaRa/Y0qcAtoov0oShARCAMkq5FFx+k7HklTsItiQ==
X-Google-Smtp-Source: AMrXdXvbXpCDsQx3PiueAOrZbh7j0S4O3j2hybIx3kjzZlMNqhAkz3NoRQQe96CTg8D2U2q+Wi0q4vDPl7139fTF6vw=
X-Received: by 2002:a17:902:b690:b0:174:7d26:812f with SMTP id
 c16-20020a170902b69000b001747d26812fmr1866888pls.63.1672345977031; Thu, 29
 Dec 2022 12:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20221229201215.3006512-1-jeffxu@google.com> <20221229201215.3006512-2-jeffxu@google.com>
 <CABXOdTcULHsvS8GQNFooy7JqCZfoP25E+Q9iszjh3Z5rXseBZA@mail.gmail.com>
In-Reply-To: <CABXOdTcULHsvS8GQNFooy7JqCZfoP25E+Q9iszjh3Z5rXseBZA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 29 Dec 2022 12:32:17 -0800
Message-ID: <CALmYWFv2SGQeBSiPW6C7ciTYrpdvj0kZOt+=rZxH5aaSVLXGeQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] selftests/landlock: skip overlayfs test when
 kernel not support it
To:     Guenter Roeck <groeck@google.com>
Cc:     jeffxu@chromium.org, mic@digikod.net, jorgelo@chromium.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org,
        groeck@chromium.org, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 29, 2022 at 12:18 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Dec 29, 2022 at 12:12 PM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Overlayfs can be disabled in kernel config, causing related tests to
> > fail. Add check for overlayfs=E2=80=99s supportability at runtime,
> > so we can call SKIP() when needed.
> >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 21a2ce8fa739..2d84c055f86f 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -11,6 +11,7 @@
> >  #include <fcntl.h>
> >  #include <linux/landlock.h>
> >  #include <sched.h>
> > +#include <stdio.h>
> >  #include <string.h>
> >  #include <sys/capability.h>
> >  #include <sys/mount.h>
> > @@ -62,6 +63,7 @@ static const char dir_s3d1[] =3D TMP_DIR "/s3d1";
> >  static const char dir_s3d2[] =3D TMP_DIR "/s3d1/s3d2";
> >  static const char dir_s3d3[] =3D TMP_DIR "/s3d1/s3d2/s3d3";
> >
> > +static const char proc_filesystems[] =3D "/proc/filesystems";
> >  /*
> >   * layout1 hierarchy:
> >   *
> > @@ -169,6 +171,48 @@ static int remove_path(const char *const path)
> >         return err;
> >  }
> >
> > +static bool fgrep(FILE *inf, const char *str)
> > +{
> > +       char line[32];
> > +       int slen =3D strlen(str);
> > +
> > +       while (!feof(inf)) {
> > +               if (!fgets(line, sizeof(line), inf))
> > +                       break;
> > +               if (strncmp(line, str, slen))
> > +                       continue;
> > +
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> > +static bool supports_overlayfs(void)
> > +{
> > +       char *res;
> > +       bool ret =3D false;
>
> Unnecessary initialization.
>
> > +       FILE *inf =3D fopen(proc_filesystems, "r");
> > +
> > +       /*
> > +        * If fopen failed, return supported.
> > +        * This help detect missing file (shall not
> > +        * happen).
> > +        */
> > +       if (!inf)
> > +               return true;
> > +
> > +       ret =3D fgrep(inf, "nodev\toverlay\n");
> > +
> > +       if (res)
> > +               free(res);
>
> Either I am missing something, or res is neither initialized nor used.
>
Hoops, this is a bug, and I'm missing a test with a kernel with
overlayfs enabled.
I will send V7.

> Guenter
>
> > +
> > +       fclose(inf);
> > +
> > +       return ret;
> > +}
> > +
> > +
> >  static void prepare_layout(struct __test_metadata *const _metadata)
> >  {
> >         disable_caps(_metadata);
> > @@ -3404,6 +3448,9 @@ FIXTURE(layout2_overlay) {};
> >
> >  FIXTURE_SETUP(layout2_overlay)
> >  {
> > +       if (!supports_overlayfs())
> > +               SKIP(return, "overlayfs is not supported");
> > +
> >         prepare_layout(_metadata);
> >
> >         create_directory(_metadata, LOWER_BASE);
> > @@ -3440,6 +3487,9 @@ FIXTURE_SETUP(layout2_overlay)
> >
> >  FIXTURE_TEARDOWN(layout2_overlay)
> >  {
> > +       if (!supports_overlayfs())
> > +               SKIP(return, "overlayfs is not supported");
> > +
> >         EXPECT_EQ(0, remove_path(lower_do1_fl3));
> >         EXPECT_EQ(0, remove_path(lower_dl1_fl2));
> >         EXPECT_EQ(0, remove_path(lower_fl1));
> > @@ -3471,6 +3521,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
> >
> >  TEST_F_FORK(layout2_overlay, no_restriction)
> >  {
> > +       if (!supports_overlayfs())
> > +               SKIP(return, "overlayfs is not supported");
> > +
> >         ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
> >         ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
> >         ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
> > @@ -3634,6 +3687,9 @@ TEST_F_FORK(layout2_overlay, same_content_differe=
nt_file)
> >         size_t i;
> >         const char *path_entry;
> >
> > +       if (!supports_overlayfs())
> > +               SKIP(return, "overlayfs is not supported");
> > +
> >         /* Sets rules on base directories (i.e. outside overlay scope).=
 */
> >         ruleset_fd =3D create_ruleset(_metadata, ACCESS_RW, layer1_base=
);
> >         ASSERT_LE(0, ruleset_fd);
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
