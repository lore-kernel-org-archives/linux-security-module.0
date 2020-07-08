Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECAC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 22:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CA8206F6
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 22:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iZ0b07cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGHWmY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHWlz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 18:41:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF6C061A0B
        for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2020 15:41:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f12so151959eja.9
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2020 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dCp/uT5qftUij25bqg/K0arVCo7oHs8eumzECRkOqM=;
        b=iZ0b07cQfnjpYludbfK6Zlod0gKDYprYg8508JQn4IqqTGx6qYGgY9TxgXLqo7IdKX
         2/kcoWYjbmByoPMRj8RcwLG956tYBTZetHqbCOaA7zhp+JKRxThTIBjDvfhKPQZL5Qr/
         NR+R6Ey6BAil34FRs8+Iv0CIIfNFQin3dfXA3LGttRpsvpCjiUDndB1Gamhj+nmQxYT4
         73+l3RfDNtfYb6TP855QHw4g/Sb3FXVG20klsZ7xash+mquWU+2MivsfVaZa+w8hO2wb
         Eu2iQJGObNzFkZdrwCJNfjKIFTFE8z0lSQVwL+yHXHRqqTZwpcIcN3wLR2JDf8ViJ3sC
         ckJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dCp/uT5qftUij25bqg/K0arVCo7oHs8eumzECRkOqM=;
        b=PtCNO2Y7co+kZc3P2v83hb88efp9opnDBPCeTOdpcRQKG7ZGn4NfhvRgf9lfn9l4vN
         lKXHNySSrQalVRKJJbptA/V7XTirpld8S7YVmmKWSxeTKXL9Y19GCc4goIxRgtmirsnm
         ZyO8Yehzz8bfof3aL+sNlBJNKcwVgrlJtFbm+U8fEQKriGf2Xr2/Sdtu+/pvhDk/QDjp
         IKqpwWpLMrTgXglWNbGSgoJpf2DtoBbBU/q7d7ZS13iHohgssU/LLBnVHPWEsC66K7He
         IHJTU++pKH0or/BAL3k2pD7STfp2TZI9w6gorSZGm933doefIV+8U1IqXfPyXeYF/HRl
         ZEiA==
X-Gm-Message-State: AOAM530f+mNh2G9e3ik81qUQQUC64tRepqRHPKu+lD9T5Ue8tuGT+apW
        Vr11I/pj6WGNA1NdQGzXL1yQNmlG6YlBM3zebk9p
X-Google-Smtp-Source: ABdhPJz7UoWSz8oqn7+rcBW1/6K3OW/v22bvTrX9IyWmI8VPcvzPYpAxWXitmv+qa8mOZSASHenNOW40xNobLmj+7yM=
X-Received: by 2002:a17:906:7d86:: with SMTP id v6mr52345580ejo.542.1594248113746;
 Wed, 08 Jul 2020 15:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20597345545df186f0a287c974c9dc88b5c940a0.1593808662.git.rgb@redhat.com>
In-Reply-To: <20597345545df186f0a287c974c9dc88b5c940a0.1593808662.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jul 2020 18:41:42 -0400
Message-ID: <CAHC9VhQT2O9GnVBhXvzpP+yNNoCqy-XTfMC7OHqz3xvFVaGvdw@mail.gmail.com>
Subject: Re: [PATCH ghak84 v3] audit: purge audit_log_string from the
 intra-kernel audit API
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 3, 2020 at 5:50 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> audit_log_string() was inteded to be an internal audit function and
> since there are only two internal uses, remove them.  Purge all external
> uses of it by restructuring code to use an existing audit_log_format()
> or using audit_log_format().
>
> Please see the upstream issue
> https://github.com/linux-audit/audit-kernel/issues/84
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
> Changelog:
> v3
> - fix two warning: non-void function does not return a value in all control paths
>         Reported-by: kernel test robot <lkp@intel.com>
>
> v2
> - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
>
> v1 Vlad Dronov
> - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
>
>  include/linux/audit.h     |  5 -----
>  kernel/audit.c            |  4 ++--
>  security/apparmor/audit.c | 10 ++++------
>  security/apparmor/file.c  | 25 +++++++------------------
>  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
>  security/apparmor/net.c   | 14 ++++++++------
>  security/lsm_audit.c      |  4 ++--
>  7 files changed, 46 insertions(+), 62 deletions(-)

...

> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 597732503815..335b5b8d300b 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -57,18 +57,16 @@ static void audit_pre(struct audit_buffer *ab, void *ca)
>         struct common_audit_data *sa = ca;
>
>         if (aa_g_audit_header) {
> -               audit_log_format(ab, "apparmor=");
> -               audit_log_string(ab, aa_audit_type[aad(sa)->type]);
> +               audit_log_format(ab, "apparmor=%s",
> +                                aa_audit_type[aad(sa)->type]);
>         }
>
>         if (aad(sa)->op) {
> -               audit_log_format(ab, " operation=");
> -               audit_log_string(ab, aad(sa)->op);
> +               audit_log_format(ab, " operation=%s", aad(sa)->op);
>         }

