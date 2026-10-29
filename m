Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245572;
	b=EKRRXoSDcFOng4mteiWH9192laqfwnQmNQRA3OpMXqP5DAnsZt8wePIHoS6vEb18on3L
	 g3LypXG91mBElQ+HgfGI78BTjzrvvPCMcrJE+OWuBX/x+t4vTACn3GR9ZC2K6/XtvCIng
	 upoorvuyiIVFZvFy24C1lSl0vi3Q8iTIqkioucIiQ4j+NzWj6RObYlR/gru+BdjOeSnxH
	 OmmdPWpw8i/4XnkVtrRDJ+J91yRa2NOZZw+pYWc2BmSct8CXEqI1U+izBDaDprWxKUY7U
	 Phm8t7/KeHs8qiwyhlCAh0vMKMGk/qj6+Y8KuFLPJDRuSDYm3F7l8up4iPXUC49f1YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245572;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=kY0RdH+bif3hp1oMZSz9xQcbx3vIn8mbTcAo0h4nIcqOjhhIEmJfJV9ThTiuXv8AVKkS
	 taQlEij+DnRAsoXlPOOdT0rlsM9of0Q81GA9obRyBq3limS7yF8w2BDDly+OmXqppLeni
	 kfUveDc74mnZIhCiTEdRySXPagC0NqVP6KkZiOSwdn3C4L9mnPzWwHDcL5c6PE91yrRn7
	 2QvAs8W/jx/xGrlCOcvmVNygP7XfKTWNU+jb2QqlKGE/QIN/Pvwl/hE4PBzmTPAlwFVtz
	 PMIkw3IP7GGbkcfybiE0vzqOy62E6vjvY2tHrFNUTOnpeGt47Z0jZhaFefr8QsCpvug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q28IWFJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3F606A31A;
	Thu, 29 Oct 2026 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q28IWFJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633691F01828;
	Thu, 29 Oct 2026 03:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245571;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q28IWFJ8cc85Pmvj85keTICXJYvlBpjdY5SvkklhryDAT7W3t4l0NPtW0l2ZeP1HE
	 SwIeYuUFCM/m3GoKVv1NlT/Sj2YGCIevW25Jn1PY2xQtCllk/1c32Fnr0sDG1D2Vqx
	 cW4kiL/8Uhw23SulhiHAw/dYcHahdnljgptee1o0JE6HUualMwrzQ1d0x+1cgw017r
	 5RQk04wN6LMoMgVutHQgN70moX/ltt9MdCbASOpXiSfjIjYpHliatyK6sMp1qdmFoc
	 /rbICAyzYWf/xfzrVxqihqHnH5ggVzPAIQaz0G7h674Lg4MQsOH7eMox/lLu7iJ3ko
	 tDQ9zNKsjonDA==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 linux-security-module@vger.kernel.org,
 Lucas =?utf-8?q?Dupr=C3=A9--Rabinovici?= <omniameasunt@proton.me>
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
Date: Thu, 29 Oct 2026 03:46:10 +0000
Message-ID: <179324557093.3327.5514860593383240428@kernel.org>
In-Reply-To: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
