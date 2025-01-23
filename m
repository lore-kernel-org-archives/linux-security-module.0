Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F91B0429;
	Thu, 23 Jan 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737660947; cv=none; b=YMUBwY9KoJoQq25w9Bm3B+kNIiHh8RTZFDROuNLx5cY2Q90FOQeigDaHRm6NFPwtBEZWiuFkL+/2Xc0cPpac0jxnvSsa86umj3esYxtjIs8Xf1zV/6IzP3NuHZC3cjZv2HLHORqhZMRpNrMgwXSKvJjYpCQUc5WAXeMDZQL24SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737660947; c=relaxed/simple;
	bh=ESpLXCEdOn1J+q5q9DszLFYf5swVpneA1iZMYueDAqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+V1mnarCzQlcvyCp5atCgJNNZnTdN89U1tBn2jO4wL9kMl2+/sy5UpCwn+H8r1UyNqmccW2RJRu1L0jjw6FK9jlid5ZWUkDHOdfiU4shWXda8qRKNRu4jjncEmuuvP1+ZC4QZf239sJCJAYy5nFuhoMqoM/zDi93SBL5pvqvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=hegTNU2l; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="hegTNU2l"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so2048262a91.3;
        Thu, 23 Jan 2025 11:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737660944; x=1738265744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=De8/klAiEcziSJYMh8yTkQ4WGD5pIWz6oUQwRgbcHmE=;
        b=vGlaLqzSyDiYwUeCtGZY5uKUzpxQCL4YSyI2UAWqQEz/3N9U9ximEJTiR/M6mRHJa8
         OvBJxtv0/8sxVjrdMDiDVmJcjEPaFnmgILGoqELPRc79gFfvZbpiybVXFnkCl8PBc2+P
         AgYTQ90NBwtN/BZ8m3C26xi2dInigQh5ZhXRNp/TgqVYgyKk0kFYwTutIqRW8hMFEBLJ
         4tYM56XGLE8ySgPRig/mDejxDiDhrK53URXChexCsAUaafx8EXkL+N5cAA1NsbHDHEi9
         hxJXM+zsfqsStr8SV+ak0nitEf5hxVZVJeotpj0fIJpdxb5faCQLGhVaUHJtbR3CgZGv
         yTrg==
X-Forwarded-Encrypted: i=1; AJvYcCXybCuunkX1EFwSXGBP8cgcxyIzal2Fk/fgSEG4NnParhvWoqOKVKLn0CPMyxuSkFTfusyWcrRTeY5syDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+jr37KZTFITKuLfyvTwJ0zoQs8lzSI808LQenIkrZkJaDVG/
	AZBJ/u6IgHPcHXspzADj451C4MboAmGADDX/LzKECeECLTuNyPWl
X-Gm-Gg: ASbGncusLwQv4xiVcLh4Bdz2uWf95k+rE0jX19OsqRq6qCtt3mYU9AOtZyndJqmGXB/
	dPg2JpiH/cbxxvWpMukl4l4jgaTTYAND3v6jwkzueIdplLF+AjC9pdtFSG3CYhUaXLU7ERLMNAQ
	6l0x5r+5f86D3LzYzTxctUjOMvULAGl2gsINDvVnCmKhj2/HnsG7NXoY3DCgooqbeboGpucrX1I
	8DfaPqIBcdxLTNb5LUBWqV0i3NruROx6z66pB+tdewjO5of+N4OYk6FRpNijCqh4kXsE9zb4po=
X-Google-Smtp-Source: AGHT+IGb8s1S69xnCftb5fH7sST8BIOGUweDI0CrQICnqZprs/VB4cqjDBgFICpNxVzpmslY85m5FQ==
X-Received: by 2002:a05:6a00:428d:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-72dafae88b0mr37532816b3a.21.1737660943761;
        Thu, 23 Jan 2025 11:35:43 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6a07d7sm318819b3a.7.2025.01.23.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:35:43 -0800 (PST)
