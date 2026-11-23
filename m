Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436607;
	b=BPlS0iT6vX6hGuksnDgLTt3oU/5nPui9I0rNvWCbVOeCIx8sQtiMtOzRLb9CfJaSmVxC
	 OeU6VjQQwQbUz9dEf8J+dN1SjXpTATs18mZWMOTm3fiHAN7YKm77gxNN1aRMOW50+B9Vg
	 GcoEZjO6UAWf6Y7yJ4X9A02yzqZ2fxCVQ2Y+iY7SRAD5xGrGa3EryFWZNIcR3SOobmA/T
	 Ws+hoeE1Ok+y7xeynwtybY0WvKkyRMLHPWhVT+PRhElwmRJ8C3ZcksHbjxHTNUl0thnYj
	 +qLS/WkDIiSR6kLc/r31TtQtBxYAc01p5lrRHLQMEK+W27sTYZrE6qKNmpGzkQkvaOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BXBoWZrNa+znQc6Qjivm/ii0C+THKTB8koifb4yMsG8=;
	b=DCNvJ5Z0ZFrC2ALHmax8s0AgDc2wowbtlbJCR2Y99wP/THQyLgSipfYIwtBhFluI8jg6
	 vCa9GLlUFUKY8dClx9z0hKPMKWgsO+7vRSMvXFQCr/MV/wwDjg77CCfOPhp8i0hRbIZ4i
	 kSJLdrKDl1uqMni7IiPleX0w5wVX9i4gCCqcrE9N1qa8MSrMqtDILmr1oQX5Hfjz0/W6Q
	 FSpo7zv2yFdT9HDMBezN4f91Bz0tACaZ2XdCyhgNKM+BrPxqiMpbE/98NKmqADoX9qz2I
	 IbwqlLNQr75ak/QhW9yGkbBTxOd4cbSRc+D+D+L7oAZ3tceOBqCPgXHfQSK6KAvBOnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ck0GjIpq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB0606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ck0GjIpq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050141F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436607;
	bh=BXBoWZrNa+znQc6Qjivm/ii0C+THKTB8koifb4yMsG8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ck0GjIpqBMV31fjXw7YigLk+S1Edl258D4gJK9sTUyNbUOWL4i60M46aSTBWauqKD
	 pGbkrs9yLsVd9tnZ9JfhmLm/xRD+TJ8BNaddrGNZUD+QaJGOednhbVuYwYUcLST/uC
	 +p5JQc7mGnTvjZ8wNDX+F+zk9VPJmbrEaleGjo4E6xu91yllictKGN469/B5uCtFz6
	 v4CNPUMhrowHI0/naT4klOtsl9quBmXux5PkRpMjyfpFIqXQauE2IhPYcgA06W8iwH
	 xDGYT3PCMAGu9EqpF+3kWt4NnG/5ZXpz0uAdBIeyWF94sebFwTmcHdG/cwtG38KuXB
	 nTZAnSXBy53mA==
Message-ID: <sashiko-outbox-229209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] fcntl: recheck signal permissions before falling
 back to SIGIO
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <54EBCABD3ACBF0A5+9d780112081161e2f99fe501c2c38f1614a68a42.1795434950.git.shilc2025@mail.sustech.edu.cn>
References: <cover.1795434950.git.shilc2025@mail.sustech.edu.cn>
 <54EBCABD3ACBF0A5+9d780112081161e2f99fe501c2c38f1614a68a42.1795434950.git.shilc2025@mail.sustech.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:23:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 2-patch series:

- Patch 1: no issues found.
- Patch 2 ("apparmor: mediate file-generated signals"): 1 potential
  issue (1 High)

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/54EBCABD3ACBF0A5+9d=
780112081161e2f99fe501c2c38f1614a68a42.1795434950.git.shilc2025@mail.sustec=
h.edu.cn
