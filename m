Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802494;
	b=KRmq0RyyPielecmFr1tgUOF0dln7dETOps7tkpG4k5xgYp+P10/2Jm5UYCe/hcixSej0
	 kn1J3fKaDqGgZsJAwIP4pKRYaOpn67Pf587/v0ECFktfIlzWeqj/X8DymBNw+ZnR4UAIR
	 OAkkLeHxTBR16CAB8z7C7oaINRJXjp5TVpIVwNuR8lU6W6bUH1/KQTDURM8PaynbMl/Zh
	 EbW6Ei6mTri2uP9ZyqbwQkUE2fQiLj77gbVcgFVw2uMMYc2U8jEptbsNyHhQk4xcPae+b
	 e7mD2YuFRL9GJ8W5loItaoloXp1alNnkOK+YCrVLEciSW45BCRfk9018SXer97plNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ROrNwIB9LmdDO7KcIt8X5zQJSWj1676z6bx0qv0ZeGY=;
	b=WmDGKPgLKeP0uWEVqJdaR5Bdx5ZbT09jD+7Th4bSA63/Cb9vKojgvKxlJ2ElEDJl7Esp
	 JA/ppqSc74KuxBOdFTqU/mqNZs+0AUZ2DcW9A5OG10xxLZ30BhAXbDWf/gM1mimhbbhQF
	 EUfOChGx65lnYF7Gj+hH+Vm36JAFKm15QTFVD3RXrJ13MaywvlPl0K1hoZ5iLM7YZOZmh
	 GjP22cnafneiAT6m1eGBR+N1GkukDSmLhQK7/OX4SEUdU0jaRD/HczG5PYj4zPa4f3NZF
	 P5xacfFceqenlqCUFDUa14386dcNyyFYgDItwC5Fmwz+905FnlhjnrzMPHWcJY3O3Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ey9gtNZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A62606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ey9gtNZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521D01F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802493;
	bh=ROrNwIB9LmdDO7KcIt8X5zQJSWj1676z6bx0qv0ZeGY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ey9gtNZvAzbaTrY3bl2lX/zzeCrcN5E7aMuPYYgvkHQMxeb2QTXWT2lrqfIRbHsK4
	 b1xfiOrLxqQe2MCt53l71oR4Ak8j6O5oFcbSwX7ewTBFKaC7uOnw/d1mpWwiAzgwwU
	 Le8jiuqX1OMxVxTFIxV1fvXxFnHpHmzBE2SbBZgxiThvEeei09QcPs7xoyMcRbT01z
	 tr6sSCpcU3B+6LTKMZqzJJoTC0LgSvRKjqZoZzesrKfrLBOxDwoZPNbGHhzQIPhWJt
	 D8AI6ymytOz7BnmgW/hiPK/x/d9YtTE4Sfyv8CJLgXYID080BDQ5AgJAFUw9xUddtH
	 it58Hc6aBHucg==
Message-ID: <sashiko-outbox-197434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] cred: add KUnit tests for the id rules
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-2-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-2-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:28:12 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Hold each of the new functions against the expression it is about to
> replace, word for word as it stands where it is used, for every
> combination of a few ids, 0 among them: 729 combinations of three uids
> each for subject and object, and 4096 of the twelve ids that
> cred_ids_allow_control() can look at.
>=20
> That the conversions which follow change nothing then does not have to be
> taken on trust.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D2

