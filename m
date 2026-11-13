Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587103;
	b=LJK5HD7j6rCrMELz9QOqQ+K/SYfl1uwSzgpDAaqwD9ksmfRL2YAOtSsBpi2YGcmct0MD
	 WFmBa18+ZZ/SxMjo3faONWxak1Ru+HiVCV50+eeHyrNRU2Czm3gPSSYZtmPp9eQuevdcc
	 RDnMRfriXLzMQkvKV1sfFl1Zecsnk7UgWpq2TpsPkjn/ODGJZUWO4Uj6NiH2OYwfNdCun
	 POnxZAOyLLVhVSjWcSAapSd0FwoSn+T7vYVp8gzIlSfBFxA/3PO2s9OZMyh5RjFxJun3+
	 I412Qn+El5rJ27f3YoVHBv1PdwY9KdtwqJQt7dpD2xRXn3xdyd0VCGRto4g3TDbDJdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QkWetrAcR7fhD7FyEbwBYUxzoS1eX9XmfVypNYl70yA=;
	b=rMtWLrMZHpvwQN91wr6MLTvvrqFtxdpd1HcP4ItUpAKEt9X4faS2ltBV2CO4lKqekvzt
	 QGcsg123MpYwUTpTboaeagUzEG2HtqW2CrEggXOZ1zMsDGV/dG7fdBPkhw11mn2YSzpKv
	 kLha/MOEUdUR65vbDNbnGMAjX8vcGfV5pplxDgPrDDrGIY99np9NjbGBQ0VVl1p4XMOKe
	 N30/oEkKYpBN8kk0heeJvucTr853/jBdbSvvMuH4qdHSY6ipJwyl1uz+vqVu/nPRFR1Hi
	 BzzFbeMpo7cv+xtvyDz45TVXWjQnYqV+8PgMm5MEnhQdTd9j30+6DOAWYhf38VHPKmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToiX5P5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7670606A893
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToiX5P5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C5C1F000C5
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587103;
	bh=QkWetrAcR7fhD7FyEbwBYUxzoS1eX9XmfVypNYl70yA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ToiX5P5oiilllPJtJ/blGmk7Pno92PlyfLlFLq2H3PY5yZMhwLLuxW2Lqa22vr1wH
	 kNkB8bslUrBWVHRbQxXG7I+FLDzikCoWOM4mzdQSHag/H45lYSOjVPVljhVfiNLKUN
	 5hhXh9mkWKDXWvYCyvUIvbcYomusrnkFJLXA1byYNv02RXGVnzARnxXQ4pu6FtJrvT
	 uEhD1QqNkSYsr/CXz4XNDI9Hn389AM1fArEQJKtdx5ScWybSFg3OlDgPqumyXcj4S2
	 GNOP7VcvRs01aXjlsCr0VA82PfD4z7+aj4xga4KZC+UJbJYUQli3laLBt+ivEKUIxS
	 5ODGemWRssmEw==
Message-ID: <sashiko-outbox-213192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113161836.3587552-2-jarkko@kernel.org>
References: <20261113161836.3587552-1-jarkko@kernel.org>
 <20261113161836.3587552-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:25:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Ignat Korchagin <ignat@linux.win>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161836.3587=
552-1-jarkko@kernel.org?part=3D1

