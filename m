Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE3C43381
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE4206B6
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfBVSPQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:15:16 -0500
Received: from namei.org ([65.99.196.166]:53660 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSPQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 13:15:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1MIFBbr016281;
        Fri, 22 Feb 2019 18:15:11 GMT
Date:   Sat, 23 Feb 2019 05:15:11 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [GIT PULL] More key subsystem fixes for 5.0
Message-ID: <alpine.LRH.2.21.1902230513480.27514@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please pull these fixes from Eric Biggers.


The following changes since commit 8a61716ff2ab23eddd1f7a05a075a374e4d0c3d4:

  Merge tag 'ceph-for-5.0-rc8' of git://github.com/ceph/ceph-client (2019-02-21 09:43:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.0-rc7

for you to fetch changes up to ede0fa98a900e657d1fcd80b50920efc896c1a4c:

  KEYS: always initialize keyring_index_key::desc_len (2019-02-22 10:11:34 -0800)

----------------------------------------------------------------
Eric Biggers (2):
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len

 include/keys/user-type.h         | 2 +-
 security/keys/keyring.c          | 4 +---
 security/keys/proc.c             | 3 +--
 security/keys/request_key.c      | 1 +
 security/keys/request_key_auth.c | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)
