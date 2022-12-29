Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3DBC3DA79
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 20:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiL2USW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiL2USV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 15:18:21 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB9C140F1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:18:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 188so5291619ybi.9
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 12:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+BGT91Cl1lEnZo/mXOwweARhd9l5NJMO/q1NMye6B8=;
        b=ap+lEfMkXXsa7XAOVF2pJPWTN9Wp6BuXpWWWlfIizGTif69A2Hkq/2M6ZLLldXnXJv
         Uzg700Je+losgrhflV5mEik2pUT8q7pMwMeUcjCuxTEKT8PIOIGLjBR3Nv582s4KIxB2
         Ep/3mtoBBKcqYvd3dsLXz28D1HwAbE+Hwio/mH73zrZ3DVjHoy/9HG0UH06uVN3iBLrA
         zGlSjoa5vM5OHGNnSPwYT58VVuGqb9Evp5mlFE4osKmyPaOM4ohrxctc5Xhmjsl8bYju
         HTN/Oem3FNDvfuEGD4pGzcSlVPxqkNrZJXFRA8W+qJWzVxetha7VyGZawCK2v7L2YQXj
         H4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+BGT91Cl1lEnZo/mXOwweARhd9l5NJMO/q1NMye6B8=;
        b=RaX0pV/ZTY7/ToiiClaLsLDBTlJNraNqP52axeVx51WfTDYwQIlxZ0ZcZxqUZ6KRrI
         HcfWFjQAIzQ9IFb547WPQhFjBIdkcpNH3bygWzYSOBHr8CDCoUUGtjB1G0j8zTs7K37q
         R3ZiaiUiH7D0gt84n0TzvvcTQ/1Bqlew6Udj4zk4vsSJqAg0+r1wSU7H6Hh014b/UI4R
         Ss1hdebek4DRGoUzHB2Duy14i/Wz53iqlZ85EZJ0dlnAH+rYQe9hmkTTFJh4zAKSuBD3
         21DVekLa4jcpBOcHGGSJeqZXa3/RlvzaPVbpsFtQtGn80gm/QONmKKgZEjPUHNz9NDtj
         tZ4w==
X-Gm-Message-State: AFqh2kpSR4MXZNGNaHWU0InfYbaAGe5Y+AtcsFUmVJwq1VLcEYAMYLoM
        CsOzq1BhUKl4LkT/83To8JldvoVBa5dXRAxI8J+sFg==
X-Google-Smtp-Source: AMrXdXtSLCuMsdmV+SE2Ns0Y503DPPayubURa7nYmf5h9Et8Ffd4CWA0fSV6pAFlah3Qo9gr86Ei+jha1Y05xbW91JE=
X-Received: by 2002:a25:aa8a:0:b0:74d:e2b6:d5fa with SMTP id
 t10-20020a25aa8a000000b0074de2b6d5famr2848156ybi.226.1672345099224; Thu, 29
 Dec 2022 12:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20221229201215.3006512-1-jeffxu@google.com> <20221229201215.3006512-2-jeffxu@google.com>
In-Reply-To: <20221229201215.3006512-2-jeffxu@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 29 Dec 2022 12:18:08 -0800
Message-ID: <CABXOdTcULHsvS8GQNFooy7JqCZfoP25E+Q9iszjh3Z5rXseBZA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] selftests/landlock: skip overlayfs test when
 kernel not support it
To:     jeffxu@chromium.org
Cc:     mic@digikod.net, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 29, 2022 at 12:12 PM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Overlayfs can be disabled in kernel config, causing related tests to
> fail. Add check for overlayfs=E2=80=99s supportability at runtime,
> so we can call SKIP() when needed.
>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 21a2ce8fa739..2d84c055f86f 100644
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
> @@ -169,6 +171,48 @@ static int remove_path(const char *const path)
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
> +       char *res;
> +       bool ret =3D false;

Unnecessary initialization.

> +       FILE *inf =3D fopen(proc_filesystems, "r");
> +
> +       /*
> +        * If fopen failed, return supported.
> +        * This help detect missing file (shall not
> +        * happen).
> +        */
> +       if (!inf)
> +               return true;
> +
> +       ret =3D fgrep(inf, "nodev\toverlay\n");
> +
> +       if (res)
> +               free(res);

Either I am missing something, or res is neither initialized nor used.

Guenter

> +
> +       fclose(inf);
> +
> +       return ret;
> +}
> +
> +
>  static void prepare_layout(struct __test_metadata *const _metadata)
>  {
>         disable_caps(_metadata);
> @@ -3404,6 +3448,9 @@ FIXTURE(layout2_overlay) {};
>
>  FIXTURE_SETUP(layout2_overlay)
>  {
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         prepare_layout(_metadata);
>
>         create_directory(_metadata, LOWER_BASE);
> @@ -3440,6 +3487,9 @@ FIXTURE_SETUP(layout2_overlay)
>
>  FIXTURE_TEARDOWN(layout2_overlay)
>  {
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         EXPECT_EQ(0, remove_path(lower_do1_fl3));
>         EXPECT_EQ(0, remove_path(lower_dl1_fl2));
>         EXPECT_EQ(0, remove_path(lower_fl1));
> @@ -3471,6 +3521,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
>
>  TEST_F_FORK(layout2_overlay, no_restriction)
>  {
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
>         ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
>         ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
> @@ -3634,6 +3687,9 @@ TEST_F_FORK(layout2_overlay, same_content_different=
_file)
>         size_t i;
>         const char *path_entry;
>
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         /* Sets rules on base directories (i.e. outside overlay scope). *=
/
>         ruleset_fd =3D create_ruleset(_metadata, ACCESS_RW, layer1_base);
>         ASSERT_LE(0, ruleset_fd);
> --
> 2.39.0.314.g84b9a713c41-goog
>
