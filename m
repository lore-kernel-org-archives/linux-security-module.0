Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5D3DDDAC
	for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190923; cv=none; b=gk2dRvGg1qJO3sLbZhN7uvG32PA5IO536eAH1z/8WE8K9BvuMTqLr+4ehxlCtYQ7MKGfbrv+2ATwuKAm0093dysPF7I3vcT0QlkmOHP2P7+42L24aZNwbuCcOIUBhyD+4xDTKFZOPxgz5JSWiOntQqQbJ32vPqinIgVGQmMYSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190923; c=relaxed/simple;
	bh=0PCn2MpUCydMBssMbLxNjbRlB5gzYl0SeHHufrDng3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9jukjbuHSOgdMoo+wvl8JA0kZRIV7iVoTUw35rPl95tZBHTBX44Zw7gmSseWE/n3BHmSXb6icba4RgRWjE7epfRX8XKfecePiiOrWsNfNjihtoWfdiKjJna1TUIexpSLxNZbuiVoMrlFbz8VAuJL8zssyIRVcweYspVZoVQkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RX7KGCj0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RX7KGCj0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80cebd41372so37005087b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2026 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785190921; x=1785795721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2nuYR8orZEuPtsg4qTKJhHkZ1JkdlEmSYy8R+O9Ctg=;
        b=RX7KGCj0TNyt4nD8wGABpbTiU6zupxpWpmvH2y7CueCMJPjxfx2S19kCnhTw829J9B
         aaboDygv8yzkEK2ZMVNY/jNuH4RihV/EE/9NPwYlvs+XliOR6a/JRgMt9t59LliAgtwX
         8Ec6Pui6TSmEtSUDCOlJIxZ4+I18l+0r3iXlumPpk08KNBYk2sVP6sSDgI4YQ1e+XY51
         xFVAyWQW0zl67F7oSQXFxJBdn478P+TWEZeCNDWB3SQcqfu5OJhjlBbDJODLE5LSYWOV
         KOndF/hu/t8Zad9/DYcOcGYZGmhkKhzH1vUB8jV0LWczTiCyjhTLhUCSTxRRiPIcTNmr
         lUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190921; x=1785795721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2nuYR8orZEuPtsg4qTKJhHkZ1JkdlEmSYy8R+O9Ctg=;
        b=YWNmVjdblP9ROiI7FIzClHYLaZn1l+zvVXv/JQbYC4yVeAA9CVmN4vP6SeuDvUe8Cp
         cN0D+zOQBcIvM1bJIM33NtYcJ8rl3Of+5Qcz/C5QTfX6otrbUjEWrtGr1DUFisSDI5uX
         6kRHwiOPiOVj5ZHBhI+PzFT92lGRHvMqANqgcqTHKyE7QParm4/LXYp0I1CJK+iRL1Ts
         7oka+UrE4YNm8hhLz0KqtKSIyNgrXiPyHfN0XpRtDbJwibZpI+uYmaO8F3B+xnRERNZV
         O5FtuAfaeIpsUg5DHSdHzKUgeLBGSDZjsHWM6UfU9zUh9rPaP7TIpMGbIwxr2+j94etT
         m1Fw==
X-Forwarded-Encrypted: i=1; AHgh+RoOTnMwxj10jTB4nANVzKwChhjIkhNTBvNn4SLt5Fi/Yu0ovOPxsDavOSeiQ6ljmB8OPlLOU7Y33B//LN5EohpFTG+m/wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53JZ5438NW9gl5+8lw+n7LgcIMt7pHVRNOzm11A+28PrdJ59d
	VQHwovQGxhITs02ttQqV/OYCcBo+0jd0kSh15qjHWONEAcYlbY9B341DvR1rGeNiq/4=
X-Gm-Gg: AR+sD11jE6uDy8Mw+AtBRZj5s6pjCQyQeun9OCVZcpW72z847cgeo4KEYVao2346dCJ
	tIdSXTJXMTgoSbZZ+ceqauEitD6IGRpBXGwN2s5nuRFP/Ln4di/uytavIeqhdn3COElWBn7T/id
	1cpO3Zeea71jnR43QKvZTzHEwVLoK/hijA0s4y+TPLQnGHzgK2DCDfu2UhavwM/N2qBSyFcBXqZ
	/ljb4lAm1c9YG7LwqL0nZMi35zp5kiK/gQN9plb+ktjiy96XCjnRhAAeAJevVnvjg1yWBAYELdV
	0eTV94S11ixda04FLMgqr01g2lAQvI/AQ7jaCJAuCSsq5t9nKT3quNS7s+vj+tiefkFX42hnKFu
	x2Q8+Y3DkoMHa+PrEMEaTIcC/aLE3Ujsl0VrSwlhuB8iZ5XFuFys7Qh664aGTHw==
