Return-Path: <SRS0=pLHH=QW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8D0C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585372192D
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBOPp4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:45:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42669 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfBOPp4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Feb 2019 10:45:56 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so17159259oto.9
        for <linux-security-module@vger.kernel.org>; Fri, 15 Feb 2019 07:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OiCgqlERhhojQuaFlWk/LlZgoAbDJtdNlcO0vs8HkM=;
        b=tKx88sm5t+q9yY6Gyex1pkkzd2vcP+gV7rELb5JpPKjR5zpNcxQjdODVlOHG7Lnlea
         si66v9+r9YDr2QFuFAF5jPzPLe1Sif4eYG7iqgYsRqMtUF5cLsRZaG7zVbPXvzqmHDrU
         yi4VkNQ0SdjZmv9Dv682Xq+CcIJ6EeWURUt0PGcfoOwKJ9TVcXE1JLHy0uxD8orXYRhb
         Um8YGuSBw/bx533paLkfJGz5cBBuMxeqWmLdAwJuMo70WBgn0GvBKfxtWdbM2FvsT8rB
         69OspJlM8y+yRuB8dKgeOF2vGbpk09bSP91Y9K9PyYFFGTgLkdX0MHc1gFjYCKmmoj9l
         xV/w==
X-Gm-Message-State: AHQUAuYpEAGhfGPf/MeSi33wF81wfQdGskNstJ+Zz1gAdUyfcAtFv664
        ptYjAu9CFARymGj+SCBxYSb1HRHZK2SPj9YPY+Y9ew==
X-Google-Smtp-Source: AHgI3IZbTXM8UMmJZmoaY8bD89J2iU4YE3o8lshMkXFG+2DNiHqslsMAj8CiiHgaFw2Iz9v22GMpkz4nhKWpLK7KSjo=
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr1009244oiy.166.1550245554986;
 Fri, 15 Feb 2019 07:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20190214095015.16032-1-omosnace@redhat.com> <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190214154854.GO50184@devbig004.ftw2.facebook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 Feb 2019 16:45:44 +0100
Message-ID: <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
> On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> > +static int kernfs_node_init_security(struct kernfs_node *parent,
> > +                                  struct kernfs_node *kn)
>
> Can we skip the whole thing if security is not enabled?

Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
is easy to do and I can add it in the next respin (although the
compiler should be able to optimize most of it out in that case).

If you mean dynamically checking if calling the hook would actually do
anything (i.e. if any LSM actually registered that particular hook),
then that should also be possible (just check if
security_hook_heads.kernfs_init_security is a non-empty list), but I'm
not sure if that wouldn't be too hacky...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
