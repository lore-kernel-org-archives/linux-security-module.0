Return-Path: <SRS0=/FKR=AT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393EC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D139420708
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jul 2020 23:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="q+Qn5/TO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGHXGb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGHXGb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 19:06:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4AC08C5C1
        for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2020 16:06:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so215199ejq.6
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2020 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jApHR8WZLOFE/3qde/qPD8ZtCUTqk+p5HMCDcm4XcE=;
        b=q+Qn5/TO5qyj1SaFlPI7928PUOSkBfuzrAV+iYm14zPwybCFy3PMOcolKsCPzShBd4
         pEs9F0B1JDt/lqiFdctP7GUOMvrKAhDSyEePNbSH+2B9VUeTiSPWwU5sGak2AtFFqUBY
         m71JTIDwWnSJeTGeLgl8AHhD8Vjbx7yDhfn3OwNPc+vvRdJHHvit47FaiLztOVYW7B3z
         AU2ENBu+1fT04qgSa5oLRjWvc3LHdZQOIVW7u1JJoK6ta2hdRo7vttBZnoA2lWJHXsAd
         EUPwatFGjpSR6r6lbJvP13kUBeyizOL8nPpcsuN39CEplK5j+IWt08kAjq4Q47J2os3d
         oDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jApHR8WZLOFE/3qde/qPD8ZtCUTqk+p5HMCDcm4XcE=;
        b=RJp8VCEZmjD8rwAp1ABk+EKKqUvnXvtMHkEqqcPuFWTXwRFihOY7aXRosDgAJD4c1Z
         osZDnf3tfzpcOY7gslzFQ1GnyQWQBmDdCgdButKDFZSY7Eyvfq4YijI4QKJ7XSe5tsUS
         T6bU64u88jbB0KNLPZmdk076/4mYQR9ENKi363DAVvIy2ITxijRH9wgrwVeWUd2ngwYv
         b3N0fs/uIEb+X0PBOzdCyAOJCt1EJ6uuvqfSFlz7AsM3jNTk0wu4bpHRFQbQLGO37slx
         MZVr0s4RH2nolkpSCFBFVRGKb2HRHqFZfqJjzvUogqdnSt13BwL91iuVygheuR/RKEr1
         Fn9g==
X-Gm-Message-State: AOAM531l8vCjbfjoeMUWlg3cFrSuxyKXPEbOr30RveiZ3N083Np+9mX4
        KVrqwDVAdNG7+3SjiHNFrGl4tH/wOoxoDXoxqDrm
X-Google-Smtp-Source: ABdhPJxEI74qZhwUWSKk0hFFl180ExVWBpR6pJlwatkcRmWOeQZ+z2OKCc+DEzr4Hd0AhJGNQUM5Ky2Op4P28Eh4efw=
X-Received: by 2002:a17:906:456:: with SMTP id e22mr47815401eja.178.1594249589239;
 Wed, 08 Jul 2020 16:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <878ac79163e31142963f1cd4f743599c35b6754a.1593691408.git.rgb@redhat.com>
In-Reply-To: <878ac79163e31142963f1cd4f743599c35b6754a.1593691408.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jul 2020 19:06:18 -0400
Message-ID: <CAHC9VhT59qkGZar0wUkNK7uVsKvHVQL4-P-gmw+99F8eTKkz-w@mail.gmail.com>
Subject: Re: [PATCH ghak96 v3] audit: issue CWD record to accompany
 LSM_AUDIT_DATA_* records
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

On Fri, Jul 3, 2020 at 12:56 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The LSM_AUDIT_DATA_* records for PATH, FILE, IOCTL_OP, DENTRY and INODE
> are incomplete without the task context of the AUDIT Current Working
> Directory record.  Add it.
>
> This record addition can't use audit_dummy_context to determine whether
> or not to store the record information since the LSM_AUDIT_DATA_*
> records are initiated by various LSMs independent of any audit rules.
> context->in_syscall is used to determine if it was called in user
> context like audit_getname.
>
> Please see the upstream issue
> https://github.com/linux-audit/audit-kernel/issues/96
>
> Adapted from Vladis Dronov's v2 patch.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
> Changelog:
> v3
> - adapt and refactor__audit_getname, don't key on dummy
>
> v2
> 2020-04-02 vdronov https://www.redhat.com/archives/linux-audit/2020-April/msg00004.html
> - convert to standalone CWD record
>
> v1:
> 2020-03-24 vdronov https://github.com/nefigtut/audit-kernel/commit/df0b55b7ab84e1c9faa588b08e547e604bf25c87
> - add cwd= field to LSM record
>
>  include/linux/audit.h |  9 ++++++++-
>  kernel/auditsc.c      | 17 +++++++++++++++--
>  security/lsm_audit.c  |  5 +++++
>  3 files changed, 28 insertions(+), 3 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
