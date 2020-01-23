Return-Path: <SRS0=QZUe=3M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0EC33CB6
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6526522522
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jan 2020 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jp69RmQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAWPZK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:25:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36568 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAWPZK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so1548224pgc.3
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2020 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4x5KAd27m8l4DDargFurbUE9qKxXrSpODZZ6bpQ4NY=;
        b=Jp69RmQkL6xEcGqyr24OfJqADG68GZDN7XOwN3C6RbgKxk3YJckrojP9H/yfiLVGpD
         qxWHjOfZEMp2p7tz7HOgM5FsSgnfRGBg54bIj9ZW2VfOMvC9cDf9MxtKy4m9AdBGYb8b
         c/1qg6nFPcx20v7/fvgeAGxLiHhwmCvUw+Ja4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4x5KAd27m8l4DDargFurbUE9qKxXrSpODZZ6bpQ4NY=;
        b=G21hJWcYDwTlcm7G4UcG8h8ONvK8Y5djRTHfmJkcfqSvWNGgcnK0pvJ1Ga0EbHrv4T
         H71bt25CovkZQjrJ1v9P1k3fN3dVyyKgT5pNdCKc0xlRQ05/tP8doqt1ILYm69gtn93x
         YXgIeS96L0omlbTD8IHiHj3pJSGUD2F9w8i7/WEJM/di7K8i9tEJT/Z5pzo5+llfZj0+
         0hv2zVU3P1LMi0EnY7s+ydPStCd8EHERND4HJfnTV6T27c+3+SsbVXZfUxMUyy6hmmPh
         ZpETvXx94gEU2iSEg7n8eGc5SerNL6sNd8IajwpZJJdSIQTUBw5aKHhOb//7g4mNg6jc
         UGGA==
X-Gm-Message-State: APjAAAUvdnce4/YBKLoJFGPt0gNh7a92AO9QH/Uaozy4EA14ja8y/XFg
        dEF0b8xCfnMdByDYELnp9KPQdg==
X-Google-Smtp-Source: APXvYqy69wILp8KzY5eBLZS9Y6shozDIu5m42vqavj1O7DKkYvFz5hDVbewtJW2V8AcxgFhtzKJSDA==
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr4570434pgq.417.1579793109702;
        Thu, 23 Jan 2020 07:25:09 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:09 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v3 01/10] bpf: btf: Add btf_type_by_name_kind
Date:   Thu, 23 Jan 2020 07:24:31 -0800
Message-Id: <20200123152440.28956-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

- The LSM code does the combination of btf_find_by_name_kind and
  btf_type_by_id a couple of times to figure out the BTF type for
  security_hook_heads and security_list_options.
- Add an extern for btf_vmlinux in btf.h

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 include/linux/btf.h |  3 +++
 kernel/bpf/btf.c    | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5c1ea99b480f..d4e859f90a39 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -15,6 +15,7 @@ struct btf_type;
 union bpf_attr;
 
 extern const struct file_operations btf_fops;
+extern struct btf *btf_vmlinux;
 
 void btf_put(struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr);
@@ -66,6 +67,8 @@ const struct btf_type *
 btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		 u32 *type_size, const struct btf_type **elem_type,
 		 u32 *total_nelems);
+const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 32963b6d5a9c..ea53c16802cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -441,6 +441,18 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 	return NULL;
 }
 
+const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind)
+{
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, name, kind);
+	if (type_id < 0)
+		return ERR_PTR(type_id);
+
+	return btf_type_by_id(btf, type_id);
+}
+
 /* Types that act only as a source, not sink or intermediate
  * type when resolving.
  */
-- 
2.20.1

