Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE036B910
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470033; cv=none; b=kCq/9iFAeCY//QrWCNF8QjLemReQgPlOI0Mp0WGL2bTgBx+pNsG+9CJ4lyUPHxTs7JLhBLf+LZE58yKOxdmcg1k27FYIsdZsOwK1zt2pZ8M3iHNdmw+Uxw8pmf3MU+jcjKmoB4eNs35/6FrMoudm+y6NFGPcN8HhvGgkB9Nbofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470033; c=relaxed/simple;
	bh=fQ/udeErkj6r0A/onDo+ZC7r0AEgZ6uYXTh057psEi8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VyP7MqyIEUeFDvhgBakP3uc1ZPDLAi58562sGVeB9JT3gHEs+7oI+qoarBviwdABr3HayJjPJs6b4Ssvq6AqwSY0pa1oft31wJJr6TNjiuY0DyUk+XLMGZ3+jAKothyacCNtD6PcjScFVVhaPrKin8aq4IeQ27LsrkcTB6LKdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDjLer1v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDjLer1v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E881F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470031;
	bh=ZuWp9Yn1Q4RH3ljdXOkwYM8i9zWJEDK31wpJN3/LoJ4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XDjLer1vYCDfJt7erVE0zo6W812ebWvA8Fk2Y/A6lcZ+MiJNP+2EHhuyHiVcVuUwT
	 gTcMLgqaeoxF167+zQ8ODS1VIA4fkNDZ71mctzcH+/SLhR8hv6Af0k/Yl+QOwKl2l/
	 73MLQav5WSfE9GSyJg5MzAmrdaYE6iq1u3gPT+qNDFzdREuXcjjZIgymVNCgwKteWa
	 zah++HFZ0Yrxs5iSu12NBZ1akTrhSSUpQuBM7xYAfeunl/xKzejsShIZUiSRvrGeoL
	 qRhsPJyDRu27xR/7TnxCbncJth2ytsWgp2uAy/QSL2F4Eqa3+Aem/11s45vFYKMmrv
	 td5iK7y+74iOA==
Message-ID: <sashiko-outbox-164297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/27] selftests/landlock: Fix stale comments in
 common.h and audit.h
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-25-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-25-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> * _init_caps() lists more than three capabilities.
> * A 64-bit hexadecimal domain ID has at most 16 digits, not 17.  Size
>   the buffer accordingly and drop a redundant domain_id check in
>   audit_match_record().
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D23

