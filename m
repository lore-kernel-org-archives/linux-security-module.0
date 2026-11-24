Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550099;
	b=pfvx1xbAESFsSsXde3BVWBLMTaTn7+D3u5MMLsPAvULQzg707pKHFiajwEoFxe2XnpVk
	 NCBabCw5Vwe8ccduOmd+s3Ud6++UaWTlI6bYT++hIcCktGPIvXIfK+0P3KIp7ySTKINkn
	 x2Orismv+KWOiNl+dOA1B8rdlfCHHlmWvGc6cjWQX55RTho4kp/xu9+FTdP2recQC534t
	 f9OEN90DlN01iKUS2eg3Z0WNrLsr4bAjYNxCnY/JryFkZF5fg3N2b0QH7GqLXk0CEXW3f
	 xtmHw6tUAqHVvhOwKs2HWDkpcomWGPCwxXYIodj/7bUpXVjNsS5wFPh8UyG4IL3uLoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550099;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K73iSUzKTqUziQUGlqO6LgVSf5jbqs0cFHujmi1BTpM=;
	b=zuOlSwdj4724h1tWQ+roycOOWS176xTtrIVrVBaXzH/69GDOPEbeZp4MldzRPizUdGaA
	 R5DKtG3+xIMRjUujIFdDdnkEBEVJkuow0+oDoryKFfY2oUUh0JAoxdmIQPZQI+x29K1D5
	 5qE5eatoPI8coJg8BLRa23tijXs/YLLozhd3SmO1r6ZABUwpDJaoVsoNAXlB9KxUrETQ/
	 FeRAvANi9uej+cjzA6z1z1Lc3gxfg2mc0Doc2A+7gqbLaGGKA4B7ARDVkrkRpt4lM+JSV
	 KSHreUolvvNuEImCDgivq2IYPLqMh42INegKjhquAxJxMmzE+i7KIehcsQGfA0/8mCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFdKcGDc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B868606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFdKcGDc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B9B1F000CA
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550098;
	bh=K73iSUzKTqUziQUGlqO6LgVSf5jbqs0cFHujmi1BTpM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SFdKcGDc4ojHjH4Ar1UmBXUQd3PWPnmBZekcyyC4RetCZyTvRQjo8C/NFIA55OUWu
	 u5RBwAxqQstYFo2vx0SQ5xbh3rMvUEMRFUIYrWdhyyQ0xO8QKjW9ojFpY+hw3edlQq
	 MvC/ab8YjlWrU1chkfUDsV4U4O9WvrqLw629H3XufU5lFcld/NGdD/QinuOoI5dP90
	 c07+YDeVDKl8NNc5kpNdHmHNfiEAM5GnwAvRJ/Wr+oyYE9yG+o0FR1jjpP16IhkiK8
	 KNXXxpYqmqtmUIYACNbl82Yl49Jav8OZWM31ahs270NyC0aoJZL7IEeJqSwg0bXN9Z
	 +h4FVB/z38jvA==
Message-ID: <sashiko-outbox-231924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/9] KEYS: trusted: asymmetric keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261124194043.1651679-1-jarkko@kernel.org>
References: <20261124194043.1651679-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:54:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 9-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124194043.1651=
679-1-jarkko@kernel.org
