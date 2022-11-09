Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE2CC433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Nov 2022 14:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKIOtB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiKIOs4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 09:48:56 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335C17E23
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 06:48:55 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id c129so19057660oia.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+BNm+dEye/daEA1y5GhiiePddIMsp/krIKxNeEOYhs=;
        b=7j/bUrWKnToR9773BHiv1P5Ddl4QSRP/4bQaClEkm0S063Gi0Y3+Iv3XAPSCp57B0n
         kzNd1OhpsrrHZPtM/7WN8OAAAPK+LqQWwRTvwfzBrLbY0RFf3jxQCMhqn79hnKM83lqG
         N8um6a37Yz4aiAM/Wo9/rsZ5WK4amGL1Ny5s8nmWMLnLMWDsLtCOCNkWtcKhpGOlLr/B
         V2CDcU+ueeYMSEFIU9LW5u6r4sxweX9pluo0Ul0Nr4EcsNUUIptbtjwnNt+9w0O6tdiE
         3LpBAnOu4Feij0I/RL77o4mGIZK6pDMG3TR5UMV/9okoTHpzXSnazgqZeuHwEZeyt7kc
         4XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+BNm+dEye/daEA1y5GhiiePddIMsp/krIKxNeEOYhs=;
        b=RA9s/b9e3nRnVz7rRdpF461kQ2uVrSbHncPIeFHIFFz/FTcHX9GEa9GhHxqJSrBmMK
         W0AOHO59bm8E55Vro83inyf04k5+VAVlZnzcSHURpVz9mgCD5CsYE1kT8FINP0bvipzO
         1orRVAB50K+6W1p4Z19ATrrreJOmkJISvqVDcuqRjA1QsgdauhwyIJyqCOxnc5dqbxIu
         reEeF1J6lzIaA+Oltfi6Zdm89uzdn7FCgM+zT5OkpNv1V+KYXhFAKRkr5PMeFh/nkli8
         scmmYgciZluF+nQMGktlpcg2LCggXGo6GUGTrKJXGEj9KQQFlZttRZzicXxAqU/fOf5P
         cu3w==
X-Gm-Message-State: ACrzQf2T0HKZ5yhOzFkG9KUALQB4RswXXotUp69ShltXIA6bs+pVWP2O
        r1j9hd6EBM9tuDOOZ5VuBBfyOet7K3LH3R0dWAkQ
X-Google-Smtp-Source: AMsMyM6xS2BAhr6f54CL7AOx2HkUDI2TpSqkI0jHt0w/lFEMyRqv1Gav0QVR2FngzvO/I5db/YIX+6FOWOtoBwMaLzw=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr19246291oiv.172.1668005334394; Wed, 09
 Nov 2022 06:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com> <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com> <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
 <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com> <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp>
 <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com> <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp>
In-Reply-To: <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 09:48:43 -0500
Message-ID: <CAHC9VhS=0Ts8E647JJiJ6dwPmnuLuYTyOS0QEYJO_EmAb3yFcw@mail.gmail.com>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 9, 2022 at 5:14 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/11/09 11:20, Paul Moore wrote:
> > On Tue, Nov 8, 2022 at 5:20 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> What I'm asking you are that:
> >>
> >>   Please don't lock out out-of-tree LSM modules (by requiring an LSM id integer value
> >>   which are assigned to only in-tree LSM modules) because we can't accept whatever LSM
> >>   modules as in-tree.
> >>
> >>   Please don't lock out loadable LSM modules (by using fixed sized array) because
> >>   locking out loadable LSM modules reduces the value of your LSM stacking work.
> >>
> >> Quite simple.
> >
> > Tetsuo, at this point I think we all understand your concern and I
> > appreciate and respect the passion you have for your argument.
> > However, I think the rest of the developers, including myself, have
> > also made our points very clear.  While there may still be revisions
> > to the syscall patches, I believe identifying LSMs via a token value
> > as opposed to a string value is the better option for the upstream
> > Linux Kernel.
>
> I'm not opposing to identifying LSMs via a token value. I'm opposing to who can
> obtain a token value, for I haven't heard a clear promise that we shall allow
> whatever LSM modules to obtain a token value.

In that case, let me be very clear on this issue: at this point in
time I will not merge patches which assign LSM ID tokens in the
upstream Linux Kernel to out-of-tree LSMs.  If there is a significant
change, e.g. the overall kernel policy towards out-of-tree code, we
can reconsider this policy but as of right now only upstream LSMs will
have LSM ID tokens assigned to them; in-development LSMs are free to
temporarily assign themselves an ID token (which may change when the
LSM is merged upstream), and out-of-tree LSMs are free to do whatever
they like with respect to their code, just as they do now.

> > Thank you for your comments, but I'm considering this settled.
> >
>
> Never settled, unless you all promise that we shall assign a token value to whatever
> LSM modules (regardless of whether that LSM module is already in-tree or not).

As the person who ultimately is responsible for supporting,
maintaining, and merging LSM related patches into the upstream Linux
Kernel I am considering this issue settled until there is some other
significant change that warrants reconsideration of the policy
mentioned above.  Of course you are welcome to disagree, and you can
continue to voice your objections if you like, but the issue is
settled in my mind.

-- 
paul-moore.com