In the case below you've added the quotes around the string, but they
appear to be missing in the two cases above.

>         if (aad(sa)->info) {
> -               audit_log_format(ab, " info=");
> -               audit_log_string(ab, aad(sa)->info);
> +               audit_log_format(ab, " info=\"%s\"", aad(sa)->info);
>                 if (aad(sa)->error)
>                         audit_log_format(ab, " error=%d", aad(sa)->error);
>         }
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index 9a2d14b7c9f8..70f27124d051 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -35,20 +35,6 @@ static u32 map_mask_to_chr_mask(u32 mask)
>  }
>
>  /**
> - * audit_file_mask - convert mask to permission string
> - * @buffer: buffer to write string to (NOT NULL)
> - * @mask: permission mask to convert
> - */
> -static void audit_file_mask(struct audit_buffer *ab, u32 mask)
> -{
> -       char str[10];
> -
> -       aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> -                           map_mask_to_chr_mask(mask));
> -       audit_log_string(ab, str);
> -}
> -
> -/**
>   * file_audit_cb - call back for file specific audit fields
>   * @ab: audit_buffer  (NOT NULL)
>   * @va: audit struct to audit values of  (NOT NULL)
> @@ -57,14 +43,17 @@ static void file_audit_cb(struct audit_buffer *ab, void *va)
>  {
>         struct common_audit_data *sa = va;
>         kuid_t fsuid = current_fsuid();
> +       char str[10];
>
>         if (aad(sa)->request & AA_AUDIT_FILE_MASK) {
> -               audit_log_format(ab, " requested_mask=");
> -               audit_file_mask(ab, aad(sa)->request);
> +               aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> +                                   map_mask_to_chr_mask(aad(sa)->request));
> +               audit_log_format(ab, " requested_mask=%s", str);
>         }
>         if (aad(sa)->denied & AA_AUDIT_FILE_MASK) {
> -               audit_log_format(ab, " denied_mask=");
> -               audit_file_mask(ab, aad(sa)->denied);
> +               aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
> +                                   map_mask_to_chr_mask(aad(sa)->denied));
> +               audit_log_format(ab, " denied_mask=%s", str);
>         }

More missing quotes.

>         if (aad(sa)->request & AA_AUDIT_FILE_MASK) {
>                 audit_log_format(ab, " fsuid=%d",
> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> index 4ecedffbdd33..fe431731883f 100644
> --- a/security/apparmor/ipc.c
> +++ b/security/apparmor/ipc.c
> @@ -20,25 +20,23 @@
>
>  /**
>   * audit_ptrace_mask - convert mask to permission string
> - * @buffer: buffer to write string to (NOT NULL)
>   * @mask: permission mask to convert
> + *
> + * Returns: pointer to static string
>   */
> -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> +static const char *audit_ptrace_mask(u32 mask)
>  {
>         switch (mask) {
>         case MAY_READ:
> -               audit_log_string(ab, "read");
> -               break;
> +               return "read";
>         case MAY_WRITE:
> -               audit_log_string(ab, "trace");
> -               break;
> +               return "trace";
>         case AA_MAY_BE_READ:
> -               audit_log_string(ab, "readby");
> -               break;
> +               return "readby";
>         case AA_MAY_BE_TRACED:
> -               audit_log_string(ab, "tracedby");
> -               break;
> +               return "tracedby";
>         }
> +       return "";
>  }
>
>  /* call back to audit ptrace fields */
> @@ -47,12 +45,12 @@ static void audit_ptrace_cb(struct audit_buffer *ab, void *va)
>         struct common_audit_data *sa = va;
>
>         if (aad(sa)->request & AA_PTRACE_PERM_MASK) {
> -               audit_log_format(ab, " requested_mask=");
> -               audit_ptrace_mask(ab, aad(sa)->request);
> +               audit_log_format(ab, " requested_mask=%s",
> +                                audit_ptrace_mask(aad(sa)->request));
>
>                 if (aad(sa)->denied & AA_PTRACE_PERM_MASK) {
> -                       audit_log_format(ab, " denied_mask=");
> -                       audit_ptrace_mask(ab, aad(sa)->denied);
> +                       audit_log_format(ab, " denied_mask=%s",
> +                                        audit_ptrace_mask(aad(sa)->denied));
>                 }

Quotes.  There are none.

... and it looks like there are more missing too, but I kinda stopped
seriously reading the patch here, please take a closer look at the
patch, make the necessary changes, and resubmit.

-- 
paul moore
www.paul-moore.com
