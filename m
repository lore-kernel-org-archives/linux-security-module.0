Return-Path: <SRS0=8q/C=DX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3855C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Oct 2020 00:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EDF206CA
	for <linux-security-module@archiver.kernel.org>; Fri, 16 Oct 2020 00:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egXQczmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbgJPABn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Oct 2020 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbgJPABn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Oct 2020 20:01:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2DC0613CF
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 17:01:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x1so515703eds.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2020 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/1IntEkdWKImHNOT+qrBdO4BgCV+2jRbRdBJi8ptLs=;
        b=egXQczmuoyRvh6M/he1kd7PQ4dgg2oOgmQXK19ba+2lhe626jeXg8WMf0DaPeWUlVC
         bUhHRXqbb1VNrT4Xb2gNjmbxJBPbt43FrX+vt8ZKUWg3wiBoChwuc1jzxh4bevC9sR/8
         Re5O8J7oGzKbfCI5ZLYWjILsESNlNbH27JNVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/1IntEkdWKImHNOT+qrBdO4BgCV+2jRbRdBJi8ptLs=;
        b=ErcWXcE7CeAnkoOJXD/74DHyARvEpLU8o/eTnkY0MZSDnbgbhzNECZwcRzexlt1TIh
         SYvlaamQGSGXuMeu3jl5GY1c+xNUbKdrxyveS1yeZbmdB3sJ+HDUTrXQVRPMCeVDQR0G
         IvsvpYOBpRGZ4wbH8t8egxkrQDnn9NWxSpA2lyVaCQIiJ3NvpXmatMLAhZun9J87S8/r
         yZjmEnr4RLHC4KxLTaOc51VwnnvbB4j9Fw1Ug1einTnM/LToBqyhXh4YTBncOqDNHrWZ
         qELn6cxfAZEthuWbK1yaXi2cY4cae3Hmqc2NRRBsoGQgX4dRe8IRlC8pvOrNMdaoiwfR
         6PMw==
X-Gm-Message-State: AOAM531bEqqs3m1ZqlxED5e32htfaVjXhO63XjLmr2NIHtNJnWX8jUvD
        Dcu1ZLAT17Y7BtiuoF7j77PUEGo9PsYz0v8ovACyCgtuki8Pcg==
X-Google-Smtp-Source: ABdhPJwfQrrcT6QUMBHBgIm/m4g7SUq0+p4qrE08K2xMTDwSO9lwXA2IPSiEEa8yuchfyZh3lCSWC1CNlrA5c14ypsc=
X-Received: by 2002:a05:6402:602:: with SMTP id n2mr969028edv.327.1602806499816;
 Thu, 15 Oct 2020 17:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOQxDjSgUL0AsCywoKDbOUNWDyxCKHQc+s6+ZemUh9Uzw@mail.gmail.com>
 <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
In-Reply-To: <CAHk-=wg3kHxMP67XmQyCg7J+KfFgAsQqj1goUa3dKR-A812ZbA@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 15 Oct 2020 17:01:29 -0700
Message-ID: <CAJ-EccPLAD5TGg=KQ-m54ymrVdd++Dg7A_UR+v535iOVRsDe4w@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 15, 2020 at 4:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> These were rebased since the merge window started, for no apparent reason.
>
> Were they in linux-next?

Yeah, they are changes that were originally targeting the v5.9 merge
window (and thus were in -next during July/August) but I didn't get
the chance to send a pull request for them. Since I didn't touch my
-next branch since then they are also in 'next-20201013' and
'next-20201015'.

I just rebased to v5.9 to make sure the 1-line changes that touch
kernel/capability.c, kernel/groups.c and kernel/sys.c still applied
cleanly without conflicts. Should I have rebased onto one of the -rc's
for v5.9 instead?

>
> And if so, why was I sent some different version?
>
>              Linus
