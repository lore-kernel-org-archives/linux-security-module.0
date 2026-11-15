Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751554;
	b=0Qo7Ty/Ff7gxIz/7csD7Ca+s7EULTcsapZObP62CAHdtUwccl6lYMzRMPp0bSGAArXLf
	 09IWvYgvkjpZk+mpFvlZD2677PsGwfGKUSWhRkAS/bpgNmVpCuHaLC+EUQHoXkTQJDUdL
	 gihe3DDdqGTglvAPdUyEVJYET8FK8mC/WmrBDbaUpkc0oEO1CXg8f07WwvfD7imPv0nKU
	 3JCrxEnjmltj59SJW0GPJuDN4SDUVRpRKHf6TYlGrUmgcs/zEFwpKXkZfp3XB4wQS7onF
	 YcUOebGiiiueT49p8/J8krsy6CjPW56kFuF4iDc1VrXo49Z8K523erub+GFvwQ0Y+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4UMWiaIjL+EFMpTedJsbccLqGcjXUVmxwLZsRU+Fq7I=;
	b=hePtsL4yit603Q+X3o1HpzBaIi88dzWt7EjiLNswN0URYVOdZPDVJ8btvNb4IejbuVkt
	 Qcf3KXg0fnn3m3QuF6nb75Vgj9lpF94b9dY2rntCShlANJbeIybhcRBYqVQmlu1664ycV
	 nFUlTStFSEIAz8+Ge1fDTruSLoDFQcuhgA8OkORWj5qIjFHja+izaN6iMi+42daMk+Qdx
	 gHSMqbEWrk+GUzqLJgcUZZwixzjxBkV9Yd59chCI/jikJDz+XAN6IvnyV5DBXspdOxHMg
	 2YQw9O/+K+Jl5wXLAP9lyeVAqzyhDC0F1ZhJJMeZSHrEXpFGdhL7oAsKb1qioWwcSDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrZoaZKl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E4606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrZoaZKl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACCD1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751554;
	bh=4UMWiaIjL+EFMpTedJsbccLqGcjXUVmxwLZsRU+Fq7I=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XrZoaZKlyr6mJzz8plFGRZbziDYHouJljqr1zpLzrO7QA4cHHDCFy1cW7ajO8SjNw
	 kd0bbSFdb1tVBmhKtsizmX2UCRRDphoDtzEQNSBOPUzK0zauZNKXU1s/tN2p5OoOFL
	 6bs2Ywr2iViL83E/PBPxLYmkM28LOs8R1vIJ+rGzKvCcSG6+3h4AnehIsGHlMxoMou
	 Gy38CbpSSmiFZFxoqv/HabqrO4TXW82SUFWZcfgp6RfzKbkaa0ahll55BMkwXmeZWM
	 B5fUdVexZizJMrVEOhsTTl4UoK+tVt9fnA9/YopOMO8NL4SIvL3FgWMhQsDXMEu5eu
	 PQc+h9Tmm+YLw==
Message-ID: <sashiko-outbox-215555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] selftests/bpf: handle d_real_data_inode() errors
 in bpf_testmod
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-5-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-5-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:05:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> testmod_register_uprobe() from d_real_inode() to d_real_data_inode()
> and drop the path again if the data of /proc/self/exe can't be
> resolved.
>=20
> That's hard to hit in practice because exec opened the file already but
> it is the only modular user and d_real_inode() is going away.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D5

