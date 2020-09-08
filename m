Return-Path: <SRS0=wBbN=CR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88201C2D0A8
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 11:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4C2177B
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Sep 2020 11:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdZke3Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIHLa0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730068AbgIHL3n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Sep 2020 07:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599564551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SJToen5De/FMO5Uvn6WpRdklNdA0QrVJ+xmLiUK7iQ=;
        b=YdZke3Km2tL23v8jomnzr6AFDI3Ts1dQ78h2HxeYJFB7ca5vsECxa87RSKm2NXZBxs+8LC
        0Hf9f+AMUEW6mfBuuKfg88eSKg6zNHUUFLxqZSBI2Fw9pRQ1t3RaSybbyytaEl264gUfsP
        1NORzE4FRfY6dwNXCNwAJeaSwuJBnm8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-YjIy3Ht0OOivNu1Bju26qg-1; Tue, 08 Sep 2020 07:29:08 -0400
X-MC-Unique: YjIy3Ht0OOivNu1Bju26qg-1
Received: by mail-lj1-f198.google.com with SMTP id z9so3402178ljk.21
        for <linux-security-module@vger.kernel.org>; Tue, 08 Sep 2020 04:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8SJToen5De/FMO5Uvn6WpRdklNdA0QrVJ+xmLiUK7iQ=;
        b=PQjRj2ZFEHwpdtvMH9O8CWcaocx04EHNoIRzOb7KrolXJr1Vk9hZtdCXKUQXct0R5r
         +93Tf9fF2oYywftfJl+qWwn6Ii5kLhGt/VkqeKdTeIVWdX6OImKIZug15QjFphXtTdkM
         /5pWVBGkku84JtiDngecB0EfPeQcUu0/0hI3q3uzdegFdGvx8K0Eg8N65wu+hccPvv5r
         RWXmVyDRECYAIuCd81vGRToQrKPGxIbMZL3m2lD78NC/N5dOBwExraGRf1e6ahfd8fYP
         KeUTjVcABhu33c+pjGU4+cTTj+wSOo2uKWaN8TGLLKAdVv9Btm75ZLsGHIIBlqB8N+PD
         AljA==
X-Gm-Message-State: AOAM533If88FRO84lQ/M0jnC+shsTcbTPFAZuxoxben2sYM/CV9s0eBt
        qT4lUC9HDxqZ4KR1DWMAc3UiBcVi83SsjTwaViDWpJGIY2NyQhDVQdCJPXelz+4r4NXQpljth96
        UDQ1Iewzh971O5bEKs7sqyM+2uut1EUTdeSe9ACg9GOhQ8mCKbMve
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr13042323ljh.311.1599564546509;
        Tue, 08 Sep 2020 04:29:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzAkVnfY3RS8jLmTTPylLLgZwYimBUxyg65KS1GNPlqmB6hBjIWbaP1koimAnXDD5XhM3jLRXYLRHBdxEEogQ=
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr13042309ljh.311.1599564546218;
 Tue, 08 Sep 2020 04:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200904160031.6444-1-cgzones@googlemail.com> <20200908102537.GU2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200908102537.GU2674@hirez.programming.kicks-ass.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Sep 2020 13:28:55 +0200
Message-ID: <CAFqZXNuD3SRQtE9OUC5NX0XepThg0MJ0b8TJ5TF7YRgS93+TOg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: only issue an audit on privileged operation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 8, 2020 at 12:26 PM <peterz@infradead.org> wrote:
> On Fri, Sep 04, 2020 at 06:00:31PM +0200, Christian G=C3=83=C2=B6ttsche w=
rote:
> > sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
> > issue a CAP_SYS_NICE audit event unconditionally, even when the request=
ed
> > operation does not require that capability / is un-privileged.
> >
> > Perform privilged/unprivileged catigorization first and perform a
> > capable test only if needed.
> >
> > Signed-off-by: Christian G=C3=83=C2=B6ttsche <cgzones@googlemail.com>
> > ---
> >  kernel/sched/core.c | 65 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 47 insertions(+), 18 deletions(-)
>
> So who sodding cares about audit, and why is that a reason to make a
> trainwreck of code?

The commit message should be more specific. I believe Christian is
talking about the case where SELinux or other LSM denies the
capability, in which case the denial is usually logged to the audit
log. Obviously, we don't want to get a denial logged when the
capability wasn't actually required for the operation to be allowed.

Unfortunately, the capability interface doesn't provide a way to first
get the decision value and only trigger the auditing when it was
actually used in the decision, so in complex scenarios like this the
caller needs to jump through some hoops to avoid such false-positive
denial records.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

