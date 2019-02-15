Return-Path: <SRS0=pLHH=QW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86BC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 22:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085F3222DD
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Feb 2019 22:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfBOWQH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:16:07 -0500
Received: from namei.org ([65.99.196.166]:52460 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfBOWQH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Feb 2019 17:16:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1FMG0Es005582;
        Fri, 15 Feb 2019 22:16:00 GMT
Date:   Sat, 16 Feb 2019 09:16:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [GIT PULL] KEYS: fixes for v5.1
Message-ID: <alpine.LRH.2.21.1902160914180.4453@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

Please pull these fixes for the Keys subsystem.

From David Howells:

" (1) Handle quotas better, allowing full quota to be reached.

 (2) Fix the creation of shortcuts in the assoc_array internal
     representation when the index key needs to be an exact multiple of the
     machine word size.

 (3) Fix a dependency loop between the request_key contruction record and
     the request_key authentication key.  The construction record isn't
     really necessary and can be dispensed with.

 (4) Set the timestamp on a new key rather than leaving it as 0.  This
     would ordinarily be fine - provided the system clock is never set to a
     time before 1970."

---

The following changes since commit 5ded5871030eb75017639148da0a58931dfbfc25:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2019-02-15 13:36:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1-rc6

for you to fetch changes up to 7c1857bdbdf1e4c541e45eab477ee23ed4333ea4:

  keys: Timestamp new keys (2019-02-15 14:12:09 -0800)

----------------------------------------------------------------
David Howells (3):
      assoc_array: Fix shortcut creation
      keys: Fix dependency loop between construction record and auth key
      keys: Timestamp new keys

Eric Biggers (1):
      KEYS: allow reaching the keys quotas exactly

 fs/nfs/nfs4idmap.c                   | 31 +++++++++-------
 include/keys/request_key_auth-type.h | 36 ++++++++++++++++++
 include/linux/key-type.h             | 22 +++--------
 lib/assoc_array.c                    |  8 ++--
 security/keys/internal.h             | 13 +------
 security/keys/key.c                  |  5 ++-
 security/keys/keyctl.c               |  1 +
 security/keys/process_keys.c         |  1 +
 security/keys/request_key.c          | 72 +++++++++++++++---------------------
 security/keys/request_key_auth.c     | 16 ++++----
 10 files changed, 108 insertions(+), 97 deletions(-)
 create mode 100644 include/keys/request_key_auth-type.h
