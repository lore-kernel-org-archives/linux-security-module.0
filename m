Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C7C28D13
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Aug 2022 16:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiHVQhF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHVQhF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Aug 2022 12:37:05 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C8419B5
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 09:37:03 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id l7so11493134vsc.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Aug 2022 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=tqHbTk7JXKktviBbyGcDAFKuhlWaYFdox+VesE69RPE=;
        b=p6LB61oMMilwcormQSDswbWb6nLXq7h61jPFGUYQnmdxbHwZOy4XhowvCkOe40n2j3
         naj1RcmsrAiUImiyayFz6XrAHlBalj4Xblw91LBqQ1D2OYlzK+f4ulYsVtd7VDdZcx1z
         x8eAaqyx/VGvpWbtmwDLRWLenVOxPbgoqjb7FBu1QPiWlBkM8y9su4Y4iIq0oFGAyGJY
         6W2RMSmdZHEPHoIOEjebHlCMo1IjW/bfDlZo49ihKxZwPHBaPWuxyiN53X0Eu8kj8knf
         hZ4PUgqEIzFexkBqYM9af8ARliFnwerEBGzITQzj2EcYfrs7GM+PIynVQKEY5YjvTvJC
         Mcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=tqHbTk7JXKktviBbyGcDAFKuhlWaYFdox+VesE69RPE=;
        b=7bwp87WiL7djOg+DG2L302Ur75VOiNOM973rN62P5AhPf80SXiy9EIgK4WPd1NuyMk
         7o8WfpnLrKM7pUzjcJAaGTs4Nsbb7Rm98Gp1jsqzAIJtQlOmAxBDI5s/BdcXi73dR93L
         x6Q/zZ2KpyYw4u7CPFd1tz2/MmavSoQURvRC0oaYswrEdhwsLzkdQVV13rJJ0eDPYwcJ
         sL2ZzHjh1qSpYwBSCFkmYBPlmU9GhbRinQB3etisTmtcEIGE3yezwKb+ieWXytxw/fTB
         bpq4Epnw6Eo5P2fO+3w+Xw12to58/VX1RfTAxshyVvM4rMeha3vjrpWyET89JXpyFQHl
         ztPg==
X-Gm-Message-State: ACgBeo2XR2FczhJHfDH+nF9PO+Qjs06+y+MyD0jr4uEN87Cg+cgPQPu/
        07NZJBg8AjR+s6pKsQNx3YirbVww/Ptx9CTx8EGj4g==
X-Google-Smtp-Source: AA6agR4KcGD33i7/NOPnqxb5GRa+mZfJajr7oVSEP9KRlvtR0zYxingMDMPTVx7BQM+TbldWBX6qGyEO9Z51OPn+9/Y=
X-Received: by 2002:a67:f552:0:b0:390:4d84:9382 with SMTP id
 z18-20020a67f552000000b003904d849382mr2884512vsn.30.1661186222813; Mon, 22
 Aug 2022 09:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220822162533.2594963-1-jeffxu@google.com>
In-Reply-To: <20220822162533.2594963-1-jeffxu@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 22 Aug 2022 09:36:52 -0700
Message-ID: <CABXOdTdwqn-8AUN++59WCqnj-=TfwEdVMkFJ_XpBkvtEGFOrrA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/landlock: skip overlayfs test when kernel
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

On Mon, Aug 22, 2022 at 9:25 AM <jeffxu@google.com> wrote:
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
> Change-Id: Ica94d677d6c11e8f2460e07d1b432be077946324

No Change-Id in upstream patches

> ---
>  tools/testing/selftests/landlock/fs_test.c | 62 ++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 21a2ce8fa739..3a4c52619b46 100644
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
> @@ -169,6 +171,49 @@ static int remove_path(const char *const path)
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
> +       if (res) {
> +               free(res);
> +       }

I don't see where res is allocated or used.

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
> @@ -3397,13 +3442,14 @@ static const char (*merge_sub_files[])[] =3D {
>   *     =E2=94=94=E2=94=80=E2=94=80 work
>   *         =E2=94=94=E2=94=80=E2=94=80 work
>   */
> -
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
> @@ -3431,11 +3477,19 @@ FIXTURE_SETUP(layout2_overlay)
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
>  }
>
>  FIXTURE_TEARDOWN(layout2_overlay)
>
> base-commit: 50cd95ac46548429e5bba7ca75cc97d11a697947
> --
> 2.37.1.595.g718a3a8f04-goog
>
