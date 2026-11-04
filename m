Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802541;
	b=4AQlJUk/fWfKDZPOHGoO9pqpUavrlLrQrza+dpT5KB98BMy3unt702Lnj4jZdMnM+4dC
	 Rmizwqat5bnm7l7v6EV2yuG9lewOncMeevx4dn1nPCPVkWm/3/oXqPek6Nw6DPDnSgiEM
	 ndz1sgHhPxR8YCl5ZTX4/JSn4R6BY49oF5KjzCUI5L/gBi/H2x15LBSnjfFGkQ6t/4aRR
	 7rjTSnYmopRnCJYxX8guNI3W+Xq7MWNv/8TqK7KV3TEC7AKRxgnAFcgi2PEpwad/4P2G8
	 +6aPeLGk7EC8DSoniTJlvsK0wDRU1JNiBz7esMNEzdeROT7bnahQiv7FNMgFDSpp8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GaNru9fIr5NdVbJ9OLqBPtVkjey7PYBAN5D3ngG0bsY=;
	b=Ry1lzAlewtGN4e9P7v+9Rm3drpItIysubimTSoog6ml9H0oZBAfr+OQcOo0wbK6XDdQW
	 LwSyqSq8U329KOU7bVDJkozyX/hGEuwMNqaDm1nETt7uLujFZ9GHwU/p8O1RrysEcoR7E
	 OJ2EsyOHE7mYL0wpitIylaSuMSn/T9jEbo9Xq4asheMk2Rqp9wFnorHfmVTOu1qBR6LvD
	 KPJV/coaeSplH/LyA5UzGcRTGnc5wjsf0UBYGbudAy9HTPSnQvKNDwfD4dbYIeIZ+cBTN
	 OxmxoR29opucU2T/lnPc0zx6o6if3FXLKx7ccM3QKGd9RZVZg+8yWiIsGV8fD5gucuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPGjizZq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A97606A32C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPGjizZq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B9B1F0093A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802540;
	bh=GaNru9fIr5NdVbJ9OLqBPtVkjey7PYBAN5D3ngG0bsY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RPGjizZq9Z7sF9BqR5ev/GsnqnvSq9FVYQLsgbdh8lZsh2KTvuVMpP+C076si8JVy
	 Fn8oEmPKryqXGlcGtmU9cFfCVWqFamQTa3vidIQlQbjecPB7zz/8rjvz4pdSZF/jlM
	 Wfa96LFTiXr3xdboN78S79ihYAQf/YqKSryySN7Ops2EAu9gV5y6AihlZNUdq8J/sn
	 KAeYDsmaLERb+bJaAdcZy3ssKwxiyEkF88y+b2JkwwjKMjB10s51zLpt11ZZ1KeYyg
	 G1wKnah/EiiN9svLe4+naDIVOYUwJ5bLcgRh30DU53O5OatVLYz9k03jaXWxxvPbSw
	 a6HBymYXgeVaA==
Message-ID: <sashiko-outbox-197439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] cgroup/v1: use cred_ids_allow_move()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-10-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-10-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:28:59 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Use the library in __cgroup1_procs_write(). That euid 0 may move anybody
> is part of the rule.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D10

