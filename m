Return-Path: <SRS0=g/MA=77=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F790C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 02:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A752220B
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jun 2020 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445833;
	bh=1WHcGKCjtY/FP1aiOnx74McpmOUqEmEpOQEdyKFF1yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRnRG8FE7ZEkjvVdcj+fd/E07GMZoQlytwst59YF82u1MN2olpZu0IVJzlnRu0W7V
	 4Tcr4+pugEmD1vPu6OMRlXMMLKSMHYn26KDAV1PLbvBEFmQ91OYGb+qIIizwzmQo6f
	 0o8NMj0/0c/NkcV71qSMm1ehOLzIyqDUNGb0kr8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgFRBXU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgFRBXU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FEA8214DB;
        Thu, 18 Jun 2020 01:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443399;
        bh=1WHcGKCjtY/FP1aiOnx74McpmOUqEmEpOQEdyKFF1yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYOBHYAvDC26lLZ0fAcC75gwZaG5DaILeDm5wc1ctF7FFm3mluaOYdB99x73lkHUv
         TaG3NHILjrnKvgFhy0dtTSPBTL6pbtrT0JhtJKCxdruAbA3wZ1dX5ZpAXYMo48mGHe
         l079BPCVtyHDKWzO3NTA3iOeWhErgK1Kav3kGP6c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/172] apparmor: fix introspection of of task mode for unconfined tasks
Date:   Wed, 17 Jun 2020 21:20:11 -0400
Message-Id: <20200618012218.607130-45-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit dd2569fbb053719f7df7ef8fdbb45cf47156a701 ]

Fix two issues with introspecting the task mode.

1. If a task is attached to a unconfined profile that is not the
   ns->unconfined profile then. Mode the mode is always reported
   as -

      $ ps -Z
      LABEL                               PID TTY          TIME CMD
      unconfined                         1287 pts/0    00:00:01 bash
      test (-)                           1892 pts/0    00:00:00 ps

   instead of the correct value of (unconfined) as shown below

      $ ps -Z
      LABEL                               PID TTY          TIME CMD
      unconfined                         2483 pts/0    00:00:01 bash
      test (unconfined)                  3591 pts/0    00:00:00 ps

2. if a task is confined by a stack of profiles that are unconfined
   the output of label mode is again the incorrect value of (-) like
   above, instead of (unconfined). This is because the visibile
   profile count increment is skipped by the special casing of
   unconfined.

Fixes: f1bd904175e8 ("apparmor: add the base fns() for domain labels")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 2469549842d2..6e7aa2ef8ee0 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -1535,13 +1535,13 @@ static const char *label_modename(struct aa_ns *ns, struct aa_label *label,
 
 	label_for_each(i, label, profile) {
 		if (aa_ns_visible(ns, profile->ns, flags & FLAG_VIEW_SUBNS)) {
-			if (profile->mode == APPARMOR_UNCONFINED)
+			count++;
+			if (profile == profile->ns->unconfined)
 				/* special case unconfined so stacks with
 				 * unconfined don't report as mixed. ie.
 				 * profile_foo//&:ns1:unconfined (mixed)
 				 */
 				continue;
-			count++;
 			if (mode == -1)
 				mode = profile->mode;
 			else if (mode != profile->mode)
-- 
2.25.1

