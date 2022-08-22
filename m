Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F082C32774
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiHVRCg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiHVRCe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 13:02:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B23F1DC
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 10:02:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z2so14783036edc.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ujKEkUWxf5RajEVkmJPv9oiXn2MzkHwMzOksCWj3I2M=;
        b=nxI2y60drjVE69L2S51AHgUjj44FTMTNhxrUj1RPYb2HjWWmegyCLSXQQYjfFnyaAt
         amQxe+ZVmqxlRST85kCqNONCzF/z2mUh2nvG3JWhAyLihqN4wTwXnHmrI3hPes72lb7B
         zqRiqF8Wk5uYmeZhq+9+V2CMiqgvs6K6a/ZqJDspbSOtBBobmH8yioUqdzFHUBWCO5ED
         aXIMWCcZogs7JT4HIdQtm6ahZ2t6KbmfPx6QLsjOE929iUjKkGZB/V6MxxbxSsWsCj9Z
         vnBiZzQWXQUUlSoo+XlhiI/dZgBVrGJHQxqKJv4weaMTbbyQoaqnJMqZ9pxjdDXAHLhQ
         rGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ujKEkUWxf5RajEVkmJPv9oiXn2MzkHwMzOksCWj3I2M=;
        b=2wcFXEV+2YrwxWtYyD/+eD45XLUKWFAwLBInrDyhgFg6hfUXr1U+xsQcINJbY4T6kG
         /4UXxde1Wx57BxchExQKAuJ7ba8BmPYJbdAr7lwnHRnKKZs7xIw82jklRhl2mrIBqcwK
         j6bgI+U4wbf4ST6O3kUxCSrt1HBq5RR99wYxIpe4VaaukDvriQU81OUWjNM1BzJfWkbI
         /B/KYVpj7lFCJZfl3ZH1L8Yb+aZbLpFRiVGY0dnW7VIdWSy5i50ujTHKhyyMupWXGOqg
         UlK3oE/odoY88r09CQ7MzefeQCeGwsp4AE6slt9UBq/2E/BP5ztBl7ScO+1EC63C5qTQ
         5Juw==
X-Gm-Message-State: ACgBeo3pjGabWHcfg89y/5G+2pXoR+pVEIkJx2vnA6PZl+l9lp7Y5ywP
        wWrmfyv0M7JUzCfScOb+CcE7UxmyNiLiLMT2I7hung==
X-Google-Smtp-Source: AA6agR4KoIFUbfCwTcBvhMKNF+JOc32vfPIrOqk9wtLZ6HCLw4ihBhXgIDTfrJhSwgdwCy9fM8096/z88id0kY+6Qe0=
X-Received: by 2002:a05:6402:5489:b0:43b:b935:db37 with SMTP id
 fg9-20020a056402548900b0043bb935db37mr83211edb.347.1661187750740; Mon, 22 Aug
 2022 10:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220822162533.2594963-1-jeffxu@google.com> <CABXOdTdwqn-8AUN++59WCqnj-=TfwEdVMkFJ_XpBkvtEGFOrrA@mail.gmail.com>
In-Reply-To: <CABXOdTdwqn-8AUN++59WCqnj-=TfwEdVMkFJ_XpBkvtEGFOrrA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 22 Aug 2022 10:01:54 -0700
Message-ID: <CALmYWFtf0+haiGjL_rNtY3f3-MHNXOzHBK+uEqMsxm=rLoiCUA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/landlock: skip overlayfs test when kernel
 not support it
To:     Guenter Roeck <groeck@google.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> No Change-Id in upstream patches
>
> I don't see where res is allocated or used.

Thank you for catching this. Sent out V3 patch


On Mon, Aug 22, 2022 at 9:37 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Aug 22, 2022 at 9:25 AM <jeffxu@google.com> wrote:
> >
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Overlayfs can be disabled in kernel config, causing related tests to fa=
il.
> > Add check for overlayfs=E2=80=99s supportability at runtime, so we can =
call SKIP()
> > when needed.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Change-Id: Ica94d677d6c11e8f2460e07d1b432be077946324
>
> No Change-Id in upstream patches
>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 21a2ce8fa739..3a4c52619b46 100644
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
> > @@ -169,6 +171,49 @@ static int remove_path(const char *const path)
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
> > +       if (res) {
> > +               free(res);
> > +       }
>
> I don't see where res is allocated or used.
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
> > @@ -3397,13 +3442,14 @@ static const char (*merge_sub_files[])[] =3D {
> >   *     =E2=94=94=E2=94=80=E2=94=80 work
> >   *         =E2=94=94=E2=94=80=E2=94=80 work
> >   */
> > -
> >  /* clang-format off */
> >  FIXTURE(layout2_overlay) {};
> >  /* clang-format on */
> >
> >  FIXTURE_SETUP(layout2_overlay)
> >  {
> > +       int rc;
> > +
> >         prepare_layout(_metadata);
> >
> >         create_directory(_metadata, LOWER_BASE);
> > @@ -3431,11 +3477,19 @@ FIXTURE_SETUP(layout2_overlay)
> >         create_directory(_metadata, MERGE_DATA);
> >         set_cap(_metadata, CAP_SYS_ADMIN);
> >         set_cap(_metadata, CAP_DAC_OVERRIDE);
> > -       ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
> > -                          "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPE=
R_DATA
> > -                          ",workdir=3D" UPPER_WORK));
> > +
> > +       rc =3D mount("overlay", MERGE_DATA, "overlay", 0,
> > +                  "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
> > +                  ",workdir=3D" UPPER_WORK);
> >         clear_cap(_metadata, CAP_DAC_OVERRIDE);
> >         clear_cap(_metadata, CAP_SYS_ADMIN);
> > +
> > +       if (rc < 0) {
> > +               ASSERT_EQ(ENODEV, errno);
> > +               ASSERT_FALSE(supports_overlayfs());
> > +               SKIP(return, "overlayfs is not supported");
> > +       }
> > +
> >  }
> >
> >  FIXTURE_TEARDOWN(layout2_overlay)
> >
> > base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
> > --
> > 2.37.1.595.g718a3a8f04-goog
> >
