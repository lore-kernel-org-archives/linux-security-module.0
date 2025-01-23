Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6F1ADC73;
	Thu, 23 Jan 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661547; cv=none; b=HYoEc+yIuTvjHp/80Ksf/5GscCLAfYYtkpQpD05JIgfzgUwmCXYdU88jnr7s7sGd5TJrF0fXK3kwksY1e7unUpItwYca5fi+1+48Cnc1sVw3BOLQI6V4B4cdomi0Em8VkPdWEjSJlCO8V7hcA+QDAdRP+fBL7EpRgc8QHcWu71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661547; c=relaxed/simple;
	bh=5I1O/eov4Wo4fc2UfOQMJCEXgyfeHIz4V6qGPgUDPKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpKGzuvRMmFkFdwqDBYDfTkBMz4LUJ/GEaYo8kcJriOi2S5ab9+D7XJdqOYSLvsC0zaWIxClNtOuZ5FqpM6oEnAIaChasSEQDrXsWMkyUfNiT0jiECerGrvdI/CdPHcNNP4fByodkRIgWNB06bvl7jaq62oRyTzSONM5mrbvHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETc0FV4i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETc0FV4i"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so2262812a91.0;
        Thu, 23 Jan 2025 11:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661545; x=1738266345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIjnwY6LHvt6R7mIksmbgtgNTneABgwSoeDmbXMnKJ8=;
        b=ETc0FV4i1n1OwaAgYo/mEsJBSHtRI3yM1ioDnwrj+xDMfJ6+fK8fQqVNBg7bB+nb5A
         7Ycch3TlfQks9jqcFME58Z2Gyokzj1K7yeJVdz9KWwepXB9W94xRgWzz6mD/dpW+1KiV
         ZaTHNci8dRF/oxF+/IX40euEOJMytl6xo5gOxK+F3i4HFt5zAURnhDYMtYsRPhDaxCMN
         5EmoXz8ygPoa6oh9hPug+TVgX6zgAUn8Qcr/Pv/Na3zx7MjYMYMg2+6yoXg6b4+LgWjK
         GwTt/iHEMmrIZ/jpSYQpFG+x0KoSDAOu2hu6qoFp58RGSU9YhcuAaBatROI6B4XZTe0W
         bC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661545; x=1738266345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIjnwY6LHvt6R7mIksmbgtgNTneABgwSoeDmbXMnKJ8=;
        b=IzFy5ovWG195gEIx6S4Bx8kLWlqeYTNnfDF3Rs61HQpW/1xOr2C7saVzxe/7E0I40v
         UpNIdVJXFETaTD4g3SmH1qv5TQPDg7vzlCMHE1FLcnPHuO2C0EUc+S2W+JWgLoc17+WU
         ZhuM4JWGtGlwrDiVfAODDnPBeyL3rtWTuGuv/253muJn289MwECmLRJMBqjKQuK0A1nc
         nMw4Rx/c1r5cBeZ0DDs2UxoPA1nSg6LicMCvU7mqmvf20E9gUZu+joec0HPXSlbqbp1O
         djZhXxQQMg7Tmf17NPcCyQGHIWGStb0urOy0u03Gmfrn01/PHg8Pf9VbZkhVz+lO8XR/
         WR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN6BmdsekdpG92vWtvRT7E88gyWwwvYeOIfsNpnE7JBDhqCAuQ4X1ByLFkNaYaeELQBr6bUiVPe7kbPDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStrEUwO7RgSCu5D0otq1VsAPG25evzIow3fsE328gZpWeP3j2
	vM1699/AWZ9WC0twf3h72A8OGTLenb7kN6eOlstsrthV9secEXiP
