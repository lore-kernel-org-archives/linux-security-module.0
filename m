Return-Path: <SRS0=qseI=6O=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC9C47253
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Apr 2020 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062272082E
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Apr 2020 15:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ew1UPCIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgD3Pwr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbgD3Pwr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 11:52:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC1C035495
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 08:52:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so7528810wrg.11
        for <linux-security-module@vger.kernel.org>; Thu, 30 Apr 2020 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZo6TuIE/5CcefbKGNzYSvkrg5IwPl6ltYNRWOcMaDk=;
        b=ew1UPCIe8ZacX7ovq7/6qUDJlJ+5LH1pYI4Qv9R/87Ys89GVuota9rIBbMd+Td5GWP
         8srIJ0cNMt9MTgjfWwAgBPDSbyGXi2rTY+X8LXmJodhZf7wgiI/EEWIy8gdcw6riIP5z
         fHQPkxuMdWBZXVn52OJZXfEr54kzDCckCz0FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZo6TuIE/5CcefbKGNzYSvkrg5IwPl6ltYNRWOcMaDk=;
        b=qOY2akC1KOFRvMI75+xpDCPe+KGFl1SekkLCsSFFY8HRQLNoHSBa06oRbOqFLCARQp
         F2Vzd6IA+61YA3f+OsOu/mLl7dqQhTTcNJTM2VLlOGEEJsFJCQoiBa/ReCN5wI2gIkhU
         se5FsmVh4jrQRa8s4dbIpgr6pS8MSoLcnRRoYtovsoI/UiR4jLFyWbxOkWvZ08IKxc1z
         pT28p2XwcDSu4ePOHr5aaY8McVxG7PzlH6axawa83dd4D1eA/qHTeDYrGEpelYUgDFyC
         qarNHpLKKeKsRyCVCB4P4GjctxvKsxvrrFuAjRurGK08UJa4/h89rbCj0ILzenkM0FOY
         IG3Q==
X-Gm-Message-State: AGi0PubapcVsG4BWY2XPdPl7uuVHdlLtV9ZdRJBJCs9+pg1doC2tY5gl
        jp+hcoeD/rsyjLxts9ybhL3TqA==
X-Google-Smtp-Source: APiQypKcObnvK7/azf9dwTI9MsY5sG6t8DBheJsjVNGF56u65EmqYwLcS0U3EwbjygZUPfHV+1Q/fg==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr4800271wre.101.1588261965505;
        Thu, 30 Apr 2020 08:52:45 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a125sm123421wme.3.2020.04.30.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:52:44 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: [PATCH bpf] security: Fix the default value of fs_context_parse_param hook
Date:   Thu, 30 Apr 2020 17:52:40 +0200
Message-Id: <20200430155240.68748-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

security_fs_context_parse_param is called by vfs_parse_fs_param and
a succussful return value (i.e 0) implies that a parameter will be
consumed by the LSM framework. This stops all further parsing of the
parmeter by VFS. Furthermore, if an LSM hook returns a success, the
remaining LSM hooks are not invoked for the parameter.

The current default behavior of returning success means that all the
parameters are expected to be parsed by the LSM hook and none of them
end up being populated by vfs in fs_context

This was noticed when lsm=bpf is supplied on the command line before any
other LSM. As the bpf lsm uses this default value to implement a default
hook, this resulted in a failure to parse any fs_context parameters and
a failure to mount the root filesystem.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..1bdd027766d4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -55,7 +55,7 @@ LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
-LSM_HOOK(int, 0, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
-- 
2.26.2.303.gf8c07b1a785-goog

