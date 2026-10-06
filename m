Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261249C4C2
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301977; cv=none; b=mnBfdajVvDq81KCBNJkyj6Owftkg2kEEI5PoqIBs/MBXIumVmeIILifIocfr2ZPQZoYeuNxyTehNJT377cXhbLhBD0wtcIu3vPS2osGchlN30GBaX7I2Ivqwr24xoqep6Jky/XZ4r+bGKaeuOjP34QDJYCave2ZVEAlY0Z0ebaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301977; c=relaxed/simple;
	bh=tajlGKZbxPqnzb2q30HEAXoQyypOU0rVZKaA13ZdjIA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H6q/a5LCFWFJv38Ny7+nuKsBrEh7DiRG+fCtNrJZ9f66H7b6YqlXY/ixWMWq1smFXvNeLc1YihGEdN20AEXNN2pqPE9bwTuBD7zaARJFSSKMr87pZvYl0vERhHw8ezIwo39/WKFKzf8AiQx2YdQ9Nw3IS22KyvzdawAcl/2susA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIZarQZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIZarQZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCAB1F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301976;
	bh=5YU9tXuqegjKcvsbBIVCZ9qgFNT2d1za+VSyAkT1RjM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RIZarQZ+LMa+MSy4zr/GN9qdOTzfjH87U9aWEIqowZUOOulM8MATVWcb2Rr0ZsdX+
	 To47xrSiMGMwMgokKUv2T/uV/UP10B0C+GEUYArRLmBJ72Xf+AwT56h62xj0ZvjR49
	 jKzZ67RJWIOvfFl/LepVivu0A2npPwlQlUQ/e+813BgbDdoqwayDI3q82EgiSRmzMC
	 Z/t1OzYscNDHsIRC37Csi7HgXW4nu0suxgdfWHW1NgCrLB1etktW9/+t5+jQ5JPX3z
	 uh48lAugn40u355WRNJgOWEczms4Hayx7oZf067CTKYTIKeRlJvUKM+IYXLrv37c3/
	 3z4p8QTyVacqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] userns: check the writer too before mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006-b4-setfcap-userns-v1-3-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <20261006-b4-setfcap-userns-v1-3-f47e7ed66072@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:52:55 +0000
Message-Id: <20261006155256.1FCAB1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> verify_root_map() only looks at file->f_cred.  For every other privileged
> id mapping new_idmap_permitted() wants the capability from the opener of
> the map file and from the task that calls write(), but a map that consists
> of the single line "0 0 1" takes the unprivileged branch, where only the
> opener's euid counts.  So an open uid_map file is a token for mapping
> uid 0:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   fd =3D open("/proc/<pid>/uid_map")
>   B gets fd by inheritance
>   or SCM_RIGHTS
>                                     write(fd, "0 0 1")
>                                       opener had CAP_SETFCAP -> allowed
>=20
> B set up a mapping that it is not allowed to set up.
>=20
> Apply to the writer what is applied to the opener: in the namespace that
> is being mapped, its credentials must have come in with CAP_SETFCAP over
> the parent; anywhere else it needs CAP_SETFCAP over the parent now.
>=20
> This only affects maps that contain uid 0 of the parent namespace, and
> only when the file was opened by a task with CAP_SETFCAP and is written to
> by one without.  Those writes now fail with -EPERM.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-setfcap=
-userns-v1-0-f47e7ed66072@toxicpanda.com?part=3D3

