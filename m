Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E52C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2965C224B1
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 13:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGNNaq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:30:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48150 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgGNNaq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 09:30:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL0y-0007EU-Qt; Tue, 14 Jul 2020 07:30:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvL0x-00052X-OR; Tue, 14 Jul 2020 07:30:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Tue, 14 Jul 2020 08:27:41 -0500
Message-ID: <871rle8bw2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvL0x-00052X-OR;;;mid=<871rle8bw2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19u6ArwG0PZV91H10uhj/KRxP3p9h+PTS0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/7] Implementing kernel_execve
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


This set of changes implements kernel_execve to remove the need for
kernel threads to pass in pointers to in-kernel data structures
to functions that take __user pointers.   Which is part of the
greater removal of set_fs work.

This set of changes makes do_execve static and so I have updated the
comments.  This affects the comments in the x86 entry point code
and the comments in tomoyo.  I believe I have updated them correctly.
If not please let me know.

I have moved the calls of copy_strings before the call of
security_bprm_creds_for_exec.  Which might be of interest to the
security folks.  I can't see that it matters but I have copied the
security folks just to be certain.

By moving the initialization of the new stack that copy_strings does
earlier it becomes possible to copy all of the parameters to exec before
anything else is done which makes it possible to have one function
kernel_execve that uncondtionally handles copying parameters from kernel
space, and another function do_execveat_common which handles copying
parameters from userspace.

This work was inspired by Christoph Hellwig's similar patchset, which my
earlier work to remove the file parameter to do_execveat_common
conflicted with.
https://lore.kernel.org/linux-fsdevel/20200627072704.2447163-1-hch@lst.de/

I figured that after causing all of that trouble for the set_fs work
the least I could do is implement the change myself.

The big practical change from Christoph's work is that he did not
separate out the copying of parameters from the rest of the work of
exec, which did not help the maintainability of the code.

Please let me know if you see something wrong.

This set of changes is against my exec-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next

Eric W. Biederman (7):
      exec: Remove unnecessary spaces from binfmts.h
      exec: Factor out alloc_bprm
      exec: Move initialization of bprm->filename into alloc_bprm
      exec: Move bprm_mm_init into alloc_bprm
      exec: Factor bprm_execve out of do_execve_common
      exec: Factor bprm_stack_limits out of prepare_arg_pages
      exec: Implement kernel_execve

 arch/x86/entry/entry_32.S      |   2 +-
 arch/x86/entry/entry_64.S      |   2 +-
 arch/x86/kernel/unwind_frame.c |   2 +-
 fs/exec.c                      | 301 ++++++++++++++++++++++++++++-------------
 include/linux/binfmts.h        |  20 ++-
 init/main.c                    |   4 +-
 kernel/umh.c                   |   6 +-
 security/tomoyo/common.h       |   2 +-
 security/tomoyo/domain.c       |   4 +-
 security/tomoyo/tomoyo.c       |   4 +-
 10 files changed, 224 insertions(+), 123 deletions(-)

Eric
