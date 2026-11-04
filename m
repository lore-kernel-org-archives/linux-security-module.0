Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826868;
	b=0ZecZA/WS+aFAkOPqEFhKwlrANmJslRn9Acbxf8oY6cVmH7cZjzjk4Jk8b5ExZJcOSzk
	 ut2a6I0M1raxacHgCYE9rMBaB4ekeAiWfVsCupLxMrRm/nph8kYc4EI9UysUb1hsCNxt4
	 KaGTWScNgGlE9MbaS54Lpo1+YgRtA0McoheEqlBV0HrAEKL0FXT8QUqjzLDo+jwp9iQBx
	 R75QLfaMsE4ZEQZ7yyS2c5ezovXl57Mn7o2anQeUhebd65BUZhJKfTEKv2RGgCg5IQGKd
	 wWAxqgnafrFRiGEgFPhJXMhl7/DPeTM64PxV5mpTqNJvR6t95O91eg7iVzzZefNX6lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QX/SPmn9hJf+SFb64A5rSx8VJRa3wmu0815kjqSBdFU=;
	b=hJOZRFaxUGWjPmqXFLSUrSCJlkiaH6tbDnvNXroY9v8XMCqOU6bkS83zbufFSFYVuiJU
	 fYF9SL7Vf3hRdHtb1F5hAtW2DoAQ1WxGQTgaH60kkSKJ6PqWvOm+1zHM5d34vAqo/8PT+
	 L0DrSC8/Z7rzmBRZDHC2OSQnNc2hYgzHq31/LZP9CJSboUEdsCIOWapgxzrwqjKl2km0Q
	 7a3AwZVM1Vhnn/UkmI59QlUuDI1QO09OuobedOjhe32JVE7QXN46xM73H1ki6Ku3sFggK
	 G/tuRmYXrfXbWupO6hw6AqaPn/QKwm1OboM6jPzJOfq+Aibo+K0gqt1DZxH7cR/45tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZeHIZkC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D36070433
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZeHIZkC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D341F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826867;
	bh=QX/SPmn9hJf+SFb64A5rSx8VJRa3wmu0815kjqSBdFU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OZeHIZkC5OfpF8ZsCxVGvnSwFXZOJGPgFBv44K17O88lTRTnWNzfepevErkgRbcS6
	 q9wkSrJf5e044ocrvDsVViSTx0MjV7rbQI7QPn8IBJMEl0lUXPjGkWHANIhh6+VDDu
	 bcLfk4y8Evrky4pEzozPtRjom04AADe8QAxV1PFHbbrI2sjPlXbXz/j6wIkJhM6nS1
	 t0M+Vff8Y4+QjHrrSVw5+D24+fLUgsmso6y+eep1QJ22Ih1yGDbJH7O6DsNiNMJc11
	 aSbPrGLVQ6U941ps5K8AntBdp9gB5kjY6foo2M+a7s/rbQNh5Kc3w+Q/7kM1RPagXj
	 lAHUU4fM7au1A==
Message-ID: <sashiko-outbox-198066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/27] selftests/landlock: Assert
 audit_count_records() before using its result
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-12-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-12-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> audit_count_records() fills in the record counts that are checked right
> after it, but its return value is checked with EXPECT.  On failure, the
> counts may be left uninitialized and the following checks are
> meaningless.  Use ASSERT instead.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D12

