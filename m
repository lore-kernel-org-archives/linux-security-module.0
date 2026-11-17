Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911054;
	b=WyB8tpL1YyDjM+ps+ZEOz0jakr8NKjLlsyYB7uxbXhfgOhNhwsgKHwjayBCj57PaCrq2
	 g4Pquv4Dl9Yto75VMJhzSJwHC4ogc/9i90Adx//PGwxKr+PyKJ01UV3ZHz0ZPDv6mmKMj
	 bu7dNjVxa3dVSFz+Lf4RS98DXXKVJvgzRhkty4izpDp3vtOECtVHOSTPuNmYzaL9ptDvz
	 0Tlny/OmhNKRu7MMedhElyyFn0QJnEVOpPTuvcrzNp7EwKyrnfnmWNtCpiYVgAIS9VeDy
	 SSdSyRCTeguDjVlmJ3FnnQSEZufE55Y8qlbXg2iwfhDM+bBHR7KFak13InVwOqCxnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911054;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+osHzBXFw6Hn6kXarqATVE5LdeLYYiGxTOjiNkzJO7w=;
	b=c8saZRe3J7j277poeKIs5zIVJkR014aJny+qdpt1ipD/B1plb0mGRC5RXbOJ80Jp6bxn
	 Mmeykc7tPytXGzGrc43SvIELkDvYe+glbDEuRS0esy57ITO2AvqGEWMh4dmnzoR84xkZ4
	 GnzrXzS+rwYgBAQulder1Bb0ofLpzTzdmwPJdTlHznqASPW7Jc3zj4ZGLeZdqISHwfElk
	 6pXX2F7xuK0bEN6ykdubw/v0m91Hfrte+zadLzvieaqLi29AWlcDixL1r81UMa0qtLnPn
	 tqYYH2GitsBxYTXmAUcokHtxGO8tkt52x/Gl9V3zPeI+PtiUzR4muQdS41znxr4OpeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBZ7vpsB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1A606A32A;
	Tue, 17 Nov 2026 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBZ7vpsB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158721F000C4;
	Tue, 17 Nov 2026 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911054;
	bh=+osHzBXFw6Hn6kXarqATVE5LdeLYYiGxTOjiNkzJO7w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nBZ7vpsBOKeSTSXabSpkeED3P0e+SvXsULJZuZ5k/mrWxQ3QA+tIxVVY63I6NKSxn
	 nZ/hKoJ1ZN8RT67vbZMO8XQvmdMMA+uHCYKCIkfGHqKUk6CWQ1gMzab5corLTgMBhD
	 OEl3b0TwKdQPPe1O9m43le6NDybuzZTo4TcHf/bz/hAdUQMrBhTrRNaI3gNe+HLD8q
	 pHE6jCNXhYgFtvKhr7bYyEfO61NNBBh2zKKPUGiYEoqrlk6HyDgA6nY7bxhA180g7R
	 iZQ/p7FAV22sdgzm5PUm82+9BnDgS3BSyHLgW6grZ4xnQ/44KdlwoE+x4ewO2yfuf3
	 X7azPIEscundQ==
Message-ID: <sashiko-outbox-218608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] landlock: Document namespace denial operations
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261117102110.2524197-5-mic@digikod.net>
References: <20261117102110.2524197-1-mic@digikod.net>
 <20261117102110.2524197-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:24:13 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Namespace denial records now distinguish creation from entry.  Document
> the namespace_op field in the audit and trace references, and clarify
> that it describes the semantic namespace hook rather than exact syscall
> provenance.
>=20
> Creation reports the ID allocated for a namespace that never becomes
> reachable, whereas entry reports the existing target ID.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117102110.2524=
197-1-mic@digikod.net?part=3D4

