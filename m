Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC44C282CC
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 18:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021642175B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FFi7CCBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBESP6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:15:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37912 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBESP6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 13:15:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id j15so3363238lfh.5
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mbf7A5q2IDkcmquFOhKq4fWWwcmHl2eQ7tXy3UEf9BE=;
        b=FFi7CCBxRdbgf0UnX2a9J6HnF7xSZEzMQGCYBRqGrUX3qCiHurhJ/RLa5HMd42fowz
         lvOM36OJ7HGSu2P2fh13+h/gQlvUcoCGSjUpNvCntuFtRuU2Sa4rowyHLVEA7Is6LAhz
         BJN4plQmOkLsAQ7yek4WPnRKfg+O2Lbwpb07ZB5Js38XZgwgMZrUvZ6ryghoEOiLIvih
         sQUSACbFjDghj5qRljOBaZKahNulaishghCe9572RlcLkpbsGwimgFmke/AEQJ3yQsq1
         r8iAQr21/AynLnEoD1hAdMPPhdICIGgN8M+wc7/wNAyyoUfA8I5bZeog5M1v0Q8BVhXV
         taRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mbf7A5q2IDkcmquFOhKq4fWWwcmHl2eQ7tXy3UEf9BE=;
        b=LLPmwPz0hq4cmduFXpTVAY3Jw89yzS6UJm4VapiknwVQRtSMoug67cuo7qFwitG9Q9
         34S8osjnkce6S+8Jja4B4EmYZ82miv/Z380DvueL7e4olbUZoS/mSDyMq1hNTYLsuzfA
         3/L9LGXm4bOXZtvZDQARyLT/h8jJos773Q5/tVFNyIzb68VJ++ZOiaCQYPZkyyJGi0ao
         QHQxtITn25ns89EYxrRRs8jfwmi97v8b21ENUSMl1ZiNtFkkb6Hdgv0WtnRvYXYovQ2X
         ebDfSSYR7vP45Ng8J3a2UD2Rr36Sm0HIwPoJ+VixqsfsE51pqwFRUb6KGq7l9A7p+LFY
         0gyA==
X-Gm-Message-State: AHQUAuYKGXTQyOCSIeArnAEQiW77vKt06sNtWTjRW/nL6Z1VZsbBYVsx
        o/uF7c6JSToKpxm6JsuQEFoWnI/NFvtYBybuv5N2wYk=
X-Google-Smtp-Source: AHgI3Ib81/3dEq0pXvAOaXbgixtsJEUxTs6tVdvATvZT/nWkRLQSt6AxIFccEoKTgWCBKGO0JSxxUArtUvnX6C9TniU=
X-Received: by 2002:a19:d619:: with SMTP id n25mr3571544lfg.91.1549390555502;
 Tue, 05 Feb 2019 10:15:55 -0800 (PST)
MIME-Version: 1.0
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
In-Reply-To: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Feb 2019 13:15:44 -0500
Message-ID: <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
Subject: Re: New LSM hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 5, 2019 at 12:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Full disclosure: This is all about me and my interests.
>
> Developers propose new LSM hooks for many reasons. Often,
> it's in support of an exotic feature such as Infiniband.
> Sometimes it's because someone got clever when they optimized
> an otherwise mundane feature and bypassed the usual hooks,
> as is being proposed for kernfs. Usually there is a particular
> security module (i.e. SELinux) that is targeted for the hook.
> In almost all cases a hook is provided for that LSM, but not
> for any other. In many cases the developers don't even include
> the LSM email list in the discussions. LSM maintainers find
> out about the new hooks after the fact.

I think it is each LSM maintainer's job to ensure that patches which
affect the LSM hooks, either through modification or addition, are
CC'd to the LSM list for discussion.  I've tried to be good about
this, but I'm sure I've missed some over the years.

> Prior to 2008, when there was only one LSM, this made perfect
> sense. Since then, it's been a regular practice justified by
> the notion that it's the LSM maintainer's option to use the
> hook or not. That also makes sense in cases where the use is
> strictly optional, as it is in binder. It does not make sense,
> however, when a core system facility like kernfs is involved.

The term "optional" is tricky here.  In all the cases I can think of
where a LSM hook has been added to an existing bit of kernel
functionality, the hook has almost always been optional if for no
other reason than it didn't exist in the previous kernel.  I suppose
one could argue that there is a functional disparity between LSMs if
one LSM implements the hook and the others do not, but that is a
different issue.

> I get a double whammy on these new LSM hooks. I have to try
> to figure out if Smack cares, and if it does, whether to proposed
> hook will solve the problem for Smack. Because Smack uses
> xattrs and process attributes differently from SELinux there are
> often problems with hooks that are provided with only an SELinux
> implementation. I also have to work out how the new hook will
> work in the stacked security module case. There are some existing
> hooks that are a special challenge there, and when a new hook is
> proposed that does the same kind of things (e.g. use of secid,
> secctx or list of xattrs) without considering the consequences
> for other modules.

Once again, I think it is important to CC the LSM list on these sorts
of patchsets, and to get the patch author to consider other LSMs, but
I think asking the original author to preemptively add support to each
LSM for every new addition is too high a bar.  I would encourage the
individual LSMs (both maintainers and contributors) to work with patch
authors in a constructive manner to add support for new hooks when
they make sense for the given LSM.

> What do I want, I hear you cry? I want some sanity in the way
> LSM hooks are introduced. I want some standards or conventions
> on what is appropriate to pass into and out of LSM hooks. I
> want push back on special purpose hooks that are required to
> fix the deficiencies of a filesystem or bizarre hardware
> implementation. I want to stop spending all my time trying to
> deal with new, crazy LSM hooks. There are enough old ones to
> keep me entertained, thank you very much.

Yeah, good luck with that.  I think trying to legislate this too much
is a sure path to failure.  Our saving grace is that the LSM hook
boundary is not a kernel/userspace boundary so we are free to change
it as needed, we just need to make sure if we change an existing hook
we don't break any of the existing in-tree LSMs.  We've done this in
the past without too much problem, even other subsystems have done
this for us (without much notification to the LSMs) and it has
generally worked out okay.

I'm all for increased collaboration between LSMs, e.g. requiring hooks
changes to CC the LSM list, but I think mandating anything beyond that
is a fool's errand.

-- 
paul moore
www.paul-moore.com
