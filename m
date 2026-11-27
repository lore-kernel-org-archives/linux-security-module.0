Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782367;
	b=Bd5OURfFNGl36tImX4Dl4/P+Vva9q74IEPn8dUfc5vKx/lfUY6GOHzYfKlF/zno9UEIQ
	 v9xfT3+U7BV069tfASmW0YFPYPK+WOJpSk+1mBvDRg8VHgbxdst5aWo0mD32TZUAii+BB
	 nb1UI+Bj/LqlTSbkdzgGX0JDO37fln9Q2IlNFnzEqsbU1XHPC9DcPztMHnqHWGHfLAKzK
	 zoBlRDcDssJnXVwB0HyLlB93GtpB+OA3xurJt/fY7T82PxPkodZ0PWLGZHy2hXMXkg2oJ
	 T9n4whl1416r2VCvlFmvFPKILRB4EiJEW92t9ItbTjinNCf8H8NeEOAM6iomZdMm98A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kV6HCkHg17aUv/4nxrZTcQI4vk7oT2OxJpFiIoiOVLQ=;
	b=HAPDTKGR81w2uZHUsL++9Q/WT5lq++AjvkY7hCJi2+VwsJfcX5nO3FGE+IaJFruv9OJB
	 JIBqQeJFDqTIZ/w4STfv/LyggADubD5h/Fk6U9l/I2Pb4sv+/uSWZ3Bld7scXmaocEaMc
	 /XiJOZM4ND1v1DjctJfuBlKPp+EceU9b/sJOCiolNBRwcJI5SXU9SXJbJ6Fhj3i8CDeFv
	 QVjeabKheN/TDt3mFXnrhCyUVSaYBWTkU8Pq/3Th5MGnBMwh0xOpxjMVgIPDfdSWS3Z5p
	 yMy3Hr/2g8HOR6E0eexF8ZTBYo0njF5/Jh60XlftzRuXZhmjvw4eCPZmKlWKZxec0cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiHqdEnT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A449606A339
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GiHqdEnT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4181F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782366;
	bh=kV6HCkHg17aUv/4nxrZTcQI4vk7oT2OxJpFiIoiOVLQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GiHqdEnTQRVXMHt4ZcEXIVQ0eUlBVkWr6sXUU0XMKDlLZ442e9ApBoZU4k5OgxEBS
	 72WTdb5oNVK8gEteQVYCsWHzpARp0HwCE0xMW0roRHlado9FpIj0zbXxMRT+6SnTwJ
	 YzwraIJhPAC0v0aHTmpgWAsqQRIuveD79iVYQ2i0pmEAf/wiyfZCHpDpxPBBLMXmlO
	 OHbYj0np2ILvnob4IEWms1myrKbFcWHl6lQylGykC7YNxvboeuii9J8Ui1X4PbgHXL
	 PpaEOpYX90THxg0n4sNsgp26jb2b3NcoCCxgU7+G0Qs3tID/XHtSGQCwC73jalSV61
	 Xg6YNmqRLBK2Q==
Message-ID: <sashiko-outbox-237382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] KEYS: Return user session keyring on lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127121433.2400766-1-jarkko@kernel.org>
References: <20261127121433.2400766-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 12:26:06 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127121433.2400=
766-1-jarkko@kernel.org
