Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792874379;
	b=Ps+rnL96kXLsiQJV36NSlWwjTJqC1aIFO9wncyNSjNLxPr1GdGZvMADOogxwxHLGDh93
	 rTCvuU1GoWmmxwAob7jMjTKFxfXOhDkVJZjUrO6+oEaoCHRQMKIl66yZ9h4bZm1VGymvJ
	 Fk4c5d93yiExQySUcvzjMS8Sh/AXc7Kqeyb2qH5BT8nYec34FZKMunNjSCj6uAJgwPE23
	 JfynXdOvpNmC6eaJDVefq99nm5Hj7Bl8mrNmdFfUyi13PqZxXTmFWeNPbAkpUC19A9mgX
	 7uqlMEOcRltnZlhk4JJM17/yq/iDt/5wJE5AG1lorTmi858YgUTahBLWi5NQydCWFpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792874379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7sCcp9GVaRxjsnZJno3GxOc2KDrFHpoSBIpls8ghdgQ=;
	b=5JVC4f3uJg00ZnPqKWUtFVYyYNQ1f81Kd9UWHOQwPdKwjN4LsMHgJvsqDWD+kpKbAZmp
	 3DL+Lwd+GzHVpN5j5ak3OETS3Ywhu0PoGCnMOykJuZBOCpJegoMrCOpJVhZAIildu5184
	 LMIk/1yQNGu4RauBBE5YyR8ZC8rPrhAISjc2/qK6cBIdS6QAFLgiQJyX7NZCQtMA8fjlo
	 dlcbMnYXLbF+7I9AnRUtC7Yagte3XvQ0OML3azWBF+3LGfXAtJsJWrRl1gzz8djTVvbF3
	 ia6j7rBKMZ3jf061LawmB05xjqNXB5QPVtT3VE7WPrWvWa0l/00gof9SaU/Kz8O9UxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PMy7oqnb;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B454606A327
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 20:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B454606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PMy7oqnb
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36661f953e4so3468508eec.1
        for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792874378; x=1793479178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7sCcp9GVaRxjsnZJno3GxOc2KDrFHpoSBIpls8ghdgQ=;
        b=PMy7oqnbMqRkj+wlnM5ZI1BakhZ+3ZaFxEmgkOIziba4zAuFu8XH0mG5P5Yyai1H/x
         +QH+oK5OGdRNCa7sQFJV0r3uwyCNlybfzetfkXQCdSXhtWwMIYN4XSsw2/ehCbjHMx61
         /lUzF/kdZF8nGIwY8qI4yJ7YkI0kEqIe9gJBG9mvSHmV4lh34Kx9egnyECo+L/XAkAKs
         fcUAX3Fxrmtl7mnFyiR/AZrquRq8Om+TudZByRYZm5QWNl88CNw4UQ6U78BcJTtSRwcr
         b6Y3DoAYYNwhyJ69Q63fCQlrJaywk1UXgeILfti365/f0Sm1qzpquWykLni/Hq8wBnL7
         /oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792874378; x=1793479178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sCcp9GVaRxjsnZJno3GxOc2KDrFHpoSBIpls8ghdgQ=;
        b=hkZrtVbSOqx1tQvIw5JLgfrqLI5d2tDxgmC0+3rTgofZHfwhh4jYEA7fLEOGAqUO7t
         8Tf32eCuHKZ2dnVo9jazYBFM6lCMSbMGijXihkXxJw8Egi2i4EntYTV1cnJnEXGfmEaD
         Kh4nOZsFwXwJ2pTYrc3yGaaPEKTthJ8dlKnAiwkoQ3XtGEsGcq5D8Fq7TTeNLrz48xkD
         x/lZ5NhCSY2HkIj13wjajGPsykkG2MUHGZX21lObJ1j7pRtKBfSrkazSDo9KP1hkJT8a
         03ABTzNHQoFvrb0VfUFw2liIXlm9uxJPIzb9qtdarwze4bTPGh3EqBu265tN5nGpjf53
         FHsA==
X-Forwarded-Encrypted: i=1; AKwUvBxcoTnFSq9uxsxGvESoiA0sfdH2jMazp7ivAsuY/f+AiZvfP7AWk11Sg3sSC2TfWJjIzjbMEBaoh2vPxbXdwkGZ6/qkgFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxkx3oeFROPeYQbhCQnB1mprrCKISaEh87LTFpBcL6eyyiV8yI
	pAmbHuwJgNkwfIuz7znt8sE003kyocxma+zYiCxE3AhmvgRtsY5kZFY0
X-Gm-Gg: AYBFou3NNSCql4+9hgovPss4L1e0wN5QvAvF6RZnqbvDezApz0EO3yr27P3UhQBoACi
	d5YLoWUKJdi5BkYGAq+iCnkPX0iVD0dNJmxuj2QOd7DGOXUDTJ4fk8pcI0Nav+AMKSGNoKGxCmP
	SrKqGv8moI2zASpcQ7ajg2mOfUtXaF2z1avjoQt9dFAO+AmVmZavqHyqNd7smMa0g0nTWG7GOaZ
	1GuPXlRZlOuovmj8NRuFsZSgYGYW7662vGhRR9n79OnP4bM+uCycjtAUz1e4QRm6bWn5Flu8DuY
	nd8cg27u3WtJab4Bh3ULoRfpqhDWzMo3lsN/h+BxLU7/X40U8YeHK8grBJMOjJQIMEoFKeL6a+k
	urIGZ8Mgfje9GrB0BRtB+wvaot0ahpA2UYZh82y8suIDfXfZvnD4wHCeklEmGtYMfXSbQwUp/K/
	uw5FSNYvZDBcyIwYv2p4JVleehYYXS59uPY2vlEx+38uFbI9tjAIT7qqG5O32CLsVXEqDnfkB5T
	pRTemI8L7VXQ3q8XcqfsmMuApafDBtUppZbGu1eP/G3XxndyOAh0Oix3gkTFA==
X-Received: by 2002:a05:7022:204:b0:188:ecb4:489 with SMTP id a92af1059eb24-19937307a0bmr5814234c88.34.1792874378320;
        Sat, 24 Oct 2026 13:39:38 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm9764737c88.14.2026.10.24.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:39:37 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Sat, 24 Oct 2026 13:39:17 -0700
Subject: [PATCH RFC 1/3] lsm: Call inode_init_security hooks without xattrs
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-landlock-created-rights-v1-1-77c8db3f6bd2@gmail.com>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
In-Reply-To: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, John Ericson <mail@johnericson.me>, 
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

security_inode_init_security() returns early when no LSM reserves an
xattr slot, so the inode_init_security hooks never run on a kernel
whose LSMs provide no xattr. An LSM can then not use the hook to
observe inode creation unless some other LSM happens to label inodes.

Call the hooks regardless of the reserved xattr count, and only skip
allocating the xattr array when no slot is reserved. LSMs that write
xattrs still need a reserved slot, so they are unaffected. Landlock
uses the hook in the next patch to track the files a sandboxed task
creates.

Assisted-by: LLM
Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 security/security.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index b284e24e3771..bb94c94d97a5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1353,10 +1353,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!blob_sizes.lbs_xattr_count)
-		return 0;
-
-	if (initxattrs) {
+	/*
+	 * Even without any xattr to provide, LSMs (e.g. Landlock) may need to
+	 * track inode creations.
+	 */
+	if (initxattrs && blob_sizes.lbs_xattr_count) {
 		/* Allocate +1 as terminator. */
 		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
 				     sizeof(*new_xattrs), GFP_NOFS);

-- 
2.55.0

