Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EB1F0E34
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190894; cv=none; b=LExA1t7rvzCMjbrD0q1NDfGW6IP5d7+McgR6SeYN356ykXcbxvT+8Ru71HjxboTSj6Hj3MjyT5ve6XZ6PZqEhnW+xTTsyY65bQjpO8De0CR37nv0qWhJQTqveuyPnP7xnTfA0mrQxreMOC+iCvO4L6fYANMQoJJoYiAzcW4ftZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190894; c=relaxed/simple;
	bh=zQk3j3MOtPI2wggepqFvqPFmzcD9ik+C9XfeMfXCUXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqhpZUeX+AUCRZ0F3+w3rHzfuuH3H9QaqeL7HWNm6apXJF27DrXGI6+q+gsDBCHuQgXRaV9ep2MHmmsQkSc02DHa6y/y5USSWUt7NPeTndechfh6r9Hmut+9m/iCTRB/fZ8BEsSmD79dlIuy7lsWgsr1IIaW2HrFhIBuWkmFAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFt+8rA/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFt+8rA/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9033d230so257055a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190892; x=1782795692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIt16tpuFSrj/OzOLf9EO5DDoiuEVcOyrhRMsz3Bs2Q=;
        b=LFt+8rA/4JzLdagXxENNYVBfnII9l/Iy0vApHH70v743DvkCE8uYRX6v9aN3VDMKSx
         C8NLd3jJH8ueORNtnCvDw2s3UHwnpuFeA1sTd+25mcS6wDl3ErSn3YLMfVKI4ftThb6U
         ZZMGDcBaSvh2M2yrc5tqUOCnWgAcR6/FoQrx1k/FQJELih4Y5r6qofHo5FGI14ooOwFZ
         568Ebq5YVf3NSx81F3+xnx7LP8pI7hyctT+OOX+Bn9Ppnt53c5tCB7H+tOEfhXgTjrIV
         LVktBSlUrI/y6ughJnQA9/UAG7GeePzrViXlo0L5CV/Adqgbdcj298da1jfJXSiCCAKG
         g+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190892; x=1782795692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIt16tpuFSrj/OzOLf9EO5DDoiuEVcOyrhRMsz3Bs2Q=;
        b=NQ2D0mfkFYOAcNC/JYw/5VDcs8uCinGqRmejbBttCvdBVdNLp0DlM40UkwP01zse3c
         nVI/jxEbCSOkvlZb2jPXXYgwNJDwTmapPVM8xpWUKI2p0OueH7wNIYVTe3EB1h2bgFgi
         Ky8c3HACRxZDfTAx+pgPt7DLyBWNS0zPpLYbDZs268LNlJ8j7fK7IODT5LWFeTlYaGVp
         BY1aJUciTu5EL4VYGhhZraL1HI0zfTIkB+s/BqD2jZjN6BrMBiqgrUo2Gu+EUZWKH/s3
         b8+JQsAsPCDYAoxAv6Avtbd8b2Wr/C9VD8cc3Sfmni37q3TCcgtudSqYYmLLOC9jHy30
         7a6A==
X-Gm-Message-State: AOJu0Yye565Vh7VhNZajtbn+YDjHtdw5EjVwOI44Zt2BrUxc8A+hKRoM
	9C6eHhqg/Wafuw9u9NfJodr1T53aofWcisUfXWWZWA8nRrEfeD4pBR7i
X-Gm-Gg: AfdE7cm85T1ash0I2DSA7zzeFmYI55gtNGX+IewG3KIDQ62/+HKNum4D5aGl/jC51ZL
	xLuCR5F5VbuUvrmROFAVSQ30SRP80VUcQES7Xi4jgi5wXXVJr1MFNc1z0II052UKtCxwqkzJAiP
	LUuo2ILH3KWf5PfhQjIL2cN6hWQftkk7YX5ToN4GMzdIjd5ILFpi6uDle/g03a/buEoGTog1jyR
	kQGeIiT/nPVvNGPxxB2Mqf6r+lLjfufh9uc74TuEQ2VN0oDb2mfHMM5xrv4FZyOrX8/QKHyekkp
	aq6IfRw8PRFzyNINMedqf5M0+hQRNqz5zivxQIEuo76ojECFzptGZKskyKAtv6DLfsXhwWiq+is
	8eWJEMWyK8CXXobXLLovO1HjhvlCyA3kkpl/48+Y3EPXIywuFBBj9mEn5q8PjQD35F9qjbmAwqG
	Z8RB6zcGcXMbDI6triYdAUCrk4Umq78cF6jfwZ15Uw/uOetd4kd9KqydSNyK+Q37e9rLc=
X-Received: by 2002:a17:90b:5103:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-37dcd6cb42cmr1692404a91.1.1782190892191;
        Mon, 22 Jun 2026 22:01:32 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4eede23esm8663656a91.2.2026.06.22.22.01.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 Jun 2026 22:01:31 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: mic@digikod.net,
	gnoack@google.com
Cc: linux-security-module@vger.kernel.org
Subject: [PATCH] landlock: shrink tsync works[] on partial allocation failure
Date: Tue, 23 Jun 2026 13:01:27 +0800
Message-ID: <20260623050127.48247-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the per-slot kzalloc fails mid-loop in tsync_works_grow_by(), the
already-enlarged s->works array keeps uninitialized trailing entries.
Shrink the array back to its used size on the error path so no waste
is carried over: free it outright when nothing has been allocated yet,
otherwise try a shrinking krealloc_array() (keep the larger array if
the shrink fails, since tsync_works_release() honors s->capacity).

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 security/landlock/tsync.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index c5730bbd..356ce94b 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -272,9 +272,23 @@ static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
 		work = kzalloc_obj(*work, flags);
 		if (!work) {
 			/*
-			 * Leave the object in a consistent state,
-			 * but return an error.
+			 * Leave the object in a consistent state, but return
+			 * an error.  Shrink @s->works back to its used size to
+			 * avoid carrying uninitialized trailing entries.  A
+			 * shrinking krealloc_array() should normally succeed,
+			 * but if it does not we simply keep the larger array;
+			 * tsync_works_release() iterates only up to capacity.
 			 */
+			if (i == 0) {
+				kfree(s->works);
+				s->works = NULL;
+			} else {
+				works = krealloc_array(s->works, i,
+						       sizeof(s->works[0]),
+						       flags | __GFP_NOWARN);
+				if (works)
+					s->works = works;
+			}
 			s->capacity = i;
 			return -ENOMEM;
 		}
-- 
2.43.7

