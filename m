Return-Path: <SRS0=T836=S4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B768CC43219
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 00:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD2B206C1
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556238628;
	bh=ZsIbUeLOxUI7bxZ1I5VzBXBiV9Win2BFl2iIJvXToNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mcA2Cq46nMXmbvi1u3AXqMeU4JnMwOSceCdsLy4BRlFoXZmGKBbqsWX8dtUZuqy7z
	 2xN0Na9qGkYEN7HTYOEplEg7lR1K2xNb+FBH3ErH89p3Uzma2s+sNfdZbQurO+bbYU
	 ilRM3emCDdH2vpkUjxoWLiWar/4tnM8rxe/k9h5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfDZAa1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfDZAa1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Apr 2019 20:30:27 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B61B206C1
        for <linux-security-module@vger.kernel.org>; Fri, 26 Apr 2019 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556238626;
        bh=ZsIbUeLOxUI7bxZ1I5VzBXBiV9Win2BFl2iIJvXToNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iJrHk0kZ/gFNcHup+yJO1IU/jiKvq8UcCebL6oFhxQKeGUYldajgOXnb8Lm30cTvi
         qoug8qHyBklQTma6MI254eyqpURUHLsu8dWN1BxqRUCLiFTDBS4nAUlWh4w+ABxbe3
         DPkxUu30oTX2FPFGPWHA277miT6mNp7tgeqvVZVA=
Received: by mail-wr1-f51.google.com with SMTP id g3so1842623wrx.9
        for <linux-security-module@vger.kernel.org>; Thu, 25 Apr 2019 17:30:26 -0700 (PDT)
X-Gm-Message-State: APjAAAXAVcgdP+PS3zDTV3v2NlMYfGiC2+7VklEZ0N/iJ43LKLcCj2hk
        cicWBCDMvr2lejXoz2RTM05PwVs3JB7dqEkmSf49YQ==
X-Google-Smtp-Source: APXvYqxbTskaCiO3hbeKzbx/74RUetFFRSKpivliZ4T8CAe9gU+OYeZj1yN2RbB4/grljATC54DI2BoSF0qT+eHhBmU=
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr12902589wrw.199.1556238625152;
 Thu, 25 Apr 2019 17:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Apr 2019 17:30:13 -0700
X-Gmail-Original-Message-ID: <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
Message-ID: <CALCETrWkYYh=L1nSO7GYt0FvMhjCcEaQiM2JEi3FfkJbYJFh2g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] x86: introduce system calls addess space isolation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 25, 2019 at 2:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi,
>
> Address space isolation has been used to protect the kernel from the
> userspace and userspace programs from each other since the invention of the
> virtual memory.
>
> Assuming that kernel bugs and therefore vulnerabilities are inevitable it
> might be worth isolating parts of the kernel to minimize damage that these
> vulnerabilities can cause.
>
> The idea here is to allow an untrusted user access to a potentially
> vulnerable kernel in such a way that any kernel vulnerability they find to
> exploit is either prevented or the consequences confined to their isolated
> address space such that the compromise attempt has minimal impact on other
> tenants or the protected structures of the monolithic kernel.  Although we
> hope to prevent many classes of attack, the first target we're looking at
> is ROP gadget protection.
>
> These patches implement a "system call isolation (SCI)" mechanism that
> allows running system calls in an isolated address space with reduced page
> tables to prevent ROP attacks.
>
> ROP attacks involve corrupting the stack return address to repoint it to a
> segment of code you know exists in the kernel that can be used to perform
> the action you need to exploit the system.
>
> The idea behind the prevention is that if we fault in pages in the
> execution path, we can compare target address against the kernel symbol
> table.  So if we're in a function, we allow local jumps (and simply falling
> of the end of a page) but if we're jumping to a new function it must be to
> an external label in the symbol table.

That's quite an assumption.  The entry code at least uses .L labels.
Do you get that right?

As far as I can see, most of what's going on here has very little to
do with jumps and calls.  The benefit seems to come from making sure
that the RET instruction actually goes somewhere that's already been
faulted in.  Am I understanding right?

--Andy
