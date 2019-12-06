Return-Path: <SRS0=Oaw1=Z4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA3C43603
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD0C2467C
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Dec 2019 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575670505;
	bh=9JvzwEgsdxYVt8s8RLOPMbFdcSuM2dK1YoTcGfh72pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=utnKtAF/KuiL03k0VZ8lDOmvy1SzhOUgKpgR1MYJZ4ptwFoW2FmZJn5AZW+/m6IW+
	 wpRj9ZUVLmu0lusQCPFqOQmDti8taAOVE8xiHXKsx/Oixwmgb8vWEu7wceXkKzfTPv
	 RYevC2qO4r9j8Ym6L8RcTBDlO7dInQzroCD4DQ5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLFWPF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:15:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37644 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfLFWPF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Dec 2019 17:15:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so6397259lfc.4
        for <linux-security-module@vger.kernel.org>; Fri, 06 Dec 2019 14:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0XBsU0Zwa7k+dx/SYcO/cC8TsFqFe7ap7E70c7vInU=;
        b=bTZdKzPiqpVSRlIEKZEGDMlBYxFAfG1XtbiNaTYxkA8G285Eux5gFHDmaTnJC4iPE5
         o8N7+YD5Z1tWk70yIvruVU0BeSE3YsKa/iMNxQrsM+BsOw2M95U/kwIKkGhLzao/qQKm
         h/+JfuStPH6oZCReJIpg2utxtMnd/SwjidQvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0XBsU0Zwa7k+dx/SYcO/cC8TsFqFe7ap7E70c7vInU=;
        b=KMrNW9oM8U7H/cfrrBm1+jcY56C2f0cmM0yy4Onfrfjw2qUmC5gQzkDcQf5YhaiLLp
         fb5b34m45B8hSM3WXM23KvMiAoBujnOnuDLKP/LiCbnOSs6W64B5W/2OmEOTWu2UoMUo
         txBSFP5R+4LGOK2BBVDLxJXV7rQDuoM0JWA2tt7JHwPZoKViaaGq+r1hInIyIl70CPT/
         FefJS9gqDZIBKgi/XByHl/tmbAmWs7wLI5nN1r6k5tpqH8wGC51Fw2Ie0CAVuvIsLOjY
         K1so/v3N9QjNE+E0g84LcpbgTbDpA1s4Mh99t+0zcsVQvfvPG0aJJ7IE3+fgiRXTkwoN
         Imjw==
X-Gm-Message-State: APjAAAXBI6KhW8+4hNF42liBGKIAnOG5Wm8VmTxdWZ2EeBM3eFp8v6us
        cCcFBDtMDqc/GdrjsYea8CoRrNHpnvw=
X-Google-Smtp-Source: APXvYqyEFMVcNjQnJFxFnYrdMf5QLN9WIJK5SloV54ar8UAFJa1eY1qqye5Acx+W0uPwyd/Xjd8Yyw==
X-Received: by 2002:a19:3f16:: with SMTP id m22mr9025430lfa.116.1575670502611;
        Fri, 06 Dec 2019 14:15:02 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z7sm5964719lfa.81.2019.12.06.14.15.01
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 14:15:01 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id f15so5570944lfl.13
        for <linux-security-module@vger.kernel.org>; Fri, 06 Dec 2019 14:15:01 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9167196lfk.52.1575670500889;
 Fri, 06 Dec 2019 14:15:00 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk> <20191206214725.GA2108@latitude>
In-Reply-To: <20191206214725.GA2108@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 14:14:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Message-ID: <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 6, 2019 at 1:47 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> This change breaks firefox on my system. I've noticed that some pages
> doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
> start loading and than stop. Looks like firefox is waiting for some
> dynamic loading content. I've bisected to this commit, but can't revert
> because of conflicts.

Can you check the current git tree, and see if we've fixed it for you.
There are several fixes there, one being the (currently) topmost
commit 76f6777c9cc0 ("pipe: Fix iteration end check in
fuse_dev_splice_write()").

I _just_ pushed out that one, so check that you get it - it sometimes
takes a couple of minutes for the public-facing git servers to mirror
out. I doubt that's the one that would fix firefox, but still..

               Linus
