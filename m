Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D273C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Dec 2022 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLSSBa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiLSSBY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Dec 2022 13:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319D13CDA
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671472835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXsj4sl5Q7Amjwuhgta29gJZDvW0Wms9duXV33JE5vE=;
        b=YSexiH/akCVyAbejQegroyHXUJA/T7W5Tfx6eyhFRzyC82vwTy/L+O1D9ZPQ0SYSl/R2C5
        3dcH0L4hbEjieXwtxcO1o0RRgak6UXymohd0faUSGQ3J1P5MVBDBlR/f4x6T/c0CKa8Zob
        VFOWCyYnIQEGZAhV1Z7L/zRQ1CgPGNs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-vZcQDlBRPzGCI0nafhCbGg-1; Mon, 19 Dec 2022 13:00:34 -0500
X-MC-Unique: vZcQDlBRPzGCI0nafhCbGg-1
Received: by mail-ej1-f72.google.com with SMTP id hs18-20020a1709073e9200b007c0f9ac75f9so6581371ejc.9
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 10:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXsj4sl5Q7Amjwuhgta29gJZDvW0Wms9duXV33JE5vE=;
        b=JVnweZ5PBnit+xP5w8tR0VwQ+W3tnl+QlLMnfzEI3G44gW3kPP68bX1/B+hudee2ua
         dY+rhsNScXRUv4nPAbV672AnRW5ZojxE6po2wTFGI8ALHK02YLATl3FxnLdVIM/O9YI+
         vJAlUXTM0+N3IreAoNPu86YW5u6o37Z7nSYmLjTzb4mGFwzxA7/WEAGaqwE9aQvsw4bC
         VJldAz+UMBa6r6h7V05qgEgmOZT81FHQKgVBu8ZN00QUE3YPgzdCQDUXttwO8qqY1IjD
         C7Opi1wbhrnnlYRbuOwmWlF5pkKo89wRowPBk6FZQx2w0hfq/kVvWbyDbvQthDiWfQnG
         ZNBA==
X-Gm-Message-State: ANoB5pkao2t5vZ3yKBdySXwn583s827vCNiLvREovwbW9kq+rkHeTl1T
        v/E1ltkqQYtT/7jpH873a3vsMptyIdqeyeHoRLKR0wcIfNmJq9LPzXoGBYDvDXLuUzNTNlIVyjZ
        O4SHIUpKvYr5ErhHUGCRcLp65gxAeG4irWEV+
X-Received: by 2002:aa7:c690:0:b0:470:1605:7d8b with SMTP id n16-20020aa7c690000000b0047016057d8bmr25983218edq.16.1671472830188;
        Mon, 19 Dec 2022 10:00:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6PYcnrDcnWATwF5yoghg3gleoYRioZkjgtlSjE/ryAWqL2h/0APCv5Ob1MK8CPQYxIBZ3/iA==
X-Received: by 2002:aa7:c690:0:b0:470:1605:7d8b with SMTP id n16-20020aa7c690000000b0047016057d8bmr25983204edq.16.1671472829975;
        Mon, 19 Dec 2022 10:00:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b0046bb7503d9asm4617691ede.24.2022.12.19.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:00:28 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH RESEND 2/2] selinux: provide matching audit timestamp in the AVC trace event
Date:   Mon, 19 Dec 2022 19:00:24 +0100
Message-Id: <20221219180024.1659268-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219180024.1659268-1-omosnace@redhat.com>
References: <20221219180024.1659268-1-omosnace@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In order to make it possible for the users and tooling to associate an
SELinux AVC trace event with the corresponding audit event, make it
include the audit timestamp (including the "serial number") of the
event.

First make audit_log_start() include the timestamp in the audit_buffer
struct and add a public helper to retrieve it from an audit_buffer
instance. Then retrieve it in SELinux's avc_audit_post_callback() and
include it in the "avc:selinux_audited" trace event.

After this patch the even includes the numeric fields that make up the
timestamp and the text representation includes the timestamp in the same
format as used in the audit log - e.g. "audit_ts=1671454430.092:1671".

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h      |  8 ++++++++
 include/trace/events/avc.h | 25 +++++++++++++++++--------
 kernel/audit.c             | 15 +++++++++++----
 security/selinux/avc.c     |  4 +++-
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 788ab93c3be4..d6d7acc1b623 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -162,6 +162,9 @@ extern __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 	       const char *fmt, ...);
 
+extern void audit_buffer_get_timestamp(struct audit_buffer *ab,
+				       struct audit_timestamp *ts);
+
 extern struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type);
 extern __printf(2, 3)
 void audit_log_format(struct audit_buffer *ab, const char *fmt, ...);
@@ -218,6 +221,11 @@ static inline __printf(4, 5)
 void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 	       const char *fmt, ...)
 { }