X-Received: by 2002:a05:690c:4b0b:b0:81f:650c:98cd with SMTP id 00721157ae682-81f69d434f2mr36442277b3.28.1785190921027;
        Mon, 27 Jul 2026 15:22:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:947f:3af::5e:7e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b02sm38756017b3.5.2026.07.27.15.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 15:22:00 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 27 Jul 2026 17:21:48 -0500
Subject: [PATCH v2 2/3] integrity: Remove integrity_audit_msg()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-report-hash-error-v2-2-30e394f524fc@cloudflare.com>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
In-Reply-To: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=0PCn2MpUCydMBssMbLxNjbRlB5gzYl0SeHHufrDng3E=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBqZ9oE4VqDkyNYae2DqILNMi/RlCrjtOrbwEDV+
 vQiCtf5dJOJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCamfaBAAKCRCrJbR2A5LT
 bVjLEAC6SXXHUnvSgu8uyB8POWrQLY91wyO1aDDhBgRMhj5o3+sF4XN9qLrZvtvNC1et2koo5Q1
 JOB94wFD3x0oRZEB1STtFPVKcVizX3SxkLB19gL1FORQK8HpIpA2cORumTFtXgMwaXLdLu0vm8P
 Kp1t5vqoJc5xXbd8T3nekK1vQEaXMYj167LNOd1YgCmlEJ8WlY84dWwdzVYd6ps8jGNNK5VBI92
 UuuHAJkrF+dbDjsFG0vUByGsB+JeHCQ77H5vl829F68t2uzQJ2LjSpdQc11HYdeRnhtrTyUehXY
 2eCjRItGnI3AwX8ck6aShnjkIq40UPEaJL5nLnRzN3opBWtUQliVQ7wRljMbxkJomao6TSygsWL
 jwy8Y4vXjZkbFV5CkOKLpISO8j0Xt4TmXQnB0amFqwIYpwFU+3L7cnuDa4wltszOu2plUuPpf1N
 uO6RtYEPb8DntQZ4WioJm1J/C6o4yh+IiTmCbfwFLa/OHEcliLFn7t5aJhSnUy/l6h0MQ2wVCS+
 BhFcg8bIXO5r4bME1W0VEtXt6MOcua5Am3ufE1XSJlQxh//uSLTIQw5uZISDjjux0ya2biqrH7j
 Uadnwv8RzxFvnEmKjG/fP8EtSNGKLeIAzVXeDojTgG3r7+MtCKo0LpS+h//EXn1K4P8iW5YA8pI
 qK/mjFQAHgY09nA==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

There are no more users of integrity_audit_msg(). Remove it.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/integrity.h       | 11 -----------
 security/integrity/integrity_audit.c |  8 --------
 2 files changed, 19 deletions(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0c581c03c5da72d80e9c352a7adff1fb89628644..1a88c245f3dde01ceb759383ef870c16de80626a 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -216,10 +216,6 @@ static inline void evm_load_x509(void)
 
 #ifdef CONFIG_INTEGRITY_AUDIT
 /* declarations */
-void integrity_audit_msg(int audit_msgno, struct inode *inode,
-			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int info);
-
 void integrity_audit_message(int audit_msgno, struct inode *inode,
 			     const unsigned char *fname, const char *op,
 			     const char *cause, int result, int info,
@@ -232,13 +228,6 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 }
 
 #else
-static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
-				       const unsigned char *fname,
-				       const char *op, const char *cause,
-				       int result, int info)
-{
-}
-
 static inline void integrity_audit_message(int audit_msgno,
 					   struct inode *inode,
 					   const unsigned char *fname,
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index d8d9e5ff1cd22b091f462d1e83d28d2d6bd983e9..cf98d00f1a1681ff738763d5c4d95c025f7d9ca5 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -25,14 +25,6 @@ static int __init integrity_audit_setup(char *str)
 }
 __setup("integrity_audit=", integrity_audit_setup);
 
-void integrity_audit_msg(int audit_msgno, struct inode *inode,
-			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int audit_info)
-{
-	integrity_audit_message(audit_msgno, inode, fname, op, cause,
-				result, audit_info, 0);
-}
-
 void integrity_audit_message(int audit_msgno, struct inode *inode,
 			     const unsigned char *fname, const char *op,
 			     const char *cause, int result, int audit_info,

-- 
2.43.0

