Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260DEC433EF
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Jun 2022 16:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiF1QaT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347591AbiF1Q3L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877F37A82;
        Tue, 28 Jun 2022 09:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4672BB81EF1;
        Tue, 28 Jun 2022 16:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E765C341CE;
        Tue, 28 Jun 2022 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656433200;
        bh=AFbYjOXviL5rmJow0VE7Z2Ll+TzqAJN36EvtLVEyoBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBzJ3f2FDgtelVRVNO08rnuOooIsTtouQkRpgXCpCNlrB/uhh3U3M0Y7Gaklc4Be6
         K9jU1JlvI1U4vS1cR8t1RidM2DBfbQOSXbyVsTL/cqajjsJJgbh5CPp3f64W0kfaMa
         k1YnSbjkc6SNfm5JmCBc5JMshXme5LnHNvDzh9Z5UVvVnoecyX+xIc7esJBJYz8REh
         buTSXg17tbE0JcunijA8JsxSd5xejcCkFA+G4n7NLJv5Wzbp3BL2YAJZx6ppNLxR+i
         yilmppsQn6I8+Qxk1dabrbAZ7rnjLYqvi/MsbyFr60IVpV9VgbWIl8m1+yxJK/Ea8W
         xLHQd/m0Znfxg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v5 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM programs
Date:   Tue, 28 Jun 2022 16:19:46 +0000
Message-Id: <20220628161948.475097-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628161948.475097-1-kpsingh@kernel.org>
References: <20220628161948.475097-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In preparation for the addition of bpf_getxattr kfunc.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9b9d6117deae..0331caa98726 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7265,6 +7265,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
-- 
2.37.0.rc0.161.g10f37bed90-goog

