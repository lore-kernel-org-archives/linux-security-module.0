Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2E13D8B1
	for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723404; cv=none; b=NRVqfjUhnkXNwSpFNrwOXzNiw8yty8Jb/f5CPtTwAAYWnhCZYNvgQluh3ezzWbA95vSyelp/0350BQBl+qEdIbeYNU1Vgf9AAMAwx0EaLMksegejSop6HTdC1rUigz5bijQImddghokziCqSYfV2zv7CSqnWz+DzgIvT8LivnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723404; c=relaxed/simple;
	bh=DcewT6Rnluc335PT2aXE0Wv72BuQ8CQjZHSyv3sDep0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc5Z8TOnEf6m4q/VTRhiaJxKlCSt0nOYDjaAHPHzkcES8v0YzQtB934hlMRB/5im0REnBYcuYLNqi8RzMLXXlGx4ZClv2F32jgm/bpQVlH7XjWoPRjXD6KEteSWmI/MPGM5uTADys9fNrYeah3+EnPrdLu0dfRtA977MiAhKYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F4HhKkxu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F4HhKkxu"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso18221487a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Jul 2026 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784723401; x=1785328201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XlYJYH6aD7SifBzyICcO1b3gqicM14HLRDoAfRS7bAs=;
        b=F4HhKkxubrP5IfYypdUWulBrpxiwND9O+XC6dPY3X1iBohJwthRsoLmHWGKC/caKax
         jArbpVqhc5TTV1Cn/wFSQKmcTYYUd+qt4NcWD9B/U+TRav1vRXGHq+LKzILUpHLD9bIa
         Z/DrURuJuA2g5gCU2u3WVCuCRFqABc8RHQaCrenh58RCum/iilCcfZYoselnrURYmVSp
         nob2Pt+9NmJZnqZPQqZ8EHsmvMxMGNh1xb77sXMnk6uYp2dHDCTxbmqVzDHLQsGGGNy6
         Rzaj9QQXuEwrIEQSqlMSdk4zBv3bfH/3MykqmZLsbocZG0K+p4lAJhydsiBDpfOz0vmE
         jsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723401; x=1785328201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XlYJYH6aD7SifBzyICcO1b3gqicM14HLRDoAfRS7bAs=;
        b=R/6FF1vmZ8yuYJPGQMXtqGrO7yYzY7xhgeR8T3urf19PO5mJnYlJEdAo+EhUs59CuB
         OuKNIvDRHYFm0NJunYrr9BjJKAVF89186tDr/jHVnofa3+7+LAWwVqxuGlGKUn91DSIp
         +yPfFHSWK9q2kX0ptLVcZxMZg8PHABNyC3zDHBiDplzmHEpeEczff9mOaMknZIDIZ0Ei
         GNw2KphauD3MClKUd012UeXrc/7mimNpYiiLaixFwyMA2i9JajEugH2hTp9xplJ1p3y2
         JorhD4Y7Jq1cmExd9eFTlBRq6LzOu6DsLmoMIqiU6Eg4fLby1QApFIkAfPO4jUC7VU0Y
         gLUA==
X-Forwarded-Encrypted: i=1; AHgh+RqnYWBV+EdUMaEJbPB7/eP7FbbqGvH6GlmQb5dnky83bIRuGKD+3vR8YHdHbbqXYVEA1ukm7DQPFKkdk9JZDdi5ujGQ2B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpCfMjc2zR46wDl2PNUHTFNh5TraaAdstq0fqFxMy/wHF4NOs
	rO4ZdL8bBLBwsT9FWm55M0kPlU9k8VLltcgD6OKQPWVk7kArmADqwU0Hg+4Aop1w2+c=
X-Gm-Gg: AR+sD12miFpFuCkUgwQCEqYedtB4vMtK6a4kg43jcoUmgUNUXF36P92i7Fy9f4B7mnf
	OAkeX1TZueda6bA9+oR456G67w1zmmlDWJTcvZB4XCiLvWN3FH1eijGYr+7Ng/OhIZ2GKlxGptc
	5eCkH+doklDW9ZZ8BySWRtL1tGk5ibnDH9E9+ORvv4EjvOt49sWLnaltyfIIrhnZ5pU0DU2UO/M
	yOI3j6itQ5UP6tJmNof4AgQsLAkBrn/iMt8tcEEuxUHCuQvgx1iMdiFBmgaQzALJCgx+ur+qMNo
	CZJp216WqNi+EBHhuY1ZrxSGIEpsD4R9W3pqxe9i3yEseiUY+iftHXuxvM+X01EZeCGP6cEjhoS
	uZNcWN3fk61201AX+S2tduvrdZNovhFpmO9+CRSXzm9VrsI7SlV+Z6ARek/+oNs4=
X-Received: by 2002:a17:907:c012:b0:c11:ff2c:4f33 with SMTP id a640c23a62f3a-c16b47c7127mr818780066b.45.1784723400878;
        Wed, 22 Jul 2026 05:30:00 -0700 (PDT)
Received: from DW927H4LGF ([2a09:bac6:37e6:1e5a::306:2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34f1b867sm835007a12.14.2026.07.22.05.29.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 05:29:59 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: paul@paul-moore.com,
	jmorris@namei.or,
	serge@hallyn.com,
	wangyan01@kylinos.cn,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	landlock@lists.linux.dev,
	oxana@cloudflare.com,
	webprosto@gmail.com
Subject: [PATCH 1/6] ipc: Move mqueue fs magic to uapi magic header
Date: Wed, 22 Jul 2026 13:29:37 +0100
Message-ID: <20260722122952.42149-2-oxana@cloudflare.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722122952.42149-1-oxana@cloudflare.com>
References: <20260722122952.42149-1-oxana@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move MQUEUE_MAGIC from ipc/mqueue.c to include/uapi/linux/magic.h so
it can be shared by code outside of ipc/mqueue.c without duplicating
the constant.

Signed-off-by: Oxana Kharitonova <oxana@cloudflare.com>
---
 include/uapi/linux/magic.h | 2 ++
 ipc/mqueue.c               | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..8e5d33bb1453 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -78,6 +78,8 @@
 
 #define V9FS_MAGIC		0x01021997
 
+#define MQUEUE_MAGIC		0x19800202
+
 #define BDEVFS_MAGIC            0x62646576
 #define DAXFS_MAGIC             0x64646178
 #define BINFMTFS_MAGIC          0x42494e4d
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4798b375972b..9515597d45ce 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -22,6 +22,7 @@
 #include <linux/sysctl.h>
 #include <linux/poll.h>
 #include <linux/mqueue.h>
+#include <linux/magic.h>
 #include <linux/msg.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
@@ -47,7 +48,6 @@ struct mqueue_fs_context {
 	bool			 newns;	/* Set if newly created ipc namespace */
 };
 
-#define MQUEUE_MAGIC	0x19800202
 #define DIRENT_SIZE	20
 #define FILENT_SIZE	80
 
-- 
2.50.1 (Apple Git-155)

