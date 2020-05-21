Return-Path: <SRS0=9GoG=7D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E4DC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 21 May 2020 22:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA5A20814
	for <linux-security-module@archiver.kernel.org>; Thu, 21 May 2020 22:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="y/LvVBBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgEUWuk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 May 2020 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbgEUWuj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 May 2020 18:50:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D35C08C5C0
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2020 15:50:39 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 23so6463196oiq.8
        for <linux-security-module@vger.kernel.org>; Thu, 21 May 2020 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tkpx7ftcTUxzBBIrIGDJ77z6AvaFvZxbexQdFNLy018=;
        b=y/LvVBBpTk9uRJjMiuEEiVdKPdabb8L19o5Zb7T4ugL7BViYxtww76HDY2t7cOJ52k
         BjHfqw51q6Tgc8tbASdU5vBOZl6dIoQgBik4GvxOsPmsTv6EFMsmuUJdA8Vz3QM3YShS
         7SRfKzZwCP4GsaBFIgHXUKR86V28mEr6pC9bifacGWVgCi4kSuYGST9QtQraQBqUVwzN
         XFEj/ezYSdTmhSY+QAjb5Qc0TD5y8zVjsyx7zMSbm7RWsyQWEulaew6qWG2JaFuQRtt/
         EyywGeK78QOBsrJpLRYPwHrM1PUsaMWXhyEAEa7tlwu9dqY5AjktXov8UyKrIcd6CZbP
         syJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkpx7ftcTUxzBBIrIGDJ77z6AvaFvZxbexQdFNLy018=;
        b=gugjcuGn+DvAaD1gFjc8IFv3Bl3gknhflyH8tMPrRW/ozmiq4y3kDvewDNnuZ0eb5Y
         bZaWX+y3kkbm7OBmV+GSkgnPcz9lSIiJGqCYGqFe76yZLmdUz8ujmnOUJLyfTyYEbf3k
         x+dJXOjOwjZhgZW6XU7yAxRPpkZ+y+BFm8dgK0xLuDBt1DK5jIwuG7fRvf24IGzp4RS4
         j5F88koVc2eaA4Sk6OiFlBi9oN0GvYri+LyaXXL+XY36wMhqLWtr7KLOFAeL0HJ1XhQH
         coNPNTcvxPJlq+VtznIO09+CU28xazfgvypJkoMD86ibuPFYS9/QBdj9roOrMT9VKCd3
         brSQ==
X-Gm-Message-State: AOAM5321vQO04JrJyw+PH2xPBkAjiVS6a1XEuZsm0AEmKHOnF83DToB6
        mmwru63vXhgDU0h2NTlXbPl5ZQ==
X-Google-Smtp-Source: ABdhPJx4fpvv6Zl+NpcN3oR+e4Smxnwp2+3qasu0LOmjkO/s7nhQAh7KlW2rQPDYj9f0KwBp+Gk/NQ==
X-Received: by 2002:aca:1e02:: with SMTP id m2mr638451oic.107.1590101438936;
        Thu, 21 May 2020 15:50:38 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 61sm1968017otp.13.2020.05.21.15.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 15:50:38 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
 <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net>
 <874ksaioc6.fsf@x220.int.ebiederm.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <fc2cf2a7-e1a7-3170-32c9-43e593636799@landley.net>
Date:   Thu, 21 May 2020 17:50:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <874ksaioc6.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/20/20 11:05 AM, Eric W. Biederman wrote:
> Rob Landley <rob@landley.net> writes:
> 
>> On 5/18/20 7:33 PM, Eric W. Biederman wrote:
>>>
>>> Most of the support for passing the file descriptor of an executable
>>> to an interpreter already lives in the generic code and in binfmt_elf.
>>> Rework the fields in binfmt_elf that deal with executable file
>>> descriptor passing to make executable file descriptor passing a first
>>> class concept.
>>
>> I was reading this to try to figure out how to do execve(NULL, argv[], envp) to
>> re-exec self after a vfork() in a chroot with no /proc, and hit the most trivial
>> quibble ever:
> 
> We have /proc/self/exe today.

Not when you first enter a container that's just created a new namespace, or
initramfs first launches PID 1 and runs a shell script to set up the environment
and your (subshell) and background& support only has vfork and not fork, or just
plain "somebody did a chroot"...

(Yes a nommu system with range registers can want _security_ without
_address_translation_. Strange but true! I haven't actually sat down to try to
implement nommu containers yet, but I've done worse things on many occasions.
Remember: the S in IoT stands for Security.)

> If I understand you correctly you would
> like to do the equivalent of 'execve("/proc/self/exe", argv[], envp[])'
> without having proc mounted.

