Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764575;
	b=O4BUQnF/33y3DOLkotcw8OGRzQKoy8U/YKuiE2PqTJgGQIVGLSshMIIHW67ndOaP/lYP
	 Y8G1Bv5iA7O5sYr+T3jojD008d578CBFRTjHXExsVDISn7cNuapskvAZ11JROHByJEyKw
	 ygyfLxKmMtvEWXueXjeOssBxZk5ws85ByPddbZLbjaEJoCokhlwdulupfSojx2tc9gB9j
	 CZSkc1ajrDX5Wioa5XzLRKl8SVRrz/LqVn6jfGswmXfrn3eaDHSZPnxVk82NXgMIiaACz
	 tdTrkzBL7t3Ux1HaX2kHBsdvPmWivYVWstxcq4rCgc6ODUx5HfW09LhnQh01DObDT1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zBDrPtxr95uLq+wwut/I4OrBKrfga94bFFGLEETXFFA=;
	b=itbyGNZX86+uFIyz2NVHmEVhG6WkYjEALvnj99+RncTfTWx1lDNfqw18ukxwaSSZ7xR/
	 HjFV/DqjcVR1cM4aKFB2Vw6NAnnPt7U40dUdeRuJyPlNFOApmgfQt9yCqFPJJo+yqZxiQ
	 6iYzTdlv2qA+5Ua+SWqHrNLl8x0UjZscvhke0GIaKrsD/iVZcPZ+SlTYMtXuO3szs7coj
	 3NrTaFRjuIGM+jxsl4WM8NEK60MHM3UNhc5rENK2b3s1VLkzXXZKMLCm9n/8xZesnlPpB
	 C6qAzIRCqKNu9jbQhHnXOQDsj0RKNihKZAt2qEkoc27/AgZi7foVzH0VW9sVY8LIlBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJPXlrX8;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA81606A327
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA81606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJPXlrX8
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-380c28f9e35so8680924eec.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795764574; x=1796369374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBDrPtxr95uLq+wwut/I4OrBKrfga94bFFGLEETXFFA=;
        b=lJPXlrX8owYo6OLbUTNBkyNo5jNAAPWr5aS/HRbzwEah5/mBpk2X4Dh98goKV5/GTf
         2gt1Ai6oEydB0nMvJQ6QXSz+QYwi3xJRaIQpwvY5q1Cg98OYjmwVEq3DFTdc5uq65zdW
         +116mw94N9AXqHutGfGLOUryAJt3M8Shns6h4qPmPz/edRhjrw9FV2CE4e7zGcTyUvRT
         c8IJshIvHKil6JlIfvWfQ1qpYr6/aQZCTI7cap4HNFbPKROia/4nwKVvhf7/qdwOd6A+
         qqXjxyIfqvrISjENqmrTL9tSW8ajLn7HXvT2BFlY2a6tfduAzgYU47zA/A2gni0RAX7l
         jvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795764574; x=1796369374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBDrPtxr95uLq+wwut/I4OrBKrfga94bFFGLEETXFFA=;
        b=2bC5s4VblDzmvwxuMrAGOdTO0xhmwfxkW/58i+GBUGNHgmbqRYEEcLtmupv2Jw4DFG
         5gsg5+eV9pxkalmYxybuBsOkdLu8gilMTcrAWdDcGbPtlPSiMUU4sNY1yZ83fHfLQuCr
         ugXm43ujaL3RTm6zAyzHm58kz6Xhu1j/f9rs3WVasbUmxr5Uofbq0i9XmIjZhI1JMMl5
         zN+myP++xzua7mCMkBiwklyKxjGMDK6DNOslkt+oGA5vsaGpJP9bWt7MN5+sXnfBNMIX
         ddaKuU6ZcKqjYStdyAQYPLlIQdw1up0DDoNbIv1oOCN17qzfzgyWsCGBItJ3ME+1+Da7
         QFEg==
X-Forwarded-Encrypted: i=1; AL+hErF6zqeU42lp4JO6PALsUGh3hCRK1gqAfv7HVmacKI/+cmkPPlM4jg8ubpef0WSBETl/XjzT3jl7a5y7X+Qs9PlqDtzhm/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D76jeOaQ7+hkTQBJJtfLvZ5/AcfZ7PBGF96oKC5q5hHvdqWH3
	ctYTHNzu47xpfAkTgu+kDGr7D0zEvhODw0AAIbhPeA9J65+2CGHV4Qph
X-Gm-Gg: AZFdTZciw4tcXukDlkOAw1Oe5lQJx6BQcbvZz5WfuYnJnxz3qYpyK3vUEn6cWvd5RW3
	XIEJaD2wMig1iMaRkIHiFDgLIv6wLASo7YVKHeID/pptlYrm0tsvGgC9fLwCAxy0roLr+ZStzDK
	R23BQipQaZItnwfEMGoRUePGnxbVTwcI/IpntYvgCx7Ho4yNvaDjLVzpoPz/zEsgwQZfUF4C4UV
	42cvlxiKy24T1NxSorwdqdBVHC9woOHADpCC312njfqw/92UINTSwi3dok7Rqq/kIXFpm1egMW7
	KScQ2rAB68wKra/JJOFT2O1iXRN/rcOuCDg/nVGAuFRN97kIVKZX0wmgUbj3R5uVK+6RKXOMhZu
	VjUBGjNBvZ+e66KDghSft1nUF6dmDy+gpUkKKlsPOVS9CRRJ0te+dxO9/OH0QVprvrmVQ5paCar
	fuYJuNtlWsb6NKLsUy/GsDukeA6pkec1T45IMR97qiiumJYqmXuABs9d0OSUR7MthzWeJjH6SvT
	SB1atRdtle5TGn4kT8wClUGaZQuixUGHficSYpaiDLsaA/rRG8fZN0VubPsDNEvCPOcqxN49upp
	IXoKaIkJ9chCMCPpbr3FT2+O0kELi9+vuFfRXpR8GXvsv7ts
X-Received: by 2002:a05:7022:f90b:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b56f36d5fbmr14790665c88.2.1795764573739;
        Thu, 26 Nov 2026 23:29:33 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm54799871c88.8.2026.11.26.23.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:29:33 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ima: free the rule label list in ima_free_rule()
Date: Fri, 27 Nov 2026 14:29:27 +0700
Message-Id: <20261127072927.172066-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_parse_rule() allocates entry->label as an option list, like
entry->keyrings, but ima_free_rule() only frees entry->keyrings. The label
list is leaked when a rule is freed, for example when a policy write
containing "label=" is rejected.

Free entry->label next to the keyrings list.

Fixes: 47d76a484050 ("IMA: limit critical data measurement based on a label")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/integrity/ima/ima_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2dc1d93aa768..c3c4faa99f5f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -410,6 +410,7 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry->fsname);
 	kfree(entry->fs_subtype);
 	ima_free_rule_opt_list(entry->keyrings);
+	ima_free_rule_opt_list(entry->label);
 	ima_lsm_free_rule(entry);
 	kfree(entry);
 }
-- 
2.25.1