X-Gm-Gg: ASbGncvSP1S8Wqe+N6581iEQu3UAY5qCt2qjyKlozEPZl6jAUSjz6A8WqFa5pNX1Qpb
	qHMO8D3sW3EG/20iIbWxCeDn0FWX/qkt9EQ3ObUDp5ybkOOrL6jR+N1pXFc1MLDLVbfhH7xa4/u
	OKLrgWVIdancfsMJXZ9chjHMni5rBGFxxEAkjBbHOnNgyYbWB4YLraIerI+rtU5ToU45+NCANOG
	dOhAD7/uUsFH2Ldv0FCb+yQBciYUfSVM1rz6LBHC9qnuhnmvULB7DzGJff5rQyJgCsX7KHOKphr
	tA==
X-Google-Smtp-Source: AGHT+IE6gbyGtmTXmrfwb6trB/38M9TIxx96LEL2fKlCbTxpNfqLGlzHJeIY6dAcjretk2EtyjfFkQ==
X-Received: by 2002:a17:90b:2e44:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2f7f1799199mr7171144a91.15.1737661545028;
        Thu, 23 Jan 2025 11:45:45 -0800 (PST)
Received: from localhost.localdomain ([122.174.87.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf80d1sm96662a91.35.2025.01.23.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:45:44 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: zohar@linux.ibm.com,
	casey@schaufler-ca.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH] security: smack: fix typos and spelling errors
Date: Fri, 24 Jan 2025 01:14:57 +0530
Message-Id: <20250123194455.2710-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix typos and spelling errors in security/smack module comments that were
identified using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
Original discussion:
https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com

This patch set is split into individual patches for each LSM
to facilitate easier review by respective maintainers.

 security/smack/smack.h        | 2 +-
 security/smack/smack_access.c | 4 ++--
 security/smack/smack_lsm.c    | 6 +++---
 security/smack/smackfs.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index dbf8d7226eb5..ca38e145f364 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -42,7 +42,7 @@
 
 /*
  * This is the repository for labels seen so that it is
- * not necessary to keep allocating tiny chuncks of memory
+ * not necessary to keep allocating tiny chunks of memory
  * and so that they can be shared.
  *
  * Labels are never modified in place. Anytime a label
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 585e5e35710b..5c17aee5dd78 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -242,7 +242,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
 	}
 
 	/*
-	 * Allow for priviliged to override policy.
+	 * Allow for privileged to override policy.
 	 */
 	if (rc != 0 && smack_privileged(CAP_MAC_OVERRIDE))
 		rc = 0;
@@ -277,7 +277,7 @@ int smk_curacc(struct smack_known *obj_known,
 
 #ifdef CONFIG_AUDIT
 /**
- * smack_str_from_perm : helper to transalate an int to a
+ * smack_str_from_perm : helper to translate an int to a
  * readable string
  * @string : the string to fill
  * @access : the int
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0c476282e279..85ec288eefe7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1950,7 +1950,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	 */
 	file = fown->file;
 
-	/* we don't log here as rc can be overriden */
+	/* we don't log here as rc can be overridden */
 	blob = smack_file(file);
 	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
@@ -4211,7 +4211,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		/*
 		 * Receiving a packet requires that the other end
 		 * be able to write here. Read access is not required.
-		 * This is the simplist possible security model
+		 * This is the simplest possible security model
 		 * for networking.
 		 */
 		rc = smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
@@ -4717,7 +4717,7 @@ static int smack_post_notification(const struct cred *w_cred,
  * @gfp: type of the memory for the allocation
  *
  * Prepare to audit cases where (@field @op @rulestr) is true.
- * The label to be audited is created if necessay.
+ * The label to be audited is created if necessary.
  */
 static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
 				 gfp_t gfp)
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 1401412fd794..432e2d094e35 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -165,7 +165,7 @@ static int smk_cipso_doi_value = SMACK_CIPSO_DOI_DEFAULT;
 #define SMK_LOADLEN	(SMK_LABELLEN + SMK_LABELLEN + SMK_ACCESSLEN)
 
 /*
- * Stricly for CIPSO level manipulation.
+ * Strictly for CIPSO level manipulation.
  * Set the category bit number in a smack label sized buffer.
  */
 static inline void smack_catset_bit(unsigned int cat, char *catsetp)
-- 
2.39.5

