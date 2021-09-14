Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED30C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 13:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AB1610CE
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 13:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhINNQj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233196AbhINNQi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 09:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631625320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8AGKzr+oRC5GYz0wBdMzYsM8X6P4NYt2n4psRw6ien0=;
        b=gd609ArCLd0v8g4WcC1ysnNzLSLWjnKvZ2iZfgHULRKZv90DwRtQJnwc6ahQ9qnG8+guD6
        gLCKTzNDfs1PEhwO/n4plpUpHkJYPsFiq1AN10HMKJTTaGJTEjIWugfRD3d/kpje+6jrOD
        +Zb71PmUZgnpBamzvLWJTofdTLUBB+g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-M7AfPabZNgi6KTSWmVMThg-1; Tue, 14 Sep 2021 09:15:19 -0400
X-MC-Unique: M7AfPabZNgi6KTSWmVMThg-1
Received: by mail-wr1-f71.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so3937499wrn.12
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 06:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8AGKzr+oRC5GYz0wBdMzYsM8X6P4NYt2n4psRw6ien0=;
        b=vrtQvb4FuCMpgLQpZzK4wZqSkwh4rzR0kHxeeARF9OOIelgABzhJfZHxv4o3laCGyE
         5nGUftBiNMxngIqgok5vdjSddZstHDhfARhzwrQ+34EA2ZijsznSUH6QgC8Z/8/XP+F3
         Vo9wum6/KDea9gOKCGfXJfqTJkVv99yujbqwtqhwH/NqqLlZIg+mRwQI+3S17ToMU4vN
         QiaejABbRYOCRarI8FSsyEBNdn8mWaAwLHlCtUHN37KDmnH1afN1TbQxzOGL+stffZY5
         akjwvOUvmLXtJMl4myqRaaWl/uWlvYvtZTVP/aPbGdMhnLM0hHqDhYGorgNGwSDY9zGq
         47qQ==
X-Gm-Message-State: AOAM5322jFnQ0rrJMJhZU7CiaFS91vPErfx37XFd6vb7QwoTdTA36k38
        D9J51vsDgoBDiC4zLTaBE7EoHhzDaZ5XOOWC55lBHU1k4o6C1CIo/GPuDysYY2k9dJ222tL+W1O
        6XXq1WAMDuYQ3N6yI69TrXL95pCZvm5d8yQrFNgO5it/fAMdHpIK3lrKIk5lo937DmzTL8ZoE/A
        cfZ23/NNO4T8wI
X-Received: by 2002:adf:e546:: with SMTP id z6mr8483900wrm.346.1631625318197;
        Tue, 14 Sep 2021 06:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8qm4+m87yA83VrUN+yEmO4pgSfl7wdTvMqVbJGKl9XmCDUQgWL0U7wkaTO24mrUvED0Vi9A==
X-Received: by 2002:adf:e546:: with SMTP id z6mr8483867wrm.346.1631625317944;
        Tue, 14 Sep 2021 06:15:17 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y9sm1276487wmj.36.2021.09.14.06.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 06:15:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        linux-audit@redhat.com
Subject: [PATCH] lsm_audit: avoid overloading the "key" audit field
Date:   Tue, 14 Sep 2021 15:15:16 +0200
Message-Id: <20210914131516.128823-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The "key" field is used to associate records with the rule that
triggered them, os it's not a good idea to overload it with an
additional IPC key semantic. Moreover, as the classic "key" field is a
text field, while the IPC key is numeric, AVC records containing the IPC
key info actually confuse audit userspace, which tries to interpret the
number as a hex-encoded string, thus showing garbage for example in the
ausearch "interpret" output mode.

Hence, change it to "ipc_key" to fix both issues and also make the
meaning of this field more clear.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/lsm_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 5a5016ef43b0..1897cbf6fc69 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -224,7 +224,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_NONE:
 		return;
 	case LSM_AUDIT_DATA_IPC:
-		audit_log_format(ab, " key=%d ", a->u.ipc_id);
+		audit_log_format(ab, " ipc_key=%d ", a->u.ipc_id);
 		break;
 	case LSM_AUDIT_DATA_CAP:
 		audit_log_format(ab, " capability=%d ", a->u.cap);
-- 
2.31.1

