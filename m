Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B78C433E1
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69D2207D3
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbgE1Pm1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 11:42:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56374 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404436AbgE1Pm0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:42:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKfl-0008Ja-PN; Thu, 28 May 2020 09:42:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKfk-00062n-79; Thu, 28 May 2020 09:42:21 -0600
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
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 28 May 2020 10:38:28 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKfk-00062n-79;;;mid=<87k10wysqz.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hjQ7mkEqSTblmWNbJmpDHrq/w9JRB1jw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH  0/11] exec: cred calculation simplifications
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Recomputing the uids, gids, capabilities, and related flags each time a
new bprm->file is set is error prone, and as it turns out unnecessary.

Further our decisions on when to clear personality bits and when to tell
userspace privileges have been gained so please be extra careful, is
imperfect and our current code overshoots in inconsistent ways making
it hard to understand what is happening, and why.

Building upon my previous exec clean up work this set of changes moves
the bprm->cred calculations a little later so they only need to be done
once, moves all of the uid and gid handling into bprm_fill_uid, and
then cleans up setting secureexec and per_clear so they happen when they
make sense from a semantic perspective.

One of the largest challenges is dealing with how we revert the
credential change if it is discovered the process calling exec is
ptraced and the tracer does not have enough credentials.  It looks
like that code was tacked on as an after thought to a bug fix that
went into 2.4.0-prerelease.

I don't know if we have ever gotten all of the details just right when
the credentials are rolled back.  So this set of changes causes the
credentials not to be changed when ptraced, instead of attempting to
rollback the credential change.

Folks please give this code a review and let me know if you see
anything.

Eric W. Biederman (11):
      exec: Reduce bprm->per_clear to a single bit
      exec: Introduce active_per_clear the per file version of per_clear
      exec: Compute file based creds only once
      exec: Move uid/gid handling from creds_from_file into bprm_fill_uid
      exec: In bprm_fill_uid use CAP_SETGID to see if a gid change is safe
      exec: Don't set secureexec when the uid or gid changes are abandoned
      exec: Set saved, fs, and effective ids together in bprm_fill_uid
      exec: In bprm_fill_uid remove unnecessary no new privs check
      exec: In bprm_fill_uid only set per_clear when honoring suid or sgid
      exec: In bprm_fill_uid set secureexec at same time as per_clear
      exec: Remove the label after_setid from bprm_fill_uid

 fs/binfmt_misc.c              |  2 +-
 fs/exec.c                     | 95 +++++++++++++++++++++++++------------------
 include/linux/binfmts.h       | 13 +++---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/lsm_hooks.h     | 21 ++++++----
 include/linux/security.h      |  8 ++--
 security/apparmor/domain.c    |  2 +-
 security/commoncap.c          | 37 ++++++-----------
 security/security.c           |  4 +-
 security/selinux/hooks.c      |  2 +-
 security/smack/smack_lsm.c    |  2 +-
 11 files changed, 98 insertions(+), 90 deletions(-)

---

This builds upon my previous exec cleanup work at:
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next

Thank you,
Eric
