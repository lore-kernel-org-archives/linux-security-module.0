Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D2C49EA7
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Jun 2021 06:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF095613D0
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Jun 2021 06:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFPGaL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Jun 2021 02:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhFPG34 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E57D261412;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824869;
        bh=BSGXxyqvPvWufTNDi9kWzIf7K9GAT+ID0ZQoJHx3Or0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6e8xlstdyJpBZFRTUthfn8Hk59Lbc2oPV2xSkY6kCv3//DYdAUBIJIJxt4eeMNbk
         nASmYDsWYc6/rfkhU8upcIu5ybZ8vUpv4sfH4iSN/a16Q7H1O+bZIPdsIKVR6LOqlb
         5SZo1aN9fApAxTY5rWQgUryLSvVO6Q4LbumI6/ijcPcQIQzWdbGooJ57T39hln0SDq
         PdK48a8jojmfK/o3jetjWKkMU+8mjOC10NS0Fqip+sz3UmKyT/riBsYHCf8yUqjoBJ
         KUTgW1AWwXqJJenkZLKZqRkKxhwzXJPksH9sq8f7iDYUCmQRxwgSXzK991JnVxa+5i
         FarkTBsdCIypg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1f-004kK2-6n; Wed, 16 Jun 2021 08:27:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 27/29] docs: userspace-api: landlock.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:42 +0200
Message-Id: <24888a9c5da3c505b2bc274fcd83be348dbaf972.1623824363.git.mchehab+huawei@kernel.org>
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
 Documentation/userspace-api/landlock.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 62c9361a3c7f..f35552ff19ba 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -145,7 +145,8 @@ Bind mounts and OverlayFS
 
 Landlock enables to restrict access to file hierarchies, which means that these
 access rights can be propagated with bind mounts (cf.
-:doc:`/filesystems/sharedsubtree`) but not with :doc:`/filesystems/overlayfs`.
+Documentation/filesystems/sharedsubtree.rst) but not with
+Documentation/filesystems/overlayfs.rst.
 
 A bind mount mirrors a source file hierarchy to a destination.  The destination
 hierarchy is then composed of the exact same files, on which Landlock rules can
@@ -170,8 +171,8 @@ Inheritance
 
 Every new thread resulting from a :manpage:`clone(2)` inherits Landlock domain
 restrictions from its parent.  This is similar to the seccomp inheritance (cf.
-:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task's
-:manpage:`credentials(7)`.  For instance, one process's thread may apply
+Documentation/userspace-api/seccomp_filter.rst) or any other LSM dealing with
+task's :manpage:`credentials(7)`.  For instance, one process's thread may apply
 Landlock rules to itself, but they will not be automatically applied to other
 sibling threads (unlike POSIX thread credential changes, cf.
 :manpage:`nptl(7)`).
@@ -278,7 +279,7 @@ Memory usage
 ------------
 
 Kernel memory allocated to create rulesets is accounted and can be restricted
-by the :doc:`/admin-guide/cgroup-v1/memory`.
+by the Documentation/admin-guide/cgroup-v1/memory.rst.
 
 Questions and answers
 =====================
@@ -303,7 +304,7 @@ issues, especially when untrusted processes can manipulate them (cf.
 Additional documentation
 ========================
 
-* :doc:`/security/landlock`
+* Documentation/security/landlock.rst
 * https://landlock.io
 
 .. Links
-- 
2.31.1

