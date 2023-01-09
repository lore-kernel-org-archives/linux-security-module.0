Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33619C54EBD
	for <linux-security-module@archiver.kernel.org>; Mon,  9 Jan 2023 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjAIV7s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjAIV7r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Jan 2023 16:59:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173F5582
        for <linux-security-module@vger.kernel.org>; Mon,  9 Jan 2023 13:59:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z4-20020a17090a170400b00226d331390cso11258700pjd.5
        for <linux-security-module@vger.kernel.org>; Mon, 09 Jan 2023 13:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd0PFjL8XFUfesEu5tEd8cW7h1KcK5xrkXdN0lYHKHs=;
        b=nFeyhV194N5exf4bm/4FvKvnlQtA+qFS2lhMDYvUvPSaG+L/9F+/iF6OETEWXFoNpz
         7ujeXnWZrOR/YCDRozta88ruD3KVxxC9VnJLwYJ8NZCN8jt4FUL3tK0+oi7MtvDnz1ur
         AaaaqXCUDe8dFpAc7Z2FpnKqK0Nu/8rlogXShPWccXdZqx0N6uLTbwUM1OhRYl1glc0V
         nfxbI1A1iPBhE2Qgc3OhuB7U3Z7Vd1SL9OCrbXtSQPiNy8EaDRpVHoDkhc5+zHlVUle5
         Llpl24xGjO4niSRYPTIelISLMrpE1GRaKGYrdglYWyygXhlyuGcax5zUyE/ScmEfhXFK
         IevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd0PFjL8XFUfesEu5tEd8cW7h1KcK5xrkXdN0lYHKHs=;
        b=JbtOf6WSBh2td1oDFuXq+4sm8JG6Rah+YblR4OM3cz3r+oe8LyKyULv7gm3q6rUqtv
         hDpXyz9IKHqr7F5F5thVZOQAg+qIKCf9cdHr1XE2183OJBqWYAKmRkJKs4t+aEX0ju5o
         RGwHj6cJWY9fEH1SA28RCoUmI03Zyfi55cbO4HLoiwKCwtYUt7pDgDJeWcjW3zD78+bJ
         BIiqNDjhm/+wqUpoIhVaKVyR/oZ4f+ud30bvX0GT5LbaINCfLeJ7gk3+ySK6HxHQmDWb
         T2Am/8KhcInP04fdZ7EFfMUAz3rGtpAtiwN8iVOMdfsxfWggF0G/vzWDXCKzHoF/KQa3
         P4Dw==
X-Gm-Message-State: AFqh2kqRBuo9+/rB0NQl57tWM5d+D0ojbiAqCP5HQljfrz6TH3aqyvuG
        IMc5prVP/R4k75OarpPzTiafronX+IPLMyVgvNzaKQ==
X-Google-Smtp-Source: AMrXdXsoS5BTsIYDsLj0Bow0yq7mTNCPI9YMAiD1eMBgtaZkCu81N0tKAqyjgOjE+iF110NqTpq1LW7nu/I8IluH+hA=
X-Received: by 2002:a17:902:f2ca:b0:189:894c:6b58 with SMTP id
 h10-20020a170902f2ca00b00189894c6b58mr3650189plc.172.1673301585404; Mon, 09
 Jan 2023 13:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20221229210236.3151723-1-jeffxu@google.com> <20221229210236.3151723-2-jeffxu@google.com>
 <CABXOdTc3QsT9+bfvk0SSzC-xkKB5UT90e3125guarYoaU231og@mail.gmail.com> <242994a4-c209-f877-f77f-7a2adf14dd74@digikod.net>
In-Reply-To: <242994a4-c209-f877-f77f-7a2adf14dd74@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 9 Jan 2023 13:59:07 -0800
Message-ID: <CALmYWFuWjsP2PxgqH006QB5hrN_fDoGS1zOefiToWNOz_Mmd4g@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] selftests/landlock: skip overlayfs test when
 kernel not support it
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Guenter Roeck <groeck@google.com>, jeffxu@chromium.org,
        Shuah Khan <shuah@kernel.org>, jorgelo@chromium.org,
        keescook@chromium.org, linux-security-module@vger.kernel.org,
        groeck@chromium.org, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Micka=C3=ABl
Please see inline.

On Mon, Jan 9, 2023 at 8:05 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> Please refresh with clang-format-14.
>
My installation has clang-format version 15, but changes are quite big
if I use it,
do you still want me to use it ?

> You might want to update the subject to:
> selftests/landlock: Skip overlayfs tests when not supported
>
OK.

