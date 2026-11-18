Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021412;
	b=RYSOM+1ZCjFdMR6I1+VwW+6Fu04/rx8XgpYP63aXPfq2eTSlfghTwLi0SSl8ENj9olA+
	 P+FyOZO2SNT3pomtBGClNMpzGiINPlNY9x3DTIAhLX5Cz3jcekjNLAFd17bXjvbGmf6K4
	 mYIU4Q1hP+FRiUd08kvSon1OtPFrVVzUP/6TaCpbZJ0r1dvHPqvI8AlsiyAlcUhpu25uf
	 XUOGt6d7rF1X9pyK83kDBK66r+mGvRp1mMU5ghU68NrCwFmtbd5/38gkvC7F0/xxqFVaf
	 TdpdX3jPLjIbSIsaenazD0AqGv0SLTS1ffE8G01Y8N/Fd0dDwcBwz00MOzxknkZSBtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iR5w7Jw7tWRxnghgFfKPz5smQthguwQg/zzhFCjzPv0=;
	b=xkWEJZTXFK3UzWdpmqOQpbq/h2HYlwfktKWd95c8BrMEl9dJ7AQVUdCAdNJH1LD6X5aA
	 vCjULIhzmsEQGGKXoNIhX0XgvORubhXlM3poowTtvO+9EVURGQTNq/4NdY4QBehuHIDyV
	 LkzDb4uqhpqT5hYfxTHYQ9ovClPQNDvPIcuKvixT9bCIAvAFvUvWNi1e4ZEHANnsUcwTH
	 b+QaTZesr22gvhNMI9YsVmhvuPM/1ZrAWYCO/0j/gDh4FBbsl6nnEJsYANUcjnGpZGjO4
	 8hRv0aVPCITp2ElnLCKx0XklzWakDSEffUqL47AZp79b8ffh8iPiPDjMkpmgClUZ/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRl1LH4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B05606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRl1LH4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8007C1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021411;
	bh=iR5w7Jw7tWRxnghgFfKPz5smQthguwQg/zzhFCjzPv0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LRl1LH4MzGY+V/xBX80VPHYYJodIVAPJlqNGO2RP0sa2XAY0vvkjdsv8oFRQ6d+G5
	 5Ea1R1f4DELbPmqfmtyrTrnNqWGTSl96apS8DfnOkfYe5i+jvB2lqJovkK/Qo/uFWc
	 d5HNAuN7EYByq/wMvomYZhUEXjTHxnP6+a/Cl8ywtZYkWcaFvxceGi5oM8sjP1Sav+
	 8WfJgIo6tky9jSUmN6KonBqRpB8ZTZ49ilq6TVEq6U7+QcCM0eJmPcX1zWL0OZ0ZH8
	 gcA4ViFcodPFfCJv5pPVVu/y1pEeumf7RpcZ491s0mbZge9mF1KnlTp1zAeVYs/gMs
	 s7S7Jp2OlAdlQ==
Message-ID: <sashiko-outbox-221575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] lsm: Set PF_SUPERPRIV only when all mmap_addr hooks
 allow a mapping
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118165603.2573289-1-mic@digikod.net>
References: <20261118165603.2573289-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:03:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> cap_mmap_addr() sets PF_SUPERPRIV when commoncap grants CAP_SYS_RAWIO
> for a mapping below vm.mmap_min_addr, before the other LSMs' mmap_addr
> hooks run.  If one of them then denies the mapping (e.g. SELinux's
> mmap_zero check), process accounting still reports a use of privileges.
>=20
> Set the flag in security_mmap_addr() once all hooks allowed the mapping,
> as ns_capable() does after security_capable().  commoncap runs first and
> denies such a mapping without CAP_SYS_RAWIO, so a successful hook chain
> means that the capability was used.
>=20
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: G=C3=BCnther Noack <gnoack@google.com>
> Closes: https://patch.msgid.link/avxjfHybQBcATFKV@google.com
> Fixes: 9c0d90103c7e ("Capabilities: move cap_file_mmap to commoncap.c")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118165603.2573=
289-1-mic@digikod.net?part=3D1

