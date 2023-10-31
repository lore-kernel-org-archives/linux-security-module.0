Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B466C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Oct 2023 12:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjJaMdm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Oct 2023 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjJaMdl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Oct 2023 08:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FFCDB
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01Cuhkq/fZzHdIhk7dn370LtT6qVzQS52GEFoCa52Y8=;
        b=EdtapYptE4dF+vxj562P0hSPy2uAL35r53AHMWkD7YCa42vB6SsbZurbPJOaBQ6Urson7A
        hsD1AuHpQs+wGt29wsc71LxUjbMO1DI0MRrtyhePN/GGE7CBE/8Vq16XWW1g6qQy1mN2gX
        KM2ADC+jJw5m3EWP2F3vjCdgiaXTCMo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-U-TJKo_NP0my1sbQVWSu8A-1; Tue, 31 Oct 2023 08:32:12 -0400
X-MC-Unique: U-TJKo_NP0my1sbQVWSu8A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7789a691086so687849785a.0
        for <linux-security-module@vger.kernel.org>; Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755532; x=1699360332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01Cuhkq/fZzHdIhk7dn370LtT6qVzQS52GEFoCa52Y8=;
        b=I8epz3A3JAsgn2jXOPcdp5th+G0zZSWjC61eISJ3A3+mGzhHbuvbhJiTXI/ocC0yGt
         inUIcYuJTT3UIxodsqj/0ZqRfaHj4fZMREY11+wcH3n1CVTdt+R6sd+o4sdrgBGOKfnt
         SWqyBjA78OgZJ3FaEzl33bQhXa7hUZMr/PDnS8WIhOPOdoZwuA/UBJ4nE0mzMrN8ShKO
         S1WrcghGtXIdz6/CpZVGAS8XvlSrOqhYFotQxWyvHrzoQvITFV3MLtEfhjvoGZ6amdJ4
         WEsPjRMDDCzV87bJZudTrFCe1MNd5oetmKl83/MWuwLwyQzV9rh2ESHaq05HPwWllnQ3
         cY7Q==
X-Gm-Message-State: AOJu0YyOEiJWfXCOdghq6WD5pt9YcMo1QHnseSye0fRSchJc1yxoGtxi
        gYGlUI+5OxkRqRjrqsJ/8G4VrdleZE0Ke7Oo3kb75nEdQbxaDwpCzbS94y62AIMJnw3srDvJS+q
        T7U0a5a3ZFxL4joennS4kEtsg+efQShWAkzyk
X-Received: by 2002:a05:620a:4109:b0:775:681d:dc06 with SMTP id j9-20020a05620a410900b00775681ddc06mr15146856qko.63.1698755532024;
        Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtP5GHt2Cr+NcxBoAmMp/ehlVMchXJA7rXREzot7xDH4Twt77eyMwn8XXa3E8PspHWfUt1Kg==
X-Received: by 2002:a05:620a:4109:b0:775:681d:dc06 with SMTP id j9-20020a05620a410900b00775681ddc06mr15146835qko.63.1698755531737;
        Tue, 31 Oct 2023 05:32:11 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:11 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lsm: fix default return value for vm_enough_memory
Date:   Tue, 31 Oct 2023 13:32:06 +0100
Message-ID: <20231031123207.758655-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031123207.758655-1-omosnace@redhat.com>
References: <20231031123207.758655-1-omosnace@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

1 is the return value that implements a "no-op" hook, not 0.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 99b8176c3738d..4dd55fdfec267 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
-- 
2.41.0

