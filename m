Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771811;
	b=fT4mUwLhY0VCuYDrklkkYOjC4PMfzBVH7r1ctrrpTHMm141BCu8+wnJuKwGYsr3FTTyG
	 uAbavrYpBU4L7pOPVjAjuW+LCmqz/XVf3qnAhi3eIcEiR+SNnCvFN/XQsiUX01NOdRpZN
	 9OQR/PWTRd8y/SGMDDDw+8AW+yST25A5TgwtpmcfF4yGcucCCnrrarCqRAdKVh43A+Yxy
	 KISd2D1/yN1uzZZ2PyHSPVeI9C50oU5yANmX1AH36ErifjeBxT0S+/tcAHQkLlkf1TiHr
	 rkBoGpW2Jn92xT7FdXjuaagKn/4ynBS2uELxo8tFxG7Zqku+Hh6jH/5W3LGpBhNdcLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=u61xyLkBEKui5b/hZjDVoIFylH0RkHZhOLpPTJn5Blk2wfqsHMqeCm2I/4BXtDon/Hcc
	 9oBA/Qm74qP5P5WrRh6cyWmWYEnm9DvgOWY7ywqbRA9mwAKoGt6eqcgjWfUjhpu+ckO8+
	 m50PScVGlpKH9ilbdIro9WD1xQ5QhsYULzYin3F87FUDaHd0+/aJP+1Ei65o+D5wZCwkW
	 hy8HuUbZ9AQjwAm+fWis0MdJu07Y35nKS9yq4eJegdl2GQ6p+smddpZCHMybdaRS5Pv7K
	 ZNFdJeYB4zVWwdu/QJbW0TmpFY+QrF9ARSEAbDl+yVBuWrM1sLhGmF0Wi7MwpPebdHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=em7+NEQm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986C606A326;
	Fri, 27 Nov 2026 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=em7+NEQm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1321F00926;
	Fri, 27 Nov 2026 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795771810;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=em7+NEQmBXzuUweQeu0bwV0KcXjZrQlnz14TitHjwEu853W2L+9ZPtImfxQr7FCHb
	 qW+I6vL4MUHCuJx0TU0Omeks69phWbHLVGiNtLIYGbBnWCEIMi//ZHyukPfj5QV/17
	 lA+nB+Ae40gCWHt4JKFLn5khhepnM/6aGdmZbGooCCVkJBmAZ6fPpNVG9InflXzdJt
	 L2/imUlmLSxTBV4g7a4QNW5vew/C6LY6glisQ1s7/JqV/AbHjjUy2wgdR1A2pwvt6l
	 z/6IRy3hRm/6sOIko/AsbEI0PNu4ybiXO7oeSkT4f5+I/7+qQaQRyDSCe4qjV139Uz
	 kgjjrP5LoX8ug==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, James Morris <jmorris@namei.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: 
 Re: [PATCH net] netlabel: fix duplicate IPv4 entries in the staticlist dump
Date: Fri, 27 Nov 2026 09:30:09 +0000
Message-ID: <179577180965.3294.12209541123439066397@kernel.org>
In-Reply-To: <20261127092325.3563681-2-xiaolinkui@126.com>
References: <20261127092325.3563681-1-xiaolinkui@126.com>
 <20261127092325.3563681-2-xiaolinkui@126.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
