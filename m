Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BA3AE193;
	Thu,  8 Oct 2026 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493483; cv=none; b=QkL1+IWPkF0OGAzIq2/DMQKIueovD3mvdnblOmkAhHGExcWk2VNGizbVwq4fmX4YU/XsGMl82p1+4AHqzz1JYQUEdvrl7Bs0Ct9lcUFidkD6HldARFisAOkt9gx6PDHvAz0HT0RpoIZdzWKE0tDAI+Kn+0Izgk7E0kMA+RzPxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493483; c=relaxed/simple;
	bh=dVPeUF6pvAy0LWVpju/wPsG3UeC8skJgRX5M/riKvdg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QLDjxgFanCGmJPfrjRDZ1YZtt/KIy98BSArez8kbhfz3IhakGjWq1VLuqJTSXxD4GMbs5Jj+RfMDrhBBJ4WMxxtxvmYr4qansNbnDOb31Sp8efFWZpB2+9ZBFD/5TCJUQMbWzcVD/zcr/MgyVJMy71/O+NPCkFnkVXLbxEungYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crKPrV08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crKPrV08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267341F000FF;
	Thu,  8 Oct 2026 21:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791493475;
	bh=S1H+pkjsgHmmakfpWA8U5VqfCZiYjMmpAOSJGvjWbt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=crKPrV08BKBpEG+Af+j6oiJpnyycX3Kz93Po6jzx8BQf7wcVzfXqsTVs8DwVnmN3n
	 X3aZ5yXullQ3me71hAZh7IpeUEamF7Hb6pM/swovo0TQ6RYZI4HLnFXEkDVFJMQdEV
	 JIia1HCC2XjBfJQEsW6PXF7XfdUeCUelgphk5opCAXBGdXLEcCTkgtMiTHgazrTfeI
	 u0EyLe9aSItUgLw6Fj5jVA0zmQ5puTD0YzkA1ezJDqdQI1sJn2XVTLFdw3YXOF5zVs
	 l59xCMfgSyi/sIvzDb7jlANv2c5yxO44klkW57ege5ThBZ6zfSAeHtjKZ1CCQkiqwE
	 niHspw2YIRmbA==
Message-ID: <sashiko-outbox-164593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Halaney" <andrew@amutable.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev
In-Reply-To: <20261008-ajhalaney-dmverity-key-identifier-v2-1-008456d189cb@amutable.com>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
 <20261008-ajhalaney-dmverity-key-identifier-v2-1-008456d189cb@amutable.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 21:04:34 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The .dm-verity keyring is not linked into any process keyring, so
> request_key() and KEYCTL_SEARCH cannot find it. Userspace has to scrape
> /proc/keys for the serial to use.
>=20
> That's not great, one could put in a bogus description containing
> a newline to confuse userspace further. For example, thanks to AI
> models, which I run as root but you could show off as any old user:
>=20
>     # DESC=3D$'.dm-verity: 1\n0badf00d I--Q---     1 perm 082f0000     0 =
    0 keyring   .dm-verity'
>     # k=3D$(echo -n "1234567" | keyctl padd user "$DESC" @s)
>     # keyctl setperm "$k" 0x3f010001
>=20
>     # cat /proc/keys | grep dm-verity
>     10402023 I------     2 perm 082f0000     0     0 keyring   .dm-verity=
: empty
>     12e0bee6 I--Q---     1 perm 3f010001     0     0 user      .dm-verity=
: 1
> [ ... ]
>=20
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-ajhalaney-=
dmverity-key-identifier-v2-0-008456d189cb@amutable.com?part=3D1

