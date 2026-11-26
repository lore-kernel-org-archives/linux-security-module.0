Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727152;
	b=CV9qBlfiQtwpkkQDm8IUuLt2SSyHM8TUNUG7xkSSzQAcuPhLkT8nGb0OUZt9fYExhs/A
	 ph51f+L541H9knFxbo4aQY3Bvrqzo6v9rfLnCeY6rUqOQy9x1M3ryftSbDgZk4g63RnDw
	 qDgyfm3VQ/Zevs/iHtF9TIZtCWydmx5X+nBkwnS9zbsOvavDjeXLIV93uvR2njqvcvp9B
	 +pbNboTlKhP9c6SHncl3eABcyF2ZzUTxw59GTbxrOfGJiJRit5khgS4oVMuJCftkGBj5J
	 SUVKETWsMEZT6RsPJPUebMr8fHS7EPksGfqeszNUqy6UnXeh58gJlLNIDgvrwd1yMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AnNChzb2y03x7N8cXY0jLaxl6sGwr7ltfJHzMUtQtR4=;
	b=0tQZKMHcnl1w7AmVOH6FM19w5decWPd0kDvnWZxyKijQ+4psHwxUq56xWIh+4byGf+A8
	 LraCk2sVqrk2U+2oFhOAaPmnvb6BbzjpueQ3aWRdaOiCCbkM1RlwvlO+OTSsv2COkvZVS
	 aTaPt1avazsKOSQuZl6Frn5uoL+/AGDgtGQe1nMDuFao2t//NOplsO2qQ2xN1oo/oNUyF
	 Nj9IjpU29JV3w6wcw+F9eODm8RMpQ0a6A48enkfbJW/auaDy+GZZDQcbZ8c3N6ApmteYR
	 j/fBOY75jfqdNSv/+h8cnGCtoUX8nKoCeakyig0C0ZsD/HnIP9d6X/we81lPfYavsUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnf+uQpP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65F606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnf+uQpP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E0C1F00893
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727152;
	bh=AnNChzb2y03x7N8cXY0jLaxl6sGwr7ltfJHzMUtQtR4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Cnf+uQpPGLZRjGGyxtmIUAO5rui0WfQO/mPLPFurIyoU4AewUCQ83/XhgIK2jmU3h
	 cqkADU1HI/LFgAa6XXhCQMNsK8giB/KSAsHb2D8FIEaqqvHMHvnn4As4T2qkIVowlK
	 FYdL+0wz+S72KFHzM/mna+mBF50jEPyrYx3vqpve+0+QynEdgUpn8HyzmRFlmWb20c
	 pftbeat8P7ldCmVcezDZH5fElmdlXV7KQcBH+okUiNThDl2OpH/O8fYyrEEkk0qZQr
	 Y5uAC/LlyCrvgvolPeCuTE+G1gHDKExfjNcm45JwvaKh7OFP2MU80Fudd3H+h8n3qY
	 QjrN85P1qOsAw==
Message-ID: <sashiko-outbox-236191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 00/11] KEYS: trusted: asymmetric keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261126205021.2200819-1-jarkko@kernel.org>
References: <20261126205021.2200819-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:05:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 1, 2, and 4-11: no issues found.
- Patch 3 ("KEYS: trusted: Validate public_len before reading ke..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126205021.2200=
819-1-jarkko@kernel.org
