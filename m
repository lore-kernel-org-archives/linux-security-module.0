Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA8C3526B
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6BF23BA7
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Dec 2020 23:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394167AbgLJWbW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:31:22 -0500
Received: from namei.org ([65.99.196.166]:60274 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405118AbgLJWYm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Dec 2020 17:24:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 28F6DDBF;
        Thu, 10 Dec 2020 22:16:53 +0000 (UTC)
Date:   Fri, 11 Dec 2020 09:16:53 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [SECURITY] fix namespaced fscaps when !CONFIG_SECURITY
Message-ID: <bc4788a7-77ed-693-9b3a-52ab9bacc3b@namei.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1130980013-1607638613=:97768"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1130980013-1607638613=:97768
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Please apply this config bugfix from Serge Hallyn.


The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.10a

for you to fetch changes up to ed9b25d1970a4787ac6a39c2091e63b127ecbfc1:

  [SECURITY] fix namespaced fscaps when !CONFIG_SECURITY (2020-12-04 16:24:11 -0800)

----------------------------------------------------------------
Fix namespaced fscaps when !CONFIG_SECURITY from Serge Hallyn.

----------------------------------------------------------------
Serge Hallyn (1):
      [SECURITY] fix namespaced fscaps when !CONFIG_SECURITY

 include/linux/security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

commit ed9b25d1970a4787ac6a39c2091e63b127ecbfc1
Author: Serge Hallyn <shallyn@cisco.com>
Date:   Sun Nov 15 21:55:31 2020 -0600

    [SECURITY] fix namespaced fscaps when !CONFIG_SECURITY
    
    Namespaced file capabilities were introduced in 8db6c34f1dbc .
    When userspace reads an xattr for a namespaced capability, a
    virtualized representation of it is returned if the caller is
    in a user namespace owned by the capability's owning rootid.
    The function which performs this virtualization was not hooked
    up if CONFIG_SECURITY=n.  Therefore in that case the original
    xattr was shown instead of the virtualized one.
    
    To test this using libcap-bin (*1),
    
    $ v=$(mktemp)
    $ unshare -Ur setcap cap_sys_admin-eip $v
    $ unshare -Ur setcap -v cap_sys_admin-eip $v
    /tmp/tmp.lSiIFRvt8Y: OK
    
    "setcap -v" verifies the values instead of setting them, and
    will check whether the rootid value is set.  Therefore, with
    this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
    fail:
    
    $ v=$(mktemp)
    $ unshare -Ur setcap cap_sys_admin=eip $v
    $ unshare -Ur setcap -v cap_sys_admin=eip $v
    nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []
    
    Fix this bug by calling cap_inode_getsecurity() in
    security_inode_getsecurity() instead of returning
    -EOPNOTSUPP, when CONFIG_SECURITY=n.
    
    *1 - note, if libcap is too old for getcap to have the '-n'
    option, then use verify-caps instead.
    
    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209689
    Cc: Hervé Guillemet <herve@guillemet.org>
    Acked-by: Casey Schaufler <casey@schaufler-ca.com>
    Signed-off-by: Serge Hallyn <shallyn@cisco.com>
    Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
    Signed-off-by: James Morris <jamorris@linux.microsoft.com>

diff --git a/include/linux/security.h b/include/linux/security.h
index 0a0a03b36a3b..2befc0a25eb3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -864,7 +864,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
 
 static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
-	return -EOPNOTSUPP;
+	return cap_inode_getsecurity(inode, name, buffer, alloc);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
--1665246916-1130980013-1607638613=:97768--
