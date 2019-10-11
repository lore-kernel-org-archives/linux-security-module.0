Return-Path: <SRS0=883h=YE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B42C47404
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Oct 2019 18:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F1B20673
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Oct 2019 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570818050;
	bh=wMDEsltzULFcANZjZoQLiL8tYBb0zmiQz+OvrPFe7aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k5tAysWwkUcPJL2W7qW2Sk3cefu6oNbRFZPN0I39ZkTKPocsCMsY0u96GEO4CdFY3
	 YwcUvLfD1whXI1Vr58KC1K/sMVGT/aJvGCG97UXakpxNg8HINwXKzGLR/YmL3aBGFD
	 aouwo6Y/K9nXNMoCi7qk0PDzgf3SZPjtgzl/KiwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfJKSUt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:20:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40707 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfJKSUt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Oct 2019 14:20:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so10730647ljw.7
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtOmkJTgWRCiTrhHWdgBsH5ShPsUcHo7wVkWA6GbOWw=;
        b=EJ30jg4up9E+EQq6XyhxqytCcLcjMUfxQCZiv0SKtis+tP16d1Y2taYObSlT7PNzA1
         LGvyUzk0LpW338viCdWts370M1zgQU++Pz96/cPXXnweOuhIbBFPJd8E204RnpU17teD
         QyB1KSmlKzHIBlccl6i4fb67lW6F+y5JeJUAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtOmkJTgWRCiTrhHWdgBsH5ShPsUcHo7wVkWA6GbOWw=;
        b=WRnN9Ztmu4Hfua3alP3veqedN6RTOjG7e8CjY1gnKBPMWtQ4oMYHeD3UGpfRFELtpq
         HRLTOItNZIXxufgXor+h4T1bOQNJAq8lfA1FM3B+owbM58a0w6xpYNEGpIg1Bp7UW6Va
         SANj/g60OLk2Xkh8L1S8au1+sX8ce71gwR+dt04lCkSViTk+M9TBhYRXSjbiWOKuD+Re
         FOWT804J1vifxrCciMhjtkwop5NC8uozmvYJL99kESWH0tibXSJtQ1BbYEW0jJD5kU6L
         iB3dFGWB4I8CqnZc16fuN9OYlASWFy8ELxY5a7XgphMvIywyZ5bCawPqx3LcIMJdzm0p
         uUng==
X-Gm-Message-State: APjAAAWjh3YiK6xe85KbTFiL0kOloPPtqrfCydWPIqsGkx69vaMkIYw0
        1TWoAoDH6yzgN6tFHIT/EJuCehGCo+o=
X-Google-Smtp-Source: APXvYqxAQdcSK3d/iGiXgAder6n5LLY7+LyEiFv2wJ1V0hkl1IM1bxyuCdJAWcDgsfVGXXoEDJCawQ==
X-Received: by 2002:a2e:3016:: with SMTP id w22mr10249265ljw.117.1570818047265;
        Fri, 11 Oct 2019 11:20:47 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o9sm2724889ljd.99.2019.10.11.11.20.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:20:46 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f5so10739502ljg.8
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 11:20:46 -0700 (PDT)
X-Received: by 2002:a2e:8315:: with SMTP id a21mr598855ljh.133.1570818045940;
 Fri, 11 Oct 2019 11:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home>
In-Reply-To: <20191011135458.7399da44@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 11:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
Message-ID: <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 11, 2019 at 10:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I bisected this down to the addition of the proxy_ops into tracefs for
> lockdown. It appears that the allocation of the proxy_ops and then freeing
> it in the destroy_inode callback, is causing havoc with the memory system.
> Reading the documentation about destroy_inode, I'm not sure that this is the
> proper way to handle allocating and then freeing the fops of the inode.

What is happening is that *because* it has a "destroy_inode()"
callback, it now expects destroy_inode to not just free free the proxy
ops, but to also schedule the inode itself for freeing.

Which that tracefs)destroy_inode() doesn't do.

So the inode never gets free'd at all - and you eventually run out of
memory due to the inode leak.

The trivial fix would be to instead use the "free_inode()" callback
(which is called after the required RCU grace period) and then free
the proxy op there _and_ call free_inode_nonrcu() too.

But I think your patch to not need a proxy op allocation at all is
probably better.

That said, I think the _best_ option would be to just getting rid of
the proxy fops _entirely_, and just make the (very few)
tracefs_create_file() cases do that LOCKDOWN_TRACEFS in their open in
the first place.

The proxy_fops was a hacky attempt to make the patch smaller. Your
"just wrap all ops" thing now made the patch bigger than just doing
the lockdown thing in all the callers.

In fact, many of them use tracing_open_generic(). And others - like
subsystem_open() already call tracing_open_generic() as part of their
open.

So from a quick glance, just making tracing_open_generic() do the
lockdown testing will take care of most cases.  Add a few other cases
to fill up the whole set, and your'e done.

Willing to do that instead?

                Linus
