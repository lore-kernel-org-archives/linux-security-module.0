Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019942;
	b=5ilHpFfW7NbQGsxp/rgRlSGllGkPKzYn/QgKNTx1Wv0Pe9vGgP2TzmCNNttvF+KTQ3OU
	 MfLZrOci1v3tyzUf/bZTqltALcvl+oqL9gxyztt2bC2anOFyddtwNCt7gJJyUCo6oengY
	 enuAtfc1eQIG0OwZNz7QCWzIhYS+7rlIVNX7NPhHMI5UmzW/QMom8pa4DLmUN+Tili4/x
	 WKT7PLYE2OWHCY5qdHQDaOJwJFtu2KqMAiLhLDxdrmKLRSTvvBraRvRB2p2WifoElIZY4
	 cAxN+Xtty+J4I4JNmLLaX9SGcGERp2yWeqkHnps/nFlMP3SfOsjzkLPKTHXwr17w9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kd8LzbqT8cs1DMltZPBek5q3OO7iFYlyrqpzDjnZTXM=;
	b=wsvb28TaAE4gOGiQilx83EunUalLxJmQOTMkWPypefoey9gflIWUB6yfyiIsJKfl14Ib
	 D/h63eLprF+VHZBXiywRE/qJkr+J9cPAKkaWIUr4z/AS695OO03G6atnJcTWtAMgOI+3X
	 Eth80EMK+b3xBG+jp4qKMZ/Rx6XoP9JISTlFVMELfSL7O1c6jt1aehAKYlcc8LHBIzZiG
	 Bifs13NgVbNygKxnvSwHdPtsc4UvOduXpqzHk5x0+P3VAFJQlv6hjamHpyNOm6z+LHT+Y
	 faVIYgrdGvmDcEmqdFmWm3dfz4DQ6d/Yi+isQtQYwGaNgkf23EXp82ye0rj0WlmKFOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLDvzcji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D3606A335;
	Wed, 18 Nov 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLDvzcji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18691F000C4;
	Wed, 18 Nov 2026 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795019941;
	bh=kd8LzbqT8cs1DMltZPBek5q3OO7iFYlyrqpzDjnZTXM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FLDvzcji5OsBuKmoPABWCQSDNLQzOQCxpjiov1Dljjn4Sv6CYbpP0B9IkDbucvj71
	 SUFlLsf0J3PG9XR6DJcMKVZgnuL9D94XIpuT2k+hPhzq1RrHNrkw/Vew58uMypz8v4
	 83Q5+HTkzmTCrRUlSsgCcLXjUl3UlsxAwLiuqLn85AlHJDKdcXkxp2xZxWe9kpAGb2
	 MK/6BpuZpQS1HOdqbW7GtMGBfOzVEv+hK+DDJ1wlrzuB5F4/aKMAcbbaXRRrUr9s5h
	 BCXxSRL9LyXqtp+aHPMjBZpZh7EeV5d0eaEmfqmotkFJvUgFBBivC1/E3WXd4u86kF
	 OkiO9WV7vIYLA==
Message-ID: <sashiko-outbox-221516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] landlock: Add capability objects to denial
 tracing
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261118163254.2554413-3-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
 <20261118163254.2554413-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:39:01 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The capability denial tracepoint identifies the capability number but
> not the credentials or user namespace against which it was checked.
> Typed BPF consumers therefore cannot reconstruct the authoritative hook
> context, especially when a check targets a user namespace other than the
> caller's current namespace.
>=20
> Carry the exact cred and user_ns used by each commoncap check through
> check_cap() to the tracepoint's BTF prototype.  The capable hook
> forwards its arguments.  Other callers mirror old->user_ns for
> CAP_SETPCAP, and init_user_ns for CAP_SYS_RAWIO and CAP_SYS_ADMIN.  The
> latter checks protect global hardening and the global admin memory
> reserve, so nested user-namespace capabilities must not authorize them.
>=20
> Keep these pointers out of TP_STRUCT__entry and TP_printk so the raw
> ring-buffer layout and textual format remain unchanged.  They provide
> context only and do not participate in Landlock's verdict.
>=20
> Do not carry the capability options.  CAP_OPT_NOAUDIT already suppresses
> the complete denial record, and the remaining option bits do not explain
> the checked security relationship.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118163254.2554=
413-1-mic@digikod.net?part=3D2

