Return-Path: <SRS0=coct=7B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D56C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C60E20715
	for <linux-security-module@archiver.kernel.org>; Tue, 19 May 2020 00:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgESAcq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 May 2020 20:32:46 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59128 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgESAcq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 20:32:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqBW-0002cm-4i; Mon, 18 May 2020 18:32:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaqBU-0003N4-Tu; Mon, 18 May 2020 18:32:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
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
Date:   Mon, 18 May 2020 19:29:00 -0500
In-Reply-To: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sat, 09 May 2020 14:40:17 -0500")
Message-ID: <877dx822er.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaqBU-0003N4-Tu;;;mid=<877dx822er.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18by/aaLJV6sf4J1suuuELTUfpwuJ2FJIk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 0/8] exec: Control flow simplifications
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


It is hard to follow the control flow in exec.c as the code has evolved over
time and something that used to work one way now works another.  This set of
changes attempts to address the worst of that, to remove unnecessary work
and to make the code a little easier to follow.

The churn is a bit higher than the last version of this patchset, with
renaming and cleaning up of comments.  I have split security_bprm_set_creds
into security_bprm_creds_for_exec and security_bprm_repopulate_creds.  My
goal was to make it clear that one hook completes its work while the other
recaculates it's work each time a new interpreter is selected.

I have added a new change at the beginning to make it clear that neither
security_bprm_creds_for_exec nor security_bprm_repopulate_creds needs to be
implemented as prepare_exec_creds properly does the work of setting up
credentials unless something special is going on.

I have made the execfd support generic and moved out of binfmt_misc so that
I can remove the recursion.

I have moved reassigning bprm->file into the loop that replaces the
recursion.  In doing so I discovered that binfmt_misc was naughty and
was returning -ENOEXEC in such a way that the search_binary_handler loop
could not continue.  So I added a change to remove that naughtiness.

Eric W. Biederman (8):
      exec: Teach prepare_exec_creds how exec treats uids & gids
      exec: Factor security_bprm_creds_for_exec out of security_bprm_set_creds
      exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
      exec: Allow load_misc_binary to call prepare_binfmt unconditionally
      exec: Move the call of prepare_binprm into search_binary_handler
      exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC
      exec: Generic execfd support
      exec: Remove recursion from search_binary_handler

 arch/alpha/kernel/binfmt_loader.c  | 11 +----
 fs/binfmt_elf.c                    |  4 +-
 fs/binfmt_elf_fdpic.c              |  4 +-
 fs/binfmt_em86.c                   | 13 +----
 fs/binfmt_misc.c                   | 69 ++++-----------------------
 fs/binfmt_script.c                 | 82 ++++++++++++++------------------
 fs/exec.c                          | 97 ++++++++++++++++++++++++++------------
 include/linux/binfmts.h            | 36 ++++++--------
 include/linux/lsm_hook_defs.h      |  3 +-
 include/linux/lsm_hooks.h          | 52 +++++++++++---------
 include/linux/security.h           | 14 ++++--
 kernel/cred.c                      |  3 ++
 security/apparmor/domain.c         |  7 +--
 security/apparmor/include/domain.h |  2 +-
 security/apparmor/lsm.c            |  2 +-
 security/commoncap.c               |  9 ++--
 security/security.c                |  9 +++-
 security/selinux/hooks.c           |  8 ++--
 security/smack/smack_lsm.c         |  9 ++--
 security/tomoyo/tomoyo.c           | 12 ++---
 20 files changed, 202 insertions(+), 244 deletions(-)
