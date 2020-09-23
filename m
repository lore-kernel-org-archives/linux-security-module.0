Return-Path: <SRS0=Tise=DA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9470DC4363D
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Sep 2020 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A21206FB
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Sep 2020 14:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xcSixdr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWO3y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Sep 2020 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWO3y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Sep 2020 10:29:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4243C0613CE
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2020 07:29:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so28004048ejb.4
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2020 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvWaZAOmCSJi5EjRj+9rGgqiUccGff1Wvin8E59j7sU=;
        b=xcSixdr2ga+Acx/jNRq3SciNJm/k6+0O76py84OD8DfGApvaqZaQlYynrd/DMYINvD
         w6AM3RwHPUJxID/5ETNaJsTfv75T1xOGBSSw/SO0W3/mJtxFd2IcLb2W6h7JymFMiEtg
         GM+PJKEGwJAGFkTM5rHfYOWNVWgyF1p9kEjLe8wA6FhYBGdeHvR31/W0Hj5LvnJUP5ft
         M6t4IedE1LKk6fTaDwqLmqK9cv6Cz9HQSdwUgk3sCPM94ZJ96Q172m6xA+lM3smf+TzW
         4IKqJQeqjAlLtIsemGF910S2HOlzV0lY6Ef9609bDIxRkKoOg8Xhv9OQSlis+D/3l7yN
         oz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvWaZAOmCSJi5EjRj+9rGgqiUccGff1Wvin8E59j7sU=;
        b=qV32gURwssFLl+rh28nvwzS6YOqNIFZweNQ9/JdMANObA8llrBZ9zokzwuHjbxOk5k
         wt+bzrvlXJJQ1yx2d+N3L6t8aJIOMjOfT12e2qD6RoOa18j7cUf6M1vYUS2hVMhs8p+r
         VXmKy1Z4icHJ58RM1nucNcKIAQk+1EYANMVmug6W8A8mdFvaU8ftjq8jJwrudIP5pDLN
         Ac1LSF3xiSQViVF44FMMnSg5nrBpWgyHCmoDYlpJDHSscwP9Yv6VvncvMNNUFRcUjRL0
         Eg+qJ9LXH5LH9myWkEb3XJvKmwb5SuiriYPYJ0aZXKcQFT7Insn4leA2BuEvm0NQK9Ih
         ieUw==
X-Gm-Message-State: AOAM533g/kmwyVghsn3HSzGx7/IQiLNmVyjZTy6eNvsQqDgqSrNz1DhU
        7IOANX28rjLT/KJsWxOlEB2smeQi9qUbvDPP7Eos
X-Google-Smtp-Source: ABdhPJxGSIKF2KiIFwdCnNZD5Z23c3TbbdA9P88SF9tmr7khUww94uVt7KXHwj5PRDeMEki4gV+UN/8Hw3VdJKdHg3k=
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr10188672eja.488.1600871392179;
 Wed, 23 Sep 2020 07:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
In-Reply-To: <7081a5b9c7d2e8085c49cec2fa72fcbb0b25e0d7.1600778472.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Sep 2020 10:29:41 -0400
Message-ID: <CAHC9VhSPk2RiMsnjTKw02_+_1Kagm06m+-r=ooNruT+fuuixYQ@mail.gmail.com>
Subject: Re: [PATCH ghak120 V5] audit: trigger accompanying records when no
 rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 22, 2020 at 8:45 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> When there are no audit rules registered, mandatory records (config,
> etc.) are missing their accompanying records (syscall, proctitle, etc.).
>
> This is due to audit context dummy set on syscall entry based on absence
> of rules that signals that no other records are to be printed.  Clear the dummy
> bit if any record is generated, open coding this in audit_log_start().
>
> The proctitle context and dummy checks are pointless since the
> proctitle record will not be printed if no syscall records are printed.
>
> The fds array is reset to -1 after the first syscall to indicate it
> isn't valid any more, but was never set to -1 when the context was
> allocated to indicate it wasn't yet valid.
>
> Check ctx->pwd in audit_log_name().
>
> The audit_inode* functions can be called without going through
> getname_flags() or getname_kernel() that sets audit_names and cwd, so
> set the cwd in audit_alloc_name() if it has not already been done so due to
> audit_names being valid and purge all other audit_getcwd() calls.
>
> Revert the LSM dump_common_audit_data() LSM_AUDIT_DATA_* cases from the
> ghak96 patch since they are no longer necessary due to cwd coverage in
> audit_alloc_name().
>
> Thanks to bauen1 <j2468h@googlemail.com> for reporting LSM situations in
> which context->cwd is not valid, inadvertantly fixed by the ghak96 patch.
>
> Please see upstream github issue
> https://github.com/linux-audit/audit-kernel/issues/120
> This is also related to upstream github issue
> https://github.com/linux-audit/audit-kernel/issues/96
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Chagelog:
> v5:
> - open code audit_clear_dummy() in audit_log_start()
> - fix check for ctx->pwd in audit_log_name()
> - open code _audit_getcwd() contents in audit_alloc_name()
> - ditch all *audit_getcwd() calls
>
> v4:
> - resubmit after revert
>
> v3:
> - initialize fds[0] to -1
> - init cwd for ghak96 LSM_AUDIT_DATA_NET:AF_UNIX case
> - init cwd for audit_inode{,_child}
>
> v2:
> - unconditionally clear dummy
> - create audit_clear_dummy accessor function
> - remove proctitle context and dummy checks
>
>  include/linux/audit.h |  8 --------
>  kernel/audit.c        |  3 +++
>  kernel/auditsc.c      | 27 +++++++--------------------
>  security/lsm_audit.c  |  5 -----
>  4 files changed, 10 insertions(+), 33 deletions(-)

I've gone over this revision a couple of times now and it looks okay,
but past experience is whispering in my ear that perhaps this is
better to wait on this for the next cycle so it gets a full set of
-rcX releases.  Thoughts?

-- 
paul moore
www.paul-moore.com
