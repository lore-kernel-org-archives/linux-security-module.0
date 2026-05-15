Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685C3C3457
	for <linux-security-module@vger.kernel.org>; Fri, 15 May 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812961; cv=none; b=gUQkx6bZnL17LIfpjo+H4gJg8CLxVVjf0FzQX5FFcq87IjD5XvdZknaVs8O2/Mu9tE34c66EU/IRBEZWDJWS2osxHfJzR9KdFFUwHkt3NAMDp2IucIRMCTxvF11XOLvMPfpsBxUj+bGkWDSLXBzn87FCCmq0uqXoWxbjaovI+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812961; c=relaxed/simple;
	bh=rWHGbHohgOySE830gytKZX7gqDyKkLV843P8Qr3kaT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGkOqxTdNhUCF2g4+pj3g624dv2r7b192t5dklUGd5GySCRagVOoboTwC+ZUi4ExVPwP1mPCG3zkvhFijkOqlQs/VoE14QVWBd+ldhQyJrsZGUMT5isGfVT6atFpccYUFaL/4B9C6QHZWg7doOAHti6vKzmYd+yrnlc0/EeFgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkZYetKT; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkZYetKT"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13317450f83so3774286c88.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812959; x=1779417759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIp3iYXnXNMmxZZYnuz+1KU87Bfjlx2A8Ev02qeKxgs=;
        b=FkZYetKT6Em0BHjsLVIielo0vCfbyQ4tQt3qxIyE+/RYdR+6iNYe7wC/Vxx/zWY9XU
         aFOXS3mPn48zYhb7tJ6+p69nHWihJ+RCHdrEZrCGHRNKZbtvlkwENs0Nh7MpF/f4ZLS8
         0pO9Yr1iQD9/b3fbVhmC2xZXMQafkKUiL4lYamTAPkPa/l882TSpFAqgg4aUoCx/79Db
         /L14f3XMS+ZlLlmC93IdDRrCoFWUKAbfWS+W2h82KO/spP0WIKuYUB4vzoS8M+jrTikt
         2p4qmmXpcD+GeXc0KfwmQ6KtXrD+HNJ+IX5Cwt8O/KGOAeZuI/3wYgXp5YtIqBCiZ6Br
         nVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812959; x=1779417759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIp3iYXnXNMmxZZYnuz+1KU87Bfjlx2A8Ev02qeKxgs=;
        b=LsgTnZpbAMinS/X0qTbC3OKEVSX7qcmmGPy3CCp8XpvUszQNdnzPLZ28b+V9vUK2Vh
         yEopf1DvR9z0VmGttPDSbF6GH9H9Z+rx9FYSMSXW1Kf0Tk8TCdVxmjenx+EUhsTcE6iz
         SaFcmi8yivYO2GlBHVm0DqV9qbyK7F/7618CeTFzC76zW7n/J4cGjt/RPM28+xLP0Mcx
         e9V6FZuzvm7lVIWn+mrSCf8lzjpTrydr9+etzA3umtcqOmvVdDgYy34WZCtDRje+KTRc
         pYrYdCG+X8iHRh9fxMVzgmB6NNtYyEScqQ8VkScg833f029aOXhEHYRFzhXO5C3gqj75
         5dOA==
X-Forwarded-Encrypted: i=1; AFNElJ+xP6DkdxIZRbIiGAJXPErTPDUZbvYtY/bWE6FRmeWYD53eA5hB3qLp6xAtkXy/XhhrQgQW0yE1io4YeJX256vR2uFQLNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+W4qqNOYtubq8734f5SENp10W0GJp3BvBP72RUmGCGJ4YpSEC
	1DxX7Fzj4kPxAC/QUJ9hHjY0P5Ly7e3Yuw31sAL+7LaowS4ArnU0Tsf9
X-Gm-Gg: Acq92OG+fsZrW6NtlGRkokHHroDqz/6kheaWOOgXZ3qfTvSfZk/u6R7vouJmubX2Btl
	gFATFFhDjBw/9JUHRxN0XRncPQnlr52zm/rzNZZUwfiRQWcHe3b4IA3MkQY/uRk4fLoPSl9HipB
	giixX8BGHkgSJLdVNpxayag0GAVkaXin3lIjHo7GkV73g/RG7aw4p73x6SIXiXQ+WaRwwi7EZG3
	U+hy3KHUj+kEqr5T5NM8ZJUdudQnsRBSiLTGJPEH57Hl4+DCHDSTD2DReZdj7+A+tHEQlW3yJE9
	+aYtqIrzTGkfEb1KyXlkfU6CzbOEwNCKj7GrGT5pf5+0uvjpISWvggt79gjHEwan8krZnX148P0
	lRgld4MsGnrpV1UUiDvprC7xv25yZ3F5Zdhsl/St5YrBQjNJ/VwwoW6NpfD59yVgjiCiE2EEpd0
	pbyWSgUSnnDaQvAomIelli+bOmjhp+ThBUXg==
X-Received: by 2002:a05:7022:6612:b0:12d:ce34:3f92 with SMTP id a92af1059eb24-1350552c4c6mr924814c88.31.1778812959442;
        Thu, 14 May 2026 19:42:39 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm7328271c88.8.2026.05.14.19.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:42:38 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	lyutoon@gmail.com,
	horms@kernel.org,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 4/4] netlabel: validate CIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 10:42:33 +0800
Message-ID: <20260515024233.204019-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
References: <CAHC9VhS63xq5Pja2iA4DEkRU5sqpQ8ozXzgLBaE6Ck4PDCKpMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed on the return value, same reasoning as on 3/4: a length
mismatch here means post-parse mutation, and the unlabeled
fallback is the wrong default for that.  v2 returns -EINVAL on
all three CIPSO bounds checks.

The 8 is the offset of the first tag's length byte.  CIPSO option
header is type(1) + length(1) + DOI(4) = 6, plus the first tag
header type(1) + length(1) = 2.  We need ptr+8 readable before
dereferencing ptr[7].  v2 will document this inline, and use
CIPSO_V4_HDR_LEN if it's exposed in the header.

Qi
