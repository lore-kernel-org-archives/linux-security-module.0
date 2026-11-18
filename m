Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978582;
	b=jkCs30Oi+9iUqPHm+cZ+1hLIvWVdZySB9+unzWVVpVXaus/A0eaNMDnpSzspFQIJnhik
	 0q4ft0x+inr+eettr/SNokt3YNocSklG0xAmRcCCkoykVy/wNlT4fUjYcBnJTFUShvUf5
	 GJRcME7xYCKtBY1q3MzLwF7dLgrAS92ojhd7XWFMNsbM4O9i/xNvKAkJlp9lq7qMzaXU+
	 SYGy4VPSqbVLbNTe8Y8/q/z1ro2uDZb50PdAi/M5YBadoNkOEgA8pcyPy6Dafh4k3aXM+
	 b3r423maokIENRxREaT78/c3opv/ODaGDUJsOUvxk8NzzaIS4PQ+zcAC8fMewI4gDGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M5Knl13IIbVc9dPSbiLBJPrGvh+7DKNUaDoFc0NkDEA=;
	b=dXU06w63Zacykrnx2Bj5XzKQD4GoPBvS3fUfj5eoApehFF50cGzRvneBDNnAIlce+rHN
	 iyrzYB44aGHcmh/Q6Iq1LbiUcWHvbPJgJKd2RhDAZ7nEkiEsAylMQO1gkcFjh0UBeAN2/
	 mYRZs7jtb+bqV+5Ri5lyHuU066gkiH07bbDAtBpoCYkfiJMTCGMQvgxIWL85F8jjXI+Fe
	 mXi3LMs/XRsBsUXmZAIVaOrQRb5RlelvF6grOmOH5fGnkqIhYHlkPkJsa09lVdCeWNGKn
	 V8rJraOEqBYuatXQPI5i2z5PMfQRzIq00fdNkIFfNfpLyU/H0Z+VpitVfy7e2EiVLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGE+GULj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF15606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGE+GULj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82E1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978582;
	bh=M5Knl13IIbVc9dPSbiLBJPrGvh+7DKNUaDoFc0NkDEA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RGE+GULjSdeYZUvKK73B4s/Xfi/1CYnXL0VMO/y9gN3YSMZUGAambmFBhA/VRgF/f
	 PC3144mv2iDuB/9iNtB971VgtUDURBhyEBQ0/l7llqXpAzlR09NmxdEC6m8xaDXQIW
	 05k74Wx+v+jvgQnhr63Oh/13IrWZxM++TnzOIWe8GOVf22cncJd+FFkkivUmbrxaB6
	 cdS+5xsM5Pdr2vzOVtTTSviMLwW6+rCB8jWUWLhGr9JbC429QAZLgGO8PGXkURifce
	 YH3u6YuGKHQC5nl8FrS6wbN5UdrZ5zfekuBcPiR0lD/EQaz7EvedBxIC166C9bpCkb
	 Ki4A+/Vyq8zVw==
Message-ID: <sashiko-outbox-220136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/13] nsproxy: Pass nsproxy to
 create_new_namespaces()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117050841.3289652-2-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_new_namespaces() takes a struct task_struct pointer even though
> it only reads tsk->nsproxy, preventing callers outside kernel/nsproxy.c
> from constructing a child nsproxy without mutating a task.
>=20
> Expose create_new_namespaces() and pass the source struct nsproxy
> pointer directly so root namespace creation can allocate a detached
> namespace set from current->nsproxy.
>=20
> Co-developed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D1

