Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD84CC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F79F2053B
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o4Hmh6p1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgFWAeG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbgFWAeE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:04 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3690520B7192;
        Mon, 22 Jun 2020 17:34:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3690520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872443;
        bh=5SUV1Yb368pVxUvao6vZUdFkJ4ebo8QZjbCUMhuzizE=;
        h=From:To:Cc:Subject:Date:From;
        b=o4Hmh6p1DIStUoojjTzdpaNqn8kVFzYIQ4+6unQbTrE52s0v0rA4BrMM3kaZE3Htn
         5eYTkXweSirwCJnuG8gC6OlPQKapvZGgp3napsAKOTVHqg9AMp8H0L9Mk80sKuMj3n
         re3DYgBWSwNAddSW9SliDwN1qCp1gjcus2zF3A0o=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Subject: [PATCH 00/12] ima: Fix rule parsing bugs and extend KEXEC_CMDLINE rule support
Date:   Mon, 22 Jun 2020 19:32:24 -0500
Message-Id: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This series ultimately extends the supported IMA rule conditionals for
the KEXEC_CMDLINE hook function. As of today, there's an imbalance in
IMA language conditional support for KEXEC_CMDLINE rules in comparison
to KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK rules. The KEXEC_CMDLINE
rules do not support *any* conditionals so you cannot have a sequence of
rules like this:

 dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
 dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
 dont_measure func=KEXEC_CMDLINE obj_type=foo_t
 measure func=KEXEC_KERNEL_CHECK
 measure func=KEXEC_INITRAMFS_CHECK
 measure func=KEXEC_CMDLINE

Instead, KEXEC_CMDLINE rules can only be measured or not measured and
there's no additional flexibility in today's implementation of the
KEXEC_CMDLINE hook function.

With this series, the above sequence of rules becomes valid and any
calls to kexec_file_load() with a kernel and initramfs inode type of
foo_t will not be measured (that includes the kernel cmdline buffer)
while all other objects given to a kexec_file_load() syscall will be
measured. There's obviously not an inode directly associated with the
kernel cmdline buffer but this patch series ties the inode based
decision making for KEXEC_CMDLINE to the kernel's inode. I think this
will be intuitive to policy authors.

While reading IMA code and preparing to make this change, I realized
that the buffer based hook functions (KEXEC_CMDLINE and KEY_CHECK) are
quite special in comparison to longer standing hook functions. These
buffer based hook functions can only support measure actions and there
are some restrictions on the conditionals that they support. However,
the rule parser isn't enforcing any of those restrictions and IMA policy
authors wouldn't have any immediate way of knowing that the policy that
they wrote is invalid. For example, the sequence of rules above parses
successfully in today's kernel but the
"dont_measure func=KEXEC_CMDLINE ..." rule is incorrectly handled in
ima_match_rules(). The dont_measure rule is *always* considered to be a
match so, surprisingly, no KEXEC_CMDLINE measurements are made.

While making the rule parser more strict, I realized that the parser
does not correctly free all of the allocated memory associated with an
ima_rule_entry when going down some error paths. Invalid policy loaded
by the policy administrator could result in small memory leaks.

I envision patches 1-7 going to stable. The series is ordered in a way
that has all the fixes up front, followed by cleanups, followed by the
feature patch. The breakdown of patches looks like so:

 Memory leak fixes: 1-4
 Parser strictness fixes: 5-7
 Code cleanups made possible by the fixes: 8-11
 Extend KEXEC_CMDLINE rule support: 12

Perhaps the most logical ordering for code review is:

 1, 2, 3, 4, 8, 9, 5, 6, 7, 10, 11, 12

If you'd like me to re-order or split up the series, just let me know.
Thanks for considering these patches!

Tyler

Tyler Hicks (12):
  ima: Have the LSM free its audit rule
  ima: Create a function to free a rule entry
  ima: Free the entire rule when deleting a list of rules
  ima: Free the entire rule if it fails to parse
  ima: Fail rule parsing when buffer hook functions have an invalid
    action
  ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an
    invalid cond
  ima: Fail rule parsing when the KEY_CHECK hook is combined with an
    invalid cond
  ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
  ima: Use correct type for the args_p member of ima_rule_entry.lsm
    elements
  ima: Move validation of the keyrings conditional into
    ima_validate_rule()
  ima: Use the common function to detect LSM conditionals in a rule
  ima: Support additional conditionals in the KEXEC_CMDLINE hook
    function

 include/linux/ima.h                          |   4 +-
 kernel/kexec_file.c                          |   2 +-
 security/integrity/ima/ima.h                 |   9 +-
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  24 ++-
 security/integrity/ima/ima_policy.c          | 159 ++++++++++++++-----
 security/integrity/ima/ima_queue_keys.c      |   2 +-
 9 files changed, 148 insertions(+), 58 deletions(-)

-- 
2.25.1

