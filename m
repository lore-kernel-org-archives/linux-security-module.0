Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622463;
	b=z7Jg+XO29wou6kxjd8EdQa+DStWQ9Zle4/6yb+3tWHNVsVNuBlsaZUAyQn3lEdlB9sJO
	 m6oPWkycBd5WuMKi7yQt1e6maXbindG8rsoS7UQRncDbAZN+1GkP+8NLckgQegR9T/pI3
	 oj03VNwbVnUSlWDWyWAxRhDBS213X8KDd4ONY8cBXUuv/dwOCM4OV4Wl44QNrIkVunw/Q
	 v5YNbq/m+iuW7zQLMSjOPrDylmmb8c7Ar23z1TjCBb0XiNvXjC3IWlHFyhhN5Z/CvOpKS
	 DPoXxZaPNUG2UIRHYJpExYqC7ATNaPv6shnAc55X0KPd/dMUUWZNwRErLRGgZzolrQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622463;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k34Ggujwvn5PcwRjXIChUYqCkar0vADvg47mz3hHWEk=;
	b=nc8v9okrWjY4AYQsA84pbwzvFURpcpSaRsK46p9Lod1oIi9+QmNsgCzMirhqK3fypx9P
	 H3CM1p3B+DYiAZaY4vJeQ7XyT4wxgGxBw/nnh0NaJ82SSa2AIUbow2z/T2e2TE4Q6kOYq
	 DB8iXnpRak7SmrLLgiPv/z991iGFFYjQrM0ZXCFVuX4Ay3XUBBGF+luA1x7GynkXb7gY1
	 BYhX07bA/p4KCuSJJIa81CoVrgYg60psrxW0Yjx0kpXylbf5Wu8nkA02EpiMJvnYyrGNk
	 lkro5bo70q808uWP/eLlUIIMLtnUg4bmKmIC2RqiXPwx7hrTkhbrvNlJvvlsmuSsfcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXux2F4f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E6606A32D
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXux2F4f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F161F00A16
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622463;
	bh=k34Ggujwvn5PcwRjXIChUYqCkar0vADvg47mz3hHWEk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HXux2F4fipe86FKq8VzXoC0cXO4RYkJHN3mWcYF531lCxTxpttgFn1BtTSxAuISRR
	 LQrV/+YZ3VRwyVxHrhd6KU2JyOOk4OCTWpyp2vFkg7aP2/Gq7WH8mUNGJfjS4NOw4N
	 eupM7jgrWUpuXvrLwU+89z4e7lYlDlpsN7siTULb+M2LZQ7dDODQ7e78F/Exzn6TIV
	 AvlrH1HKX7SF0PduV64hVpHtE/o1WkikcnvVbBPDRuK9bL2Rg0co4L2jgLOCW7CYAk
	 YFNBfIUmVAg4EQx9n5kaFC8aBMdsKuH3FIZNR2Qtr5zHu+VoTZZQThyEpLW2mmgyDG
	 LFPPLHM2xCRjA==
Message-ID: <sashiko-outbox-193405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] KEYS: trusted: Disable sysfs bind attributes
 for TEE driver
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261102121518.1197453-2-jarkko@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:27:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> trusted_key_exit() calls unregister_key_type() from the TEE client
> driver .remove() callback. Suppress sysfs bind and unbind attributes on
> trusted_key_driver so userspace cannot unbind the driver and unregister
> key_type_trusted while the trusted module remains loaded.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102121518.1197=
453-1-jarkko@kernel.org?part=3D1

