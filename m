Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA67C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 03:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2419722B3B
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Dec 2020 03:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgLUDsE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 20 Dec 2020 22:48:04 -0500
Received: from casper.infradead.org ([90.155.50.34]:38482 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgLUDsE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 20 Dec 2020 22:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZJVSch0SZkzI+63yW/zf68R+PNFMBkCVh2UVvuoPHQ0=; b=FvLM4dRm+zGG/JNC13xdRx4IP4
        Lfd3/YFZN7t+hMGOFd7Ln3sVKCQSSrCkhMcuzkWMLHNQcCHxz/tQCIERYmb0Ra6OHSmScZ/hqz0dO
        aHl827ZnmMdtFzqMDuvcr8tCIIPn1wNUfcPwdUrKpN/Xx/uRn8N0FfWiz8sBaJQ71H2/XTIuYb/Rs
        twfmyKCnmEt2qY1YaVnm59DeF93stm6mIP5M4WptQ2OYYNz1srm0d5Z2NIau+FZYVXVE67nQOR8bO
        L4uJbyZ2f5JZ0MJTno/C85hWI87AGlXoBEJF9dC4API+ECvgGmF/5k+asMZsc1bSFRqYFWKLtz4Sx
        +/p550gg==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krBrM-0007GQ-KT; Mon, 21 Dec 2020 03:27:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Seth Arnold <seth.arnold@canonical.com>
Subject: [PATCH v2] security: apparmor: delete repeated words in comments
Date:   Sun, 20 Dec 2020 19:27:39 -0800
Message-Id: <20201221032739.11379-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Drop repeated words in comments.
{a, then, to}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: apparmor@lists.ubuntu.com
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Reviewed-By: Seth Arnold <seth.arnold@canonical.com>
---
v2: rebase

 security/apparmor/include/file.h  |    2 +-
 security/apparmor/path.c          |    2 +-
 security/apparmor/policy_unpack.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20201218.orig/security/apparmor/include/file.h
+++ linux-next-20201218/security/apparmor/include/file.h
@@ -167,7 +167,7 @@ int aa_audit_file(struct aa_profile *pro
  * @perms: permission table indexed by the matched state accept entry of @dfa
  * @trans: transition table for indexed by named x transitions
  *
- * File permission are determined by matching a path against @dfa and then
+ * File permission are determined by matching a path against @dfa and
  * then using the value of the accept entry for the matching state as
  * an index into @perms.  If a named exec transition is required it is
  * looked up in the transition table.
--- linux-next-20201218.orig/security/apparmor/path.c
+++ linux-next-20201218/security/apparmor/path.c
@@ -83,7 +83,7 @@ static int disconnect(const struct path
  *
  * Returns: %0 else error code if path lookup fails
  *          When no error the path name is returned in @name which points to
- *          to a position in @buf
+ *          a position in @buf
  */
 static int d_namespace_path(const struct path *path, char *buf, char **name,
 			    int flags, const char *disconnected)
--- linux-next-20201218.orig/security/apparmor/policy_unpack.c
+++ linux-next-20201218/security/apparmor/policy_unpack.c
@@ -39,7 +39,7 @@
 
 /*
  * The AppArmor interface treats data as a type byte followed by the
- * actual data.  The interface has the notion of a a named entry
+ * actual data.  The interface has the notion of a named entry
  * which has a name (AA_NAME typecode followed by name string) followed by
  * the entries typecode and data.  Named types allow for optional
  * elements and extensions to be added and tested for without breaking
