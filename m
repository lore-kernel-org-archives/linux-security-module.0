Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010036C5B2
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2026 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993428; cv=none; b=h0DOTIUKCt9nd9YLVfNSyF2DUKqGOaFK2vqfYkGR2486Ah7dIvL60bAlXszSjSh3/QI852UtmrJQUsral7guHVN578vUQttyMhSPDKFz+9U0t3wk0RtvPw29nMV5JhgbxIptyHSRjJIpCV802Ial9s1chs52nYrHYXrkMYvdS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993428; c=relaxed/simple;
	bh=dKZHmZi+xVQS5CbSi+LMf6D5ukNa65oK0aZqGSLgxrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTia/BAZKLH2p4GKGlSgOrKZeESwPRvShkXctCbl/wCPAeaXlKGnwAS4T9j0FRx+fndAAg3maqgNNDEzfYe2KORadAfJK3YMCizzhirMtcu5kvMR12okZTjp9bTqif/S96+AmJIFI/lnnxAvupQyVtB9oBKPfIMgC7UDtUr+QJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luRz8Es4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luRz8Es4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3660029a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jul 2026 18:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993424; x=1784598224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCQhDpUBQaP5eNAOavkcbS3PiRS94B5qHHxRvZHqb+U=;
        b=luRz8Es4fOKbrp/4HFzYfKSnxm53ZrBxqtDxxKYmYtXXRQywvuJbL9cXxvcQKgrTFH
         KtX/NF8TY8cQjqfs//DzIfNU4XDfHIm4XGxd6PfDLfOkGJbsw2CFfbypHwkC6gmS3Xv6
         D64JsDeP9EtFZD9/ev87S1a7oCFyPOX/f4X8CHe9Usfo2MGNxoInQTXvpHlB1ZUsvOwS
         rcVmGXlwl2+iDuKEzYa9MJlg5xqWQErU3aKfg+62YBsqMw8Va19hdKRwA9+9n3y3RfTg
         0OWer+IiKB8n7b8PH9JVRBX6ee9XpvU5HpXV9VBhsW8B0aA+nGbeH/Q7ij4YMeV+JuXX
         5G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993424; x=1784598224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCQhDpUBQaP5eNAOavkcbS3PiRS94B5qHHxRvZHqb+U=;
        b=mjGrAVcAaiHUCsfUlMkpSIHR+n7AeN3D1hYdZTf6IFFDWceqAA4jOgKcIE3o2CGoqx
         XpS3oNwsNQAHxXEpxhvQ+B8RzHSrRs7w8iQv55EHv9HavlcqhnYbJAKQHQ3W+fQviw7S
         m+xYPfSvf2KzdEVpfvd+t3OG/I8kFCV64Y6VApQ+b02o2kAydOzcb5qjVfCmLVBDomao
         L8uo1bNYNjS6M/0CvM5CrOyKOWQtExsy8byxO8C2DDgh/z6s4JftHa6aZoWdD1pKakcc
         YgVIyE015EdS5WKLCPbKl39zaW0VW7hZQeWgUJGZ9mIldZazI0IAUW4p3EaznV0ejhmD
         se0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp3j/Cba1MU6GIDFLImZFVV5rN+wcEDduKnXKXzgzSxxAq5aWPxoonETdmt736cbDNU7cekPk2HS2xu+kX48u2PS9d7BNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatWPQv6oYVgvGfXQEqVvQNOYjaGn4LlPEdHVL8WR970e1p1T8
	Hy0k6uJexTSnRV55T5QGt/ElmccZYVOxtNnqXuFDesFY5Hw6SZkkUWE+
X-Gm-Gg: AfdE7cmZLU1YuXofAbwRlCt9DNTCNVvdadSvzP/yObYhujDiXPX78ff9HerOfmTKV9z
	9h2XJJX0+s0ZYVpweLAg5+y6l0BK4ONaKJIq9E03eK72kT/zWRJhYGZSfzVKd41gU2Z2h+x8T5N
	eo1PKz8eAqRzlJty3UjXwNWlEKe9pCUu1gZtgQ/7qJvvgRWjcKSKL/TuB4K8E6oge90PWPZMcwr
	jmXHeOMQCpszHgyGP4uXBVr2rXFE7aMdXTNJl1q84HICetrzuRgdAu+fnJfKxiGCJbI/OKb6LSt
	idad3iosX7/ohq6XGkz+cv6NNU3WzAzl8q9OxG01YOoOkU9sVvQiH3a8x+C/qj6mA+gz2hKn0lf
	/QgTOxcFEVpH1ldzeXbqlnba/zG0a9i7cbelbeGtFo55R5IZ0uYXZ8uh3dw+1IaWYynxH91bwno
	5s9ZCSzUD+iQ==
X-Received: by 2002:a05:6a21:730c:b0:3c0:9c19:65b7 with SMTP id adf61e73a8af0-3c110a207ebmr13095048637.63.1783993424197;
        Mon, 13 Jul 2026 18:43:44 -0700 (PDT)
Received: from sleipnir ([2804:d45:3612:3b00:32a3:79f0:cdff:a04a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm59675775c88.1.2026.07.13.18.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:43:43 -0700 (PDT)
From: Lincoln Wallace <locnnil0@gmail.com>
To: paul@paul-moore.com,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	penguin-kernel@I-love.SAKURA.ne.jp,
	rdunlap@infradead.org,
	Lincoln Wallace <locnnil0@gmail.com>
Subject: [PATCH 0/2] doc: LSM: update usage document for current LSM stacking
Date: Mon, 13 Jul 2026 22:38:30 -0300
Message-ID: <20260714013832.977443-1-locnnil0@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LSM usage document (Documentation/admin-guide/LSM/index.rst) has
not kept up with the LSM stacking infrastructure. It still describes
CONFIG_DEFAULT_SECURITY, which no longer exists, and its description
of the module ordering in /sys/kernel/security/lsm does not match
what the framework actually does.

Patch 1 updates the selection mechanism description to CONFIG_LSM and
the "lsm=" parameter, keeping "security=" documented as the deprecated
legacy option. This revisits an earlier attempt by Randy Dunlap [1]
that was rejected for treating the two parameters as equivalent; the
new text keeps them distinct.

Patch 2 fixes the ordering description: lockdown precedes capability
when CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is enabled, the integrity
modules are always placed at the end of the list, and the remaining
modules follow the order given by CONFIG_LSM or "lsm=".

[1] https://lore.kernel.org/r/20250114225156.10458-1-rdunlap@infradead.org

Lincoln Wallace (2):
  doc: LSM: describe CONFIG_LSM and lsm= as the selection mechanism
  doc: LSM: fix module ordering description for /sys/kernel/security/lsm

 Documentation/admin-guide/LSM/index.rst | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.53.0

