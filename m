Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336073;
	b=pL3ZVKS6KuGDub6LpCXQmrjJvJecMF9tXY5jzwWVFS6BB+OFFAuFtMyih/A+eYv4lx+l
	 iFPmzzSHSmRZMxs1z9/K2wmPSpR9icJ/vKN1RNmA6yOKnyzpaoUh0dvj0SLkWkTk+X9Ky
	 d1vRGGSIGSNYX1leGA1MpNHxWSp77kC87WQn3rm7Aqji7MuoEtxkrbO7qVRx8j+UmR3bf
	 2BhrZeBDWt+U+HvU1R3NFoAmnkIGuaGOhlPQ/G6LUV4qeYrp7BxkvyeCjvkXBHSlYbTzn
	 151FOW8TS+VyroeDetiYG0IhqkqBoTh+2jWdyrI/CvnDarDaryGdpJYHIAGXSrMV8Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xdm4wVeQcIfh+FOpJaYGM/fMLMKU2FQ3FDhyfaXrPnI=;
	b=tMqqnceWKbcYv++ChoC2WLP9tleH9By9BGFi7BFyQBVT0le0c8FdCV/qE/BNVkLNq55a
	 9fhGHVfFSJWZOB9CNCEWOLwhE1mVM1ZEQ+pw1W+lQOQd84M4d8MjRbixlmMbHgEoZZGp0
	 SIPy1JApKRtn1GmJpfS6F3D3cBxyP5Y/GxhHWhYU8my6mMDwvcg9bHb1e4TMJvk799bIJ
	 H3ZO3uTsxc+uhJbwp9P7WUQWx0pTgqpoODvgJ1cS6V/MWe6+wSEjEsblsCo9axSsXUN1T
	 055Q20tnw+gC34nF8tqFw0jv/OLAqb6/fgjl0E1OAwxiAGnhDEV02QoDYypg8t8DlAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuY0mkhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF0606A320
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuY0mkhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670C91F0093A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336072;
	bh=Xdm4wVeQcIfh+FOpJaYGM/fMLMKU2FQ3FDhyfaXrPnI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LuY0mkhJSyCLgM6be/SFtPQZF2pWr+1J4sl9pNHlbs1M/gPWmbPBRCAH0ht02/Bkp
	 1O9n+fiBfXKPewAz5AVLqEKSloj4UgLZORWpxSnuXEZPYOUwrfzo0tCrM6kwS7fwtt
	 t7qx/FmUjtzytSzpcDHqX/+rBfKoINQglJusl3eo6DAq6m5DY8idZvb68SGpbiXv3U
	 f3gSH/7ouILymwNNaLU6EXTT8VerADJpbbvJV+4AMO90W8gBB6Pxo0Lf1FRg8QPJ0y
	 +Mz0IYHST2d1982178WHyQ08kvmVD8BONlfXzqwTnw/A1giHgVOJQiMiwqu+AQIPMT
	 Y4/QPdYxyN/5w==
Message-ID: <sashiko-outbox-190476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13 RFC net-next] net: cipso: guard IPv4 packet
 manipulation functions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260712013941.4570-12-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-12-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> To enable compiling the network stack without IPv4, the CIPSO functions
> that manipulate IPv4 options and generate ICMP errors must be bypassed.
>=20
> Ideally, CIPSO should not be compiled when IPv4 is disabled but
> currently it is too integrated within netlabel, so let's just bypassed
> the relevant functions.
>=20
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712013941.4570=
-1-fmancera@suse.de?part=3D11

