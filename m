Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B58DC49EA3
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Jun 2021 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5AB61415
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Jun 2021 13:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFENUc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Jun 2021 09:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhFENU1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7945261456;
        Sat,  5 Jun 2021 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899118;
        bh=JmkxZbG0Dzpqyif7bYYY62pQc/1q5Vp2mW4DafqUD9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEU3HnoUOGVwHG4GOZPzAmDwfX84nFO9FFOjsZsjU9MbabfiElLA72X8LcDLbJHp+
         LyX6j36mcF+YuCEquenyX049Vz94IQCzFXhnGwEFJGed2C6pTfLwuO3wb0sbDWvKgW
         uO2VDL231/2bl64mW6z7nHw2kLNOd8SjNB+xQMQCxmrpptS+lQUHmy157KiyTCI6jL
         87tGxZyZJVPB9mFiaXpV0u8hErlMRR688KI3vtQ4zdq1SkscPPWu+3ed8YFbxsR+on
         iunidDVbs+amECjmYSruZw3dFhifYif2HcfPrYX3QkWrJEngNkyDlhIhINSbJk7Ebb
         +p3VgbKv+Nagg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GGL-Kq; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 29/34] docs: security: landlock.rst: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:28 +0200
Message-Id: <07fc83f40702a11a60ca12c9345346e52f14f4ef.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
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

