Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117023;
	b=NjfnulaH7wxvaUn5nrYT03yB6hr7vjvqX58ItQNsrXc76b5CA2IZGrI0h6Rg1qEYmigT
	 efimWDNGBwD/8TF2GBOj/IsIz4VPONVbUwwt9/s0QUrq0YWTBEXj7acvQwiRJK3tZMkBD
	 ROt8zrc62pOv+wa3NvucWjoRPJLjEYvWQd3pg1NoBt8dvlQSmwr2T+b4Wcylu5r+0JmnT
	 BXYd/A/chqdv21UO0Rcf5+IuBv/O2IjEpQH51Kb34y/XcXd3l1tC7ZWhH1jWAP6IZQnDd
	 WdL5wV2ydYKE6qFeR62b6OyW+0k/NEpzlpwqsHKCbqSJhnlEF1ZlmC8s12u2ugkUIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kMGHqoivCQBt3MxZnpJ4VX0O0yj446YGyEC+ZDzcoxs=;
	b=ovBKr3gOdhKec2vAJn4J2EDyxdkIwVnVZM7eAtVIrGS6aWaeFN7naja6MLFjA4lRzOD3
	 ZWHr8TKzafxDA6WWDX66NxGr+uKsZMzzNOEW+bXbv9llid7VtaUx/g76Hqg9x6SNBvXFe
	 /ETWozWJlbRuaIVklSTxcAZ6sT9LpJNsanidtxKfPYgYwblPtFBtsb3cxa8NyPDTpFbiQ
	 9hiSyCljlw89Yf9BJew3G38NT6mkcbMg1Y05zugujyHnf474vgKYHf4H/KbkyDg5ctwgD
	 LqyNJTmqL8y/I5ZS0w78eTXV9NE8RSIlHSAkh/fHDh0iPFZ9qbcCWfSCpGl3XDv2XTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXY32+0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18960A260D
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXY32+0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C141F000CF
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117023;
	bh=kMGHqoivCQBt3MxZnpJ4VX0O0yj446YGyEC+ZDzcoxs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GXY32+0M7S6QoRjghUIgG/XRmV8HppoQE4Uqt/7/6QudHKCvJ/EokzxSFTdknLSgw
	 lrv8c/R7mpMkDr4BXmGBTIEryJW1X7gqJxf7KemLjwB9TRgo63u8IaxK7N1J9xOnbk
	 QbkN8LOvoVVdtrKUvCyGU8UanPo4BkD9o7RX+2UhNeKBQa/twTM4oUgMcNvZhpiZEn
	 9MuzAe2PE2atGD12aIeTiXBvGA5fBRKTjXQ36l7mu/m9HhcqiD2MdHVydItzZImk5B
	 QYXll+wzmb0JTjCxc6cixmmGodiTgEtZLEUaZXFPYzvYNPRKmOGqYuRiunQj061kT4
	 rIV9vz7EvMPZQ==
Message-ID: <sashiko-outbox-223953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 11/13] docs: Document root namespace uAPI
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118193539.240065-12-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:37:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Userspace container managers need a clear specification of rootns state
> transitions, namespace fd ioctls, mount-tree construction, credential
> rules, and process creation semantics.
>=20
> Add Documentation/userspace-api/rootns.rst to include the kernel-doc
> sections and system call reference from kernel/rootns.c,
> include/uapi/linux/rootns.h, fs/fsopen.c, and fs/namespace.c, and
> register the rootns ioctl magic in ioctl-number.rst.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D11

