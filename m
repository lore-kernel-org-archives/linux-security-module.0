Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD791C47255
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4B820736
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="E5S6DY5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgEKTEM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731163AbgEKTEM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 15:04:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E5EC061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 12:04:11 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k110so8474772otc.2
        for <linux-security-module@vger.kernel.org>; Mon, 11 May 2020 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s73sYUjU2T+59AL45Tu6TCysxqjsop1IGHTRXXypctk=;
        b=E5S6DY5dOJAQJ1y0RjFlD/g9ZJgf1fK9Qa/tgwB0E5Z9j1UTeta7QmykD9FZ30bOni
         c4DVq96s2Evv7V9KaW8OQhxbMXwoepXtudd6kQBCa0dJySxYJmwTUrwF2+oRTKC9ExjM
         gjI+gsIZtPs/bQ+CEiDeOzXyiAhkG5gTCLG6eca9ZRGsF5kXUQvmXWk2zEj5UhOhWuXa
         hFfBbR18/T3k5p7wj0/LC2+XlwCvrJcFZIIGpWEZHY/IlzLM4XaQkuhODDxDAldBSqfq
         Zvh1PkSumtOA9HVXZnMw8PSWuZdBo3yLIU5xWM/ii+gXYIVomaFt0qBQWmDt+mvi3Hs0
         9cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s73sYUjU2T+59AL45Tu6TCysxqjsop1IGHTRXXypctk=;
        b=uBxGBwqbxIK/KvF320iTbwh06sLCFJNQs6JAD0IbSYhWAqP6HyNy3iCV4o8ds5tnZj
         5mIMMe3yFKHU3wrT2rBuzd0uBJ9ApzgtqQMXROuhXFeF6YEbwqUPQRPNZ4jqpggnZCyJ
         paKTaWer4zLbCRzojPy8CGLO7OJCeKiN5wgj4vHdU9mGhsX4gMOls7zyIaGhuo0IZChT
         rZodvldo5IMpgjXgQMpx2FiHDIWJ2tsLh8tJOrQwmUhIs4iovY5iUnc95TzjyMrOzlbr
         fcNMjpfCfT0X0UHONFSVQ8oxAvlDkIm6l7RpL1U1VIcnx2Ge5TurtmqGmEK5shgecOy5
         Z5bQ==
X-Gm-Message-State: AGi0PuaIK8MmO/W6BEAm2Sx3/NqZc13WN16bsl+AG2bj18zj0kqC60h7
        UIVXhQ7/qMysLZcib9mEV2it9Q==
X-Google-Smtp-Source: APiQypJIVFT+ZCv+tK80xUXbracodPGzrtONiD0MTwj6mM4HCs3oxADGxVBontAQ8QNSI/IJI96jVw==
X-Received: by 2002:a05:6830:22e8:: with SMTP id t8mr14366049otc.229.1589223851277;
        Mon, 11 May 2020 12:04:11 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id a7sm2848586otr.15.2020.05.11.12.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 12:04:10 -0700 (PDT)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>, dalias@libc.org
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <f33135b7-caa2-94f3-7563-fab6a1f5da0f@landley.net>
Date:   Mon, 11 May 2020 14:10:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87sgg6v8we.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/11/20 9:33 AM, Eric W. Biederman wrote:
> What I do see is that interp_data is just a parameter that is smuggled
> into the call of search binary handler.  And the next binary handler
> needs to be binfmt_elf for it to make much sense, as only binfmt_elf
> (and binfmt_elf_fdpic) deals with BINPRM_FLAGS_EXECFD.

The binfmt_elf_fdpic driver is separate from binfmt_elf for the same reason
ext2/ext3/ext4 used to have 3 drivers: fdpic is really just binfmt_elf with the
4 main sections (text, data, bss, rodata) able to move independently of each
other (each tracked with its own base pointer).

It's kind of -fPIE on steroids, and various security people have sniffed at it
over the years to give ASLR more degrees of freedom on with-MMU systems. Many
moons ago Rich Felker proposed teaching the fdpic loader how to load normal ELF
binaries so there's just the one loader (there's a flag in the ELF header to say
whether the sections are independent or not).

Rob
