Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826752;
	b=TA5yQoW0m1WIR/emSU015JAVszW0RUoG1QdtRovNQV6gojtrMqwDnB7aexmg9UHrgKdg
	 DVfmnJhYBcBZGoHbNp0By+oz7UP8sHHeNnXEI+zzXhRJ8S6g4Vqr1DQ5+QoJjE3n9HYNt
	 m2tEySAA+MxK91g14Qon7LA0caUzteaJwo6iSNxmNN6P7VKvGg4xcHMt9E7P2KY+dm5aw
	 9Tuwhj7YPvWfA8CFxQbeOIbWR2OMBCmfs1ei73ld2LQZ7pqYDvvscrcxPChzMmNlMegJ8
	 d5QjVMQxPojuwIC1hkwQgDZhBCVbYWNMfbGZ6gac1fResrG0q76JBxFd81zffn1ixSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826752;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GzYAym4hkUMXQ0HK0sfNg5pvWjHHlu4TjX/F6CXV/GQ=;
	b=AYVNS2yr7SF8v9mdLtWn0b7h13GlAL0kEMpill01XCJaifUgic5niJnK1RFOc0V5AF8W
	 /XlOR/WdZFs8Z/G32Cua7Gz2SjtFzPvc7jrE4P0xmsmprKVa3uEBo0nc8n2ItQR9q7vt/
	 RTGSJ5f/Ge4D/I5TZTFQA67aY0aiwc7Tw86icTOtAwTYRhr9DWkixSXX7TogL3ZhheKAK
	 9+LbvZWP/+pYrfvRPGMjI7s3G0WpHzdXGo1DMEsVcN98B2xAF7dkdzp7Ywej0iGFoTgsn
	 Qkjqw9oSlfE3bthooYAzIFDNOlAVY+0KvNY/HiKF0PJfrZIW8gHWsMnJkgVkM28/iBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nidv0DoZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D860841BE
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nidv0DoZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE421F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826752;
	bh=GzYAym4hkUMXQ0HK0sfNg5pvWjHHlu4TjX/F6CXV/GQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Nidv0DoZhJDZrKTe30xnJu3mj/WBEYluJWatKC2TEbAla6KgrwdBSkJOq4VvuWiSj
	 PIbbx5GvewIRV0Y7SG1pehApEhu5n8/+DOVtiYW7mv+cSoCC6SoRrDJk2EUEtWqFMn
	 aDpsHbzmRg3maWLT8cnMd/TwbG07qxGHE8AQWp9XNIKB2iPaXymjuqkYOjgco2LCbR
	 8CmyNz1HR1fGHgsjpaVZ8trVtMx4TD8+nMWAC0U22ja0xjWGG+zBOF8+qlte5wj9OP
	 o5X5SnqqvENjPBNBvaHlRlf2f0yfgPDFMLOM3F8hepWXO/VCem1e8FsAp4t9//bnju
	 VPttNDmCGR2Pg==
Message-ID: <sashiko-outbox-198057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/27] selftests/landlock: Zero-initialize the buffer
 in inconsistent_attr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-4-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-4-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:12:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> This buffer is passed to landlock_create_ruleset() a bit further down,
> expecting an ENOMSG error.  This is only guaranteed when the buffer is
> zero-initialized.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D4

