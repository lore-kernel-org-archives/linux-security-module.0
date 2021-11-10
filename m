Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2DC433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8841461241
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Nov 2021 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhKJVsT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:48:19 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44194
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233484AbhKJVsS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Nov 2021 16:48:18 -0500
Received: from [192.168.192.153] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 584543F1C0;
        Wed, 10 Nov 2021 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636580726;
        bh=eMB5uDmzC4Gy3XB9mLPnZzPySUDtGeEv8TCnrzSwWNg=;
        h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type;
        b=btzhvul1UNBqSCtZP7UA3/RY7OgJAMdM9B5Bm2+PHbAi+A36KHwsxUSEB1eHrpUut
         oBdyv+CiXcTuGoC5WIUfQrcYGly3PPD9M0PCQXnfEc83OVDGnfAwdjcA7lyCtahHbK
         DPptxMxiZimsuVGBbLKjMldWFHOkL0aEKDqpoZykhipcsszUie6sTnzwGV/ZDT8sWn
         7dzZTEaLgeiEJiUfqBMfOn6XnrlE4eeHO+DNRGwXYUJGav092jNtZ+rgYoQyCSfSWC
         OErmgS8l0uZx7QIZsrj2XSaIDKD3gDv1RRz7QKX9pKuv+WbnGpkwNfOnsiOxujwhIq
         aW6J2s83sn9Sg==
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor changes for 5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Organization: Canonical
Message-ID: <92f2d63e-02ac-0990-672d-43a646c2c42a@canonical.com>
Date:   Wed, 10 Nov 2021 13:45:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

sorry this is so late, we had some issues with the test infrastructure. If you
prefer I can send an alternate PR with just the bug fixes.

thanks
john



The following changes since commit e37986097ba63c94b1af9d5ad5486d120a809f72:

  apparmor: Use true and false for bool variable (2020-05-15 14:26:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2021-11-10

for you to fetch changes up to 582122f1d73af28407234321c94711e09aa3fd04:

  apparmor: remove duplicated 'Returns:' comments (2021-11-03 15:57:51 -0700)

----------------------------------------------------------------
+ Features
  - use per file locks for transactional queries
  - update policy management capability checks to work with LSM stacking

+ Bug Fixes
  - check/put label on apparmor_sk_clone_security()
  - fix error check on update of label hname
  - fix introspection of of task mode for unconfined tasks

+ Cleanups
  - avoid -Wempty-body warning
  - remove duplicated 'Returns:' comments
  - fix doc warning
  - remove unneeded one-line hook wrappers
  - Use struct_size() helper in kzalloc()
  - fix zero-length compiler warning in AA_BUG()
  - file.h: delete duplicated word
  - delete repeated words in comments
  - Remove the repeated declaration

----------------------------------------------------------------
Arnd Bergmann (1):
      apparmor: avoid -Wempty-body warning

Austin Kim (1):
      apparmor: remove duplicated 'Returns:' comments

ChenXiaoSong (1):
      apparmor: fix doc warning

Florian Westphal (1):
      apparmor: remove unneeded one-line hook wrappers

Gustavo A. R. Silva (1):
      apparmor: Use struct_size() helper in kzalloc()

Hamza Mahfooz (1):
      apparmor: use per file locks for transactional queries

John Johansen (5):
      apparmor: fix introspection of of task mode for unconfined tasks
      apparmor: update policy capable checks to use a label
      apparmor: switch to apparmor to internal capable check for policy management
      apparmor: Fix internal policy capable check for policy management
      apparmor: fix zero-length compiler warning in AA_BUG()

Mauricio Faria de Oliveira (1):
      apparmor: check/put label on apparmor_sk_clone_security()

Randy Dunlap (2):
      security: apparmor: file.h: delete duplicated word
      security: apparmor: delete repeated words in comments

Shaokun Zhang (1):
      apparmor: Remove the repeated declaration

Tom Rix (1):
      apparmor: fix error check

 security/apparmor/apparmorfs.c     | 17 +++++------
 security/apparmor/include/file.h   |  2 +-
 security/apparmor/include/label.h  |  5 +--
 security/apparmor/include/lib.h    |  9 ++++--
 security/apparmor/include/policy.h |  6 ++--
 security/apparmor/label.c          | 11 +++----
 security/apparmor/lsm.c            | 47 +++++++++++------------------
 security/apparmor/path.c           |  2 +-
 security/apparmor/policy.c         | 62 +++++++++++++++++++++++++++++++-------
 security/apparmor/policy_unpack.c  |  2 +-
 security/apparmor/procattr.c       |  2 --
 11 files changed, 97 insertions(+), 68 deletions(-)
