Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D5C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Dec 2022 03:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiLMDGd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 12 Dec 2022 22:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiLMDGH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 12 Dec 2022 22:06:07 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878561E3FD
        for <linux-security-module@vger.kernel.org>; Mon, 12 Dec 2022 19:06:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id w37so9562416pga.5
        for <linux-security-module@vger.kernel.org>; Mon, 12 Dec 2022 19:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4sc2qPCALaTdyLsOHLpgYVFt+YsFy8ieVdQHGJ4OT/M=;
        b=dF5ydFeffCjIh3e1rDsgjtpr6ZOPhTDFqYM/CGPrPH3oa0LsQ0nfD+Jjad2PYPjwoY
         hvUCOVSa8ZBx7+V3UmGf/9FfFbskeQJJeSCSGsjHpax+fozIVifJ9/50qIkMn0v9EyYu
         ysFws4TnvhFK1DjeACImxTPHI2WYXwXMRsxapQxNGJkRXSbzY7q/f91Kgt7sj0+B/Cmy
         YEN72H/uA2AeBuQNY26NdVvDNluzUYEk3UKAX6Y8sVp47nDZdE6QunMhk6KY+UvcG1FT
         lQJ1/UgTtDDgL9WYQ80YlY3xzHt5Nu/oPsvE287Mz8enmwh4vneVBhnSH7/k/x0IkuiA
         oxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sc2qPCALaTdyLsOHLpgYVFt+YsFy8ieVdQHGJ4OT/M=;
        b=bTcRWDelrLG+u0XzGqx4ENqWdZRG8HRo3eCTE8SCi8Cq8EIctq+DlhIoeIxDdaB+cL
         uSE04UTcTP/J2uVZ4QNtryptUtdhCYXi3kQzefxRjfdWMMx0ruKMkZTTMED9kNN+CQde
         zso6p1isVW47c/a3XToxtGDjaFAsnhcRnQQlE7yfbtfXCTwr2Fel83F8zbu6utVbNAOi
         tz+yWob0A4hJjv2DFwy4cXjK4yk2rSAkgtsvYDMe3Uitfq7uQQawTaZoE1MbQm6gOF5h
         37LO3BhYKQSyYQlGovXT1pB6vO57JKr4EdADsI4FoMYTCvUBfJMX6MEVIkgcHG8kJMbM
         c6yA==
X-Gm-Message-State: ANoB5pmfUticXKX/Awgb6lgivfMLJOYkwGm7MXMssDpkCxZ0oElQE4Sv
        ZsmDq/8beh7JhiTKYhTB1c3WWL0SKPHQb1QJ4fZdlqORzRyL
X-Google-Smtp-Source: AA0mqf484bgR9PM8u7LM8KPfIfXaQ8VF7ROgsaX1OFk7xGGyIznpBNFvcoTLyLd9lZr07UzAiTQV/hoNrn5RWWJXQCc=
X-Received: by 2002:a63:4424:0:b0:477:96e2:9065 with SMTP id
 r36-20020a634424000000b0047796e29065mr69942852pga.533.1670900759958; Mon, 12
 Dec 2022 19:05:59 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Dec 2022 22:05:49 -0500
Message-ID: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Here is the LSM pull request for Linux v6.2, the highlights are below,
but I first wanted to mention that like the SELinux pull request there
are merge conflicts due to patches that were merged during the
v6.1-rcX cycle.  You can fix those up yourself or you can pull the tag
below which has the fixes and has been sanity tested today; if you
need something else from me to sort out the merge conflict, let me
know.

* tags/lsm-pr-20221212.merge

Now for the highlights:

* Improve the error handling in the device cgroup such that memory
allocation failures when updating the access policy do not potentially
alter the policy.

* Some minor fixes to reiserfs to ensure that it properly releases
LSM-related xattr values.

* Update the security_socket_getpeersec_stream() LSM hook to take
sockptr_t values.  Previously the net/BPF folks updated the getsockopt
code in the network stack to leverage the sockptr_t type to make it
easier to pass both kernel and __user pointers, but unfortunately when
they did so they didn't convert the LSM hook.  While there was/is no
immediate risk by not converting the LSM hook, it seems like this is a
mistake waiting to happen so this patch proactively does the LSM hook
conversion.  I should mention that Alexei Starovoitov has NACK'd this
patch because it touches the network stack (!?) and presumably because
he objects to the __user pointer annotations in general.

* Convert vfs_getxattr_alloc() to return an int instead of a ssize_t
and cleanup the callers.  Internally the function was never going to
return anything larger than an int and the callers were doing some
very odd things casting the return value; this patch fixes all that
and helps bring a bit of sanity to vfs_getxattr_alloc() and its
callers.

* More verbose, and helpful, LSM debug output when the system is
booted with "lsm.debug" on the command line.  There are examples in
the commit description, but the quick summary is that this patch
provides better information about which LSMs are enabled and the
ordering in which they are processed.

* General comment and kernel-doc fixes and cleanups.

-Paul

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20221212

for you to fetch changes up to 577cc1434e4cc1342c3df6d6a3c85136ab335c81:

 lsm: Fix description of fs_context_parse_param (2022-12-09 12:22:56 -0500)

----------------------------------------------------------------
lsm/stable-6.2 PR 20221212

----------------------------------------------------------------
Bo Liu (1):
     audit: Fix some kernel-doc warnings

Gaosheng Cui (1):
     lsm: remove obsoleted comments for security hooks

Kees Cook (1):
     LSM: Better reporting of actual LSMs at boot

Paul Moore (3):
     fs: edit a comment made in bad taste
     lsm: make security_socket_getpeersec_stream() sockptr_t safe
     lsm,fs: fix vfs_getxattr_alloc() return type and caller error paths

Roberto Sassu (4):
     reiserfs: Add missing calls to reiserfs_security_free()
     lsm: Clarify documentation of vm_enough_memory hook
     lsm: Add/fix return values in lsm_hooks.h and fix formatting
     lsm: Fix description of fs_context_parse_param

Wang Weiyang (1):
     device_cgroup: Roll back to original exceptions after copy failure

fs/reiserfs/namei.c                       |   4 +
fs/reiserfs/xattr_security.c              |   2 +-
fs/xattr.c                                |   5 +-
include/linux/fs_context.h                |   2 +-
include/linux/lsm_hook_defs.h             |   2 +-
include/linux/lsm_hooks.h                 | 241 +++++++++++++++---------
include/linux/security.h                  |  11 +-
include/linux/xattr.h                     |   6 +-
net/core/sock.c                           |   3 +-
security/apparmor/domain.c                |   3 +-
security/apparmor/lsm.c                   |  29 ++--
security/commoncap.c                      |  22 ++-
security/device_cgroup.c                  |  33 +++-
security/integrity/evm/evm_crypto.c       |   5 +-
security/integrity/evm/evm_main.c         |   7 +-
security/integrity/ima/ima.h              |   5 +-
security/integrity/ima/ima_appraise.c     |   6 +-
security/integrity/ima/ima_main.c         |   6 +-
security/integrity/ima/ima_template_lib.c |  11 +-
security/lsm_audit.c                      |   1 +
security/security.c                       |  51 +++++--
security/selinux/hooks.c                  |  13 +-
security/smack/smack_lsm.c                |  19 +--
23 files changed, 296 insertions(+), 191 deletions(-)

--
paul-moore.com
