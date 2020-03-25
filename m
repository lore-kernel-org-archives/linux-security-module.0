Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031EC54FD3
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 14:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0BE216FD
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 14:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSQNWZYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgCYOfi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:35:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34832 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCYOff (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 10:35:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id m3so2976139wmi.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4SCMfX4AFsAbSPoyRRB2akn3fbWQgwxVoxo/587s/z8=;
        b=NSQNWZYgH7h9i9bJ/0fpcGqR+VH3MsRrjjNKsBw/qMvHIVxROtE/7whq7UFq7v5S/z
         QrMRhJWkncsPtnhD/cQ9XRdOB6fwTXuvNhcCY3r0VvanFGk9LmguhT/S1HwmklbCSygS
         FPlzURZP+Wp0rut/CEkrX0IAIb1QiGU5LO2WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4SCMfX4AFsAbSPoyRRB2akn3fbWQgwxVoxo/587s/z8=;
        b=DyxVLdNDQ8rDZhPm/VotZvsNhmVqQLdip0AJcyF7zdedFbKJSrajdIQLB6d/7RiKEy
         9WW89Xc9L2R9FvWjQ6MlJ8cZQ9UJnLlddNnkmwY/o9wkdOX8/MEpVYLdAGtF9+8T/evp
         h9G2vt+KgL1E9Uat1LlDE/MILbQWz+5rQNz2Rne9dUBe6FJ+MgPMg0bmKN9YvV38CVTo
         0wBg0Ny+Jl6stI7RUkz4QY3SAyagB4EQ5wMliQapb0G2LCPyVDT6oG5q7D1xT54kLYgE
         SLbMd0N8J9r9ay4eBVfFPe4voXpf9XZz8xp5d8mJFnv32F2BnhNlsCP3FbDHFgtylPTb
         VqlA==
X-Gm-Message-State: ANhLgQ3XkDM9XT3qjhS2VzPUHE8V7UOOs0e1Yf5LwxY4MakvJXR6D+mD
        tjDiUYiR3IooLl4k2YtlC3YEIw==
X-Google-Smtp-Source: ADFU+vtcbDNx2fH0BZ0dRVcQfoo8d+zdTI5b+qqCqcI7EqKovAvDaWAteq4zsCjG8Ks4n87sO3e5Aw==
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr3925012wmd.161.1585146932514;
        Wed, 25 Mar 2020 07:35:32 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id e9sm33653723wrw.30.2020.03.25.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:35:31 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 25 Mar 2020 15:35:28 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200325143528.GA22419@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
 <0655d820-4c42-cf9a-23d3-82dc4fdeeceb@schaufler-ca.com>
 <202003231354.1454ED92EC@keescook>
 <a9a7e251-9813-7d37-34d1-c50db2273569@schaufler-ca.com>
 <202003231505.59A11B06E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003231505.59A11B06E@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-Mär 15:12, Kees Cook wrote:
> On Mon, Mar 23, 2020 at 02:58:18PM -0700, Casey Schaufler wrote:
> > That's not too terrible, I suppose. What would you be thinking for
> > the calls that do use call_int_hook()?
> > 
> > 	rc = call_int_hook(something, something_default, goodnesses);
> > 
> > or embedded in the macro:
> > 
> > 	rc = call_int_hook(something, goodnesses);
> 
> Oh yes, good point. The hook call already knows the name, so:

I learnt this the hard way that IRC that is passed to the
call_int_hook macro is not the same as the default value for a hook

call_int_hook accomdates for a different return value when no hook is
implemented, but it does expect the default value of the hook to be 0
as it compares the return value of the callbacks to 0 instead of the
default value whereas these special cases compare it with the default
value.

For example:

  If we define the default_value of the secid_to_secctx to
  -EOPNOTSUPP, it changes the behaviour and the BPF hook, which
  returns this default value always results in a failure.

  I noticed this when I saw a bunch of messages on my VM:

    audit: error in audit_log_task_context

  which comes from audit_log_task_context and calls
  security_secid_to_secctx which ends up being always denied by BPF.

In anycase, I am still adding the default value in LSM_HOOK and using
them in the following hooks:

 getprocattr -EINVAL
 inode_getsecurity -EOPNOTSUPP
 inode_setsecurity -EOPNOTSUPP
 setprocattr -EINVAL
 task_prctl -ENOSYS
 xfrm_state_pol_flow_match 1

Will send v6 out with these changes.

- KP

> 
> #define call_int_hook(FUNC, ...) ({                        \
>         int RC = FUNC#_default;                            \
> ...
> 
> 
> -- 
> Kees Cook
> 
> 
