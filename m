Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35538DC73
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430285; cv=none; b=fG9MYc3LYeqk4efqsPKAX6zSYpO9hwQdz5aTHWnFqO0GhwzhGmrwWuPI+lYn2CNqCgeY79O2305ahZszzOR5REnyn6xWlMSLhrPyehSKN1NaDqXmbRhe+bv6UJVleNoHSVlCvc2fsoO5PDKldssjoIQ+pm7lMlAGrWtB/2FyrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430285; c=relaxed/simple;
	bh=yzzYNCWe4A870YvOQVWeXlPzoMLQ6/FaRi+ohVtWwPE=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aZWzQkUeYmN4Y3Pb9xKxZfjyfJd+5gqSxUHZEaTocf+HWtTDskXpPRvAkRTLRgn5OuPGjEzxMInbJV10E9vDRGRjRnnyFhAlUtzVSwb4wxpb8AN0mZvFFIViyG6yYr9MKBe6yRPloyJNJrkxlAB2nsPqlRq7MC2n/yFU9ZbCq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzsfklvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzsfklvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B51F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 03:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791430284;
	bh=yzzYNCWe4A870YvOQVWeXlPzoMLQ6/FaRi+ohVtWwPE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QzsfklvyF0W8zgvLI3UYC2z1yt78MJONcVx13APCsynLroPUlPo6oVhLXR/VfhAEq
	 Q94IVv1KSQ/VZAjuz3P7rDBLSz4e1DkHE/9Q/YvkSPl5dgGK0TsquQGrnBwSaW6TZp
	 x7IGbLTe13q5bLTD4eNrFbHM/WwVW+Q/wVjgX91J5mxc6ro7b6St1k+hNfo3CQbbAR
	 PYWC0+vk8e2mZJV1Yil3xOK1SJHa6m+umJkcgncjqWJXY1XxJsNW+JhUaPRstqkGI5
	 YIKk5SYPbdK/pcn/Nj2HPx1cORZJ0Hh13mDk1XnKmqbWsUlX13jjtUm0OcgRu93v9Y
	 UjeZTL0GMuYCg==
Message-ID: <sashiko-outbox-163539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: avoid potential double free when remapping
 DFA tables
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008031533.2205-1-lirongqing@baidu.com>
References: <20261008031533.2205-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:31:23 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Li RongQing <lirongqing@baidu.com>
>=20
> When unpacking a DFA, aadfaunpack() stores a table in dfa->tables
> before attempting to remap a 16-bit table to 32-bit.
>=20
> However, remapdata16todata32() frees the original table when
> allocation of the new table fails. This leaves the corresponding
> dfa->tables entry pointing to freed memory. If the unpacking then
> fails, dfafree() attempts to free the same table again.
>=20
> Only publish the table to dfa->tables after any required remapping
> has completed successfully, so that dfa->tables never contains a
> pointer to a table that has already been freed.
>=20
> Fixes: 9208c05f9fdf ("apparmor: add support for 2^24 states to the dfa st=
ate machine.")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008031533.2205=
-1-lirongqing@baidu.com?part=3D1

