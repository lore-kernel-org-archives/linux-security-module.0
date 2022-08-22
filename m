Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E9C32792
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 23:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiHVX0X (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiHVX0T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 19:26:19 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6F558C3
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 16:26:18 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id o14so2536166vkl.6
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=T7of7RkdRgsLzkBFxI/wfi1fAKpxOWqYqUCU6ecRVHU=;
        b=tB9TayyfOz4aMf9wsk2xzckOIKBu8iLQUpEoE9A6bOjBE2Rr8dfkzNc5b7dHIWJi3X
         oJG0OpXDImoFNyYZ528cU71B4wAADrl6hgV5cdIVv12FQK8gHjIgk4S1wsWm3LBPg0xT
         ZBiJeSjcZO3V4HjiN7x4lWbpZIyoYBhFYWDuQWHM/rnXahhPsebK0izQjuog1r1x3G17
         wzAJdmLDzsMGy7kaHSi1/+kLiQEbGAJvjYDmCBKBCbe57hJDmGAa3eMWUIM1GLPygGUs
         iiGBTyoEs98/IA25Tg5FyDs4lR4baKiJA/pCGE0deSPHWcgCcI7ucQWnG7rMV6F5ROsM
         f3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=T7of7RkdRgsLzkBFxI/wfi1fAKpxOWqYqUCU6ecRVHU=;
        b=GvEnHNiwvRGiUCcs4BThphiS+ZZ5tJon9qi844H2vVemPLuZ2ShDjsBumN9WfNrl3q
         GlZosyj8XMxN/m8h8eYGRD0oxCt+gVoujFiEarG63qe/8OxjkC4UCwogICmjZ33YX+zd
         aJDDazC2h3J56QyAXOR3jipS7cyPdUQlCfD1zOyd+DSDN840EolevWw+rbeawX8I+ZaF
         45ZLrSgRUswTUbMh54JYenJsGFtUNBto901F1sfAyFEWwWCw+anLy9Mi8AtHLL6edy49
         HVXqytqbScujCpIyu2X1U28kDvUWwiVIMGYKm5vBBWsYzvmEpwxJPbl6JqACBcJ3UoDR
         XoSQ==
X-Gm-Message-State: ACgBeo09T1ooOsl7ZB6LV6F2aksKKyBL4EvB0WypLd7O6kKpJBuqJpSf
        HvXC6iIzsbM5u4ww61dPYJxdfSKYtRWaBuLBWnFeKQ==
X-Google-Smtp-Source: AA6agR6EfyW0+feOavtNnH/B0ttYUFJumvWwSGEsN7cHE/piFv06LCKNP6BvHbzbo0/M1oDkH5Ux5LOprkJP0ibzojc=
X-Received: by 2002:a1f:b254:0:b0:345:87e4:17fb with SMTP id
 b81-20020a1fb254000000b0034587e417fbmr8537133vkf.25.1661210777126; Mon, 22
 Aug 2022 16:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220822165333.2600411-1-jeffxu@google.com>
In-Reply-To: <20220822165333.2600411-1-jeffxu@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 22 Aug 2022 16:26:06 -0700
Message-ID: <CABXOdTes7rXAfGfQ7kGVrZCbE1L4MDkc31sZhmc5PY+ndi8xYw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/landlock: skip overlayfs test when kernel
 not support it
To:     Jeff Xu <jeffxu@google.com>
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

On Mon, Aug 22, 2022 at 9:53 AM <jeffxu@google.com> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Overlayfs can be disabled in kernel config, causing related tests to fail=
.
> Add check for overlayfs=E2=80=99s supportability at runtime, so we can ca=
ll SKIP()
> when needed.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Couple of nits, otherwise

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 21a2ce8fa739..0c283d50f222 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -11,6 +11,7 @@
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <sched.h>
> +#include <stdio.h>
>  #include <string.h>
>  #include <sys/capability.h>
>  #include <sys/mount.h>
> @@ -62,6 +63,7 @@ static const char dir_s3d1[] =3D TMP_DIR "/s3d1";
>  static const char dir_s3d2[] =3D TMP_DIR "/s3d1/s3d2";
>  static const char dir_s3d3[] =3D TMP_DIR "/s3d1/s3d2/s3d3";
>
> +static const char proc_filesystems[] =3D "/proc/filesystems";
>  /*
>   * layout1 hierarchy:
>   *
> @@ -169,6 +171,43 @@ static int remove_path(const char *const path)
>         return err;
>  }
>
> +static bool fgrep(FILE *inf, const char *str)
> +{
> +       char line[32];
> +       int slen =3D strlen(str);
> +
> +       while (!feof(inf)) {
> +               if (!fgets(line, sizeof(line), inf))
> +                       break;
> +               if (strncmp(line, str, slen))
> +                       continue;
> +
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool supports_overlayfs(void)
> +{
> +       bool ret =3D false;
> +       FILE *inf =3D fopen(proc_filesystems, "r");
> +
> +       /*
> +        * If fopen fails, return supported.
> +        * This helps to detect missing file (shall not
> +        * happen).
> +        */
> +       if (!inf)
> +               return true;
> +
> +       ret =3D fgrep(inf, "nodev\toverlay\n");
> +       fclose(inf);
> +
> +       return ret;
> +}
> +
> +
double empty line

>  static void prepare_layout(struct __test_metadata *const _metadata)
>  {
>         disable_caps(_metadata);
> @@ -3397,13 +3436,14 @@ static const char (*merge_sub_files[])[] =3D {
>   *     =E2=94=94=E2=94=80=E2=94=80 work
>   *         =E2=94=94=E2=94=80=E2=94=80 work
>   */
> -

Unnecessary whitespace change

>  /* clang-format off */
>  FIXTURE(layout2_overlay) {};
>  /* clang-format on */
>
>  FIXTURE_SETUP(layout2_overlay)
>  {
> +       int rc;
> +
>         prepare_layout(_metadata);
>
>         create_directory(_metadata, LOWER_BASE);
> @@ -3431,11 +3471,19 @@ FIXTURE_SETUP(layout2_overlay)
>         create_directory(_metadata, MERGE_DATA);
>         set_cap(_metadata, CAP_SYS_ADMIN);
>         set_cap(_metadata, CAP_DAC_OVERRIDE);
> -       ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
> -                          "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_=
DATA
> -                          ",workdir=3D" UPPER_WORK));
> +
> +       rc =3D mount("overlay", MERGE_DATA, "overlay", 0,
> +                  "lowerdir=3D" LOWER_DATA ",upperdir=3D" UPPER_DATA
> +                  ",workdir=3D" UPPER_WORK);
>         clear_cap(_metadata, CAP_DAC_OVERRIDE);
>         clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +       if (rc < 0) {
> +               ASSERT_EQ(ENODEV, errno);
> +               ASSERT_FALSE(supports_overlayfs());
> +               SKIP(return, "overlayfs is not supported");
> +       }
> +
Unnecessary empty line

>  }
>
>  FIXTURE_TEARDOWN(layout2_overlay)
>
> base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
> --
> 2.37.1.595.g718a3a8f04-goog
>
