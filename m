Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13126C352A3
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97222086A
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBKRCs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:02:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgBKRCs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 12:02:48 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1Ysg-00014T-Iy; Tue, 11 Feb 2020 16:59:26 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 21/24] sys:__sys_setregid(): handle fsid mappings
Date:   Tue, 11 Feb 2020 17:57:50 +0100
Message-Id: <20200211165753.356508-22-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Switch setregid() to lookup fsids in the fsid mappings. If no fsid mappings are
setup the behavior is unchanged, i.e. fsids are looked up in the id mappings.

During setregid() the kfsgid is set to the kegid corresponding the egid that is
requested by userspace. If the requested egid is -1 the kfsgid is reset to the
current kegid. For the latter case this means we need to lookup the
corresponding userspace egid corresponding to the current kegid in the id
mappings and translate this egid into the corresponding kfsgid in the fsid
mappings.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/sys.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index ef1104c9df56..41551c01c3eb 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -354,15 +354,18 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 	const struct cred *old;
 	struct cred *new;
 	int retval;
-	kgid_t krgid, kegid;
+	kgid_t krgid, kegid, kfsgid;
 
 	krgid = make_kgid(ns, rgid);
 	kegid = make_kgid(ns, egid);
+	kfsgid = make_kfsgid(ns, egid);
 
 	if ((rgid != (gid_t) -1) && !gid_valid(krgid))
 		return -EINVAL;
 	if ((egid != (gid_t) -1) && !gid_valid(kegid))
 		return -EINVAL;
+	if ((egid != (gid_t) -1) && !gid_valid(kfsgid))
+		return -EINVAL;
 
 	new = prepare_creds();
 	if (!new)
@@ -386,12 +389,15 @@ long __sys_setregid(gid_t rgid, gid_t egid)
 			new->egid = kegid;
 		else
 			goto error;
+	} else {
+		gid_t fsgid = from_kgid_munged(new->user_ns, new->egid);
+		kfsgid = make_kfsgid(ns, fsgid);
 	}
 
 	if (rgid != (gid_t) -1 ||
 	    (egid != (gid_t) -1 && !gid_eq(kegid, old->gid)))
 		new->sgid = new->egid;
-	new->fsgid = new->egid;
+	new->fsgid = kfsgid;
 
 	return commit_creds(new);
 
-- 
2.25.0

