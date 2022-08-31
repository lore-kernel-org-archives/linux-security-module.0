Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F669ECAAD4
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Aug 2022 15:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiHaPYX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHaPYW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Aug 2022 11:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E6D87E2
        for <linux-security-module@vger.kernel.org>; Wed, 31 Aug 2022 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661959459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rps/yJBAwXB89WpAJeggNdBtdGS1yl5U+irzY4lHG4M=;
        b=bPrnXq/8mxUDHKj6pT/z32eUsaloWFl5p/elFg2ZVeNDzQ0iZSc43c9pOCkhg7vq/u8pl9
        jZSJRCu6C6t4S9DgJrPyeRq30SfEK6UFjATd2NPcJbMO86ubrDkRTzwlbJCanaRxd39w1O
        VlB6N2ZBpxVfmvGWc1UeQswga8zNtho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-cgakyn-RMqiyAdH_ON0bTQ-1; Wed, 31 Aug 2022 11:24:17 -0400
X-MC-Unique: cgakyn-RMqiyAdH_ON0bTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37BE4294EDCA;
        Wed, 31 Aug 2022 15:24:17 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08062909FF;
        Wed, 31 Aug 2022 15:24:15 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, alexei.starovoitov@gmail.com, jbenc@redhat.com,
        linux-security-module@vger.kernel.org,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [RFC PATCH v2] bpf: use bpf_capable() instead of CAP_SYS_ADMIN for blinding decision
Date:   Wed, 31 Aug 2022 18:24:14 +0300
Message-Id: <20220831152414.171484-1-ykaliuta@redhat.com>
In-Reply-To: <20220831090655.156434-1-ykaliuta@redhat.com>
References: <20220831090655.156434-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The capability check can cause SELinux denial.

For example, in ptp4l, setsockopt() with the SO_ATTACH_FILTER option
raises sk_attach_filter() to run a bpf program. SELinux hooks into
capable() calls and performs an additional check if the task's
SELinux domain has permission to "use" the given capability. ptp4l_t
already has CAP_BPF granted by SELinux, so if the function used
bpf_capable() as most BPF code does, there would be no change needed
in selinux-policy.

Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---

v2: put the reasoning in the commit message

---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..3de96b1a736b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1100,7 +1100,7 @@ static inline bool bpf_jit_blinding_enabled(struct bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden == 1 && capable(CAP_SYS_ADMIN))
+	if (bpf_jit_harden == 1 && bpf_capable())
 		return false;
 
 	return true;
-- 
2.34.1

