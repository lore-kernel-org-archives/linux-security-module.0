Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091E2C28D13
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Aug 2022 01:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiHWBFq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbiHWBFp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 21:05:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CB85723F
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 18:05:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ca13so13256443ejb.9
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=TxLvDnqjt4FHrwYKIGzl/2+IQ/MthfqHFY+BJWEcB2A=;
        b=OHnSmh7Tscx+rcx4s3mLrT+PWNfbRstR4GG56JxtiK2D3GFJTUpH97Yi7H0F9xKDeU
         BlNPUKqXu6EzwC7T1zwTVeMQJQ3YgBYOpHjOBLomDgTbV7Vm1WndAcQPJNRxHpEHEXhJ
         NQ5wS+sUTMCgmTD0BgKSKBVml1pDrC22y+JNF72aZ0+9wd0wvUCPiqHQ2X0MjkG1axqj
         fKY5DxHk9orw18yR5khNkI4zYxZrztkX9nQ8i1SwWbnMPB3eghi0ghvrHVYFCudM7Q5V
         kiGxCCYNzhp5xorjQRr7ow/dXoem5xXaYnwtsU26p8WLlPKnZi+PBq4mDUHHqfIpp3be
         PMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=TxLvDnqjt4FHrwYKIGzl/2+IQ/MthfqHFY+BJWEcB2A=;
        b=tdq32n/mDd9TXcNIBcEKZJSjgh4M0MByzkwCC56vrWxaZly66zHlM1oWwzyGpaHRD6
         Gd6wVoAqXSQekD5l6tyCzqfcbUysPJJxl4MSaYkVkvoTggG+QKFQVOd9w2gMcYhfkVoU
         eTwx8Y2yn4XqfTbQfNVOgh0xXlpjqqr4LWhQaX581cKrcQz5/xMR1X6GXKxuFZTswEtr
         4qRoFIkvJYeLSwIW96h395N0B1HvFlTDIu11ryia1TOWvVlPETRbPxhenevUbk8pHyD0
         PcxqWv1/12JIc/Ua66s2fwfCARemgTAMWCokRE9wOJTUqRkg0TphOtBxubVBUWDOQU7Z
         530A==
X-Gm-Message-State: ACgBeo344uvGMp3HENieGPTndf3g9TFujvjRkYUzCU4fCzCQkHvgH6+0
        x/kpTAvsq1VT5Y4iuwYcDiVcy8OmjTWbEH51WL2mOg==
X-Google-Smtp-Source: AA6agR4ifGlsiCyJ8TPxNWj+BkWYVYuzv44+Tmh6972MoUCo2deqplZ51WgxSUz8SWq5LmlNGyWkwoYriU5mqdBvppM=
X-Received: by 2002:a17:907:2e0d:b0:73d:82a1:136a with SMTP id
 ig13-20020a1709072e0d00b0073d82a1136amr4891093ejc.128.1661216742698; Mon, 22
 Aug 2022 18:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220822165333.2600411-1-jeffxu@google.com> <CABXOdTes7rXAfGfQ7kGVrZCbE1L4MDkc31sZhmc5PY+ndi8xYw@mail.gmail.com>
In-Reply-To: <CABXOdTes7rXAfGfQ7kGVrZCbE1L4MDkc31sZhmc5PY+ndi8xYw@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 22 Aug 2022 18:05:06 -0700
Message-ID: <CALmYWFu3S3JzK51O5aoXnTp=x0VPjij2TRdNFF+XcGPRS4SdXg@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/landlock: skip overlayfs test when kernel
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

> Couple of nits, otherwise
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Thank you. Updated with V4 patch

Best Regards

Jeff


On Mon, Aug 22, 2022 at 4:26 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Aug 22, 2022 at 9:53 AM <jeffxu@google.com> wrote:
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
>
> Couple of nits, otherwise
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++--
> >  1 file changed, 52 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 21a2ce8fa739..0c283d50f222 100644
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
> > @@ -169,6 +171,43 @@ static int remove_path(const char *const path)
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
> > +       bool ret =3D false;
> > +       FILE *inf =3D fopen(proc_filesystems, "r");
> > +
> > +       /*
> > +        * If fopen fails, return supported.
> > +        * This helps to detect missing file (shall not
> > +        * happen).
> > +        */
> > +       if (!inf)
> > +               return true;
> > +
> > +       ret =3D fgrep(inf, "nodev\toverlay\n");
> > +       fclose(inf);
> > +
> > +       return ret;
> > +}
> > +
> > +
> double empty line
>
> >  static void prepare_layout(struct __test_metadata *const _metadata)
> >  {
> >         disable_caps(_metadata);
> > @@ -3397,13 +3436,14 @@ static const char (*merge_sub_files[])[] =3D {
> >   *     =E2=94=94=E2=94=80=E2=94=80 work
> >   *         =E2=94=94=E2=94=80=E2=94=80 work
> >   */
> > -
>
> Unnecessary whitespace change
>
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
> > @@ -3431,11 +3471,19 @@ FIXTURE_SETUP(layout2_overlay)
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
> Unnecessary empty line
>
> >  }
> >
> >  FIXTURE_TEARDOWN(layout2_overlay)
> >
> > base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
> > --
> > 2.37.1.595.g718a3a8f04-goog
> >
