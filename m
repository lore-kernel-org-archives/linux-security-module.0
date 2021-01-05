Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB5C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Jan 2021 20:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B53322D75
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Jan 2021 20:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAEUjb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Jan 2021 15:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAEUja (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jan 2021 15:39:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5F6C061574
        for <linux-security-module@vger.kernel.org>; Tue,  5 Jan 2021 12:38:50 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x20so1459761lfe.12
        for <linux-security-module@vger.kernel.org>; Tue, 05 Jan 2021 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fg2ptfYhMp275EJ8aZPMAK34P1NI/LW/B7PJd9XCtM=;
        b=XbqOfD/7D5bjtgFzF0RQNHSxNzsX0vBTIJAUlv110w8Ep1C+9bm8nFfgltldIE6Am5
         8mrpdAMXEwDOuIO3/ajMYWKQuH7qEeNQ1YqyUYoseneP8Y3bDQmjNsFWvaTlILPhrgug
         NsgsV3TmxKXugXsqWczid34qwfeDVB8UtgcMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fg2ptfYhMp275EJ8aZPMAK34P1NI/LW/B7PJd9XCtM=;
        b=umJ5d9QxX79vJq2RmDfjCKr0Cv5Cppu2np3njoV1Rr235x7TqqAjh/3cZK8nLB0ner
         lYPfE6TvfjgqaKhqOZ/qnROaHHYd4orRJt0BRmfSgUTDcgAxC52FItuu9U8U6xC+fgXj
         fms4H0Fm//D5F8/dgEgfa1Y6CRBWL7SSTeqt41hWtufOEyLbPdb1OLbF3FSv2rBDDWVA
         rrOAAl8y60aTqCGavZTwOY938Vqpr/akoPwQ6hkR+NRLxK+12NQ2pQ94V9wXGKlyFWWt
         xOz73R7oX22baNMKZrYRGnzYsyQWZ5+ylL2nVyHCQXp/EghfubnAuamM0W5GOdG4B1+x
         9Vsg==
X-Gm-Message-State: AOAM532B0fWXFyCX++jAcIefXg4Nb41XmN4ZXTaotS9ERp3u9MaqavcZ
        R2dtk74zYPTG8Tp2J1J2GzZGm/FrELTPWg==
X-Google-Smtp-Source: ABdhPJw1STJn35ZuC50mbpUHx32ekAcbXdCVMzUuwu4qbAtih6jrQ6r6hTJsLdjTILy00gAO7cUjEg==
X-Received: by 2002:a2e:7d18:: with SMTP id y24mr635707ljc.384.1609879128568;
        Tue, 05 Jan 2021 12:38:48 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 11sm27497ljf.53.2021.01.05.12.38.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 12:38:47 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m25so1474570lfc.11
        for <linux-security-module@vger.kernel.org>; Tue, 05 Jan 2021 12:38:47 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr444303lfb.421.1609879127184;
 Tue, 05 Jan 2021 12:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk> <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210105195937.GX3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 12:38:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP9EAP=JHGKG5LUCusVjVzTQoPVyweJkrX5dP=T_NxXw@mail.gmail.com>
Message-ID: <CAHk-=wiP9EAP=JHGKG5LUCusVjVzTQoPVyweJkrX5dP=T_NxXw@mail.gmail.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 5, 2021 at 12:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We are not guaranteed the locking environment that would prevent
> dentry getting renamed right under us.  And it's possible for
> old long name to be freed after rename, leading to UAF here.

This whole thing isn't important enough to get the dentry lock. It's
more of a hint than anything else.

Why isn't the fix to just use READ_ONCE() of the name pointer, and do
it under RCU?

That's what dentry_name() does for the much more complex case of
actually even following parent data for a depth up to 4, much less
just a single name.

So instead of

                       spin_lock(&dentry->d_lock);
                       audit_log_untrustedstring(ab, dentry->d_name.name);
                       spin_unlock(&dentry->d_lock);

why not

                       rcu_read_lock();
                       audit_log_untrustedstring(ab,
READ_ONCE(dentry->d_name.name));
                       rcu_read_unlock();

which looks a lot more in line with the other dentry path functions.

Maybe even have this as part of fs/d_path.c and try to get rid of
magic internal dentry name knowledge from the audit code?

                  Linus
