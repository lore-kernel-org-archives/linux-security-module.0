Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826763;
	b=x9H3yTih7egONfqmBMOhlpervpltWjSsk4X8xzuE79VdFjl92kMswVtbV8Z2CCWfhr62
	 3/EFD7mMkmDeWB+Nb6XJbBCkvlvJhzS1cLat/5OKcj0hRSE+wYrUuN6p88YOwB09yHDtA
	 5X5Yc62XamvLAzwzxoowb686JvadxKvBCBgUm3ALmMLZo9nxSNs2+ermnOAKT+vhOpd7l
	 9kUsHK7rSjZjC+2H34BxGKTPKdK7NDSGVjjjnlgzgyay6GG7uozWu8rkTtN2lNCHupca7
	 OiZkypwCLEG8TfSIaXaQ46vN62kPAdgIFMJ936KHRrgDkgHSMRzqWtgaIubzmcPVuyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tI1TlOKtwJBjuSpQY+qsgYRJuPDUx9pxx++JBJ78dyk=;
	b=LZPnNOZNjyO+CMQI6G2M4b4kqMa3ZwbDdZS656OZWUQRBCHh+3QDNGCmhbDMIfkPkQDL
	 pGQvkTtuFvVtl9ndzcduRrINoBTUHVkS2Pndg90yiCJC0TuS3rdvSyJj6nJ3v/BWU2RD1
	 HjUFsA4tvn6q0u4pA3w89OwSTaGAI9waOPKRyimDkxobwtbgSpZcrXHYxQvFdghzqRTmp
	 8BQyiLpoHCqxnYJP1ixotuOklgLPj8WpGXn0mJWNEQ+Dc/IM/RMzjt8xenvLNdwTFLjj+
	 zYkGwtJMROQm9W7ST+f+OhZtjceokxh1lubkJTAQpZD/Q5W0drVIemgWsyS7eh9Xp3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HR0k5S1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAB60ABB03
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HR0k5S1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF98A1F00A1A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826763;
	bh=tI1TlOKtwJBjuSpQY+qsgYRJuPDUx9pxx++JBJ78dyk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HR0k5S1yA8rQx+Rn5ZbuRYwacHsEQXrbt1/CC63qPU5Hfi6CpAyc2gcnJRur3NsAQ
	 NX0wa+FJhigVj5BrlhmNZDD3bdtU/MT6fbiskGu4qvRjkFUme5InxhXSPTVXKPnrfM
	 Znj1nJSSI1Nj7kehLeffD1TFdUcYqrQt8RqdR1N2PZ5OE0MXn8MHR3OMIWMgqFVkvY
	 Iup099EtxXlSlbfeIKuAgbKMlfeJblM/Fr44JsUombV+6HkAOQj4HOzFuYXZp4xpcc
	 51NW9T4cGfsgSeQMmaoyRWty3nABmmYD53n7MyQOytuVZsgQXu2zEXPppftkvij2T2
	 fNB/yDBoD0paQ==
Message-ID: <sashiko-outbox-198058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/27] selftests/landlock: Assert
 tracefs_extract_field() results that are used
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-9-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-9-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:12:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Several trace tests check tracefs_extract_field() with EXPECT_EQ() and
> then compare the extracted field.  If the extraction fails, the field
> buffer is left uninitialized and the following comparison reads it.
>=20
> Use ASSERT_EQ() for these calls, as the other trace tests already do.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D9

