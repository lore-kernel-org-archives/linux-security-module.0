Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010314831C;
	Thu, 23 Jan 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661405; cv=none; b=Wf3GrVGiUpwkLUEDPn7NusPMWj3Hpdvk7Sn8bLn2aa56N8/i7FTtMGVufkZhVUQKa6x+0xTIWBrYMnh0XyhQ5sqtao1Wu3d44SJN1+Tn+RkxvEhL1MkwVzQRK8pux2PWP4h7J7G7TGeeB99loEwlvVbSBX3qff1sj5le4HQlTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661405; c=relaxed/simple;
	bh=KOc745FyjKPvZzmhRs2YBB54rpYSPvyNlUU1VJJ7VQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDpDlAX6antZcv9L7mOpcaEqGbVdle+NAipD9NpzkXTamnE3S496HmpZqg2+ciIxLuFatg8ao2B+6r947QQr4dXpOTGLBAhWRhq0nCfv2UHlriL3CmElD9bp24v1vtVCmvPm76A/kVW2aG31bGu19pjPkGzlJwAurdFO3iLvNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz/zW7KW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz/zW7KW"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so2565719a91.2;
        Thu, 23 Jan 2025 11:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737661403; x=1738266203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYAxyPe27hpl15pqny2ax6du3jUfo2/Ke4Am4zGScmQ=;
        b=Tz/zW7KWvg3bgMHQ8p/5WPR+RuZ+tFYcHzHY1WmgWtfCzJpaV/8NEpWqWUkaSEflt2
         7I+t5KZNfUPXpSllsgSxg/VkjiXNnx2nGFYMoFYM96k/A+CNFVgL8vEHhXDEfnkecUe+
         KV7iMIyS8nUAKo9B/BPKXVzX2KpPoSLTggGtTKowY5d7xiu81u/JOx638GEq4U+RbfC4
         zb/oiotnsDOnGrVb1x9r7zL1nS7LQ50pAXoj7yp0g0IxRQiXh1GOEf/j4w7Iuj+UQj2D
         hiUj5s7ARFsk6wkWpIPmeUjUGBWOgROwKOb4keWvLqZzaL67NOdMxrckGG9KfE54vi1v
         9Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661403; x=1738266203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYAxyPe27hpl15pqny2ax6du3jUfo2/Ke4Am4zGScmQ=;
        b=dA2f6lXrziXMv1Nf8BUwrWJSBpmpKVWAQJIhbHXDj9tMRNvEe2+sbpb8sInY7ngnw9
         E8e0IJFC6qDiJVS93SkxsKF21dD8BSqgk1wImsohuVpz3QRgjL8KTVjsZXjXnTI9SK6A
         vjWlZLLybdnRjygEqWnOyvyp2E4hBaoKbpzC4RVCLOIT0wcj2BhKE3PyUFcqQnEGM+k6
         QKzsR094RezhyZZvp2rwSZi7Pv80lGdt3ILVEQ/hywBjeTptkTyAtI3nEt/MqR8niaYM
         1+WEzuPcduNrITFA9f+j/D+ly4Fm+r0ceZGgs4T4Z/NArp4cxbphUoc2k62XPlIjGbR5
         l3VA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6OfZPf2c2ISExsNrUriwiBK3FANhEm94zAhrkl2ZUEYo30stYTeRZI2zt4cjtSx6u8nQkTVZ0Hzz2eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAr8bBnbWs6CrJCfm0wXFMNQF+6AZblnJGyEOz0infz8+ZWSQu
	ZqstIzCgzar6taXHv2UE9+f57QAuheoEmeb9ukN/L44e6b4lb/rP
X-Gm-Gg: ASbGncv5Qx4l2CZZShErv1mpwe8DeGE1eGC/qcu9AHe5E5kPTCoC3dO8RuLiXu4ldmm
	vzihvzTlsg2fpNkkdNOyn/Mgy1w8uyDDGd+VKxQ1kkO0esv6YGUu3qjNV8pZXkNa4SWEy8H0S2N
	HsvWCa5jVr6qx/aC7BewmF1XeGMFSBxJf1iGs8iuU5JWPYpBTUMIqTEZ/kEGGcddtPXvmGg+/gW
	64alW7Z1C/99tzSoADbI6RwXxX2o9YykSDArZ5b4mUA9FrxUuSr7pQNWElGFrf71RcVToqIBaZC
	fQ==
X-Google-Smtp-Source: AGHT+IF9MUJWye7NYFuqZaB4WmJjre7mEeU1rgB35BpnDwcw2GDyOwUh+DPJXP27vkoT3RBBOdGp0Q==
X-Received: by 2002:a17:90b:2543:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2f782d9a1e1mr44324042a91.33.1737661403131;
        Thu, 23 Jan 2025 11:43:23 -0800 (PST)
Received: from localhost.localdomain ([122.174.87.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa82f9esm88287a91.43.2025.01.23.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:43:22 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: zohar@linux.ibm.com,
	gnoack@google.com,
	mic@digikod.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH] landlock: fix grammar and spelling error
Date: Fri, 24 Jan 2025 01:12:10 +0530
Message-Id: <20250123194208.2660-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Fix grammar and spelling error in landlock module comments that were
identified using the codespell tool.
No functional changes - documentation only.

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
Original discussion:
https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com

This patch set is split into individual patches for each LSM
to facilitate easier review by respective maintainers.

 security/landlock/ruleset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index a93bdbf52fff..c464d1f84792 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -121,7 +121,7 @@ create_rule(const struct landlock_id id,
 		return ERR_PTR(-ENOMEM);
 	RB_CLEAR_NODE(&new_rule->node);
 	if (is_object_pointer(id.type)) {
-		/* This should be catched by insert_rule(). */
+		/* This should have been caught by insert_rule(). */
 		WARN_ON_ONCE(!id.key.object);
 		landlock_get_object(id.key.object);
 	}
-- 
2.39.5

