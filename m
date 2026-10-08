Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397F305692;
	Thu,  8 Oct 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493320; cv=none; b=BfntY+C/ilnrCZzwxfH5+Oz56VwZ6k4KeBV3qcDJMkvtYo8chX+DQhPDjaKYKuMeSBLSGjMxChLolIpwMacPpNUUZC+M7/FquxfkVVZNiLwH3Rj8yYVXXYoccplH5EJ1cmZr/ktZEnzOSJneD3iDRP4ShzEinygK6DcRTjlzA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493320; c=relaxed/simple;
	bh=SwD0uhRmHqi2vx1IlQLHUmTWn1ywB06csMecdxdAaIQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HQR9STeFwkm6m5AybsBg8I0d57ERqgouJxbA7kLhXu9jFb9FITgJHZ9y2OrBMKImzT1UFbSZDVrPHiXVa1fM/i7JP+OgIQPFjv4SvpoOqjyoUaoNZqAu1YRTg7lGkH49CL71cCM3rDvHjv+15VbRsJuTC7u8txQssLy0yj2wBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W30gWayL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W30gWayL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F9F1F000FF;
	Thu,  8 Oct 2026 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791493319;
	bh=SwD0uhRmHqi2vx1IlQLHUmTWn1ywB06csMecdxdAaIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W30gWayLY0jYzLh2Q2MJlYDIn7wKT3rMxAAO1tUMNMPAnwSwefuPJrAfM5ibHu4P7
	 KJSmyoAVr2+t91qPXHZd5bMgDViX8ibttFj8rItCba30cpGSI/RzzyigTTVctgQzka
	 cxnoV3OFKIKbQHGls05KzHId9YVaELqPUiFC5eKOA+Y04OWwX7e5jGbGtMEWFd8klO
	 cAKmq0voV6QJ72d7vkUwxHRL5Zz26K5eOfVyrsCpSqx0x2w2mT7hhbQ1a8j2Z/kQzD
	 1N5IThqDhAfbqcSOYJQzqlQaOMGIrm7SOjOHmviJM8WcifyYXY7apd3V8EXmtR+C5v
	 NbcEMPquvQ/ug==
Message-ID: <sashiko-outbox-164582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] Documentation: keys: document IDs added
 since KEY_SPEC_REQKEY_AUTH_KEY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Halaney" <andrew@amutable.com>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261008-ajhalaney-dmverity-key-identifier-v2-3-008456d189cb@amutable.com>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
 <20261008-ajhalaney-dmverity-key-identifier-v2-3-008456d189cb@amutable.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 21:01:58 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The table of special key IDs stops at KEY_SPEC_REQKEY_AUTH_KEY.
> Fill in all the new ones.
>=20
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-ajhalaney-=
dmverity-key-identifier-v2-0-008456d189cb@amutable.com?part=3D3

