Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E251C4708E
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Jan 2023 20:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjACUMz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Jan 2023 15:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjACUMx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Jan 2023 15:12:53 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF8DE80
        for <linux-security-module@vger.kernel.org>; Tue,  3 Jan 2023 12:12:50 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b16so34425511yba.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Jan 2023 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrlm21F35UW0ZErh80zRGp7zZlOtHRlcQoW7KGV7l74=;
        b=rwmx7T1c95X6p/xBRrEtRkdrFY9iq2j8p1WgJaADZOtOYBRIg/Er05zE5qWzXoaqUH
         r4uElARdY8cvHVz9xqC90o3ruIQG64mK5dvblsWLYy5RIR2vOGa9/jsOAVmJiXuzSyvq
         HAAU3akFgg4kzsRXVkVi5/rG20ctG8Vk8dQD2HAwp8BKa8GIvDQh8Ui9JwDiM20gwTqC
         Una75CoZlxnC9CT5dlTJqPSz/5hPOFKuCCmlp40q72IQ3Hyr+TBCPwLj44bXl2OA0L+4
         c6dgkLObjbi5y1pHzok1Cbzn2iGcRcQjCCezQy4U0+6l7NzLyegT8hHfzbPxq4OU4Tyx
         BQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yrlm21F35UW0ZErh80zRGp7zZlOtHRlcQoW7KGV7l74=;
        b=tZs5NLmCyhI8867/k9tLeL89zIAhReCLs6kZIPBHB3eaWnQfGTrP59joaDH+w4r/pZ
         57mvx7P5da/lW3ERbYj4UC0DWkN84e7gzXT01FXj/QvDJtRNXzAYPdSqSlRWOCWMrt5C
         0yNKtTtYF1YfgK3nVBYJibtYCz+0aG8gmen6u+0BG50imzRuqKwF8Z/fGqb6KwCqst5S
         Vm4AVikxzoufsEmz9QAoFN/MfjmdYVNEaplmqLKsNenMQUs97yFNxqrE3U4/uk+K6pgo
         j97HINTjgTdeN3tabSYaZATdsRrXmhNM6UJjDC4uKkJ+rQb6gnq+wJ4IxChktT1JsB/y
         tD6Q==
X-Gm-Message-State: AFqh2ko1ImdpId72BhbWK9ttv0HkAjNC+f5c/DhkXgxwi0A7eKfOb2ML
        wUBzkFrgScPMd6R2Gza7an0oa6GDTR0nn2KhEmkUphMhsq4RRjn3
X-Google-Smtp-Source: AMrXdXvY46M8tDrqB5cnjWB+4wO6wNVw2ZuZShNhGUnj2OtKF1vynCjVJbuFPi1Jjoso+EAxrEsYvAX4ORqO/NlP/N4=
X-Received: by 2002:a25:bec3:0:b0:6ee:f3dc:b8d0 with SMTP id
 k3-20020a25bec3000000b006eef3dcb8d0mr5143955ybm.642.1672776769245; Tue, 03
 Jan 2023 12:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20230103190314.3882177-1-jeffxu@google.com> <20230103190314.3882177-2-jeffxu@google.com>
In-Reply-To: <20230103190314.3882177-2-jeffxu@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 3 Jan 2023 12:12:38 -0800
Message-ID: <CABXOdTdf=0C3G4C4CTwAvx3wUQ1RZ_tFuO40LUQMDHCZr7wZmQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] selftests/landlock: skip ptrace_test according to YAMA
To:     jeffxu@chromium.org
Cc:     mic@digikod.net, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 3, 2023 at 11:03 AM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Add check for yama setting for ptrace_test.
>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  .../testing/selftests/landlock/ptrace_test.c  | 48 ++++++++++++++++---
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index c28ef98ff3ac..379f5ddf6c3f 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -60,6 +60,23 @@ static int test_ptrace_read(const pid_t pid)
>         return 0;
>  }
>
> +static int get_yama_ptrace_scope(void)
> +{
> +       int ret = -1;

Unnecessary initialization

> +       char buf[2] = {};

Unnecessary initialization

> +       int fd = open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY);
> +
> +       if (fd < 0)
> +               return 0;
> +
> +       if (read(fd, &buf, 1) < 0)

buf is an array, & is thus unnecessary. Also, if the file is empty,
the return value would be 0.

> +               return -1;

leaking file descriptor

