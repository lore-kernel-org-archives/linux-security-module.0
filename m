Return-Path: <SRS0=cN3+=7Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6DC433E0
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 00:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643B820757
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591144313;
	bh=ZFZ50+cfovPyZG+Z87lR5GTVuve0aKAAjV3/T3oj86k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cSIRLUiIsI8nZBAoFn8Dl9NX9/NVXVWuyFBKqGjTdBSWOkRVwWCnfCJ1EADb2/dMW
	 greSlaOOl8xbv66y5uQvJqE8B7jJ27D8FBSLUpC/2wPcBxuwodRAIn9lRZhdt7Qse6
	 CHS0WPCMQBvIu01MU5Lyz0a2MIIWC4ILEeBvbUdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFCAbw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCAbw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 20:31:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB7C08C5C0
        for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2020 17:31:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a25so520929ljp.3
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y05Eb9eafJ0NXvQYL09qhaAipJ12OeTgF1kVh6EgfnQ=;
        b=BIdCjuRkcZ6AtUKiMEcL/bPMx/D1bItwVGJFF1ZfEiSaScUoFvZ1ZZsl3PQqkbQ7I+
         1pgdNd5VxSPlPrPUxZOkdE8JL51bKGr0g+MkbxHFdq1zz9DHgwUHcu6VSzZYXPad+csj
         3uML97UaIPUm1p1BiOICKjeYpqfWTK6nFQlZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y05Eb9eafJ0NXvQYL09qhaAipJ12OeTgF1kVh6EgfnQ=;
        b=cv6WK+tGn8egPuDzaukuqDWmqJywngokOBbnQDyFlogY3d2NBjht5SEfCfMbGsj24w
         C5KpRJfCmIRU3g7n0EpJjDAcksWN4hfJt92EiJGZclSgergztjKUBHAP/AliJZPLUiSk
         4iunrS2pKvudtjQ1DxtZfZxkbSYVfSIfLlYMTshamMXzeTtn2MXrUfxa9+SL1D5n2RUX
         vxCE2cOeLrWgeccyEM2FQyLVpmykushOIyerzzxXUhx5XLxN453LdzgimSEsZJOq5VMZ
         sGW2/Elt4uQ3uyHDrViuJ0WEDXEMT0ic8sC9ilASQCBTZDWTSxVk03MRH9snI34SPs8q
         6DCg==
X-Gm-Message-State: AOAM532Olnd0KedbIebRUazWRhhPCk/nzMslulLDrvcsQ71fk15/J9e4
        YrpVa5lblsBXW4MCNL0y3i9ia0/pnEQ=
X-Google-Smtp-Source: ABdhPJwV+C5Ia9ttFG/TwARv1TQC6DJdwo3T90YCvSwiVRZc3g56YTHdBGDWiNIObMM45kJjSBFJMg==
X-Received: by 2002:a2e:6c12:: with SMTP id h18mr815974ljc.62.1591144309956;
        Tue, 02 Jun 2020 17:31:49 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d16sm91860ljh.97.2020.06.02.17.31.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:31:49 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id z18so463373lji.12
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 17:31:48 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr702860ljo.371.1591144308329;
 Tue, 02 Jun 2020 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
In-Reply-To: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
Message-ID: <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 1, 2020 at 6:07 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - A number of improvements to various SELinux internal data structures
> to help improve performance.  We move the role transitions into a hash
> table.  In the content structure we shift from hashing the content
> string (aka SELinux label) to the structure itself, when it is valid.
> This last change not only offers a speedup, but it helps us simplify
> the code some as well.

Side note since you mention performance work: in the past when I've
looked at SELinux performance (generally as part of pathname lookup
etc VFS loads), the biggest cost by far was that all the SELinux data
structures take a ton of cache misses.

Yes, some of the hashing shows up in the profiles, but _most_ of it
was loading the data from inode->i_security etc.

And the reason seemed to be that every single inode ends up having a
separately allocated "struct inode_security_struct" (aka "isec"). Even
if the contents are often all exactly the same for a large set of
inodes that thus _could_ conceptually share the data.

Now, it used to be - before being able to stack security layers -
SElinux would control that pointer, and it could have done some kind
of sharing scheme with copy-on-write behavior (the way we do 'struct
cred' for processes), and it would have caused a much smaller cache
footprint (and thus likely much fewer cache misses).

These days, that sharing of the i_security pointer across different
security layers makes that sound really really painful.

But I do wonder if anybody in selinux land (or general security
subsystem land) has been thinking of maybe at least having a "this
inode has no special labeling" marker that could possibly avoid having
all those extra allocations.

Because it really does end up being visible in profiles how costly it
is to look up any data behind inode->i_security.

               Linus
