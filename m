Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802445;
	b=BtXXPGlDioOvN9BRwVVxi/DQ9FfD6+xq8W+cCwGOBuHUm6k9tAPhlBPYlzH5EwA1ppop
	 0evt0PK8XD+q2IXeNJAfkXmsUjj5znPSVYX0xiCPNBowq7CYVQQnbU/NLD/KP7a/s9qd7
	 8Gw428wJ9Nk7ouWn/vm2kXC0UXt8UaVpjbcFBfwm90fSxEiFen9esXr9CIahUNck5xygA
	 lT5gJPYvqJI3AsgqOMcQRO2ofEEAGOpCXzUALDdw1Y51UCA+BGo16qOGSSMFRPMH2ii/k
	 AZuI+BYVw7DAMC46/FBqTmetNlY4VMHAwxs0xk1I+UDibfScxWpT6l4L58Kib3Rf3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802445;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3tNzDzPwByRaK3w2cITPqjl5/KEm9TVefyBwVPiLRAM=;
	b=5Qsdfx/U8lKaAwaXif9JxctM0yovWWrzutqGpj0tFaHsftwJttu8VaqNM+/Mmt8UMQgS
	 DKOZFOoTJuogWrz0gK6VADz0o/EJBsi/8PMRM1yNgaxN1Bpj+NlBeq2mYF5zMNN2g1G65
	 lUNcTxgehdc5h06VdENUXg5175CHsJjtM4GSlKLpf5AmOW5NuqieQs8n++4IqZojnCng7
	 YmNKOx3oCgaxHqLJnSZtATGnPDh8KSe3e95NK+MsYPUxiRiX4+l8NiyudrwHHiVeUsiGz
	 F2wo8ZuiQWT/1lQRavsKir5SzepcBbqZhgXsrHSBXfsfv8ehQJjIh9nURYfabU3rYVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgWgzfpr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98A606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YgWgzfpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8491F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802445;
	bh=3tNzDzPwByRaK3w2cITPqjl5/KEm9TVefyBwVPiLRAM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YgWgzfprqzX5+iSchjEtQGuubPH88sAFNwh++ibfwJSu6B+tT0XV/pnXh0+LXbnGu
	 /H7plYwMhT0n/bT6+QXpj7iDlOYHsuDiHsvI50hzecCYTVKJGGYlAaSpeYsyobfNUS
	 gBtohfHYieZG2U2jaaMACMD8HHGJR3maWyS3Vv2RhnoCpKYP1tW3SGrfYJuJyCaiL9
	 aFdxwDH5HB9Ll+oZLp52LuLfMVhLyzMzGvAOeoownA3WVFhwHmBjVvp053zD9sI5ry
	 iC3m0MPSOsoQiUC6J1TjwDzOGnNszcbRUbVw3GURSLUGYwHqP5UpRzT59u3oL1DVU6
	 78r4kbspJ98SQ==
Message-ID: <sashiko-outbox-197429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] sched: use cred_ids_allow_sched()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-5-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-5-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:27:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Use the library in check_same_owner().
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D5

