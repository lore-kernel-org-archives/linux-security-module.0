Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177189;
	b=vy0l17zvy70a3oDoWWFC+2KlXiMQdzcAiF4dMiXK0SFblIv4q3y5s1LWQ4Rxndq85wNN
	 YqVRVZX9rTr58+KjCMTuWfL/rgoC6VoPatELvKhwfx3Q1H3xk2W7rVyjkyZjNfMcLJJeU
	 Q5yBmwCXX+NIg/vS3JGLixS5A/FpY86/ZxS+VY1zjq66y9FVOLjPrXGuxbIDKL2G5ozlW
	 EmfbgXj+SikmYUXzSNuBwdFEaqX78bhDeIn90F+8B2U6hJbGAmuidNXfHHDvlG2UmzxEC
	 8zbg2tv2WijJcpV96kCcwGphnvbgB67t6ntNmNZvjUPbbIW7l7OaeGI0prECK6WD/zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fKpCFOyek5FQhn4zyGIdDQvWxZw1iRXsnkiaoOah/ss=;
	b=kI0bVOGZpr8NFumXxVwT/fqM591Gq2LODDdSZoYZoeesPdQdbRc+I3Dd2sinVdVP7n1s
	 GDI1/g3yQslLUSka+hYimzSweer0caslT4+MfJiCXUQEMnuVcvhTZDC+6fWLyyA1SLsoE
	 kaOigmYnyYYCS3T7RXjrfDc9GLCTUQPZSZ3aHrq5XFEhMrHnQWdKmmomgtsH51TdrLXPS
	 xzxKZcWsaVvmtlAqC53d/ZbSlFETSOxUSS3pM5M+jwWfpU/ri+XDizzeFZZRzf6Y3/O4s
	 /T7s4rCOLSJeSavXLJhtGPoMWgCZ9XPeddLSOmCvQTR8RpCnnqLam0j0Gu6n4Mcm86g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3VH+jNN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AD606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3VH+jNN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87091F01828
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793177188;
	bh=fKpCFOyek5FQhn4zyGIdDQvWxZw1iRXsnkiaoOah/ss=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=G3VH+jNNsVgdf6cTIBR9HgYUeyDHORuuFPEVJQMaMlBRc8GxRYYWuokiO4uwztWB5
	 sab5bex77qjn9nSzwYiJaT79AlYN2alRuh4aq+QDN2646wC5s1Y+buM0M9jknPJhqc
	 g1clOj2JdG4pzY8+9SLQZt+VTTcU+S/M4WQs2kA1PuoBwS9/ZLwcGszSBNgx2o7Zwo
	 DQu9w+tRz10VC+rdzJj4oP7hFArEaZTP9IcWWtjr4O9EstT8jx9J7OapJ3Wh4IqdV6
	 Oe4oKeIErV+OgVCfCgtHuTIRPXoR9GHw4/UmMPPx4H8iILb2xiyeqziUmZVy0ob0c3
	 NYW2RV9Mzzw3g==
Message-ID: <sashiko-outbox-187634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] pidfd: Use scoped cleanup for task access
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-pidfd-get-paths-v4-2-e2a6a47e3c95@black-desk.cn>
References: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
 <20261027-pidfd-get-paths-v4-2-e2a6a47e3c95@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 08:46:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Chen Linxuan <me@black-desk.cn>
>=20
> Split namespace acquisition from namespace fd creation and represent a
> privileged target task as a scoped class that owns both the task
> reference and exec_update_lock. Use the class for namespace lookups so
> ptrace access checks and task state reads remain tied to the same exec
> critical section, while open_namespace() stays outside the lock.
>=20
> Carry the pid namespace visibility check into the helper so that all
> users of the class enforce it.
>=20
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-pidfd-get-=
paths-v4-0-e2a6a47e3c95@black-desk.cn?part=3D2

