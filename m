Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945713;
	b=1T57tkQn0tU3H8IZMKeZw5MQb8qN780acophuvVgIXBWwCS+hbFT/GLQiZHLVTTQmZ5D
	 g0jO4nhLOgwBr72dHjpmy0snvwPp+W0kw6Omno8RZ9qowQjj5RszB6xVnv/yr8rWqWIUQ
	 aKRZKoaTmK7EurhYW7xMSDqKhFITm6ahxV8csanhBUxWbSW5OnucAkqzbpKtHE2T/k+VM
	 1UbhYgjmKT4Hhk5pVjUptqW3iRy4cwe0v4wifn21K62rCpREqdQ+3+zdSja3/br9kX4dI
	 dCmhURR7xAfQ/uWPxsMgM2VAyDrmO7DCpkpnH3btCPNC2OJyMw/dKw41el7/mmOHxwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dE7okxHFLa91UbSgIvYaGDHF8IHxbbbhClq1rCWU8TE=;
	b=qpDNMeJ7odTlQfrfE8NEpTCWXpT7pgHGtVekJLOzT1uAG14CBYMdqsECjSVvZSXTJ+hi
	 XsnkcILWBMxzjee2cX3sKPAzhJ01hOkr57VjqIso0zbouwA250QrmTzzHlHqiiIFeEwCt
	 dAVSQUxnD5nSz21NWk/qK+ZBqTb+KXe1TO//WUcUua/4drTYtp02h93hsObeJq8y5EQO/
	 s5BLqCHT/3pH/0Zk8GOftP6ktHcwRyqsK1tsTXhQm91pmfUbSAIG4n9vpVa3zPeBoDcgY
	 ti1V2hQom7O9m9jW2bbxUxDqkyGoX5YGWjpI7ZOLQ6gnFK9aG+T6wyQHrD1nwnspyKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOdYVfRt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB2606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOdYVfRt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD6F1F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945713;
	bh=dE7okxHFLa91UbSgIvYaGDHF8IHxbbbhClq1rCWU8TE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BOdYVfRtFUyZ6GcnqgGa2TQtp2XKxDfqIqhK6YrtmIZFR2YBKiBTqpgCwylgwEYKW
	 ghkD5jqcaD3ruKMGp0d9L7TRsjnOOFqwk4O6JAV4UWmjCU1PbH6XgCtZt12PI9VV5Q
	 UbGDrYtJZXlE4NHWHxMaycaDgfMyPnbmiCvWL25x1Ew34BOE0TkBQr5Sjvza5QBJN0
	 edW/8+whYM6pob8FnFnQvs/pQ9jexXphp56LnHjMAP2oo7LSYS+idIoaiXggkHgHXo
	 ViqtGFmx0i7KXbuxpYuSMkb/z5Puq/3G8GeTGfP8ePhRWaWVrxg7KXcu4VElkau/WV
	 QIshtWaLOxeGQ==
Message-ID: <sashiko-outbox-219543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/3] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117-b4-setfcap-userns-v11-3-2be11a2c32f4@toxicpanda.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-3-2be11a2c32f4@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:01:52 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests for whether a uid 0 task that gave up CAP_SETFCAP gets it back
> by joining a user namespace whose tasks can write file capabilities for
> its root user, or by attaching to such a task.
>=20
> Each case runs as root in a private mount namespace with a tmpfs on
> /tmp.  It sets up everything but the step it tests and fails if any of
> that goes wrong, so a refusal comes from that step.
>=20
> The ones that must be refused:
>=20
> - setns() and PTRACE_ATTACH into namespaces that map host uid 0, at
>   uid 0 or another uid, or that have no uid_map yet and whose tasks can
>   still map it, and the same one level down among tasks of an
>   unprivileged user
> - setns() into a namespace without a uid_map under one that maps host
> [ ... ]
> create user namespaces, or there is no tmpfs or no security.capability
> on it.  The ptrace cases also skip when Yama forbids ptrace.  The
> idmapped mount cases also skip when tmpfs can't be idmapped.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-b4-setfcap=
-userns-v11-0-2be11a2c32f4@toxicpanda.com?part=3D3