> +
> +       ret = atoi(buf);
> +       close(fd);
> +       return ret;
> +}
> +
>  /* clang-format off */
>  FIXTURE(hierarchy) {};
>  /* clang-format on */
> @@ -232,8 +249,20 @@ TEST_F(hierarchy, trace)
>         pid_t child, parent;
>         int status, err_proc_read;
>         int pipe_child[2], pipe_parent[2];
> +       int yama_ptrace_scope;
>         char buf_parent;
>         long ret;
> +       bool can_trace_child, can_trace_parent;
> +
> +       yama_ptrace_scope = get_yama_ptrace_scope();
> +       ASSERT_LE(0, yama_ptrace_scope);
> +
> +       if (yama_ptrace_scope >= 3)
> +               SKIP(return, "Yama forbids any ptrace use (scope %d)",
> +                          yama_ptrace_scope);
> +
> +       can_trace_child = !variant->domain_parent && (yama_ptrace_scope < 2);
> +       can_trace_parent = !variant->domain_child && (yama_ptrace_scope < 1);
>

Unnecessary ( ).

It is difficult to understand the context. yama_ptrace_scope == 2 is
YAMA_SCOPE_CAPABILITY, and yama_ptrace_scope == 1 is
YAMA_SCOPE_RELATIONAL. I for my part have no idea how that relates to
child/parent permissions. Also, I have no idea why the negation
(can_trace_child = !variant->domain_parent) is necessary, and what its
functional impact might be. Someone else will have to chime in here.

>         /*
>          * Removes all effective and permitted capabilities to not interfere
> @@ -258,6 +287,7 @@ TEST_F(hierarchy, trace)
>
>                 ASSERT_EQ(0, close(pipe_parent[1]));
>                 ASSERT_EQ(0, close(pipe_child[0]));
> +

Unnecessary whitespace change

>                 if (variant->domain_child)

Why not change this code ?

>                         create_domain(_metadata);
>
> @@ -267,7 +297,7 @@ TEST_F(hierarchy, trace)
>                 /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
>                 err_proc_read = test_ptrace_read(parent);
>                 ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> -               if (variant->domain_child) {
> +               if (!can_trace_parent) {
>                         EXPECT_EQ(-1, ret);
>                         EXPECT_EQ(EPERM, errno);
>                         EXPECT_EQ(EACCES, err_proc_read);
> @@ -283,7 +313,7 @@ TEST_F(hierarchy, trace)
>
>                 /* Tests child PTRACE_TRACEME. */
>                 ret = ptrace(PTRACE_TRACEME);
> -               if (variant->domain_parent) {
> +               if (!can_trace_child) {
>                         EXPECT_EQ(-1, ret);
>                         EXPECT_EQ(EPERM, errno);
>                 } else {
> @@ -296,12 +326,12 @@ TEST_F(hierarchy, trace)
>                  */
>                 ASSERT_EQ(1, write(pipe_child[1], ".", 1));
>
> -               if (!variant->domain_parent) {
> +               if (can_trace_child)
>                         ASSERT_EQ(0, raise(SIGSTOP));
> -               }
>
>                 /* Waits for the parent PTRACE_ATTACH test. */
>                 ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
> +

Unnecessary whitespace change

>                 _exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
>                 return;
>         }
> @@ -321,7 +351,7 @@ TEST_F(hierarchy, trace)
>         ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
>
>         /* Tests child PTRACE_TRACEME. */
> -       if (!variant->domain_parent) {
> +       if (can_trace_child) {
>                 ASSERT_EQ(child, waitpid(child, &status, 0));
>                 ASSERT_EQ(1, WIFSTOPPED(status));
>                 ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
> @@ -334,7 +364,7 @@ TEST_F(hierarchy, trace)
>         /* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
>         err_proc_read = test_ptrace_read(child);
>         ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
> -       if (variant->domain_parent) {
> +       if (!can_trace_child) {
>                 EXPECT_EQ(-1, ret);
>                 EXPECT_EQ(EPERM, errno);
>                 EXPECT_EQ(EACCES, err_proc_read);
> @@ -350,10 +380,16 @@ TEST_F(hierarchy, trace)
>
>         /* Signals that the parent PTRACE_ATTACH test is done. */
>         ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +

Unnecessary whitespace change

>         ASSERT_EQ(child, waitpid(child, &status, 0));
>         if (WIFSIGNALED(status) || !WIFEXITED(status) ||
>             WEXITSTATUS(status) != EXIT_SUCCESS)
>                 _metadata->passed = 0;
> +
> +       if (yama_ptrace_scope > 0)
> +               SKIP(return,
> +                          "Incomplete tests due to Yama restrictions (scope %d)",
> +                          yama_ptrace_scope);
>  }
>
>  TEST_HARNESS_MAIN
> --
> 2.39.0.314.g84b9a713c41-goog
>
