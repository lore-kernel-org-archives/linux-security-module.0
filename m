Return-Path: <SRS0=7Wqb=3O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA13C3F68F
	for <linux-security-module@archiver.kernel.org>; Sat, 25 Jan 2020 18:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D9E2071E
	for <linux-security-module@archiver.kernel.org>; Sat, 25 Jan 2020 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579977948;
	bh=A7WTXqLdUu+CmDmtHBI7lHSK6Jj/P5gnEhhaLf29Mcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TH6j0J96CHDQnpS2U7ByR9ZbwMTLWOTLwmjkLUAHZBNrf1xwB3zHXkJLCjbmNB7D2
	 DjkaE9YpqtTvCf/91sJziaHulyiatpl4uMf2oOpWclj2VCFqxi2ALpblpU7LSQFutJ
	 8vmpgl8cySSxXQvz3eCNwjPCuMClzb0qL/VITfbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAYSpr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 25 Jan 2020 13:45:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43012 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAYSpq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 25 Jan 2020 13:45:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so6251025ljm.10
        for <linux-security-module@vger.kernel.org>; Sat, 25 Jan 2020 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agKBgndk3wOWKqvCTJf0yLyX2bJKGsFMAU50Ri7/n9U=;
        b=ebrkpC8lWGHzj/TTwQVlGmpfBj+LMhP3xc48s3IkdXLpfPBkmBQH8glAibN3NZzhJ7
         eaX+oPyIl6RK4Fcu/p33lei0jipvUcU+PHgqX1Ir4aJDuHlpLIX4SbceygCECD/xiFMl
         QwEsuOsJJnKRw8LKLW82q3yqXp++TF+4Q343k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agKBgndk3wOWKqvCTJf0yLyX2bJKGsFMAU50Ri7/n9U=;
        b=un155KA7huW3MyentLtJXEvE3VVvk2jmMrwRZD1TOLe9WpCKkMqRvZLKvbCVRNVlwI
         CcKWyC8n+J3q4q7KLynSMIpenKaoeT2SdjpxOCwOPc7x+1vc6dtKCXRwoCnNLVEie8+j
         OjHU80ZV11M1wH79Q0DR2DFRUNy/zFHz1rY/hGdne+AA7SifvQe6FSOy8GKyrWowyQEI
         gpydjsozqJqsC4PfBRFwwopCfXc3EZICUPOhjhdW/YtkGrpt8cgaqbhkWRWlAIIVq6Hi
         uq55y4K5G5cpLIrwbtHqvJTeDUZlfL3p7kFy+rESDDqNFe/wx/OJANLto+0k2kAx/ubZ
         4WlA==
X-Gm-Message-State: APjAAAWDR/92HCHm/XCpirWa9k6Cxh5iNkSVj09yNRuGuapSvTvOeVKG
        gKf1SSQRbEUabbx0r/5VqExneAHJ4HQ=
X-Google-Smtp-Source: APXvYqwZIrdQjjuLDpxbo8wwqBIo3QZUrvuRsZoVrSa9cn3T5+05YT7rYk8d4YblMccZRkRrT0IABw==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr5935851ljc.100.1579977943190;
        Sat, 25 Jan 2020 10:45:43 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m15sm5377576ljg.4.2020.01.25.10.45.41
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 10:45:42 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q8so6248536ljj.11
        for <linux-security-module@vger.kernel.org>; Sat, 25 Jan 2020 10:45:41 -0800 (PST)
X-Received: by 2002:a05:651c:ce:: with SMTP id 14mr2080983ljr.241.1579977941361;
 Sat, 25 Jan 2020 10:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20200125130541.450409-1-gladkov.alexey@gmail.com> <20200125130541.450409-8-gladkov.alexey@gmail.com>
In-Reply-To: <20200125130541.450409-8-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jan 2020 10:45:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGNSQCA8TYa1Akp0_GRpe=ELKDPkDX5nzM5R=oDy1U+Q@mail.gmail.com>
Message-ID: <CAHk-=wiGNSQCA8TYa1Akp0_GRpe=ELKDPkDX5nzM5R=oDy1U+Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/11] proc: flush task dcache entries from all procfs instances
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jan 25, 2020 at 5:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.

From a quick read-through, this is the only one I really react negatively to.

The locking looks odd. It only seems to protect the new proc_mounts
list, but then it's a whole big rwsem, and it's taken over all of
proc_flush_task_mnt(), and the locking is exported to all over as a
result of that - including the dummy functions for "there is no proc"
case.

And proc_flush_task_mnt() itself should need no locking over any of
it, so it's all just for the silly looping over the list.

So

 (a) this looks fishy and feels wrong - I get a very strong feeling
that the locking is wrong to begin with, and could/should have been
done differently

 (b) all the locking should have been internal to /proc, and those
wrappers shouldn't exist in a common header file (and certainly not
for the non-proc case).

Yes, (a) is just a feeling, and I don't have any great suggestions.
Maybe make it an RCU list and use a spinlock for updating it?

But (b) is pretty much a non-starter in this form. Those wrappers
shouldn't be in a globally exported core header file. No way.

               Linus
