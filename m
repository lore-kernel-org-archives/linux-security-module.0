Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697740;
	b=svXPtrUJtN30gl3UAjkrejmfVghpxYJMN0adrbfqxWOmLg2xbRc9dfHj1ypU0VDVfY1X
	 UOjfrukEYOKD/JE1x2Il3XUSxH7F3X/ltK8w3NhKg50rkMX7X6KYSK4hoMGCMe/7lryhR
	 G13UM6MAthtdBOHsCzBAur8QqHbTYlHKv6xZn9I1tFBRD1MXlbsmN7ygUPn2Vfkl6aZO/
	 4n/SQZ3gOVcNYPBhlvCCRwfcMTxRCNIYh+zZEOZCOwoMGRn70ZT+Fpn29KK5WmA1OWaKL
	 Vk7Mgi7KdilWBlNOEOqIcSmK1z0xgLOPytQpey1eKoAetfxLrIex3rRKs/9pdoIo4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697740;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xUsb3Eukc+j62ISNycXBQsYTIppIztXYVcQ+iMQ7I4c=;
	b=Wf+XkKw0go6FhiwIPoivo0dGPFAitauV1Laikku/VWrBPaZE7FIWlt2SLAtTd7kqFMYd
	 0D9RG7968QaqqpoDMfOt3a86BifviPIPLSy/rAfqfG5/A4lmzp9wqqr/Kp1JyjLwAlPK5
	 3fINwNw9Ck+LXnjuA6jVHrvMGcDJxAJn7tm45dg8tVUA5Cu3SDey44pDNKTxuEl0dPi9A
	 dFL5SQ6J/93Fco4Tf+/n6OatxgeFYYQj3nEQiX0h8Aj/IXB59KRia1kl+Nq8AAt9yYycQ
	 T8x7dOL+k7rXh0lNLQrPfjjczlYup/6oo45J8yACzwwzSXmdpFrwHrl63cwsNRybqmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM4HsrB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC9606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM4HsrB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B751F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795697740;
	bh=xUsb3Eukc+j62ISNycXBQsYTIppIztXYVcQ+iMQ7I4c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MM4HsrB9Ql5y5T5IqJyTmfaOiFsOBm6hUyojvMnydedE5EQLZKng3rdql8WMa6/Lc
	 fQTZ2YLOJlq8FkK/6oA+Mmv3sxya5QBSK2cV6XX0vigiU2hAp6BsAHdon7ddYFXmfI
	 JmiIEZDPhVAdoAHFhNRqRJlHOwNhdKnwf3PU4GvH/SsIqmwDn87Th2rCA5OEVIZQtM
	 iJtSYz3Dpx4VjJhywQZ88aMOy+OJ9mi4mI2ifX43caaJdYk2VLCJ+3rmjymYrM6cOR
	 qmC59B8E1HGjIKfDIm4tJ6ur+5UD/o41WdSOuR2MEMSnZLQ6P0kRr2efMRxRbPoqsQ
	 obMZRnsWB3I6g==
Message-ID: <sashiko-outbox-235546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/8] lockdown: fix the securityfs interface and add
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261126131315.1256553-1-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:55:40 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 8-patch series:

- Patches 1-5 and 7: no issues found.
- Patch 6 ("lockdown: bound the status string with scnprintf"): 1
  potential issue (1 Low)
- Patch 8 ("selftests/lsm: add lockdown securityfs test"): 1 potential
  issue (1 Medium)

Detailed reviews have been sent as separate replies to patches 6 and 8.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126131315.1256=
553-1-caixinchen1@huawei.com
