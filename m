Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFDBC433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Nov 2022 04:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKJEpQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 23:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKJEpO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 23:45:14 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073661275F
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 20:45:12 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n205so789050oib.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 20:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+jY0QwUqWcQ3+srGkuX2EUCpq9PRDfxdTT+/RS7Lbvw=;
        b=R8I9vEcuNoliQ0nKq+0lMG/IdYBuMCV4kl0MLmX7jchcR9EW68x215sLCXVCibGR5e
         WtDW5WjuaZVtUv/GBP84tRxZmDghjzyifd0pzCZEGXsDTwdRKLOMilYBsc7LSobDiiCE
         zsIQg6PxRqINbwzPM8FxtV51TCtOh2UMa8r1IbfRltzdcmem0gxfN7LaOE2vCYWFewlJ
         X+uDjFizTuX8LekAAjp41mup+l9gl+4ZITqrFBMz8RBIW2S1RSTs1zClGesuDG30F5a2
         e/08FvF9ogkHhwmEnWGcsuQyugPSM6CAS9gIvij7lg3G51N3H8VWgLLy7ycLwTcz9zeQ
         mMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jY0QwUqWcQ3+srGkuX2EUCpq9PRDfxdTT+/RS7Lbvw=;
        b=5/3TRPUn+JL+Xiqli6v15tCIKwgEJ6lI1Bd9KGl3mxIB/B4okRphElSpFenuQCU06f
         5eR5cViSCtIdp/f2XLuY1lCk3xCdFNyGVL4dGGgO7p6OkSY0xNROVvaDRmjtUjm64nks
         55mGRyg1j5lApuGsF5X3CRcnNA3Es47VQ62ZMxCcA3uAyJECQgmc1MXauz7dp0fQhgxO
         IWllw0tXGaGmklt0zEg/oyDQe9W+dYHVpZHRn070bQFfp5mK5R5QY8h/EGvtiqiUDBZ2
         0dsUHJujFMM7w7QQoh7l5tma2pzVS42zEfwUfXLeoQ/OvjEEMwh35Rs/5dR0IRGy8O4o
         TrGw==
X-Gm-Message-State: ACrzQf2G1TZcdZRnqoV31C7TBzR+L0zEqkPgk37ZEDY6g3uOt4J7/3+b
        rw6MHb9/C27bPWUCc7lHfVJKgZGgMK35E4q6m1rc
X-Google-Smtp-Source: AMsMyM5KAhYip4HaMQa3iLLBcCdgRzDyRzRC4xRqUskNBP6jvBjXptcyEBKl+Q5OwnBHWCfkb//aNm6rwmioLuYm/G0=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr20583335oiv.172.1668055512071; Wed, 09
 Nov 2022 20:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com> <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com> <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
 <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com> <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
 <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com>
 <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp>
 <CAHC9VhS=0Ts8E647JJiJ6dwPmnuLuYTyOS0QEYJO_EmAb3yFcw@mail.gmail.com>
 <82e46552-54da-6df5-c451-485991dcb5c3@I-love.SAKURA.ne.jp>
 <7CED07F5-A6FC-46AD-8F9D-ECFC28FE23C9@kernel.org> <ef585586-2436-8665-a5e1-475cdd5be5a2@I-love.SAKURA.ne.jp>
In-Reply-To: <ef585586-2436-8665-a5e1-475cdd5be5a2@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 23:45:01 -0500
Message-ID: <CAHC9VhT490c+x8_za-uC=1-VePd=yZtJEd6by1kNWWT+hmUvKA@mail.gmail.com>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 9, 2022 at 11:12 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/11/10 11:22, Kees Cook wrote:
> > On November 9, 2022 3:57:06 PM PST, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >> On 2022/11/09 23:48, Paul Moore wrote:
> >>>                                             If there is a significant
> >>> change, e.g. the overall kernel policy towards out-of-tree code, we
> >>> can reconsider this policy but as of right now only upstream LSMs will
> >>> have LSM ID tokens assigned to them; in-development LSMs are free to
> >>> temporarily assign themselves an ID token (which may change when the
> >>> LSM is merged upstream), and out-of-tree LSMs are free to do whatever
> >>> they like with respect to their code, just as they do now.
> >>
> >> If in-development LSMs and out-of-tree LSMs cannot get a stable ID token,
> >> developers cannot write and publish userspace tools which make use of ID
> >> token. If ID collision happens by use of temporarily ID token, this token
> >> is no longer an identifier. That is a pointless and needless constraint
> >> for getting LSM modules created / tested / used.
> >
> > You have to let this go. You aren't hearing us: this ID reservation process
> > is not a problem for anyone but you. It is the same for all the syscalls
> > that get added, and all the prctls, etc etc. This isn't a problem for userspace
> > tools using those, and there won't be a problem here either.
> >
> > We will not support out of tree code, so needing ID stability for out-of-tree
> > LSMs isn't a valid argument.
> >
>
> This ID reservation process is very much a problem for you all.
>
> In https://lkml.kernel.org/r/CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com ,
> Paul said that it is becoming increasingly difficult for people to find time to
> review potential new LSMs.

It is important that you understand that difficult does not mean
impossible.  As Kees pointed out the rate of LSM acceptance is roughly
at the same level as the rest of the kernel.  The rate of upstream LSM
review also has very little, if anything, to do with the LSM ID
token/string argument.

Beyond that, I'm trying to be polite, but I completely agree with
Kees' statement that you need to let this go.  We are going to be
moving forward with the LSM ID token over the string values.  I'm
sorry we couldn't come to an agreement that satisfies you, but I'm
done discussing this at this point in time.  We can revisit this
decision if something changes, but in the meantime please let this go;
a decision has been made and I'm no longer considering arguments on
this topic.

-- 
paul-moore.com
