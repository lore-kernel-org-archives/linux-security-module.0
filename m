Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAD3612CF
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290360; cv=none; b=vA1DqIPoVcMQCLIPE8fidi7+wJp4bjEEsCE5xoXpjAmXRMjWVfnkaDFV/NmH7/8wBZ8pV2hNDBaMgNfRTSNAHOqM3MOaLkNwPR1Jh4TsTjcF8sEgjxKLDYvCqiEvtlHGGPBdOobVFX/ospw6FttDx351/LmzU7He7FVwo5XVko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290360; c=relaxed/simple;
	bh=9YgdDQB594YhY04UhKjFUKPBBqlh+WnhU+EuLELG1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2DoR73mZH8MeW4HR9YXZqAfbnrfra06q8y0QBUbjhRDORIxgUl1FKYkasKgt3U5lD3bWj5YVMQ0wD4MvC4YAuq4Ou0duRQAiPouATyctW6AnnPwuBreX3PATgoSo2adM1Ls5MyM+cnNIwAS3v6GZ3QwTr3mwD1jVswlgfCClV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gORyc2qm; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gORyc2qm"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66807ba2f0fso1652269d50.3
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786290358; x=1786895158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdWOIkrtO8O1vO8qraAFeciOWzTCObEsIaLYBRcPpHo=;
        b=gORyc2qmbXP0g1bSUjkEZFuu/Rp1MT14CSODKxzkB/2TRymuUkMr2dq+aHOJq4c2mI
         QRuOZIxuoC4HaNtbFVDYT199l74E0sDq70r7+gf/4MDeAadp7Ao58JXG7ZIMwLiacb+4
         F39sn2ZbuZACP/d3Ms0RD9Erv/rRiTfm9tSQNVRP4Db+5CLkmdjW3OxeVEAQMKiv2Q2L
         Z2hXeptSTwB4FDcsv1ZhffDJBR4YrfS8ybpFT+Tm4VuMcmv9tSsCM191934wBqbVurKW
         AQqP6lov9I/j+ql0GY89CzaAG2oVEw3/401lRkyEpiBJ/GeOU9IZIv9ZwQebmpnX7m8O
         ZPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786290358; x=1786895158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KdWOIkrtO8O1vO8qraAFeciOWzTCObEsIaLYBRcPpHo=;
        b=MqjGV14vcXBHt1O8F59612/yMx0Xuuyvs1eMV1kqeNLTe9CKsrg/vXmJjJim5xiRm0
         I4+47joJxmefXztcO9QLYrrWHXm0WYUiNDWvwhIIww/kbP1ANuagpsxZkfyrxZhiMHsw
         w7bkCRwsdgGfLgSMqgNW5GRgSOzZvmAH+nMe5Xx2KuNK3HoD8+VZfavQt6Al4xQwh0eA
         GejDCxor5ii6V/DOlVJ+stlx+Wq97GJ03nJRU55EMkZqjaoILVKj9dqYLKh/6thgTxn4
         ybgugwLvnjn2jaHhtmvRnPOXoyrtQ9HTLmARnSvKtsmXeC7D8tbqGHd2sIgeT9meoq8f
         REBg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm30pOxl43OFFLjnjsYmXoih9NpWTBGSNTNEh1rFHhZq/Nea6XVxzXpK7YK6adL9efb5UBscAWuf1qilRFdA3TYsS54L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7lj8XbRuZShM1A1Zloee8UaOVJQiE3wCv9Ip66uvYkiChk+o
	utUbomW0emhxK73VaJriuuK298wR6Yje3DLhlQRMXd9L/kuyNM0OQh3/
X-Gm-Gg: AR+sD12DhCDqLyAy+SBTHcUunAsliBAi3wPfBGarrDe7WJvn2c2yI9Sja1GZBb4yiF2
	J9j+oEZGcok1wDK3zFSFsO1yXd5VbLPwPMu/KBiE832hhwisN7n0eYuzMDBhqJEBbuyo79T2vHO
	dFXO6jbgxJ0nGBKV8nqF34UA/QUG2JzdyaJxTifEWA9rhemmw500FESJ8T3G3vnasypjMRi2Siu
	S9ZkKHUKOIAVJ5nTIQalJi4dg79KPHTB6azs4lSckdWfcVV+bSbdZ71sg9jHgaBRaIIlzX1wnch
	kEyLEYRNBIEc9HLFYPumwZB3kLwqVZ7bnUujYKbwhlXrbGDEDdPO22eOL9s3V2y3mVTGKragiBe
	5cZdV82h6JPceaITTxmhVpM8Btmm/xrN/Cv4ekc3MEo4a+XX9fKg74CGucbMrHJkoFxSMVcANlL
	gLEsqib2s9SFEGuPLK4BLeUgY73y/6liPKl15JJ3rgeVentVS/5gVIzNuXgaG3umNbUYBEvvLXS
	zNC6R8EgyIHNqa3qOLMOx6TKWOnUn+7gg==
X-Received: by 2002:a05:690e:1552:10b0:666:541f:6355 with SMTP id 956f58d0204a3-66ad72fa49amr6636286d50.35.1786290357741;
        Sun, 09 Aug 2026 08:45:57 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acacdbea9sm4838001d50.3.2026.08.09.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:45:57 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v4 5/5] samples/landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to sampler
Date: Sun,  9 Aug 2026 11:45:23 -0400
Message-ID: <20260809154544.1253100-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809154544.1253100-1-utilityemal77@gmail.com>
References: <20260809154544.1253100-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to the default flag setting.
Gate the flag on the ABI version, but do not expose any userspace
control over this flag as it has no practical effect on the resulting
sandbox.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v3->v4:
        - No change.

 samples/landlock/sandboxer.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index ac71019e6212..030583273f3f 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -369,7 +369,7 @@ static int add_quiet_access(const char *const env_var,
 	return 0;
 }
 
-#define LANDLOCK_ABI_LAST 10
+#define LANDLOCK_ABI_LAST 11
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -453,8 +453,9 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.quiet_scoped = 0,
 	};
 	bool quiet_supported = true;
-	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
-	int set_restrict_flags = 0;
+	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
+				       LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
+	int set_restrict_flags = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 
 	if (argc < 2) {
 		fprintf(stderr, help, argv[0]);
@@ -545,6 +546,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 			  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP);
 		/* Removes quiet flags for ABI < 10 later on. */
 		quiet_supported = false;
+		__attribute__((fallthrough));
+	case 10:
+		/* Removes LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS for ABI < 11 */
+		supported_restrict_flags &=
+			~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
+		set_restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 
 		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
@@ -673,7 +680,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		}
 	}
 
-	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+	if (!(set_restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) &&
+	    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
 	}
-- 
2.55.0

