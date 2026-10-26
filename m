Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011555;
	b=qzkR0xTl+7ecbIrn38GxAqGnFQKANvjCeX1ecxtBN6MPQdcFtKcBYH3kTg3M6KtAvdsw
	 OYAG3Uv8t0o9foFHFa/vwTAXIWgtU05CeWfuICQmLwj3Qny0JyiTjcT5Ov/ztaAc61RbT
	 qr687+VJ9GObIDhUrYSzMaHFSh9dEMmDhS6OBWj0dPRWnRzfKj4G5hyJ93DqDG1L+XOsm
	 UbPpGMSRCaILpVjwV9CU2JdMWJA+2+ttGs9NYY2G4iBD0gFpi8gZvj9VJU6xDzhBSmgdY
	 LpcdtpNwImBwiXHtYfCEVmkEjYp6FhM+W40Mwu1IhGZ9GL+Dsw5gy7Fss0SXgMrQ/cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tgp3q1GxNDbBFjH+hvcUrBMCDtSWl9RiIYRbxW2gR50=;
	b=jnYsaVNNA3ehAthT+Aryb+rGyy/aO9lHWcf1hI8JXR0t3UE7bYmPAOjkCDa7BUpz4GBL
	 KkqiPudmV+CMcOjvx3SlfLZ1h059/xjEJOXI/7cS6OxB9xrr4YkBKId0LfDAtNsDsx+Cm
	 YGr8co19Yig3RPO4BDU51LZyiKGn47VsDkO4Ogca0nP4QR53eSepiwiVrh5XrE+lBGm1p
	 EfV7PZGqY2lsGEvbq6qWG1FRewqiT90W7Bx0OaRihBvyN7Vqw+nN6XhYd3J/lY/VdTXhK
	 ElCjzFcuXPPCvOaKQgHyUpWa0NIJRZ6XmtkNg5a4HySnXWLEaCcaRvxmyBoZafOw5tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qcr8UuB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2118606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qcr8UuB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381DD1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011554;
	bh=Tgp3q1GxNDbBFjH+hvcUrBMCDtSWl9RiIYRbxW2gR50=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Qcr8UuB9BVt7NWxQPYlxJSRQ1NquuIZ3T+h2r9BtXpqFDxPrpoCFDusFY5k8MOqUE
	 rys3pO6JZpOV7TbSw6Wou+HqNCIip7UjP74W338GiR3KUGa2BGGvElVQognPN6RvX+
	 23l351TkNhIlhKzXimgqyLlwlbnc0VJwQQPoYwXXlzq798fm4uyBIZVoVDEhaWuW5l
	 xsbAGQZzj2nn3Osn8E+j1a7IFV6jHn6vjG5MJMzGfc64XJso9CnW2cjCgUBKG/BjxV
	 YXyK4wWhXK+/gVwYpVzF++XGlLqJ/fgGRaAYmKgvcdWV+TcfuCRU4iLe8i3rqYEOZy
	 OdXXrLkQo2H+Q==
Message-ID: <sashiko-outbox-185007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] landlock: pass the namespace id to log to
 check_ns_type()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-4-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-4-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:45:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Landlock logs the namespace id when it denies the use of a namespace.
> check_ns_type() takes it from the namespace itself. When it is called
> from the namespace_init hook the id is always zero as it is only
> allocated after the hook has run.
>=20
> A follow-up patch will allocate the id before the namespace_init hook is
> called. But a namespace whose creation is denied never becomes visible
> and the Landlock documentation says that namespace_id is zero for
> namespace creation (cf. Documentation/admin-guide/LSM/landlock.rst and
> Documentation/trace/events-landlock.rst). So pass the id to log to
> check_ns_type() and keep passing zero from hook_namespace_init().
>=20
> No functional changes.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D4