Toybox would _like_ proc mounted, but can't assume it. I'm writing a new
bash-compatible shell with nommu support, which means in order to do subshell
and background tasks if (!CONFIG_FORK) I need to create a pipe pair, vfork(),
have the child exec itself to unblock the parent, and then read the context data
that just got discarded through the pipe from the parent. ("Wheee." And you can
quote me on that.)

I've implemented that already
(https://github.com/landley/toybox/blob/0.8.3/toys/pending/sh.c#L674 and reentry
is L2516, yeah it's a work in progress), but "exec self" requires /proc/self/exe
and since I gave up on getting
http://lkml.iu.edu/hypermail/linux/kernel/2005.1/09399.html in (I should
apologize to Randy but I just haven't got the spoons to face
https://landley.net/notes-2017.html#14-09-2017 again; three strikes and the
patch stays out) I need /init to be a shell script to set up an initramfs that's
made by pointing CONFIG_INITRAMFS_SOURCE at a directory that was made without
running the build as root, because there's no /dev/console and you can't mknod
as a non-root user.

Maybe instead of fixing CONFIG_DEVTMPFS_MOUNT to apply to initramfs I could
instead add a CONFIG_INITRAMFS_EXTRA=blah.txt to usr/{Kconfig,Makefile} to
append user-supplied extra lines to the end of the gen_initramfs.sh output and
make a /dev/console that way (kinda like genext2fs and mksquashfs), but getting
that in through the linux-kernel bureaucracy means consulting a 27 step
checklist supplementing the basic 17 step submission procedure (with
bibliographic references) explaining how to fill out the forms, perform the
validation steps, go through the proper channels, and get the appropriate series
of signatures and approvals, and I just haven't got the stomach for it anymore.
I was participating here as a hobbyist. Linux-kernel has aged into a rigid
bureaucracy. It's no fun anymore.

Which means any kernel patch I write I have to forward port regularly, sometimes
for a very long time. Heck, I gave linux-kernel three strikes at miniconfig
fifteen years ago now:

  http://lkml.iu.edu/hypermail/linux/kernel/0511.2/0479.html
  https://lwn.net/Articles/161086/
  https://lkml.org/lkml/2006/7/6/404

And was still maintaining it out of tree a decade later:

  https://landley.net/aboriginal/FAQ.html#dev_miniconfig
  https://github.com/landley/aboriginal/blob/master/more/miniconfig.sh

These days I've moved on to a microconfig format that mostly fits on one line,
ala the KCONF= stuff in toybox's built in:

  https://github.com/landley/toybox/blob/master/scripts/mkroot.sh#L136

For example, the User Mode Linux miniconfig from my ancient
https://landley.net/writing/docs/UML.html would translate to microconfig as:

  BINFMT_ELF,HOSTFS,LBD,BLK_DEV,BLK_DEV_LOOP,STDERR_CONSOLE,UNIX98_PTYS,EXT2_FS

The current kernel also needs "64BIT" because my host toolchain doesn't have the
-m32 headers installed, but then it builds fine ala:

make ARCH=um allnoconfig KCONFIG_ALLCONFIG=<(echo
BINFMT_ELF,HOSTFS,LBD,BLK_DEV,BLK_DEV_LOOP,STDERR_CONSOLE,UNIX98_PTYS,EXT2_FS,64BIT
| sed -E 's/([^,]*)(,|$)/CONFIG_\1=y\n/g')

Of course running the resulting ./linux says:

  Checking PROT_EXEC mmap in /dev/shm...Operation not permitted
  /dev/shm must be not mounted noexec

But *shrug*, Devuan did that not me. I haven't really used UML since QEMU
started working. Shouldn't the old "create file, map file, delete file" trick
stop flushing the data to backing store no matter where the file lives? I mean,
that trick dates back to the VAX, and we argued about it on the UML list a
decade ago (circa
https://sourceforge.net/p/user-mode-linux/mailman/message/14000710/) but...
fixing random things that are wrong with Linux is not my problem anymore. I'm
only in this thread because I'm cc'd.

Spending five years repeatedly posting perl removal patches and ending up with
intentional sabotage at the end from the guy who'd added perl in the first place
when the Gratuitous Build Dependency Removal patches finally got traction
(https://landley.net/notes-2013.html#28-03-2013) kinda put me off doing that again.

> The file descriptor is stored in mm->exe_file.
> Probably the most straight forward implementation is to allow
> execveat(AT_EXE_FILE, ...).

Cool, that works.

> You can look at binfmt_misc for how to reopen an open file descriptor.

Added to the todo heap.

Thanks,

Rob
