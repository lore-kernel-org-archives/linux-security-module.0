Return-Path: <SRS0=tN9D=MW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD2C43441
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Oct 2018 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6CC2098A
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Oct 2018 18:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="B7ASxN+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6CC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJKBvx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:51:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52775 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeJKBvw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Oct 2018 21:51:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so6508452wmw.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Oct 2018 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LSzPkdyXCnld1Qrpx/0mZjuGfI7NfvPhmLovA3eTmQ=;
        b=B7ASxN+d2+UUN+toqLcDU+AQimJ2M2xPWv195SvbGV1jWn8R51cmwUFlnFCg/7+ebq
         2Y3W8y20c4KS5EBakIH2/dmRmGOuoSHn1CHookqMBWKGnskFaR1rGnMZpTBnGkKVhKD4
         9sIlrOthnkKlud0SXul1xLLoz9ZZgPAT7i+P0dd0WbTGrDbevzmk8sdizrJjpuFeKGs9
         I9jD4mbjeKSeICFN6gnnBT7dX1s+qER8I13zgnBBaSKQoETZfrejLg8MAgk0WkO8AwR8
         OpIeFjk5lSotr/qmghF8MBZBKSnmSflC2xgJ0DFzj2/38Gd4C3nWXkxnp2W9n2uuT1dk
         Fo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LSzPkdyXCnld1Qrpx/0mZjuGfI7NfvPhmLovA3eTmQ=;
        b=OlgEvrnyJax+M5ZVhDvDu4Quws+0LSPNBJRIctzPV1i97BDo7Rcgu3xpHZwmoDHkx5
         7+4vLcBATpKI4Av/dA6a1/QzlzNqhWjw69QQvk60co7q91eRbiwjWiRAZLXh+241xg21
         yjUdl/WKiLwjPqSbRjMhOI0Ji/gwbYxGJdQB7bYIs6tRYG+aI94+8tL8wnmcz/c3TJUf
         tVGt70CPaXTcOBGZr/ELpxNiIB4D1EmxjaXiYXVTmlsjJFIjziwJbPymP2+U6wpRN1yE
         WVHo6lvBrT7FVDwUY0rZa62DT+sOLOJu5VhteLs3YdyDQOxWeCST74HqOKtTGY2gAx9H
         tuVw==
X-Gm-Message-State: ABuFfoh/bk1/i4fsvQ2eKtt54N+tQoKvpxFgKd8N15RezI0b3QV3RkGZ
        J8N6QNtgnzq37mLikRmEpKTTLrxX3V4DfA==
X-Google-Smtp-Source: ACcGV60wdS+IazSqVTeKiv5H+s/UnUnd95bi7xl69BVNgAAY/f8vGdSrh7oGXjiAyXUFCLs+XSgq+g==
X-Received: by 2002:a1c:1649:: with SMTP id 70-v6mr1709071wmw.2.1539196109659;
        Wed, 10 Oct 2018 11:28:29 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id m67-v6sm2900371wmb.18.2018.10.10.11.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:28:28 -0700 (PDT)
Date:   Wed, 10 Oct 2018 20:28:22 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181010182821.grl7fwmcuk7rlogc@brauner.io>
References: <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <20181010153956.zzlatxdlcwolbs6k@brauner.io>
 <20181010165458.GA5607@cisco>
 <20181010171500.wh4yygmh7u6ynqid@brauner.io>
 <20181010172622.GB5607@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010172622.GB5607@cisco>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 10, 2018 at 10:26:22AM -0700, Tycho Andersen wrote:
> On Wed, Oct 10, 2018 at 07:15:02PM +0200, Christian Brauner wrote:
> > On Wed, Oct 10, 2018 at 09:54:58AM -0700, Tycho Andersen wrote:
> > > On Wed, Oct 10, 2018 at 05:39:57PM +0200, Christian Brauner wrote:
> > > > On Wed, Oct 10, 2018 at 05:33:43PM +0200, Jann Horn wrote:
> > > > > On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > > > > > > +cc selinux people explicitly, since they probably have opinions on this
> > > > > >
> > > > > > I just spent about twenty minutes working my way through this thread,
> > > > > > and digging through the containers archive trying to get a good
> > > > > > understanding of what you guys are trying to do, and I'm not quite
> > > > > > sure I understand it all.  However, from what I have seen, this
> > > > > > approach looks very ptrace-y to me (I imagine to others as well based
> > > > > > on the comments) and because of this I think ensuring the usual ptrace
> > > > > > access controls are evaluated, including the ptrace LSM hooks, is the
> > > > > > right thing to do.
> > > > > 
> > > > > Basically the problem is that this new ptrace() API does something
> > > > > that doesn't just influence the target task, but also every other task
> > > > > that has the same seccomp filter. So the classic ptrace check doesn't
> > > > > work here.
> > > > 
> > > > Just to throw this into the mix: then maybe ptrace() isn't the right
> > > > interface and we should just go with the native seccomp() approach for
> > > > now.
> > > 
> > > Please no :).
> > > 
> > > I don't buy your arguments that 3-syscalls vs. one is better. If I'm
> > > doing this setup with a new container, I have to do
> > > clone(CLONE_FILES), do this seccomp thing, so that my parent can pick
> > > it up again, then do another clone without CLONE_FILES, because in the
> > > general case I don't want to share my fd table with the container,
> > > wait on the middle task for errors, etc. So we're still doing a bunch
> > > of setup, and it feels more awkward than ptrace, with at least as many
> > > syscalls, and it only works for your children.
> > 
> > You're talking about the case where you already have shot yourself in
> > the foot by blocking basically all other sensible ways of getting the fd
> > out.
> 
> Ok, but these other ways involve syscalls too (sendmsg() or whatever).
> And if you're going to allow arbitrary policy from your users, you
> have to be maximally flexible.

So, I totally like the idea of being able to get an fd before the filter
is active. If this could be done in seccomp()-only it would be A+ (See
Andy's mail in the other thread.)
But I really don't want to keep you working on this forever. :)

> 
> > Also, this was meant to show that parts of your initial justification
> > for implementing the ptrace() way of getting an fd doesn't really stand.
> > And it doesn't really. Even with ptrace() you can get into situations
> > where you're not able to get an fd. (see prior threads)
> 
> Of course. I guess my point was that we shouldn't design an API that's
> impossible to use. I'll drop the notes about sendmsg() from the commit
> message.
> 
> Tycho
