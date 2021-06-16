Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E8AC49EA4
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Jun 2021 06:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9911613F9
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Jun 2021 06:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhFPGaK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Jun 2021 02:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231686AbhFPG34 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C952E613F0;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=JmkxZbG0Dzpqyif7bYYY62pQc/1q5Vp2mW4DafqUD9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKiC2sD2sY76alIKtUdEJnZTJ0RuTZS6n9xZdrwiHo2emNFB+6IQgDa6+L2TOkVEb
         zYfC6BYFyS6VFN3PhbM29zFpP12IAZVQSFtql7LPGhP9/lyd3v7R8cJiEk7PKlgvI2
         cby87hDGloIjSrEhLGEANfUwOOvnpQjcxgRD8yJypFjQ4bXhV236OOaDglqp+AJjsy
         F9BRZPSA60DPhu4qnM0TcNL3rEzG3QCh36PQ09U0ognrO6eYImWy40Fnt9p/CulUgM
         WObdCIjUkT9ug+sLqGE56Y0Qcbn53FagLuZrLhOoWD9dTsGSFfcAOhmzp8K9GgIV35
         PVzCPGgzXTRxA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1f-004kJq-2q; Wed, 16 Jun 2021 08:27:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 24/29] docs: security: landlock.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:39 +0200
Message-Id: <9174021ef2c87f395a4cc0895a4b2f7fd97db626.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/security/landlock.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
index 2e84925ae971..3df68cb1d10f 100644
--- a/Documentation/security/landlock.rst
+++ b/Documentation/security/landlock.rst
@@ -25,7 +25,8 @@ Any user can enforce Landlock rulesets on their processes.  They are merged and
 evaluated according to the inherited ones in a way that ensures that only more
 constraints can be added.
 
-User space documentation can be found here: :doc:`/userspace-api/landlock`.
+User space documentation can be found here:
+Documentation/userspace-api/landlock.rst.
 
 Guiding principles for safe access controls
 ===========================================
-- 
2.31.1

