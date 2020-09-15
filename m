Return-Path: <SRS0=nJ8u=CY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE69C43461
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Sep 2020 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3920F20756
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Sep 2020 20:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgIOUXg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:23:36 -0400
Received: from namei.org ([65.99.196.166]:57558 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgIOUWX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Sep 2020 16:22:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 08FKLTg6008561;
        Tue, 15 Sep 2020 20:21:29 GMT
Date:   Wed, 16 Sep 2020 06:21:29 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: device_cgroup RCU warning fix
Message-ID: <alpine.LRH.2.21.2009160619400.8445@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This was posted a while back and been baking in -next for a while, please 
consider for 5.9.


The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.9a

for you to fetch changes up to bc62d68e2a0a69fcdcf28aca8edb01abf306b698:

  device_cgroup: Fix RCU list debugging warning (2020-08-20 11:25:03 -0700)

----------------------------------------------------------------
device_cgroup RCU warning fix from Amol Grover <frextrite@gmail.com>

----------------------------------------------------------------

Amol Grover (1):
      device_cgroup: Fix RCU list debugging warning

 security/device_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


commit bc62d68e2a0a69fcdcf28aca8edb01abf306b698
Author: Amol Grover <frextrite@gmail.com>
Date:   Mon Apr 6 16:29:50 2020 +0530

    device_cgroup: Fix RCU list debugging warning
    
    exceptions may be traversed using list_for_each_entry_rcu()
    outside of an RCU read side critical section BUT under the
    protection of decgroup_mutex. Hence add the corresponding
    lockdep expression to fix the following false-positive
    warning:
    
    [    2.304417] =============================
    [    2.304418] WARNING: suspicious RCU usage
    [    2.304420] 5.5.4-stable #17 Tainted: G            E
    [    2.304422] -----------------------------
    [    2.304424] security/device_cgroup.c:355 RCU-list traversed in non-reader section!!
    
    Signed-off-by: Amol Grover <frextrite@gmail.com>
    Signed-off-by: James Morris <jmorris@namei.org>

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 43ab0ad45c1b..04375df52fc9 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -354,7 +354,8 @@ static bool match_exception_partial(struct list_head *exceptions, short type,
 {
 	struct dev_exception_item *ex;
 
-	list_for_each_entry_rcu(ex, exceptions, list) {
+	list_for_each_entry_rcu(ex, exceptions, list,
+				lockdep_is_held(&devcgroup_mutex)) {
 		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
 			continue;
 		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
