Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246025;
	b=41Ysx9gdliTogK5TTTeJPMYDSxemEO8uZ9P4FkdejMYFlUZ0Snu+S70pmz0/yFprpKwi
	 DFpEuOxugYHEEXNpcl7Cd03hVqqRbBOdyZNTGfQ1EFbrmXT4tnfkbMXEbQdoPx7m1on5x
	 7dJrYIynTFdWc/wmJnSGR5O4t7nfXAq/0M4tRo3seUg4m2T3LUeh6jrFOqjpdjN0n6lU2
	 9KIAB2qgpO3K9h8J+PlhtZzdqALC92a7i/j6fsCK69wCdCEhtPDjXpgNL/kS3bWlGPW17
	 phQHSoGh+xQYOZBlaRZqT/V4RFJwkZoLyQvncL0HqXiD4DEsnwnlWCUSc6H2Xwnz9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EOq/tuB2mfzAkSPlyE9r4WmG31u0FB/P97zfyg2zh2g=;
	b=OV2L3esBYqYpaD3brT4aqxT3VgC+dJFv9BbNgei7wmoA6cByB42syPNvEonYqlFSuvBY
	 YmlM2U/YLjgUo8zJOKtoiZwJNbRn9wJiucmrvaJAbar/HRHtpnREXRluJNpYilL8egPPB
	 ZGnoIX1XUjyHfVjZfbz3VmX7/DGDRwBs1dW+GgQ6covIi1VRP1+55BG7G5+zwe4FVQMfS
	 VKJSS6ddnaOopFNv1gQXb5LgNvTvEfk03iN3Q3Y0h5TU4MLe19B2x9DdxYt7OHt7bNMX5
	 MA6pPrw2hQ1U+RZNqKKfGPI30dxkO1JTDgpIqOQccpxS2mXWlCH3TcIXWlXP6++VrZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cwPPPs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B1606A320
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cwPPPs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C861F031E3
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 03:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793246024;
	bh=EOq/tuB2mfzAkSPlyE9r4WmG31u0FB/P97zfyg2zh2g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=S0cwPPPsCdasvjUzd4AZfBoj3XPwqMZeKkagekF2FPtnQiY2UienoxcsAWdrUdXH9
	 dNMY8KqUleHLbKPlIXl3f3kwbj4EX1hb5bayLu8orsakTCWYwK/sn9iNfqQlg479Em
	 ram4Hcebv4mnmmj7zOcUAttaazMznIypvsbVLlCP16HVj50ZnHIsnhS5WgS22+M8TH
	 a0LolTLL7SpkyvV6RSWYlB7bP6VyA2qxjJglW7KBdkqtCRvwb4pcNXJ/P0WFARwvsI
	 FfnJu35Z9pQLELD+OQcxj2e0PE2lDiKhLf7xNnPYNtryuOIsaNk0vAeN96lrKiU/0N
	 S1m3iXYkve7uw==
Message-ID: <sashiko-outbox-188686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in
 cipso_v4_delopt()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:53:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> cipso_v4_delopt() recomputes the option length by walking the option
> buffer after the CIPSO option has been moved out.  The walk then reads
> the stale bytes at the tail of the buffer as option data, and a crafted
> setsockopt(IP_OPTIONS) buffer can make it treat one of them as an option
> length, increasing opt->opt.optlen beyond the valid option data.
>=20
> The corrupted length stays on the socket and is later used as the copy
> length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths,
> where it exceeds the size of the buffers they copy into.
>=20
> Compute the new length from the intact options before the move and
> subtract the CIPSO length, and fill the padding with IPOPT_END.
>=20
> Assisted-by: LLM
> Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connection e=
ndpoint")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029033942.3644=
-1-q.h.hack.winter@gmail.com?part=3D1