From: Ricardo B. Marliere <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1737660942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De8/klAiEcziSJYMh8yTkQ4WGD5pIWz6oUQwRgbcHmE=;
	b=hegTNU2l8NdHfVFAQU2M9Ib+a6R7FWvzcqmLHGNPpK7OI2/iS0AUZbpRXX5EZ0ZyuCQ9T9
	z6cq4MGIyVsupvNXou5fSOCviJK8MPk6YjffvurOtfOO0Qtk96PXDK5k8SzJtDyFQsGVSK
	3yiinoYAQbbtnrYaSWcDwVmKqROyuKdLJKr+gp4lmHANH82BaJhF5S7YTlGSXmo33/ZH4W
	b0cnyaiQ2f3nQ0ZHppZ0Lh/LrWSIzKKImXGVf+sTcHBrOIGqrPdbJnc52CzCr99YuhOzPH
	HzTKeVAGlbrgZyoUhMoHyE5Wt0d8PgLJqYd08w76Lv11aB0Adu8sG0zxRXo9fA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 23 Jan 2025 16:33:34 -0300
Subject: [PATCH 1/2] yama: Make sysctl table const
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-sysctl-kees-v1-1-533359e74d66@suse.com>
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
In-Reply-To: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
To: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <rbm@suse.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=rbm@suse.com;
 h=from:subject:message-id; bh=ESpLXCEdOn1J+q5q9DszLFYf5swVpneA1iZMYueDAqE=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnkpoEi4H2TiJIIzRBB3mTFCU3dMfXwsz7etwGN
 SYsjT1OF/CJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ5KaBAAKCRDJC4p8Y4ZY
 pjwxD/9ZwhORWchZKcw2A1LDFgVTk3ASg4Q1lA4gwEp3SB+HxxbgESixqf/YCNPcy/pU8QyY3sM
 Xg/fWur1AfwQMo9kGOuQ6EOcI9V4yC6nzC6JeQbBFfTGWPfxyTngjTes/5mBHLFQ7jDvCjWelTb
 JR65InBOuqyZBtTEPDnl+mNqk4YhUCw2GDeAADqLKKd5vlcD3RIDCR66tWVbd+KGsmCT2vcCVHF
 gC2yzcxklq1kWlTG92vs2CjchCKLx0m5rXrCUcS28yf1tjxWV0gcbvQAE0gKtYKpGVQ7FyUhnTU
 lWMFkkGwiEBgU2BacwHaGGy6eqn/KjpzfxdFmnctIJhNeCV7tkd1R+Sf1JG1Q/cXus+Oc5bsWBH
 X9LLlIH1iklf7ZFnYMl0GbSd+QERON7IgQ9liBdhSTMunJIXxYar0VdgmiQDcAWVcSvVre5TXku
 iT5jZOLvVQE8+cDkmtvxGaTMcixJxxVMkXaNe3RTU+3lATObrBu/AWUudH77wMdBRB98zLl522+
 FnrF8tG537gEO8OAtMoUj/zylFnLY6/fdeSstnfK3HalsJuOV+Si9Tg1zs11dbOX8vUDuEM6oqO
 U4zIGHvldv12SXnMYFyPab4ufdFJBhTC3OG4ZO7X75L3VenGh8vWsuzdJLOD3Vi7b74226PILAe
 RzvebGfIKNhU/og==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows for struct ctl_table to be
in read-only memory. Move yama_sysctl_table to be declared at build time,
instead of having to be dynamically allocated at boot time.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 security/yama/yama_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index e1a5e13ea269d4917fe2c78cb79f1d44881653c2..54bd5f535ac1fef9409ea96ad60825f565318daf 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -454,7 +454,7 @@ static int yama_dointvec_minmax(const struct ctl_table *table, int write,
 
 static int max_scope = YAMA_SCOPE_NO_ATTACH;
 
-static struct ctl_table yama_sysctl_table[] = {
+static const struct ctl_table yama_sysctl_table[] = {
 	{
 		.procname       = "ptrace_scope",
 		.data           = &ptrace_scope,

-- 
2.48.1

