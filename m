Return-Path: <SRS0=7Hmq=4B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929CFC3F68F
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Feb 2020 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB13217BA
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Feb 2020 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581629434;
	bh=ItnnmxoRJ5gT+30BziuxUd+qlmmx1CXkUL9ZfYPGf/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=czWXMa6uD0iZ8rHlehoGfXTmu7nN+GljgqK8yQbfkF2CkHqtnxkWXRYFTqop2pBxQ
	 NcWU2CYYFEcvKZQMqg4vLqu6EkwUTAUgvzmKN7AD7o1GqpXGvgGlF3hKx1AbAtvpsp
	 JIfUFQixaOp0nP/ofdwAmDCIRhRqgHj3Rg+X6Prg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgBMVae (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:30:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38834 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgBMVad (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Feb 2020 16:30:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so8328899ljh.5
        for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2020 13:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfXM82VfoqeRc90gxFVeIWXJ41itdUqMd3xA0dVgW2Y=;
        b=BawgSQbYq1TbwSpri2I8yt8BLdW+yFwAYoE8dMiMSbSBq331xObis6ZCTB17z/2+pu
         BJ/TFbcNqMRECulsFRMIiMTcM/ovFgWzkJQC0Q8GiR94lJcnmNpi+fvP6UvLQSDrJh9R
         cMZLEUQ8JhCaHYaouGQIdPmwtosqiphyKcUZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfXM82VfoqeRc90gxFVeIWXJ41itdUqMd3xA0dVgW2Y=;
        b=KSXgD3DuTRFPaIZ/Zj0wDU/0YG9mDyvosDH/YN2VA6+hnkio65watvkRbNYdRYQe+K
         sqBDybspy+fzA0coF2WC4v1Z0A6xnK3BRLrgsNTXIeRYKdbIFPKWD2wiGj1MQvwQdnxk
         D9CDk2hFFmDex5s5kDNzFjHPlSlgGOOK3ZwTCkCjd6cKVz01ujOGNEOUB88N3/AzK6Jx
         CwBfC8flsF8+Z1T6ESBLE0Hz0RHv5LD4gEQcO0CdPy1R4ofd2x1/04v0wgqTogKeaZIW
         fvB/zbEORquJYDSQhPyiWavyqRrFUyfu8ZoPueqPDPWwlG8SaPk6A6HJWVVNIwaB8jj/
         PzEw==
X-Gm-Message-State: APjAAAVINWg5xyaAg0vL6/aGX07VM6vv0bJ1MS1U88t9ebn6PmOeyEu5
        CPl2Nvx4RYv7VJXSpRkqBofwZyxqrKI=
X-Google-Smtp-Source: APXvYqyQf56LBayHNM19LY5VoMxfoGyUUeQuPyP1+cq+KgRY129Dre/yfHB9D+3dBUTYJ/hZ0uVhSg==
X-Received: by 2002:a2e:a490:: with SMTP id h16mr5016664lji.115.1581629431098;
        Thu, 13 Feb 2020 13:30:31 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j7sm2252674ljg.25.2020.02.13.13.30.28
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 13:30:28 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id x7so8328343ljc.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Feb 2020 13:30:28 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr12460727ljb.150.1581629427873;
 Thu, 13 Feb 2020 13:30:27 -0800 (PST)
MIME-Version: 1.0
References: <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <20200213055527.GS23230@ZenIV.linux.org.uk>
In-Reply-To: <20200213055527.GS23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Feb 2020 13:30:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com>
Message-ID: <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Feb 12, 2020 at 9:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What I don't understand is the insistence on getting those dentries
> via dcache lookups.

I don't think that's an "insistence", it's more of a "historical
behavior" together with "several changes over the years to deal with
dentry-level cleanups and updates".

> _IF_ we are willing to live with cacheline
> contention (on ->d_lock of root dentry, if nothing else), why not
> do the following:
>         * put all dentries of such directories ([0-9]* and [0-9]*/task/*)
> into a list anchored in task_struct; have non-counting reference to
> task_struct stored in them (might simplify part of get_proc_task() users,

Hmm.

Right now I don't think we actually create any dentries at all for the
short-lived process case.

Wouldn't your suggestion make fork/exit rather worse?

Or would you create the dentries dynamically still at lookup time, and
then attach them to the process at that point?

What list would you use for the dentry chaining? Would you play games
with the dentry hashing, and "hash" them off the process, and never
hit in the lookup cache?

Am I misunderstanding what you suggest?

            Linus
