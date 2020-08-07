Return-Path: <SRS0=PbfF=BR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D5C433DF
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Aug 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059A622CAE
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Aug 2020 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTriFmLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgHGQvH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGQvG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Aug 2020 12:51:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F3C061756;
        Fri,  7 Aug 2020 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RIJQU5bJaS8+eeCwZwEF7PZkGZvsc2GUo4LIjXOFzL4=; b=ZTriFmLmu37Bl8o4aFw4yGjsYf
        mUMtfra9EPFNHrMz9UdYXkutIVuRepDozrjR7DEAcJTyRQua4JkK+haql12L+CIbSjLtkaX3bTkgF
        FA89cf/7y4rBYjNc0mXs4V9rkFjl5iVbeTATmE0RPXK907TORFu7AYykPGmuB7Wnr1eYIrnekMscx
        kZS8dYKwk7Czg87K4/QLDH6k0C7A9fIm9joaFFsAFyy1s1OQFj+2bQqkT3RlsPuU3HFr5Ab66iDb1
        EAN8UKI1SVVG1cyGEzFn3XuKF8w7/Rl0N+Ye8CiW91sBbDAowG1SmUFiRlZVbjTTUo3s/bXKGP9NC
        5SZkLVHw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k45a6-0004EV-RK; Fri, 07 Aug 2020 16:50:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH] security: apparmor: delete repeated words in comments
Date:   Fri,  7 Aug 2020 09:50:55 -0700
Message-Id: <20200807165055.3756-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
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
---
 security/apparmor/include/file.h  |    2 +-
 security/apparmor/path.c          |    2 +-
 security/apparmor/policy_unpack.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200731.orig/security/apparmor/include/file.h
+++ linux-next-20200731/security/apparmor/include/file.h
@@ -167,7 +167,7 @@ int aa_audit_file(struct aa_profile *pro
  * @perms: permission table indexed by the matched state accept entry of @dfa
  * @trans: transition table for indexed by named x transitions
  *
- * File permission are determined by matching a path against @dfa and then
+ * File permission are determined by matching a path against @dfa and
  * then using the value of the accept entry for the matching state as
  * an index into @perms.  If a named exec transition is required it is
  * looked up in the transition table.
--- linux-next-20200731.orig/security/apparmor/path.c
+++ linux-next-20200731/security/apparmor/path.c
@@ -83,7 +83,7 @@ static int disconnect(const struct path
  *
  * Returns: %0 else error code if path lookup fails
  *          When no error the path name is returned in @name which points to
- *          to a position in @buf
+ *          a position in @buf
  */
 static int d_namespace_path(const struct path *path, char *buf, char **name,
 			    int flags, const char *disconnected)
--- linux-next-20200731.orig/security/apparmor/policy_unpack.c
+++ linux-next-20200731/security/apparmor/policy_unpack.c
@@ -39,7 +39,7 @@
 
 /*
  * The AppArmor interface treats data as a type byte followed by the
- * actual data.  The interface has the notion of a a named entry
+ * actual data.  The interface has the notion of a named entry
  * which has a name (AA_NAME typecode followed by name string) followed by
  * the entries typecode and data.  Named types allow for optional
  * elements and extensions to be added and tested for without breaking
