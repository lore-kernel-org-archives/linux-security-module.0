Return-Path: <SRS0=2B8k=XS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE0C4CECF
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Sep 2019 19:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772DA20B7C
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Sep 2019 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569266920;
	bh=CHTUM5qN0A/+/Vv+y3/qzY0L6jibsQ4Sqi6RrHUuzNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t1uGxSGtXYAzz/dzA5M74tIeiHGSRH/vTGP+BchyrmYqSr66npC8VGdza5THnZYgW
	 /oD7Xet0l8R6kq7C1Z1v1pmSaHDAkJJb7+gLw3BWtBJvGihkcJh0bWLhW0UZIEz2+B
	 +jkOoYHUCCrGag9aeqKMbEtro6UQrX97rSjfZfFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfIWT2j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:28:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41721 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfIWT2j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 15:28:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id f5so14888255ljg.8
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHCBm/1jGmQwHbU3E0NMphnn1MxQoT3D3BrUANEfkOQ=;
        b=YmtIQM7n5dLYeJlfCVJ+MLwa5thzJ1ho3tngibt6UbSJkJPTQph1Vu2oFAv8ZLBEaN
         HEgNm5xkLBRGq23jgSJXV6Q9UkhNxsip0g20ZmKDNUdmDZhw8MtidquZ9VF6aL9TIqiP
         i8RkBSi926RqOawjghgbl4ZvL+ejQt7wCqw+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHCBm/1jGmQwHbU3E0NMphnn1MxQoT3D3BrUANEfkOQ=;
        b=UmYbExsKMBH1rvyv7KjN99U0RuB2FI4q2ALAcY6TTa5A9KI14yO52pFcyuHj3K3aOr
         mzaWmP9Az8x0/Zh+Jf3Uz1FdjckCH+vAEwlgGND9qqzraglqry3/KK/GKVuIlsS2x2i/
         +vCtXttlvhUeCTxdFHPuGbI3wJ+m/gVw1cVABfGeIwRcjN1wEikTe6X49aYk9pYxYwna
         GlFh2ACZC40PLQpywn6+3ZzL4EjOsHT6qN3daqCrRo8KD8GUbyyepwqE9YJohraJvflk
         fxaobnA2DzDFx1TSzeMNApsCbWIqaX5zDcPpS2qv1ZJP4Ph/S19iSJl/DI2pqERR033U
         Bcbg==
X-Gm-Message-State: APjAAAUe1NHHiyyLg34Pjk+RB4muQErpjKVdvLw8lOtqUMPaSYMXA2lf
        R8eAP4VQFnfGHMGGDCvkyg/zgKgptMQ=
X-Google-Smtp-Source: APXvYqwZ3AvWXkc+gazpY5ByVE9+hhZWFUrRZF4a9s8m93gFHb3HWjS6+NxiKY1hLHhCaiHlXfkHjw==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr576959ljd.224.1569266916552;
        Mon, 23 Sep 2019 12:28:36 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id q21sm2395967lfc.2.2019.09.23.12.28.35
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 12:28:35 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id e17so14829500ljf.13
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 12:28:35 -0700 (PDT)
X-Received: by 2002:a2e:1208:: with SMTP id t8mr584695lje.84.1569266914859;
 Mon, 23 Sep 2019 12:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 12:28:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
Message-ID: <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 12:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, this bug would likely had been avoided if rcu_swap_protected()
> just returned the old pointer instead of changing the argument.

Also, I have to say that the fact that I got the fundamentally buggy
commit  in a pull request during the 5.3 merge window, and merged it
on July 16, but then get the pull request for the fix two months
later, after 5.3 has been released, makes me very unhappy with the
state of safesetid.

The pull request itself was clearly never tested. That's a big problem.

And *nobody* used it at all or tested it at all during the whole
release process. That's another big problem.

Should we just remove safesetid again? It's not really maintained, and
it's apparently not used.  It was merged in March (with the first
commit in January), and here we are at end of September and this
happens.

So yes, syntactically I'll blame the bad RCU interfaces for why the
bug happened.

But the fact that the code didn't _work_ and was never tested by
anybody for two months, that's not the fault of the RCU code.

                  Linus
