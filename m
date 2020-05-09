Return-Path: <SRS0=34bQ=6X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79480C28CBC
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5777F2083B
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 19:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEITnz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 May 2020 15:43:55 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53792 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEITny (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 15:43:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVNz-0002uX-Fb; Sat, 09 May 2020 13:43:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVNy-0006US-Ht; Sat, 09 May 2020 13:43:47 -0600
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
Date:   Sat, 09 May 2020 14:40:17 -0500
In-Reply-To: <87sgga6ze4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 08 May 2020 13:43:31 -0500")
Message-ID: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVNy-0006US-Ht;;;mid=<87v9l4zyla.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19IOND8rj4bMCGwxstKDUfSmpiOWIeGpr4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/5] exec: Control flow simplifications
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


It is hard to follow the control flow in exec.c as the code has evolved
over time and something that used to work one way now works another.
This set of changes attempts to address the worst of that, to remove
unnecessary work and to make the code a little easier to follow.

The one rough point in my changes is cap_bprm_set_creds propbably
needs a new name as I have taken it out of security_bprm_set_creds
but my imagination failed to come up with anything better.

Eric W. Biederman (5):
      exec: Call cap_bprm_set_creds directly from prepare_binprm
      exec: Directly call security_bprm_set_creds from __do_execve_file
      exec: Remove recursion from search_binary_handler
      exec: Allow load_misc_binary to call prepare_binfmt unconditionally
      exec: Move the call of prepare_binprm into search_binary_handler

 arch/alpha/kernel/binfmt_loader.c |  5 +----
 fs/binfmt_em86.c                  |  7 +-----
 fs/binfmt_misc.c                  | 22 +++---------------
 fs/binfmt_script.c                |  5 +----
 fs/exec.c                         | 47 +++++++++++++++++++++------------------
 include/linux/binfmts.h           | 11 ++-------
 include/linux/security.h          |  2 +-
 security/apparmor/domain.c        |  3 ---
 security/commoncap.c              |  1 -
 security/selinux/hooks.c          |  2 --
 security/smack/smack_lsm.c        |  3 ---
 security/tomoyo/tomoyo.c          |  6 -----
 12 files changed, 34 insertions(+), 80 deletions(-)

---

I think this is correct set of changes that makes things better but
please look things over/review this code if you have any expertise in
anything I am touching.

Thank you,
Eric


