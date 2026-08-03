Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA53546E1
	for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796283; cv=none; b=I8cvkRkr6je+RnlB3l5jikNddrE8EdLHGemEMasqIjIoCDzgbf5+3Rt1n4pFslSV0Slf8DRVfeS73q6FCogn6gi4vCG9Dh3X9R6s9//BVJOI2RmSylykpw7YNGsY0aoHwky7nkWx1nwU8P840ddYdWWciqugkotj/vKkSr7vE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796283; c=relaxed/simple;
	bh=KP2yf+UiOQ+kZdXdrgDO/YAok+x/uEJ6qSv4gTkthFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUbrmEZsCYslkHWdCx1FbSJXjkBdR8CH6Aicgf4oBLyZL1Ii0+kqrPujrn7EAfbE9ra1qS63DuE++usTRtKu1cPOFgIhIOIxos2CYtjwoVvn/RN5HExFV0ApDMtk5JbWMPhIMqtHDm9lgipTtvsgrPk+XSSJVZXgzS5SAUzIjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqxocZUI; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqxocZUI"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6689f36ae56so6167592d50.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2026 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796281; x=1786401081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2syxNBpEmU6+L0HeNqA4IUUoR9lvooZKJyrfeWUIyKY=;
        b=sqxocZUIjx5MLzD7xcDtIYQUjgoUVoduLgb08NFCleeycdRHX91PdC96RS0VUah9AL
         TK5XFpwFlCZvwvLJqf6+EeKf5qVlo/anIfLgDUQd/2lJdkMYpKC6fxGPsRhb5/g6uk6l
         lkEyMT98SzP8c+za+wzp4Bv7mV2UcwIAp9e50QrLF10pvtfh4k0BgzI8iGh7x9sB0LgZ
         CtEwryEindbTbgDlyuwzjK3et5VUb0/W+qzDLuTzXBiqIVXX51saIdPYlLcBD6JaalRr
         XoOXMD2XvEafrF9gOhzNplEZXdg3l/VMBVlmSDjAwwVd6ISPDNPdIQWz1IEI2supksqd
         Szkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796281; x=1786401081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2syxNBpEmU6+L0HeNqA4IUUoR9lvooZKJyrfeWUIyKY=;
        b=gEqZluBozQ1H9Q+OnrRUIswmSRu4GuAsXWk+vqpQ5rUrk+anUmzzHkZwWPsZycasEr
         oYQKu+JQWjirOuvU+QFki9XKztQMlpDneTL2+FvjKWs9F++CCc5uklcpvpii7IbL6ZJu
         5AgCmgS84x+L+fakVcq4AUcCOMe3P8pddp4udxsAjELu0pVw5hc487sprlqEIb3IA5aL
         +uJpDxNAMsKt5K1J+vjxFIKg1P+jyM8OusiDfvn1m2uEV92zFej9/EevDPOL83nHLEt0
         HtssNlDodhs8dFIx1iT04QkhWSsPrwCGz3PObiDLCOOAhUsIYKrfJVwscX95ZfpDJ5Xb
         0x1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrmw1FotCtH//BuCIYsqv8Vgo9JkWJNzYfsHbNm9Fm1hWjLPYuTMr1P5fdyiXTHyTDDhnaR53bsYNgGupogKQXypFJHfMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqHtQjv+H3mfEDURCLTx5Fi5vus9LIm6NCs7obJlMdBYQ+FCfZ
	QonSePFvJgUZNIkYPXRy6B/FMN3RmkglQA0psUVlto8Lp1CEz9KeAjy1
X-Gm-Gg: AR+sD11voWwszaiIwrBuZgPXbzzOmUYuFi7HRuBp0iH/H+vlSFF8TWPeZE4U06OaspF
	j+shfceOuzSnpsjfMy1heXa+EDI/PiUCjcYFe4X0AmksA8QDRfLA8PQRo4wXtv1jEU2U669aJ/4
	yBjZaB9bZVEW8Lxo545rDD/ifx/KQIbKJjk9FHXEknehUn1MUhJk3J5c15htsJ7x1s17jQdfpB4
	dQisHOESu790HJLulhqsRcTKuW4pv8iOhqaAfPLA6A8rlFdqjtjkyXOA2/O4mrPxLojm9i6FwYG
	oUtktoQZ/qaYozuSMQwCWevU3fIqFNyIR8McXFNB/erGMof0y2TuZCPJCnt3DVDJhe8EzfPEdDl
	sERWsjDppEsiSy743KvUMkFvbaAOG+sXsL3IBwswcM7vCIDi7woCFv3vRZzQB7NfYBRGaSXzmeR
	Ur9nkRMH8YcNlOSEdlvch6gPDXVQTZso1RW+Eml1QSAIGr/8JtIr0NM7A7nEv1NvCJigtS0GR34
	5mpzSzp/euwqX5piuCtFZY=
X-Received: by 2002:a05:690e:440b:b0:667:d82d:d4f3 with SMTP id 956f58d0204a3-6694efcc207mr10221232d50.11.1785796280625;
        Mon, 03 Aug 2026 15:31:20 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6253:b407:801c:a745])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6694903782fsm6420774d50.21.2026.08.03.15.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:31:20 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 4/4] samples/landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS to sampler
Date: Mon,  3 Aug 2026 18:31:08 -0400
Message-ID: <20260803223109.707353-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803223109.707353-1-utilityemal77@gmail.com>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
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
    v2->v3:
    - New patch: use LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS by default in the
      sandboxer, gated on the ABI version, with a prctl fallback

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
2.54.0

