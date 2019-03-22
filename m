Return-Path: <SRS0=snF/=RZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A933CC10F03
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744682075E
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mDVknPG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCVWpT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:45:19 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46527 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfCVWpT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Mar 2019 18:45:19 -0400
Received: by mail-ua1-f68.google.com with SMTP id j8so1261676uae.13
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2019 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIWF5r+FeAyzFbB/tkDZ1Cwr2CHIZ4gIs+pbAdf62jk=;
        b=mDVknPG/ZmQ9thZGsga0cOASQO6ss/HgUzvEnM228t8RAHZw3hWN8WerQSRw/M9Afm
         roKYwxtmePMDQjQOFiG9eDPcbxc5qIXQ7j3PQuRoY0gRF/zV6uqJU5O6ZmaTOayzTu0v
         AMvnzZz7mA8KuTsxqEOUEc743wS0ObEQ1FXDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIWF5r+FeAyzFbB/tkDZ1Cwr2CHIZ4gIs+pbAdf62jk=;
        b=TkUy4zr/wMgEjqdgJZ5G+rvT5Bbppc1rQTVOS3bAaQYQDG7tXWmFFQXxq4L6cwWMn9
         OfhL+jlKUn6VzRtvwGqj8HxYvLkC26x2X94PRUSjMbEorNFvNFd9PwRLs5PY3Xe8G88P
         yFzjvVABniGGFtNub+gpEULavoOfS21Zt6dgIjKrVnnta/IrMeNKgywsPEWsWU9TDT/j
         m7WoeLfu52gzISQZlXQTed/wcEeHPTHqK18gGF9Axkpk4AX5w4iUgzQuCWEAME0+IQi2
         9SIKtr32OLrDKiz7ocP3Mz2NWiGbEcjCJDSwpeSHl9N+s5NrkaIrs9+9I74QCvKvWUHE
         h5+Q==
X-Gm-Message-State: APjAAAUpM/LEHTfR4pM3KqCGlfLngfFxmIaUiiJyPa1c4O8G5eSfqq9N
        dhtwhquEPobLoSPKVSyN9Fj/w0+vk4I=
X-Google-Smtp-Source: APXvYqzkk/GETcOjtnLEjVCNfQ55EMFnWUJw0Hw3du0NkrOXhAq3ITqdLTqK0q/We72sNiZcTlUHvw==
X-Received: by 2002:ab0:164a:: with SMTP id l10mr7435944uae.116.1553294717914;
        Fri, 22 Mar 2019 15:45:17 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id d17sm2115967vke.53.2019.03.22.15.45.16
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 15:45:16 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id e131so817615vkf.10
        for <linux-security-module@vger.kernel.org>; Fri, 22 Mar 2019 15:45:16 -0700 (PDT)
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr3298849vkk.13.1553294715883;
 Fri, 22 Mar 2019 15:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190315110555.0807d015@cakuba.netronome.com> <20190315120105.5541ad46@cakuba.netronome.com>
 <20190315165440.53b9db3c@cakuba.netronome.com> <CAGXu5jKHRPuaALQcPXvpDeuVgZR+EeRqo9Qj4j3kYatb3HUSSA@mail.gmail.com>
 <CAGXu5jL-e7bDEXfpUuT-HyFarR-8T0djXChR0cuzTwFQPQ0tOw@mail.gmail.com>
 <f23d0fad-dc72-0e53-cac6-31abfd12a050@I-love.SAKURA.ne.jp>
 <bee1a774-461a-2535-a640-bbe65291e909@schaufler-ca.com> <2bf23acd-22c4-a260-7648-845887a409d5@i-love.sakura.ne.jp>
 <CAGXu5jKj-Pq4krHmKd__4MoXBe1FK399cDZnSxdPigZo78tPfA@mail.gmail.com> <e20bf21e-77b0-6403-51b6-3f174d45529e@i-love.sakura.ne.jp>
In-Reply-To: <e20bf21e-77b0-6403-51b6-3f174d45529e@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 22 Mar 2019 15:45:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKVQ=-mdMWsefuNDagwF3pQEiosb4niRx-gBKCmRK_h-g@mail.gmail.com>
Message-ID: <CAGXu5jKVQ=-mdMWsefuNDagwF3pQEiosb4niRx-gBKCmRK_h-g@mail.gmail.com>
Subject: Re: mount.nfs: Protocol error after upgrade to linux/master
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 21, 2019 at 2:10 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/22 1:38, Kees Cook wrote:
> > This is mostly good. I'd like to keep the other LSMs listed though
> > (similar to what I had originally) so that if a legacy-major doesn't
> > initialize, later ones will be. I want to remove the concept of
> > "major" LSMs. The only thing that should matter is init order...
>
> Excuse me? Are you saying that
>
>   if a legacy-major (which is defined as the "Default security module")
>   doesn't initialize, later ones (any of selinux,smack,tomoyo,apparmor
>   except the one which is defined as "Default security module") will be
>   initialized
>
> ? That sounds strange to me. Any of selinux,smack,tomoyo,apparmor can be
> initialized when specified by lsm= kernel command line option (or security=
> kernel command line option if lsm= kernel command line option is not
> specified), won't it?

It breaks the backward-compat for the "security=" line. If a system is
booted with CONFIG_LSM="minors...,apparmor" and "security=selinux",
neither apparmor nor selinux will be initialized. The logic on
"security=..." depends on the other LSMs being present in the list.

-Kees

-- 
Kees Cook
