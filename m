Return-Path: <SRS0=lc+5=AK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824DC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03D320720
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgF2VAG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:06 -0400
Received: from namei.org ([65.99.196.166]:42618 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbgF2VAF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jun 2020 17:00:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 05TL03nS010843;
        Mon, 29 Jun 2020 21:00:03 GMT
Date:   Tue, 30 Jun 2020 07:00:03 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Security subsystem fixes for v5.8
Message-ID: <alpine.LRH.2.21.2006300659080.10756@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Please pull (now using signed tags).

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.8-rc3-a

for you to fetch changes up to 23e390cdbe6f85827a43d38f9288dcd3066fa376:

  security: Fix hook iteration and default value for inode_copy_up_xattr (2020-06-23 16:39:23 -0700)

----------------------------------------------------------------
Two simple fixes for v5.8:

1) Fix hook iteration and default value for inode_copy_up_xattr
	from KP Singh <kpsingh@google.com>

2) Fix the key_permission LSM hook function type
	from Sami Tolvanen <samitolvanen@google.com>

----------------------------------------------------------------
KP Singh (1):
      security: Fix hook iteration and default value for inode_copy_up_xattr

Sami Tolvanen (1):
      security: fix the key_permission LSM hook function type

 include/linux/lsm_hook_defs.h |  4 ++--
 security/security.c           | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)
