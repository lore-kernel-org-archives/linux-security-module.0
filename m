Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111854;
	b=sHZM2BJYZzcrRp/+0maxGdU3KWLbBH8VM5+0ZpsMmksiJ75E/2CIupHiy6tyq8+pRdgD
	 AmPMtb02ss6YxS+un0JIiZgCKZpuFo1qkQQ/LpskhPWwCHN8NOGMFV6D+tsJ/mn070ow4
	 /rPEJ96HVSsLWyqdG4HT5umXwxuFLmKdwBANX+Ps9Y6/HyqH+Za9lAB24e0l3nKDKb3cB
	 dcG+562BV14E0HC557va2Wvld8+DrijVedyQ2GxV7L2DbJxzaHbpV8D1FKujupfdYjEHV
	 FzT3AYWGOkWnAJd8jR3heqmDZEA6qLsWza8tafrly/IMBu1phyjEc5sG6I+S4jkKw3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lVmhLW2JpUjjcwt0I3CTU/ySLytVxEzIUpOWuPRtz2s=;
	b=gkEk3oSHkz5iUdC7j2jwJ8HzvWV8O4npW4FX1hvtq/Iz+twhYFRWsmGHQ1Brmfr79f/Z
	 WcZv7aC0ez+Fm23NyqL9mJLViCaYGo+cDVbl9M2gm1YAMsnnP/Z02Q0t7vIxww/RjdYZK
	 m0NkcOi5fy9S220zyKBXJlLC+czX8UnJnoRvWKT+3MdGeXJauzcmNFed/cefPKxhlf4gw
	 BRZrcfalqpGqbn+N+Rm9TEkYx5ZW2OCOzof9t5KvH9kqbv8tiQ5N/m5etdIPstN8aDz/O
	 1cJmnndpAWzXrvK20CFCvsD9eg0tjLXR4SFLxWVG4OruaYTSZoBVDXCi9Fgz+vXMWUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hahAAl0g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414E606A322
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hahAAl0g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D141F01825
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111853;
	bh=lVmhLW2JpUjjcwt0I3CTU/ySLytVxEzIUpOWuPRtz2s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hahAAl0gxBuV+E7jpH7asU3AU+7IwrGR7CgROrLuXBS91MHd0KYgFYfQlWFZwIQpr
	 J+hMMYxYFC3jXwpc8Xi6wFUHB8RRg7aPSsfj/ahrAWfss3BjWHQK8cJ+mjIVarOdbt
	 o1DbcsEVAA0r0JKZoq784EzSTcjG4HQr+gzyeIBisFOk2dD2lTfwr/Zy2zi+WB1pOM
	 vaDrXYI7i9iSljTH1jl01NIhpISynmLsycQxJI9HhMwni91UTVToif2XKkAzZk9iqT
	 ALBjvd9BAbZEZ9SNcaxl0o7TedZpkejdg5I/Xij0ssft7INTErZ3JlKLQrbQkcqitZ
	 XbJv/NiWCWtCA==
Message-ID: <sashiko-outbox-186738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-b4-setfcap-userns-v8-5-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
 <20261027-b4-setfcap-userns-v8-5-2674adc63f3c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:37:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
> 0 of the parent and write file capabilities that are honoured there.
> That is the one privilege they keep outside of their namespace.  setns()
> no longer lets anybody in who doesn't have it, but the ptrace checks
> don't know about it: for a target in another user namespace
> cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
> target's namespace, which the owner rule hands to any task with the
> right euid.
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     ptrace(PTRACE_ATTACH, A)
>                                       uids match, euid =3D=3D ns->owner
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
> [ ... ]
> tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-b4-setfcap=
-userns-v8-0-2674adc63f3c@toxicpanda.com?part=3D5

