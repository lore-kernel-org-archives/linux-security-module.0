Return-Path: <SRS0=jOYs=T4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6CC04AB6
	for <linux-security-module@archiver.kernel.org>; Tue, 28 May 2019 15:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCD421530
	for <linux-security-module@archiver.kernel.org>; Tue, 28 May 2019 15:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sprd9OI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE1P6s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 May 2019 11:58:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41930 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1P6s (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 11:58:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so6903591pfq.8
        for <linux-security-module@vger.kernel.org>; Tue, 28 May 2019 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFPRydaFCZdMmPVKvDXNj7xYRJ6Ig+LceXzLBCa7YDs=;
        b=Sprd9OI3bkm3dypWoWDIKrSKfd/7d79CGN+OXc14Vv1SIB7UPm7OFoQLebBbZBO9pc
         2V6xcybmJzIjl1iKqZvsApO2z0KewajjWltSt/ZU+Trs2CsWkB5jSmkdTam3JZsfmkpK
         rnEKa+XTfkW932JroQIwGVVApU+Ik9ynKTB60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFPRydaFCZdMmPVKvDXNj7xYRJ6Ig+LceXzLBCa7YDs=;
        b=QEe6rdLAI88sMgjcds82K0Js1XG3Ogq90dF17X8V5feLhK2/k1emLySDE8tXvtyhbg
         pdMwmYiBAC/VB/9GXcSpmm2J0sH2Xn2QUf3Wsv3ZCYSKrtavZ0WzjNgA0ySHKD7KtL9h
         mFO3QeKkx0ZCeEyj3EK/DOr9WpI5CumqNzKhRXyQxh1lB34xWfBmBYqbVkIQ0LxdCKxn
         /0C7SG7VBpJRQbA5HZqluyzrCAaUWlv5OS/JqRDw29C6hsZqP/ebSpjvB2GqQ6RJa7Uw
         5Y9l/R/urdkqOqRxzW0HWQM2G9OgyUrQDtn1Y6W/vIi0JRpGmnCDXvEoZq8LRy02o6UM
         tE4w==
X-Gm-Message-State: APjAAAXF/OTSoVFCDUHOCJ6wYmSFkEJqI3UQpt8xMTqm79kd1oqe74PA
        XJ/7YfJuxqPvec+UkrgmrRfe6w==
X-Google-Smtp-Source: APXvYqx07YqNRJYiralbY+vojx7cPsO3oW8EfMGmgP4XT0F64Orf4475J8DRHOF7rDFEchpgtuPCwQ==
X-Received: by 2002:aa7:8b57:: with SMTP id i23mr62666199pfd.54.1559059127432;
        Tue, 28 May 2019 08:58:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9e10:971c:f11c:a814])
        by smtp.gmail.com with ESMTPSA id b67sm15992131pfb.150.2019.05.28.08.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:58:46 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Subject: [PATCH] LSM: Fix formatting errors in SafeSetID LSM docs
Date:   Tue, 28 May 2019 08:58:44 -0700
Message-Id: <20190528155844.171547-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This fixes the unintended occurrences of ??? in the text.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 Documentation/admin-guide/LSM/SafeSetID.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/SafeSetID.rst b/Documentation/admin-guide/LSM/SafeSetID.rst
index 212434ef65ad..aa41fdb211ff 100644
--- a/Documentation/admin-guide/LSM/SafeSetID.rst
+++ b/Documentation/admin-guide/LSM/SafeSetID.rst
@@ -56,7 +56,7 @@ setid capabilities from the application completely and refactor the process
 spawning semantics in the application (e.g. by using a privileged helper program
 to do process spawning and UID/GID transitions). Unfortunately, there are a
 number of semantics around process spawning that would be affected by this, such
-as fork() calls where the program doesn???t immediately call exec() after the
+as fork() calls where the program does not immediately call exec() after the
 fork(), parent processes specifying custom environment variables or command line
 args for spawned child processes, or inheritance of file handles across a
 fork()/exec(). Because of this, as solution that uses a privileged helper in
@@ -72,7 +72,7 @@ own user namespace, and only approved UIDs/GIDs could be mapped back to the
 initial system user namespace, affectively preventing privilege escalation.
 Unfortunately, it is not generally feasible to use user namespaces in isolation,
 without pairing them with other namespace types, which is not always an option.
-Linux checks for capabilities based off of the user namespace that ???owns??? some
+Linux checks for capabilities based off of the user namespace that "owns" some
 entity. For example, Linux has the notion that network namespaces are owned by
 the user namespace in which they were created. A consequence of this is that
 capability checks for access to a given network namespace are done by checking
-- 
2.22.0.rc1.257.g3120a18244-goog