+static inline void audit_buffer_get_timestamp(struct audit_buffer *ab,
+					      struct audit_timestamp *ts)
+{
+	*ts = (struct audit_timestamp){};
+}
 static inline struct audit_buffer *audit_log_start(struct audit_context *ctx,
 						   gfp_t gfp_mask, int type)
 {
diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index b55fda2e0773..8cac14ae22ae 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -16,34 +16,43 @@ TRACE_EVENT(selinux_audited,
 	TP_PROTO(struct selinux_audit_data *sad,
 		char *scontext,
 		char *tcontext,
-		const char *tclass
+		const char *tclass,
+		const struct audit_timestamp *ts
 	),
 
-	TP_ARGS(sad, scontext, tcontext, tclass),
+	TP_ARGS(sad, scontext, tcontext, tclass, ts),
 
 	TP_STRUCT__entry(
 		__field(u32, requested)
 		__field(u32, denied)
 		__field(u32, audited)
 		__field(int, result)
+		__field(u64, audit_stamp_sec)
+		__field(u32, audit_stamp_msec)
+		__field(u32, audit_stamp_serial)
 		__string(scontext, scontext)
 		__string(tcontext, tcontext)
 		__string(tclass, tclass)
 	),
 
 	TP_fast_assign(
-		__entry->requested	= sad->requested;
-		__entry->denied		= sad->denied;
-		__entry->audited	= sad->audited;
-		__entry->result		= sad->result;
+		__entry->requested		= sad->requested;
+		__entry->denied			= sad->denied;
+		__entry->audited		= sad->audited;
+		__entry->result			= sad->result;
+		__entry->audit_stamp_sec	= ts->t.tv_sec;
+		__entry->audit_stamp_msec	= ts->t.tv_nsec / 1000000;
+		__entry->audit_stamp_serial	= ts->serial;
 		__assign_str(tcontext, tcontext);
 		__assign_str(scontext, scontext);
 		__assign_str(tclass, tclass);
 	),
 
-	TP_printk("requested=0x%x denied=0x%x audited=0x%x result=%d scontext=%s tcontext=%s tclass=%s",
+	TP_printk("requested=0x%x denied=0x%x audited=0x%x result=%d scontext=%s tcontext=%s tclass=%s audit_ts=%llu.%03u:%u",
 		__entry->requested, __entry->denied, __entry->audited, __entry->result,
-		__get_str(scontext), __get_str(tcontext), __get_str(tclass)
+		__get_str(scontext), __get_str(tcontext), __get_str(tclass),
+		__entry->audit_stamp_sec, __entry->audit_stamp_msec,
+		__entry->audit_stamp_serial
 	)
 );
 
diff --git a/kernel/audit.c b/kernel/audit.c
index aded2d69ea69..ad21d148704a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -199,6 +199,7 @@ static struct audit_ctl_mutex {
 struct audit_buffer {
 	struct sk_buff       *skb;	/* formatted skb ready to send */
 	struct audit_context *ctx;	/* NULL or associated context */
+	struct audit_timestamp ts;	/* the timestamp of this record */
 	gfp_t		     gfp_mask;
 };
 
@@ -1826,6 +1827,12 @@ static inline void audit_get_stamp(struct audit_context *ctx,
 	}
 }
 
+void audit_buffer_get_timestamp(struct audit_buffer *ab,
+				struct audit_timestamp *ts)
+{
+	*ts = ab->ts;
+}
+
 /**
  * audit_log_start - obtain an audit buffer
  * @ctx: audit_context (may be NULL)
@@ -1845,7 +1852,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				     int type)
 {
 	struct audit_buffer *ab;
-	struct audit_timestamp ts;
 
 	if (audit_initialized != AUDIT_INITIALIZED)
 		return NULL;
@@ -1900,13 +1906,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	audit_get_stamp(ab->ctx, &ts);
+	audit_get_stamp(ab->ctx, &ab->ts);
 	/* cancel dummy context to enable supporting records */
 	if (ctx)
 		ctx->dummy = 0;
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
-			 (unsigned long long)ts.t.tv_sec, ts.t.tv_nsec/1000000,
-			 ts.serial);
+			 (unsigned long long)ab->ts.t.tv_sec,
+			 ab->ts.t.tv_nsec/1000000,
+			 ab->ts.serial);
 
 	return ab;
 }
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..e59c91eb3228 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -708,6 +708,7 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
 	struct selinux_audit_data *sad = ad->selinux_audit_data;
+	struct audit_timestamp ts;
 	char *scontext = NULL;
 	char *tcontext = NULL;
 	const char *tclass = NULL;
@@ -735,7 +736,8 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 	if (sad->denied)
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
 
-	trace_selinux_audited(sad, scontext, tcontext, tclass);
+	audit_buffer_get_timestamp(ab, &ts);
+	trace_selinux_audited(sad, scontext, tcontext, tclass, &ts);
 	kfree(tcontext);
 	kfree(scontext);
 
-- 
2.38.1

