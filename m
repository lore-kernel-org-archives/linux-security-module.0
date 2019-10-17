Return-Path: <SRS0=Cjvm=YK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5487FA372A
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Oct 2019 15:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CEE222BE
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Oct 2019 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571327609;
	bh=XsEievKWg41Ej4+tPR0ePPLUNXudjwrs03DC2R4PGp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1bb9slcw8B8IxW9YmyKZItnqUL7vbprYbsZZ8ZmrVlrdoea9hKcg+g5QaEnuLPXqX
	 PgqjihytpGeEztjCsEnn0ERzhgWTqX6EFUfENpJbtk5nZbAW7iDYdvJjcaJAdMOqGh
	 Qmi8ZiDgVQ+1JfVPZ+7QiVrYlvaSmEdLsvh2TAJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393440AbfJQPx3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:53:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41492 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393697AbfJQPx1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Oct 2019 11:53:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so2300478lfn.8
        for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2019 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIzDy9DTfDNRhN7LSYB97ye4DVyGrDXll/MmImkgT6U=;
        b=BVpF6LyRGlHDFAruswmAHbv0+pLGUbDhV9wcN5xE8WS8g+zUh4x5jXcUYAsmzaIB6g
         YMEX8gjoO+3WdmFLQuP7Ko+nM3JcFnx6Odu1iLGo112V8bGqq9akNkXniU0XB2vYqP2h
         zo3E/L5G8PzgPvTprfyPmfiSP4luH/eHr1DuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIzDy9DTfDNRhN7LSYB97ye4DVyGrDXll/MmImkgT6U=;
        b=PpGsrPUOunZdKzgCzU/O0CSrSllFlmuo+VKXVZEtUKaM4nI9Us8fncwTtaV50dIH8t
         IX/ujeHT5LserSmgcbmw7DMlWCaS2kq/mgncN3VeI8pF0ePGInq60NlcUXi3KWq98f6k
         WSwGCk9qy6cFQxKmFKjcIzoq2jOFkZ9rf5U4adH4MPhHMJc/69PEwxxfDLqT2xK6jOi2
         6cysy6KXzZSXH9dVfAqsPY42+3Ko8i0b0WhImggirUyDFafOcf8yUyFjsTwWSKrgDax8
         wwhMZ4bEK27hQWqevrpztGF1JyQEuvKwtCjMDPEFuRtq4OkK1iyq+ME0TuDqadGMxVW7
         kdrA==
X-Gm-Message-State: APjAAAXORwCiq98d3SKrQ8t7cLwcX6rIYFkOMU11V300sYk1tOJq62ta
        5eiOQeZm5dDjKsmFMFxE9V2SZOMPWaA=
X-Google-Smtp-Source: APXvYqwjXQTwomrdFKjF8XYQbVBvl1Ng/LV/F+fsYilGzaf4YAkvHxlGthmofJ6LtAOlTPd5Ru68UA==
X-Received: by 2002:ac2:4888:: with SMTP id x8mr2815355lfc.90.1571327604640;
        Thu, 17 Oct 2019 08:53:24 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q16sm1108460lfb.74.2019.10.17.08.53.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:53:23 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 195so2295470lfj.6
        for <linux-security-module@vger.kernel.org>; Thu, 17 Oct 2019 08:53:22 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr2890741lfe.106.1571327602667;
 Thu, 17 Oct 2019 08:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000830fe50595115344@google.com> <00000000000071e2fc05951229ad@google.com>
In-Reply-To: <00000000000071e2fc05951229ad@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Oct 2019 08:53:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
Message-ID: <CAHk-=wjFozfjV34_qy3_Z155uz_Z7qFVfE8h=_9ceGU-SVk9hA@mail.gmail.com>
Subject: Re: WARNING: refcount bug in find_key_to_update
To:     syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
Cc:     aou@eecs.berkeley.edu, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris James Morris <jmorris@namei.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 16, 2019 at 7:42 PM syzbot
<syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to 0570bc8b7c9b ("Merge tag
>  'riscv/for-v5.3-rc1' ...")

Yeah, that looks unlikely. The only non-riscv changes are from
documentation updates and moving a config variable around.

Looks like the crash is quite unlikely, and only happens in one out of
ten runs for the ones it has happened to.

The backtrace looks simple enough, though:

  RIP: 0010:refcount_inc_checked+0x2b/0x30 lib/refcount.c:156
   __key_get include/linux/key.h:281 [inline]
   find_key_to_update+0x67/0x80 security/keys/keyring.c:1127
   key_create_or_update+0x4e5/0xb20 security/keys/key.c:905
   __do_sys_add_key security/keys/keyctl.c:132 [inline]
   __se_sys_add_key security/keys/keyctl.c:72 [inline]
   __x64_sys_add_key+0x219/0x3f0 security/keys/keyctl.c:72
   do_syscall_64+0xd0/0x540 arch/x86/entry/common.c:296
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

which to me implies that there's some locking bug, and somebody
released the key without holding a lock.

That code looks a bit confused to me. Releasing a key without holding
a lock looks permitted, but if that's the case then __key_get() is
complete garbage. It would need to use 'refcount_inc_not_zero()' and
failure would require failing the caller.

But I haven't followed the key locking rules, so who knows. That "put
without lock" scenario would explain the crash, though.

David?

              Linus
