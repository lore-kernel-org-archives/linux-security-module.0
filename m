Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C9C3DA79
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Dec 2022 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiL2Vl5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Dec 2022 16:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiL2Vlz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Dec 2022 16:41:55 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF8610061
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:41:53 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 192so21849275ybt.6
        for <linux-security-module@vger.kernel.org>; Thu, 29 Dec 2022 13:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgGM9cNAkqOvtfmWsQmm967SQTunenHFYIab0LFiTyI=;
        b=U0PIA1bbLeutTo1ZQhwTYid7MtwAALdJkSa0soFLiSAb1ac/UV8ORZVOJN0RoApaVN
         ZYwhsouNgtLZ+J/LrH6nb/ROh98vW+IWMeLQ9DrsDeQ7CQgPyi5vqTjeHEpqglVWi1Mv
         2hHFgB9TCNP4ZeF65KBF1b9J03BxIgb3gEhS8X9WrD8Lsdse2sDMg/rU4vS10RRl13Fw
         kxZ8+UqJY2yvfLvX3XRRcbVc0kPy2wFq6vlMfYUpNdPTgaegs7APp4iWMPkrAnTNNdhC
         rAifraRPE5YZ2gii4p+U/hbW0Yc25OnzjHR1D6ohJ2FiZun7y8bnNnBB4pnHPeRhuGbz
         Idig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgGM9cNAkqOvtfmWsQmm967SQTunenHFYIab0LFiTyI=;
        b=7sUzVgLmzPROpKCwvvxsFLPQZ+UL45aECJFTVOPphjDzsM6RmC0WUtzDaCXKLQU0fF
         2llaboqBF2vEWHXxcrVfkSX0QUTF7K5r3z42h7dEKXQrEKQLA/TmzOW8lFQfPz256SJJ
         rHG7j6gX5N/LZdRM+8uFdYT80KxCvJZ4yiqH1ydZcS521/UpDmRzJOSn0HdJFTGdras/
         C5RXb6ae+4ykuKvW0dZPwRezsXe++Odww4ZBHqAmDEq8EZ7OTWMOCR8jMK+F+xPC6ESs
         r6q+1EQfaBadk+pytKg/eXTo8pQOz/uc8ne5AvgqG9M0/mO44ifGsla7blyk/1FnKhiS
         aZqQ==
X-Gm-Message-State: AFqh2kqMmDgUBUSLAucZWcd8A+HRKrtwn13eUgw/cC/6gkw2CAUqAHbf
        RjDisZ5OmKx0s97lxDOOH7GzWrvI4OBaBUbgzGv57w==
X-Google-Smtp-Source: AMrXdXuj0MUxoeoedEWbJQiQ+NvjOobKG6S9xd7ndNF+T9SNRaYeL5PVehfS6bedeHGJ5lyId7wez1ZMkKJvxXCVlfk=
X-Received: by 2002:a05:6902:1817:b0:723:be61:1a2c with SMTP id
 cf23-20020a056902181700b00723be611a2cmr3398071ybb.130.1672350112500; Thu, 29
 Dec 2022 13:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20221229210236.3151723-1-jeffxu@google.com> <20221229210236.3151723-2-jeffxu@google.com>
In-Reply-To: <20221229210236.3151723-2-jeffxu@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 29 Dec 2022 13:41:41 -0800
Message-ID: <CABXOdTc3QsT9+bfvk0SSzC-xkKB5UT90e3125guarYoaU231og@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] selftests/landlock: skip overlayfs test when
 kernel not support it
To:     jeffxu@chromium.org
Cc:     mic@digikod.net, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Dec 29, 2022 at 1:02 PM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Overlayfs can be disabled in kernel config, causing related tests to
> fail. Add check for overlayfs=E2=80=99s supportability at runtime,
> so we can call SKIP() when needed.
>
> Signed-off-by: Jeff Xu <jeffxu@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 21a2ce8fa739..34095fe2419b 100644
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
> +       bool res;
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
> +       res =3D fgrep(inf, "nodev\toverlay\n");
> +       fclose(inf);
> +
> +       return res;
> +}
> +
> +
>  static void prepare_layout(struct __test_metadata *const _metadata)
>  {
>         disable_caps(_metadata);
> @@ -3404,6 +3443,9 @@ FIXTURE(layout2_overlay) {};
>
>  FIXTURE_SETUP(layout2_overlay)
>  {
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         prepare_layout(_metadata);
>
>         create_directory(_metadata, LOWER_BASE);
> @@ -3440,6 +3482,9 @@ FIXTURE_SETUP(layout2_overlay)
>
>  FIXTURE_TEARDOWN(layout2_overlay)
>  {
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         EXPECT_EQ(0, remove_path(lower_do1_fl3));
>         EXPECT_EQ(0, remove_path(lower_dl1_fl2));
>         EXPECT_EQ(0, remove_path(lower_fl1));
> @@ -3471,6 +3516,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
>
>  TEST_F_FORK(layout2_overlay, no_restriction)
>  {
> +       if (!supports_overlayfs())
> +               SKIP(return, "overlayfs is not supported");
> +
>         ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
>         ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
>         ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
> @@ -3634,6 +3682,9 @@ TEST_F_FORK(layout2_overlay, same_content_different=
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
