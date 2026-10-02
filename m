Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F03C3F5B
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945378; cv=none; b=V1+NBKsje5ULDiGqiFLqH9qgzYRL3IZ3F2e4w/RVqJQFIiwneXLbmolwWkFq1qz1igshRVjQbHpSGFPiCfe1M78ILiT9BzuiWT/quqSHCFJdzGKie4vCrvGopQodfr+xFKOCrygUBfhGJzF4T1mbBGcNdGmh48ziCsU//hqLr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945378; c=relaxed/simple;
	bh=R9ZL4VO8ZjqcAfvpK3iYINiO0VlxIT4/Ghqoy9d+KDQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LEr5b0uqgXPq006S2bmHKYQ0q/imVn3Bgezm4VisNPRPDaepRM1dk1AEP1W4zs0ezny0kPwHyCp5/0h1u9qn6Srf0inDk0Kl2dByA8eojAOu55Z71PIh5zGcklmkONhDONxrFcNuZ4euuvphyZtp1NajII34rdoKqtFrVy05dJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJBKRCcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJBKRCcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A6C1F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945376;
	bh=Cp9MjHXLxrjTh2dhFb8kBZsTrYtIda2vPpVvma6hugk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dJBKRCcOE+nns75j+ShJ+4dItq7Z/O3CKPE9ghAYND948d1Ukpd5zYwmoP9SYHlP2
	 o60wBaY5XMLSOBcmvpExOWkKuZ41IO+uG0g9kcbbXnUy+r/Ih49XrFbuwcMS74+T2q
	 KOVHcEvDeb16lguGAszbnspOn2dRhPn0W9d0rnwdHTfXdrhiK1FCdlpz1DDICJrVXP
	 gyqWVAjwIFxOyk/eTn8OUROxqB/27Kt0a7rgfVbiGh+e3vIAYSvLgddkLvQ4LSo2vg
	 I6Po8Qi+qoqOOT0Gz1mJjLba+umk202fhMYwgs9VPGGCw7Wvxz5+tdW2OCO5ZJYvyJ
	 kt58uuphg9I5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/8] landlock: Wrap per-layer access masks in struct
 layer_config
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-3-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:49:36 +0000
Message-Id: <20261002124936.97A6C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The domain layer FAM stores struct access_masks values directly, while a
> ruleset stores the equivalent single mutable value.  Per-category
> permissions need additional per-layer data beyond the handled-access
> bitfields.
>=20
> Introduce struct layer_config as the common value type.  Keeping the
> handled bitfields in its .handled member leaves struct access_masks as a
> lightweight parameter type for functions that only need those bitfields,
> while the complete layer can be snapshotted with one assignment.
>=20
> At this point struct layer_config only wraps the four-byte access_masks,
> so it does not grow the per-domain allocation: the maximum 16-entry FAM
> remains 64 bytes.
>=20
> No functional change.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Reviewed-by: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D2

