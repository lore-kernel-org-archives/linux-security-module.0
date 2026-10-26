Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049497;
	b=YiLb+A/9KK/IvS/NdVL9EU8jh9itGOpPrzcGZ9aNBwmriyjRPkfTtfhKddnxbJmfzoJV
	 NyHDv3tr1TjeCF/RN830Y0+RNq27j+R7n7erJ3n2j72eDyiMRzYKftnXoicTHsviXFS2h
	 LudwZdSDZS83y3AJq0AcBfTjROIpRlA5B5GF5UFx+4wbkQuqRUFTiElOxqRTn8pfd4uKQ
	 GBz2V234lFEZbcHhIiBzxxKYOl9PfgwCueDpcBZ308Bjq4o7Y08r2bbfzf2PFRJWSs8Hu
	 reN8pl87RKVHwK8NnvMubAOy71IExyoCJQAycoejasDMGk/5rrwYEJzD6pNwxB+uyOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cGI6XxGy9ZZmyco0lZPNZmfdcUUs+Z4T4WohpqTS+00=;
	b=bI2sDWK3yasC5XOUxUNtuK2zI65dHmuKi9N17OWCJsdmW2+HrNJYft21rUbJlBDIh21m
	 q/JfzFPlfbIo/nejOQqSUXMlkEKFqFZpht/xwV5lHM/OuSj5rUSsnTqcCEIMYsw6x4Ow2
	 pSlp5KLneQLlpmIt7GcGMphRrz+8kKDBKRstGXFp6P9rUMkNEMkR66YA5rL24gRywTLM0
	 k7Ir+l1iEnPDGmoXN6ztlPAmu0t5N10AKF1otVgHiHfGkRC/s8HhAnE+gqTBqnC+qeD5L
	 1DvJ9s0kggzprLzgU6lhqVDiFGQOVMSSiiJ1znFUeCIeMwSqm3J0kzwx4gbkVlMZoSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcfEl24O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C23606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcfEl24O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA1D1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049497;
	bh=cGI6XxGy9ZZmyco0lZPNZmfdcUUs+Z4T4WohpqTS+00=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LcfEl24OwpyVfVEPrweqOEzxMN+800mwNq21IwH6ejAklYqOzaIko10pOLlhBQxxB
	 YKd86GjD2At+yVBwLh70hvzkFW1hmJ7Cpe+sY3cg9nW3oZYJ8Q5k/1MzE2loxpxDi8
	 +t5O68XQCmqf1WJspALoFJO3vWNLOTF2PAYQWSb7TuYsNjtXLEPH1Vi5vIkHtf5nnK
	 BWY74pu/G/G1dWsN9uHiM1Jc5K/5fPVOZDVNAYczHUDTLVqdOdycRp8hHjxva93sp/
	 cuEJBxnHC5MRC3yfCBv7yk2S2Cg0WW+WRMyOP3E3XnsoXAokovZRvRhBOL+cImAa3O
	 L9zD4Jz+ho8Gw==
Message-ID: <sashiko-outbox-185747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] userns: don't let setns() lend CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v7-2-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
 <20261026-b4-setfcap-userns-v7-2-bf8a576f7259@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:18:16 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
> because a task in such a namespace can write file capabilities that are
> honoured in the parent.  A task that is already in the namespace has a
> full capability set there and can't be asked any more, so
> verify_root_map() goes by what the creator had, now ns->setfcap_level.
>=20
> But setns() lets other tasks in, and they get the full set as well:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     setns(A's user ns)
>                                       allowed, euid =3D=3D ns->owner
>                                     write "0 0 1" to /proc/self/uid_map
>                                       ns->setfcap_level is A's -> allowed
>=20
> [ ... ]
>=20
> Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undur=
chdringlichen-35666eb62cff@brauner/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v7-0-bf8a576f7259@toxicpanda.com?part=3D2

