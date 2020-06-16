Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA77C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052C220707
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 10:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1rU4R3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPKT2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPKT1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 06:19:27 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68EC08C5C2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 03:19:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id h3so18233351ilh.13
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kqbimwgEbOIJYJLWKEaCLp58PXChrceFH9NU0EWRhU=;
        b=M1rU4R3TTMMpixDbLk8vBQdiLBBdkyl/aqI2TNZz5CijvpcUThXzf7nyPto9iuemPX
         DSXchy0Wmvu+MsrVPfMrqvhs2B4wzYuS50D5Bn228HIHQ6J653ZiciJasPxA6BQVxY8q
         +2S9WcAlCxrPm3bu2WnfIG4rs84SEx3R228KD9aR3gAohvJdn9QaySDUe36PzFp3dyAU
         UTv9z5+efyF21/cXF+A8hrr+ONGO+DC9QuGJoNKq35h39I+sUT2M3wbIFy78L9oG+EpZ
         7+KpSneFk/iJleviiW5zpPrsXEbidakr3uD6luITC1HyWTVbKArKedZ+jZYsPF+kWRLt
         IszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kqbimwgEbOIJYJLWKEaCLp58PXChrceFH9NU0EWRhU=;
        b=BVZMdBep+ZmF5Rw15iHobsTCBaRaOZR5skperUao25AKQ6pxr+6XWxLFeeKhwa4iNr
         c44K5dAwEnqhJt8Ex6WUthj7yEbTKu0gLyOurpfZLGErJahKqOawMGN3g04Q26hOzzZ1
         RuoV+WaPboqsp0YX4sFjDnQ4IQ2+gWrIID5YVYZ7srwTX0rx1JHcs/B5qLh9e088Tj02
         VwMarmGBf7bJcJ0yu4RWVWsNNjHIezSkzmLbWo6070PQyGWjVeAOHd4dqU+yIYRXXrxo
         fC2I3xXsd9QoObyR+NVJ+4gbipTMmXVK+qrPHoIVyEHM/Vpc/XRD3YocPOk5QnFc/w0w
         3TPg==
X-Gm-Message-State: AOAM533MSmfYmKJhf2D864dEI5zGVfm/AUC2m2DWrKznE9iRkUTnXC9K
        RLIZPfaDt2ifESIYRz+7Q5Y0s6vXc2lXVInWwdVYwhHyp53R4g==
X-Google-Smtp-Source: ABdhPJzrGDFJysUCJVNDR5nvOXo7oba4sfOSKBTxtSj3Ckx5zUmbQFAyRZXIJSwxtsNcLB0I7RWmlLHIfQrJfeQ67eg=
X-Received: by 2002:a92:a112:: with SMTP id v18mr2185623ili.278.1592302766529;
 Tue, 16 Jun 2020 03:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200616083435.223038-1-glider@google.com> <20200616100309.GA2614426@kroah.com>
In-Reply-To: <20200616100309.GA2614426@kroah.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 16 Jun 2020 03:19:15 -0700
Message-ID: <CANP3RGckq6_kMLzS-Yp5ottH4fm9Z3BQo3dbY1fMiQKiRMPbPw@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        yamada.masahiro@socionext.com, Kees Cook <keescook@chromium.org>,
        jmorris@namei.org, Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module@vger.kernel.org,
        Kernel hackers <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> Nit, your From: line of your email does not match your signed-off-by:
> line :(

This is *probably* a matter of configuring git:
git config --global user.name "Alexander Potapenko"
git config --global user.email "glider@google.com"
git config --global sendemail.from "Alexander Potapenko <glider@google.com>"

> Gotta love the name...

I've just read through a long discussion thread on clang dev (got
there from this cl's llvm link)...
There's a lot of interesting info in there.  But ultimately it seems
to point out tons of projects already use this or want to use it.
And there's security and stability benefits for production builds,
while pattern mode can be used for debug builds.

> Anyway, if this is enabled, and clang changes the flag or drops it, does
> the build suddenly break?

(my understanding of the patch is that the option does compiler
testing before it becomes available...
in at least some of our build systems built around kbuild the option
going away would then cause a build error due to its lack in the final
.config)

> And does gcc have something like this as well, or does that have to come
> in a compiler plugin?
