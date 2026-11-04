Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826965;
	b=E6Nn9tftHl6IMZdWIZIUIaYLgZ9iVU1K/51tg3SeIGMpomwS62dh1l52AIwi8kwwu/UT
	 iUKy805falKFVBcIuDMNMNvUhGV0tRA0WCdvE4TrH1TF0wJnpLvdlfrxhcsxq97CukEOz
	 mzOa4cJ1MEshRHn7HF5I9b1LFsuuNFqp4QfIruLF9l+T4ONGZikbbZe6F/Bhl5FxjRs6E
	 VDPYKnomCe1SRemN29bYD5bPDF4kkdDYfnyx8UGI1EVDcRzfyCcYijWpKaBqHLNldxsSh
	 kC0B8ZZhX5HoyA4TBPl0VYYQ1qq6yirKQnclBHHxx7cNz5aNCrLsIbtbUF03WO8EJiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CtjjVBk5Vo8Yc0vlumMV4mrAPcS1VomPPdcDad+aI4A=;
	b=4gxrgPlB+DSP+/UQje2caqZHs31nIPHY8hdowDYQZJ6nshpYwjGylkdzA/PjnBE3hYUA
	 J4VEWu+V9tK4yN3TskbifBtfobmj+lM/tsUqulxO+c/KJzcfqLdyaoUExl6w1VvGXthts
	 vzuvN9SpCKV0ZKOEAw7iTEUFMhv5/sx5b384aox1/Be82zCHCCovRZs3ARy92VG/v1HKC
	 66Ggzb56DY+F8fgjyyUMYepc7gqIcWXcNvcFv61jRuArVMh+6+3Dmf93lxYSD12yzsLu6
	 BJUFtbrL2aY8jW7fbBeuIx4+V1DvPZAH94rCjmPMU+Qmg8UNSL09FlE2zHZqC0Nsdcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hm9HWeSw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B56070339
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hm9HWeSw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FF71F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826965;
	bh=CtjjVBk5Vo8Yc0vlumMV4mrAPcS1VomPPdcDad+aI4A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Hm9HWeSwrphIHPqXphLbulKWRfBXtlRdJyUptOamAxX8QQHLlTaE+lBJw5Dl6KlpQ
	 pERnxOKIZ8LG6t8oaPCUo2UXySQ4eIN/YT0OH+2i/Iwg/F8JlD5rZCcFGoJ+HFgCqv
	 PTBS5h0swRDIqWeCFr8oFMnoMyXwpolNnRX4mFqz6fDrLU7CEC3eBDHjlFma6Dhckn
	 PcGqiRfJNjROFIM9U3uYDvqdvqeP1/f+D3ttQgr0Pjb6RDzxwCbLHcz4neFKvAjHBP
	 8fwMtnVFUIsme/frJFG9ps9FhEgKwt2hQYXAPykaXGjMYiNuxFgK4Lag2ifhBF4b7K
	 RkHedUdvCCd8Q==
Message-ID: <sashiko-outbox-198082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/27] selftests/landlock: Fix the snprintf() error
 check in matches_log_fs_extra()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-20-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-20-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:16:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> By storing the snprintf result in a size_t, the chunk_len < 0 check
> could never be true.  Store it in an int instead, matching the return
> type of snprintf().
>=20
> Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D20

