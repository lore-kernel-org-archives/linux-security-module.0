Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721825;
	b=fIUveuyUjM6k1ID4g1yQ5b+GxiMKD1roo/DbIheVHAlXv8Ot/7PPem2zjO5gCY8kYQL7
	 G3p0Wpz2apBWkfX7wgxX8KUzaulg0rgjFDFR2IaH4ewkMGWv3FuOwvEvX+ZRyTiC7EyWJ
	 nk55UbOitZ5b0RhJbsY6qxvY3ydJRh7FTgmROpz2dr0ShGHQMIxNgz5Kbz2a6ffe615lM
	 P5Q8nvzmrRuUPth0sAaaXX/WaJvWQK7p4rXff2T67MATPIGcNjVDPnmdd1s9DvzvM89w/
	 /TvFh7vCb37oXOIoFlVHx6MgoxSROerHQpf0EmLSpxD9BPgR9/Va9e0aLTkNTxREytg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721825;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rSxK1N8HhAJhZGEp86C1Kvai83aYA1WhLTfCS381lhM=;
	b=ON4wIjq8T6wdWiho7VwKxFTNNXgHk2zLqPi/Da2gsaQzMsGz3Sjb1zCP301iypDF1wAY
	 sM4V5b4p77Dfn7xnajiM6eea83nAErmSnCQpqsS4cS98H506xEMuP3DFwD3CmbGJNi2rf
	 4EiccThQWPDkCsxfu9EgAJkuLVkQpfV+zbdnccvHHxXNc4W4Gx+8FlAL6ReV0Cmol2ovM
	 RHW47v7my90WUGTPz9/E5StObTefrnATsNNRiOH5Kki3lRshpJwwS4SkZvIiw2ZReVviK
	 zTplneSHitbIl8UR5vgXoQfDDxXuTwjbRj6SXXWOf4NMgszXt59SLJfMGKy2hzIPrMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHvFYA5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255D606A327
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHvFYA5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E608A1F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721825;
	bh=rSxK1N8HhAJhZGEp86C1Kvai83aYA1WhLTfCS381lhM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lHvFYA5xD1zXWKrifX793Hbj/oFoOj6ZXhKWjmwzVZqPzCu6RFcW/LQeQsT7lUH2t
	 Ns0zL97q+UoWA+ncJS8MBvDsBCEtdu8P8xeQaH6T+s+tWzEqBLP2h6094Oj8xwZeQ2
	 yHX0/cWJOCGzAD0gGbK7q5SVv5tfpE/0nKV9xgEWYu1VcOuKQQol8gp3+vc1xV8yar
	 K3WTjnerXYNhaVmQxRS1HNfPHkV6XW7Q2R7yHWe/QHnElc7r1ZtS3tasH6U5OdKWXI
	 sSkY29KDlmjIKVE6OWT1x02TaszfShVAs0TNlhr09g/EBj1/Mch9TgI2kGMRjSEwpN
	 vs84Ih7pkDlNg==
Message-ID: <sashiko-outbox-195693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/landlock: print st_ino as unsigned long long
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103155512.535137-1-sashal@kernel.org>
References: <20261103155512.535137-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:03:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> On 32-bit architectures with a 64-bit ino_t, st_ino is an unsigned long
> long, and printing it with %lu warns:
>=20
>   fs_test.c:10511:57: warning: format '%lu' expects argument of type 'lon=
g unsigned int', but argument 4 has type '__ino64_t' {aka 'long long unsign=
ed int'} [-Wformat=3D]
>=20
> Cast it to unsigned long long and print it with %llu.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155512.5351=
37-1-sashal@kernel.org?part=3D1

