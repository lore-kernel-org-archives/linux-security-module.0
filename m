Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7E0C388F9
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 12:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7022202
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 12:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvEOlY46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbgJ0Mvy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:51:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42927 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbgJ0Mvy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 08:51:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id h20so1605153lji.9;
        Tue, 27 Oct 2020 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftk1EYAFLOBR6UlEa4OpWRTYRPIM3tkKJGAeflcbmic=;
        b=NvEOlY46HtypZNbSAOEr4+nLo2M2E1I8caU/D754l2qRDHg9QLSDC3V/cxFRuef+5X
         G8M/irG2x4w68zuSfLEsrtWb6SxbvPjLi4FLqAswQR+KYk2XsXklHpsEh6LJX9ZW/T2j
         W3ZPw/wux6ErhTCiRC8dWfmjauAc/ceWmLAkaQ53HJrXSr870Afs9doQP4NfgRzz/Afz
         0z1kldssWecLJaKBbkrBMNaU75xuwTjJQa/5F1YzQtQo7qbD/BoAuPIg61uTQtJ6uQhT
         euiJziC/JcI5DtN422sWeFz5GXQEJTSLU1XDtevAmcKLYZ9MshwuFZj1qepKZ1cSebRi
         tNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftk1EYAFLOBR6UlEa4OpWRTYRPIM3tkKJGAeflcbmic=;
        b=WQ+hvX8wqdsufT5keVDd+w1P0U9Qo3CL8K9nAthYHXT031Lt47T5GI8AKEQuWyOdXH
         BXrRqt5cJ4dvDypS/zQpS51DHxh7j3G67x4xmdVi08FFzEtm64ukdfom7hTN0i8R0kFV
         TDAwvDOj5/uUsWV8mmqFeo4E32sKNT9a4Ut9LBTdzjad8mHLFT0PUhXfDpcbt8AEEvDq
         zu2RNdFM2PatqSU1knrw8C7P14M46JE/2ZNjP3RiSA3n/mdRh3GtWOX5lkbWYtrjFYDx
         BGfGHb75h2vQv8LIOB1x4qMscuDOOwRVldHsz9+mqOHS9tEIws/0437FFG61w0XFRO5N
         O5kg==
X-Gm-Message-State: AOAM5313raAK1xl011rC7sqQ/w6ljm3FtzlKsgXnkonzWkV53/Fe88k1
        7coaComFaFBx4kgZk6ihF8M=
X-Google-Smtp-Source: ABdhPJyWESS0V1Yw/BaoR3MKB+XrkvfG7YRHUTkgWdpMoFr0aLGE6RrhP2frUetzQwiPGCcFS6R7kA==
X-Received: by 2002:a2e:3112:: with SMTP id x18mr1050673ljx.149.1603803110624;
        Tue, 27 Oct 2020 05:51:50 -0700 (PDT)
Received: from grain.localdomain ([5.18.91.94])
        by smtp.gmail.com with ESMTPSA id 21sm166406lfd.272.2020.10.27.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:51:49 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 2ABF41A0078; Tue, 27 Oct 2020 15:51:48 +0300 (MSK)
Date:   Tue, 27 Oct 2020 15:51:48 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: Inconsistent capability requirements for prctl_set_mm_exe_file()
Message-ID: <20201027125148.GA2093@grain>
References: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 27, 2020 at 01:11:40PM +0100, Michael Kerrisk (man-pages) wrote:
> Hello Nicolas, Cyrill, and others,
> 
> @Nicolas, your commit ebd6de6812387a changed the capability 
> requirements for the prctl_set_mm_exe_file() operation from
> 
>     ns_capable(CAP_SYS_ADMIN)
> 
> to
> 
>     ns_capable(CAP_SYS_ADMIN) || ns_capable(CAP_CHECKPOINT_RESTORE).
> 
> That's fine I guess, but while looking at that change, I found
> an anomaly.
> 
> The same prctl_set_mm_exe_file() functionality is also available
> via the prctl() PR_SET_MM_EXE_FILE operation, which was added
> by Cyrill's commit b32dfe377102ce668. However, there the 
> prctl_set_mm_exe_file() operation is guarded by a check
> 
>     capable(CAP_SYS_RESOURCE).
> 
> There are two things I note:
> 
> * The capability requirements are different in the two cases.
> * In one case the checks are with ns_capable(), while in the 
>   other case the check is with capable().
> 
> In both cases, the inconsistencies predate Nicolas's patch,
> and appear to have been introduced in Kirill Tkhai's commit
> 4d28df6152aa3ff.
> 
> I'm not sure what is right, but those inconsistencies seem
> seem odd, and presumably unintended. Similarly, I'm not
> sure what fix, if any, should be applied. However, I thought
> it worth mentioning these details, since the situation is odd
> and surprising.

Hi Michael! This is more likely due to historical reasons:
the initial version of prctl(PR_SET_MM, ...) been operating
with individual fields and this was very unsafe. Because of
this we left it under CAP_SYS_RESOURCE (because you must have
enough rights to change such deep fields). Later we switched
to PR_SET_MM_MAP which is a safe version and allows to modify
memory map as a "whole" so we can do a precise check. And this
allowed us to relax requirements.

As to me the old PR_SET_MM should be deprecated and finally
removed from the kernel, but since it is a part of API we
can't do such thing easily.

Same time current PR_SET_MM internally is rather an alias
for PR_SET_MM_MAP because we create a temporary map and
pass it to the verification procedure so it looks like
we can relax requirements here to match the PR_SET_MM_MAP
call. But need to think maybe I miss something obvious here.
