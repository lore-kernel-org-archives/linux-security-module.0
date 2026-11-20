Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168632;
	b=qB3WUiQuxe64dPX8khOyzFej7tFfZ51fYKhyMMn4TTMSp54LkpEBtwlB67MjnZ+GTf0a
	 WLpozbj+4s5v+vll1uVegdWB83+j+kLBCVv7177s/AMRz5Ac2hPFJ2vrivLm6Vgjl52X2
	 cn7YvetAK5AR6sHnQD4VS7mnuQh8taLVvHa69KHNhlHvBuVlceNyilnEYkw52wVtH5GDj
	 qHV1eoZ8BMlKWySphT+u3CoXTQnPmmPe5CTtNuN9vxbhUnhj+rMTRW6cmM0aljMRdBmzL
	 7usOdMAdkpheAmfDttBLmUHiaHPb4oTpX+Mdb65RIZ8wUe3oF7iJp+blnyq0If4J6cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168632;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vdw3emVpJfiJGoRnllakditfeA5qe8gUBc8EyU+XRa4=;
	b=TPhS8WaeNP+nCOynmWZMRSXtZ7uIlsowCqnsLxYKixqT5WEJcX6WJICifdICiXfqMQ9L
	 dq3vpgjwmbC/937VlMPW55Ikk3/msXnm6RFww3i20kiiv8T8IYti2X8WU3OgSyVWkdBAC
	 xXOodqenuvrvSl3XN8EATwPUIkdMlhcsTDjmKoGz2jon5YgQqLW/QSo/LEGCoZw4mBOnF
	 SkeTqK66Jf8SzmHpXplqYz14QMEvnWhMy08yXlIaQgJlCLW6ZqnjeKIDG+P5XrqlKTBTm
	 CaOfLbaSYUpIQFi/wr91NxtAhmOsC8V9uoj3SbxXlNbToDQyQh4uj6SXf3zKHeVQ0dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K0+/CUV3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AE606A320
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0+/CUV3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBD81F000E6
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168632;
	bh=vdw3emVpJfiJGoRnllakditfeA5qe8gUBc8EyU+XRa4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=K0+/CUV39f1bzQ6defY5AKMnWTXVvdJmw6eMTPLiZNuGtCL0dygTO2Lztu9rYmHCF
	 7Skg2lM/vBW0mtaFYwhv/IQ/Jhhs3spu+p71G0bbjgBJ16M5HTDuJ8Ui4gBIWfH9ey
	 HjdRhXJec8rraIfnB+JAaGJnSTEzTz0Xnv9dlvMn5ZNNtV786g5GKdBVQS92A77RMX
	 FqAwOktt+FfofOZtX9z6vO2BF9T6tXG2Yu/HBnccwoySjI5GZ67etio0dETB/2noGM
	 iGbJ1nBNa43dkcYuceCNEzemf/K0d4P0NeFo0O1lRM0nKlOQ+f2bI2aua1e6rQzxQ0
	 6eCdSYrtnvuTQ==
Message-ID: <sashiko-outbox-224899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] selftests/bpf: Test pathname open enforcement
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <20261120094820.11929-3-tasos.papagiannnis@gmail.com>
References: <20261120094820.11929-1-tasos.papagiannnis@gmail.com>
 <20261120094820.11929-3-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 09:57:11 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Verify that the hook sees the raw symlink pathname and the dirfd base.
> Check denials before creation and truncation and on O_PATH and O_TMPFILE
> opens. Check that -ECHILD makes the VFS retry the open with references.
>=20
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120094820.1192=
9-1-tasos.papagiannnis@gmail.com?part=3D2