>
> On 29/12/2022 22:41, Guenter Roeck wrote:
> > On Thu, Dec 29, 2022 at 1:02 PM <jeffxu@chromium.org> wrote:
> >>
> >> From: Jeff Xu <jeffxu@google.com>
> >>
> >> Overlayfs can be disabled in kernel config, causing related tests to
> >> fail. Add check for overlayfs=E2=80=99s supportability at runtime,
> >> so we can call SKIP() when needed.
> >>
> >> Signed-off-by: Jeff Xu <jeffxu@google.com>
> >
> > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> >
> >> ---
> >>   tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++=
++
> >>   1 file changed, 51 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testin=
g/selftests/landlock/fs_test.c
> >> index 21a2ce8fa739..34095fe2419b 100644
> >> --- a/tools/testing/selftests/landlock/fs_test.c
> >> +++ b/tools/testing/selftests/landlock/fs_test.c
> >> @@ -11,6 +11,7 @@
> >>   #include <fcntl.h>
> >>   #include <linux/landlock.h>
> >>   #include <sched.h>
> >> +#include <stdio.h>
> >>   #include <string.h>
> >>   #include <sys/capability.h>
> >>   #include <sys/mount.h>
> >> @@ -62,6 +63,7 @@ static const char dir_s3d1[] =3D TMP_DIR "/s3d1";
> >>   static const char dir_s3d2[] =3D TMP_DIR "/s3d1/s3d2";
> >>   static const char dir_s3d3[] =3D TMP_DIR "/s3d1/s3d2/s3d3";
> >>
> >> +static const char proc_filesystems[] =3D "/proc/filesystems";
>
> You can inline this string in the fopen() call for now.
>
Done.

>
> >>   /*
> >>    * layout1 hierarchy:
> >>    *
> >> @@ -169,6 +171,43 @@ static int remove_path(const char *const path)
> >>          return err;
> >>   }
> >>
> >> +static bool fgrep(FILE *inf, const char *str)
> >> +{
> >> +       char line[32];
> >> +       int slen =3D strlen(str);
> >> +
> >> +       while (!feof(inf)) {
> >> +               if (!fgets(line, sizeof(line), inf))
> >> +                       break;
> >> +               if (strncmp(line, str, slen))
> >> +                       continue;
> >> +
> >> +               return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +static bool supports_overlayfs(void)
>
> You can move this two functions just before mkdir_parents().
>
Done.

>
> >> +{
> >> +       bool res;
> >> +       FILE *inf =3D fopen(proc_filesystems, "r");
> >> +
> >> +       /*
> >> +        * If fopen failed, return supported.
> >> +        * This help detect missing file (shall not
> >> +        * happen).
>
> You can make this comment fit in two lines, with 80 columns.
>
Done.

> >> +        */
> >> +       if (!inf)
> >> +               return true;
> >> +
> >> +       res =3D fgrep(inf, "nodev\toverlay\n");
> >> +       fclose(inf);
> >> +
> >> +       return res;
> >> +}
> >> +
> >> +
> >>   static void prepare_layout(struct __test_metadata *const _metadata)
> >>   {
> >>          disable_caps(_metadata);
> >> @@ -3404,6 +3443,9 @@ FIXTURE(layout2_overlay) {};
> >>
> >>   FIXTURE_SETUP(layout2_overlay)
> >>   {
> >> +       if (!supports_overlayfs())
> >> +               SKIP(return, "overlayfs is not supported");
> >> +
> >>          prepare_layout(_metadata);
> >>
> >>          create_directory(_metadata, LOWER_BASE);
> >> @@ -3440,6 +3482,9 @@ FIXTURE_SETUP(layout2_overlay)
> >>
> >>   FIXTURE_TEARDOWN(layout2_overlay)
> >>   {
> >> +       if (!supports_overlayfs())
> >> +               SKIP(return, "overlayfs is not supported");
>
> This looks good to me except the multiple supports_overlayfs() calls.
> Only the FIXTURE_SETUP() should be required. I guess some modifications
> of kselftest_harness.h are need to support that. I'd like to avoid
> touching TEST_F_FORK() which should be part of kselftest_harness.h
>
>
In kselftest_harness.h,  SKIP() only applies within the function scope (
FIXTURE_SETUP(), TEST_F_FORK(), FIXTURE_TEARDOWN())

If we want to apply the skip logic to all remaining steps of the testcase,
I think we should do it with a dedicated environment check hook
(FIXTURE_ENV_CHECK),
called before FIXTURE_SETUP(), if the environment check fails, all of
the remaining
test steps will be skipped. In this way, once the env check pass,
the remaining test case should also be passing, or if env check fails,
there is no need to
delete the resource since no setup is called.

However,  this requires change to the kselftest_harness.h, I do think it ne=
eds
to be a separate feature and commit (we can adopt fs_test to be the
first user)

Best regards,
Jeff

> >> +
> >>          EXPECT_EQ(0, remove_path(lower_do1_fl3));
> >>          EXPECT_EQ(0, remove_path(lower_dl1_fl2));
> >>          EXPECT_EQ(0, remove_path(lower_fl1));
> >> @@ -3471,6 +3516,9 @@ FIXTURE_TEARDOWN(layout2_overlay)
> >>
> >>   TEST_F_FORK(layout2_overlay, no_restriction)
> >>   {
> >> +       if (!supports_overlayfs())
> >> +               SKIP(return, "overlayfs is not supported");
> >> +
> >>          ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
> >>          ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
> >>          ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
> >> @@ -3634,6 +3682,9 @@ TEST_F_FORK(layout2_overlay, same_content_differ=
ent_file)
> >>          size_t i;
> >>          const char *path_entry;
> >>
> >> +       if (!supports_overlayfs())
> >> +               SKIP(return, "overlayfs is not supported");
> >> +
> >>          /* Sets rules on base directories (i.e. outside overlay scope=
). */
> >>          ruleset_fd =3D create_ruleset(_metadata, ACCESS_RW, layer1_ba=
se);
> >>          ASSERT_LE(0, ruleset_fd);
> >> --
> >> 2.39.0.314.g84b9a713c41-goog
> >>
