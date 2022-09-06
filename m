Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7755DC38145
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Sep 2022 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiIFVD5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIFVDv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Sep 2022 17:03:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E897A9252
        for <linux-security-module@vger.kernel.org>; Tue,  6 Sep 2022 14:03:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b9so9173046qka.2
        for <linux-security-module@vger.kernel.org>; Tue, 06 Sep 2022 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date;
        bh=zxQ66m5smH23GnuOECwAiTPpsELUaznzezl4/ifu74Q=;
        b=M7VpfvSjm/xhgtLPB8T/3TywX/TwQtxWaF7Df56ET1MNqn08IrKYVhDDqikYYU4bZk
         ZyLlphwIrvabKTQi11OzmuwkiYXfi+3BzNXsxlWkPIIw9jKrdh6ioFpPyIF7BnvQZG7P
         15kKquPxU9JOp9n5QUqaFpvvL5qjJudyCm/sdMq4m+1ru/NEQCNcaegVzAHMptkOpA20
         U1qH6BMcrVOZfNqnV7ZAQtD0+TxhsWwg7bsu6JWGPurtECJVv3T8FAXMGkqRPhgAOYy+
         0WedvN9NsbMgU6U6YLnuSftryooyL9ghpvmM9Gf0kTBe27DTa++/WNPcSivcP9ikj4yd
         hv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date;
        bh=zxQ66m5smH23GnuOECwAiTPpsELUaznzezl4/ifu74Q=;
        b=sptQqeABqkK/AlNCdqqx4BjNOYbMtw21ZEmbnfd1sSapvBO8B88PyXQLvFM4K2P65o
         9utR2xO4OwqJZ8nNQ0VHbLVlwmq6YPLQ7sARKUiofaeUvI+vVwVB3+Innur1RAPfEVR3
         bZVn9oytchxGGCdBuhXF9XGmz6Qz/RgFz1k3PQkMotIEnsXCdHsmyBgY441W6xSl/dj6
         vqMnkyptVDdaJOZ26b6bucbDv7WBL+hPz9QswtnlxWBZ0XHn1nbg7hN9aYZbcve4gwAV
         RHLNtENlTOdGYIhVsSrPGwT1MlGqELEm7kD5azy8kapNsM5MsQEvpKAwIZ5cwKUtD5EZ
         dYyA==
X-Gm-Message-State: ACgBeo2GhC0Cv47J74kMOSko9rvFvGEP4rVNf1+6aktaVrVlKXBwMwVb
        9R35qhHumZ/Exxzqvtt0/pk1
X-Google-Smtp-Source: AA6agR7SkQibN9yqKoWTbVD1M3dgQcyRamfkXa6npPHkPIwXqfb7VFKVYavZTtR0SJ4LPkIJjS2bjg==
X-Received: by 2002:a05:620a:1018:b0:6bc:638d:cf54 with SMTP id z24-20020a05620a101800b006bc638dcf54mr428624qkj.161.1662498229300;
        Tue, 06 Sep 2022 14:03:49 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87a98000000b003431446588fsm10351464qtr.5.2022.09.06.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:03:48 -0700 (PDT)
Subject: [v5.19.y PATCH 2/3] selinux: implement the security_uring_cmd() LSM
 hook
From:   Paul Moore <paul@paul-moore.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Tue, 06 Sep 2022 17:03:48 -0400
Message-ID: <166249822847.409408.9982274436178494091.stgit@olly>
In-Reply-To: <166249766105.409408.12118839467847524983.stgit@olly>
References: <166249766105.409408.12118839467847524983.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Backport the following upstream commit into Linux v5.19.y:

    commit f4d653dcaa4e4056e1630423e6a8ece4869b544f
    Author: Paul Moore <paul@paul-moore.com>
    Date:   Wed Aug 10 15:55:36 2022 -0400

    selinux: implement the security_uring_cmd() LSM hook

    Add a SELinux access control for the iouring IORING_OP_URING_CMD
    command.  This includes the addition of a new permission in the
    existing "io_uring" object class: "cmd".  The subject of the new
    permission check is the domain of the process requesting access, the
    object is the open file which points to the device/file that is the
    target of the IORING_OP_URING_CMD operation.  A sample policy rule
    is shown below:

      allow <domain> <file>:io_uring { cmd };

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c            |   24 ++++++++++++++++++++++++
 security/selinux/include/classmap.h |    2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1bbd53321d13..e90dfa36f79a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -91,6 +91,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
+#include <linux/io_uring.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6990,6 +6991,28 @@ static int selinux_uring_sqpoll(void)
 	return avc_has_perm(&selinux_state, sid, sid,
 			    SECCLASS_IO_URING, IO_URING__SQPOLL, NULL);
 }
+
+/**
+ * selinux_uring_cmd - check if IORING_OP_URING_CMD is allowed
+ * @ioucmd: the io_uring command structure
+ *
+ * Check to see if the current domain is allowed to execute an
+ * IORING_OP_URING_CMD against the device/file specified in @ioucmd.
+ *
+ */
+static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
+{
+	struct file *file = ioucmd->file;
+	struct inode *inode = file_inode(file);
+	struct inode_security_struct *isec = selinux_inode(inode);
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_FILE;
+	ad.u.file = file;
+
+	return avc_has_perm(&selinux_state, current_sid(), isec->sid,
+			    SECCLASS_IO_URING, IO_URING__CMD, &ad);
+}
 #endif /* CONFIG_IO_URING */
 
 /*
@@ -7234,6 +7257,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 #ifdef CONFIG_IO_URING
 	LSM_HOOK_INIT(uring_override_creds, selinux_uring_override_creds),
 	LSM_HOOK_INIT(uring_sqpoll, selinux_uring_sqpoll),
+	LSM_HOOK_INIT(uring_cmd, selinux_uring_cmd),
 #endif
 
 	/*
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ff757ae5f253..1c2f41ff4e55 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -253,7 +253,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "anon_inode",
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "io_uring",
-	  { "override_creds", "sqpoll", NULL } },
+	  { "override_creds", "sqpoll", "cmd", NULL } },
 	{ NULL }
   };
 

