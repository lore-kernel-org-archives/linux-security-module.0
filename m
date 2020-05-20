Return-Path: <SRS0=Q/5P=7C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A3C433E1
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 13:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EFE206BE
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 13:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETNGm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 09:06:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39646 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETNGk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 09:06:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbOQc-0007Zb-8X; Wed, 20 May 2020 07:06:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbOQb-0006Q7-Dy; Wed, 20 May 2020 07:06:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christoph Hellwig <hch@infradead.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <202005191442.515A0ED@keescook>
Date:   Wed, 20 May 2020 08:02:51 -0500
In-Reply-To: <202005191442.515A0ED@keescook> (Kees Cook's message of "Tue, 19
        May 2020 14:55:49 -0700")
Message-ID: <87r1vekbd0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbOQb-0006Q7-Dy;;;mid=<87r1vekbd0.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uA8zRl9AyhKnD0V7yz6o0yeiwCD3dOiE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 18, 2020 at 07:29:00PM -0500, Eric W. Biederman wrote:
>>  arch/alpha/kernel/binfmt_loader.c  | 11 +----
>>  fs/binfmt_elf.c                    |  4 +-
>>  fs/binfmt_elf_fdpic.c              |  4 +-
>>  fs/binfmt_em86.c                   | 13 +----
>>  fs/binfmt_misc.c                   | 69 ++++-----------------------
>>  fs/binfmt_script.c                 | 82 ++++++++++++++------------------
>>  fs/exec.c                          | 97 ++++++++++++++++++++++++++------------
>>  include/linux/binfmts.h            | 36 ++++++--------
>>  include/linux/lsm_hook_defs.h      |  3 +-
>>  include/linux/lsm_hooks.h          | 52 +++++++++++---------
>>  include/linux/security.h           | 14 ++++--
>>  kernel/cred.c                      |  3 ++
>>  security/apparmor/domain.c         |  7 +--
>>  security/apparmor/include/domain.h |  2 +-
>>  security/apparmor/lsm.c            |  2 +-
>>  security/commoncap.c               |  9 ++--
>>  security/security.c                |  9 +++-
>>  security/selinux/hooks.c           |  8 ++--
>>  security/smack/smack_lsm.c         |  9 ++--
>>  security/tomoyo/tomoyo.c           | 12 ++---
>>  20 files changed, 202 insertions(+), 244 deletions(-)
>
> Oh, BTW, heads up on this (trivially but annoyingly) conflicting with
> the copy_strings_kernel/copy_string/kernel change:
>
> https://ozlabs.org/~akpm/mmotm/broken-out/exec-simplify-the-copy_strings_kernel-calling-convention.patch
>
> Is it worth pulling that and these into your tree?
>
> https://ozlabs.org/~akpm/mmotm/broken-out/exec-open-code-copy_string_kernel.patch
>
> https://ozlabs.org/~akpm/mmotm/broken-out/umh-fix-refcount-underflow-in-fork_usermode_blob.patch

Good question.  It is part of the greater set_fs removal work, and I
don't want to mess that up.

I would love to give copy_string_kernel a length parameter so
binfmt_script did not have to modify it's buffer or copy the string,
before calling copy_string_kernel.

Hmm.  I already have to call strdup on i_name in brpm_change_interp.
So I probably just want to bite the bullet and figure out a way to do
strdup earlier.

So unless it makes things easier for Andrew I think it is probably
easier to live with the conflict for now, and use this conversation
as inspiration for my next round of cleanups of binfmt_misc.

Eric

