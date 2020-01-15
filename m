Return-Path: <SRS0=2BO2=3E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E49C33CB2
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4972224679
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jan 2020 17:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDuGgPNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAORNY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:13:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40940 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgAORNY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jan 2020 12:13:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so726917wmi.5
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2020 09:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMrzaXbHOJoXJR4BqSM8/Q4xofgHVyPxrukOYhnuR8w=;
        b=CDuGgPNGWYz4c7wtILqThkFOu+2SErXXx0agyzMiefku/qGD/up2rxB74jjJxZUpBd
         CGMun26K8cwuHV8+eF1JDPocckf2uAIRYQlk2HncWsO3bcdjtDSbfcIWLkcZ8KVUc2zI
         K5bVO4gJX9/CZv2WMSjT0r0RtWS0O7XLR3pkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMrzaXbHOJoXJR4BqSM8/Q4xofgHVyPxrukOYhnuR8w=;
        b=IOwfeYPnsRuadVNeckki8KfbJbL9tPytwantH8rMp4otrrIfyWs+GgUqmkW0im4gOZ
         EPGSFVTw6y5YKpSu+aCr6cjlw7d5HZ58l7Las0F4xdUB/1VqYU7AhBH7TQ3VngWfXMI/
         oxFZadz9BWcmU/JG5pzK6RGAajT8jkgCMZh7u96pO1LKoQxSkBTn5iHQBWcfNGlr9FlC
         RaAMDd9Ozc7Z0Uiar827pbqbu3Hovar7HM8hZLXqi9fnmh6sVvPi7HQNUSKwO5FGHL0y
         GaTde7B5rYsA5jwr8juBbvWgYld70J9muHrbghMoJZRUiuSb3+PdICNplnjbYjfsoeU1
         tnUg==
X-Gm-Message-State: APjAAAVio/lS2+WSX/fzi2XbEYTYpuBh0s8iuVBvvQuLjtvsSDRa/FCM
        nYqrco3MAfOwJRbcsZN392H71w==
X-Google-Smtp-Source: APXvYqw+83aJOogdP51uHjakQPrbRphvcxTyKNh4lFcbQf8mJWthRqQx/L4xsXdKWcUBUCE2YaLkWA==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr978688wmb.32.1579108401751;
        Wed, 15 Jan 2020 09:13:21 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:84f3:4331:4ae9:c5f1])
        by smtp.gmail.com with ESMTPSA id d16sm26943227wrg.27.2020.01.15.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:13:21 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf-next v2 01/10] bpf: btf: Make some of the API visible outside BTF
Date:   Wed, 15 Jan 2020 18:13:24 +0100
Message-Id: <20200115171333.28811-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115171333.28811-1-kpsingh@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

- Add an extern for btf_vmlinux in btf.h
- Add btf_type_by_name_kind, the LSM code does the combination of
  btf_find_by_name_kind and btf_type_by_id quite often.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/btf.h |  8 ++++++++
 kernel/bpf/btf.c    | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 881e9b76ef49..dc650d294bc4 100644
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
@@ -142,6 +145,11 @@ static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 {
 	return NULL;
 }
+static inline const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 static inline const char *btf_name_by_offset(const struct btf *btf,
 					     u32 offset)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 832b5d7fd892..b8968cec8718 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -436,6 +436,23 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 	return NULL;
 }
 
+const struct btf_type *btf_type_by_name_kind(
+	struct btf *btf, const char *name, u8 kind)
+{
+	const struct btf_type *t;
+	s32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, name, kind);
+	if (type_id < 0)
+		return ERR_PTR(-EINVAL);
+
+	t = btf_type_by_id(btf, type_id);
+	if (!t)
+		return ERR_PTR(-EINVAL);
+
+	return t;
+}
+
 /* Types that act only as a source, not sink or intermediate
  * type when resolving.
  */
-- 
2.20.1

