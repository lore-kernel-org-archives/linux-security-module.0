Return-Path: <SRS0=UFfU=5L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9847C2D0E9
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 02:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D25520775
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 02:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl4C1DBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCZCBN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:01:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44156 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZCBM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 22:01:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id x16so4050097qts.11;
        Wed, 25 Mar 2020 19:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfDBqnoDk7+WrJd1+uPYSH2KCPjyEuxa89DWXm3bmH8=;
        b=Fl4C1DBn+fUTzfbu/f+eoGiCyfJx7FwO92+Vxi31fr5sNtrsnlaD3iZfvr6LGLooEk
         +01RoWONUrHOa6G/m6pERIO0iRY3JcKhGLYVCTOVHSyEeyE1G95Tkz0bWx0zEYFwdGT6
         hnv+wmjW5dSDiN+3DPP2SiUpMu4UE2CckumGh9+LMZ6Sq69VedNJNE+zEPZLS3LhPot7
         YTpo5oUoshGNjWRXI7sr6Y8kCmKU4Q43fEHlDfmpi5p/fvOrEbjjZq/PopfHpF7XgPER
         SXcQ7zQi1sRzTwO2D4Tc/Sf+P1qHCI6HFnlB4gzDPTDZ0WXkmmXqwZSbEYWj1vHlVtMh
         E4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfDBqnoDk7+WrJd1+uPYSH2KCPjyEuxa89DWXm3bmH8=;
        b=BEKoWzuhqT7i/6ZF13DDa9roCTD5440fvWN0Y0HEpcD16AEcU7oWsNXUMymN34wO/G
         6uM01Ha4vvhWvQHt7QePh74yg7IEuz28nFYf8yqxpAxhuD62C/QtLXS9WxybD8o6oCCv
         LxTWUPd8U1AyRg+hJ99/DCRV/lA6zOXsqQDx06QlKfyG6sIv5m6ptnzwD+kOEv4M0nNQ
         vx19MoYN0t8SOYT2r/sxZU6Xy2389VPDcYyGov4W5Zk5fmkO8XdE75QQHnEcnV4Xe4IA
         4jlbxQQx3gvCV9g0YjvUrUqzixKFjp/TFbf+mpQwIHsXPYh6YtdkPekmKBdDHpltby4+
         pjew==
X-Gm-Message-State: ANhLgQ3joE2woMe5/uQURhzhjvrpf8hKWYVc4tseiE19qJiX+xR3X8QF
        QvqtpCBcS+7Uu43sORvICCt3cDqUzJGo2ztHihQ=
X-Google-Smtp-Source: ADFU+vso0K1cvL1q9SrpEdWIqGIFrHL4xgAECmYR7YSLtyGx3b7KBjOhL/42EFez99LDEYomrSf1BZZPJwg90uVjIcw=
X-Received: by 2002:ac8:3f62:: with SMTP id w31mr5917641qtk.171.1585188071656;
 Wed, 25 Mar 2020 19:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200325152629.6904-1-kpsingh@chromium.org> <20200325152629.6904-8-kpsingh@chromium.org>
In-Reply-To: <20200325152629.6904-8-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 19:01:00 -0700
Message-ID: <CAEf4BzbzfbTT9x3tfLrqhYgozcvxvHvKSVkvyuNqji=aNgvmZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Load/attach a BPF program that hooks to file_mprotect (int)
>   and bprm_committed_creds (void).
> * Perform an action that triggers the hook.
> * Verify if the audit event was received using the shared global
>   variables for the process executed.
> * Verify if the mprotect returns a -EPERM.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---
>  tools/testing/selftests/bpf/config            |  2 +
>  .../selftests/bpf/prog_tests/test_lsm.c       | 84 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lsm.c
>

[...]

> +
> +int exec_cmd(int *monitored_pid)
> +{
> +       int child_pid;
> +
> +       child_pid = fork();
> +       if (child_pid == 0) {
> +               *monitored_pid = getpid();
> +               execvp(CMD_ARGS[0], CMD_ARGS);
> +               return -EINVAL;
> +       } else if (child_pid > 0)

This test is part of test_progs, so let's be a good citizen and wait
for your specific child. I'd rather not hunt for elusive bugs later,
so please use waitpid() instead.

Otherwise looks good and clean, thanks!

> +               return wait(NULL);
> +
> +       return -EINVAL;
> +}
> +

[...]
