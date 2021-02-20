Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0426BC433E6
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Feb 2021 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34BD64EDB
	for <linux-security-module@archiver.kernel.org>; Sat, 20 Feb 2021 14:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhBTOmj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhBTOmi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Feb 2021 09:42:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE0AC061786
        for <linux-security-module@vger.kernel.org>; Sat, 20 Feb 2021 06:41:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p2so15807852edm.12
        for <linux-security-module@vger.kernel.org>; Sat, 20 Feb 2021 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcMXzHETlziskFHmDJ+qkZLeneeQpeM7XNw3uJBtD+c=;
        b=zk0Biby6NMxEZ6ecW0PWpgn8ZAopV4xiduHkt5Y+g3jLy3ocDGq+UmmxovqEVr5Vuu
         WuFDzXipTa6VtxmlSQXVdRfkRKHHhQSI6y6wxob9XH0u4hkWEqF2m1VsdO1PiR7p4esk
         a007+B5AkQjVjRwe3u/D1kjwTDTxhi336ukxIr3f78nhvjgy+Y4x1EL+mgw1G+RruO6W
         fK6vmqOsRvYwbcmUefiudl0G7zYN5CSWWfdRDOnHdjiYhygTd+HjLdrmzBCpeIHarsDn
         4rxU2yJCssHDB18gLnYebSjl8zQB+JVEWR6Ek+tLGlQ7KsTvvsTrQ5m8BD2AlmWVYdfY
         wnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcMXzHETlziskFHmDJ+qkZLeneeQpeM7XNw3uJBtD+c=;
        b=Q0H/Oi7YeJd0qyX882CwM3FwfNxfTNEBnn5tF2fQXpaVS6PRXdSQql4fCNos/1mXIE
         7i1teYiPwfwUNzxUSXK/Tw3P6dQoYPK007GyXILYwhOWCWfkA80YLU8j05YKENWfkqBQ
         fxYJ26zBqcLQuhyn/iDCwk0l1QC4Ro4pOMkYjzJABYOwhdGpMHrnVRQKcx2oU1dVBDD5
         C6oy3u0/j9kZ1HqCFGC+Yp8B8rjKdpkT4j9NiF1v/uQsrS3Iy/6pHIe28VvwPIYezLH0
         f6V1SZ4NTuSDGF9PhHEbU2xH5HQYN9qofh9TzI2iJFN0auaW/keoqBfEqEqaRsbdKGJq
         fkLg==
X-Gm-Message-State: AOAM532ZTcc0BBkhjJLTG0ld8TBs5Ffs69Zze6LifZC9wVf71E1BMS5e
        k7SN2MyL0Lw1b9KpGP9l0uLxp6W2LimePGBnhf600WR5PIng
X-Google-Smtp-Source: ABdhPJxxLAZLt/puGXEZyNivaEvDVegaTzTNADNqggY/6U73kUDTWgCF0vyCCU1n+fkOfxsvgqCtQWMRbxJG7KkTEHs=
X-Received: by 2002:aa7:df0a:: with SMTP id c10mr14279765edy.12.1613832115287;
 Sat, 20 Feb 2021 06:41:55 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl> <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
In-Reply-To: <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Feb 2021 09:41:44 -0500
Message-ID: <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj variants
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/19/2021 3:28 PM, Paul Moore wrote:
> > As discussed briefly on the list (lore link below), we are a little
> > sloppy when it comes to using task credentials, mixing both the
> > subjective and object credentials.  This patch set attempts to fix
> > this by replacing security_task_getsecid() with two new hooks that
> > return either the subjective (_subj) or objective (_obj) credentials.
> >
> > https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
> >
> > Casey and John, I made a quick pass through the Smack and AppArmor
> > code in an effort to try and do the right thing, but I will admit
> > that I haven't tested those changes, just the SELinux code.  I
> > would really appreciate your help in reviewing those changes.  If
> > you find it easier, feel free to wholesale replace my Smack/AppArmor
> > patch with one of your own.
>
> A quick test pass didn't show up anything obviously
> amiss with the Smack changes. I have will do some more
> through inspection, but they look fine so far.

Thanks for testing it out and giving it a look.  Beyond the Smack
specific changes, I'm also interested in making sure all the hook
callers are correct; I believe I made the correct substitutions, but a
second (or third (or fourth ...)) set of eyes is never a bad idea.

-- 
paul moore
www.paul-moore.com
