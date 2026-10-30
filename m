Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356182;
	b=NQHoQ1vZyyIVmO+dNn9Ijpb8D9miRSN8+q8PzYIZnLeNs7KPapQsXY4XTXCrxvfJE3zH
	 37VZrouE8azbEn73tecoprhp3aQD6rC0opggkEny+mNO+y3xcOsAPJNv+4QCR6rhDtl3L
	 dj1Lk569/cAfFhL9zBfM9MP6bhOdjH9IhxEByftNY8eNbioeYFr1smlNTe7anadOvKftl
	 pjvhu3JX8lRpYw6jrFT/igHCmE5hnpX5GuBkdxEFEL6UpctnWSC2DEjDIw5R3OcFrPbip
	 tc1fEVD5eJ1QRL3vSe6B5gO6Gj5VDeI+ZCw3D1urVedLcpUXtdvoLCIO3RwizWPdLkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PAeWLQYbZsWEJx2JQyHiC0V+8TvVRYkgEsmMfrLUypw=;
	b=Ohb869DEOmV7m705WXV+lfqci7HY9N8HAXHO/PO5LsQ0pYtziG2gXH3JSNp7S3lwEuVK
	 8UWE32uADEMRSYoXQd51ITfDkVVXnGrdJiNv2zA++NZzLNHodtW22uFhY3bzmONx63VgM
	 tMQDryWE0Q/NkjC6X3gg8Erii8MTGjg+IiZFmjNveUzR7u3piy/INZicxEilq+86x0Hnf
	 Nen6AU/YEgcYYNv27526qB/TnxH0h29DS4aCw14xTQ3SS6kbED/Z8UIWU1LsNPblqIn/N
	 uIVK2sbvrHkNuidecUBqAXTJvW5QaK1uZLijH0cQGkCaV9BWUcUxBQRGythxuefYqRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8BtlEc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5D606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8BtlEc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E981F0093A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356181;
	bh=PAeWLQYbZsWEJx2JQyHiC0V+8TvVRYkgEsmMfrLUypw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=R8BtlEc85dcU5FWrQHRbrHjf6DOidJ6SmAuxw+km+ODXsdP+pf7UXzq1umwJSbp2/
	 qegkD8c9tT0q8sZNtkH8wosc5fGdoNZiPPSHetFRasZKPG4I0Fhg+gEqIA6MtnveKT
	 zgxkIl4CswQTz41qnekWykuwqGkJZeur+h62FTu+HGvM1tA0hDtGPATtHwAH09hElM
	 mhzM4vzvCug52PreeIlDBFwE9IwlLsHMuD8BLmIpfEL4iXjysj24bq9un1BDeBm65D
	 1K12bVgYO1WHSvqfpW7MtuS2pyPWCzhuZhxzznw83PwltV7d7PO/LBPv8qvA8tRj33
	 hekSMxlTukmKg==
Message-ID: <sashiko-outbox-190830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261030102411.12985-2-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
 <20261030102411.12985-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:29:40 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> In landlock_get_fs_access_mask(), only add the
> LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
> handled at all.  This prevents us from accidentally treating
> non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.
>=20
> landlock_get_fs_access_mask() is used when initializing the layer
> masks for doing access right checks, so this bug meant that we
> unintentionally denied "refer" (e.g., link, rename) operations in
> layered cases, where the same operation would have been accepted if
> only either one of the two layers had been enforced.  If the rulesets
> individually allow an operation, the composition of these rulesets
> should also allow it.
>=20
> The bug only manifests as soon as one other layer handles filesystem
> access rights.  Otherwise, Landlock filesystem path walk is guarded by
> an early exit for the case that no filesystem-enforcing layer exists.
>=20
> Reported-by: Dwi Siswanto <me@dw1.io>
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and c=
onnect")
> Cc: stable@vger.kernel.org
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030102411.1298=
5-1-gnoack3000@gmail.com?part=3D1

