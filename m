Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB4349CFF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966759; cv=none; b=KvpT8t2mexOPnN1qpsikDWk+cI09y373FJklkaHVagMfSl7uaSeuo5gs5U0T0iqY5I+EeS6yZxQ5NUzeX7xmzWEXsQrI4B8yqVEdY7v0cOd8BHBXw6vjlXLdJ+G3Qguw2uCIoSZUPmA0PnoEMnMm8SjPsccIiC0wesJsTfadirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966759; c=relaxed/simple;
	bh=eAh1cgbDtQgyIAOx1Q1vPKQLdsgYTRt8G8un4nEIHE4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Txj3QYL/D0QDFnoI+fE2/cKTBmGSUzImyiMtcl/xqqAT2r+GFzV6Vnq4xkxdFeD921mGzpDj5dOqdbMhbmZgl8JOz9ibyzAFa0jcv8HvkEfiSBI/UU9wBchGjZ6FpMSpIZ3/Mz1s4eQMnkkFvk2aBEbTIZB/6IdY6ShCLcD3T0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDzZoAsC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDzZoAsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F61F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966757;
	bh=SbjqVdvu6OAeevLMHMp7ZKgFcjGnUZ7f6Q3UTiFUiCc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EDzZoAsCRA+tI5VEdvw/7zrL6OjI035lqBsMluO63FHvOiwdNm1AdrKlSXJgLdcXk
	 gMwsII5usUHKMo+DmGn3gv2+Yojb00gjIWlt/qIv8lL1Wns6/2L11XHmS/aPbhDOf2
	 Q2IlUne4kX/NwRw0oU61Fx5mEydFp5gvuVaAiiBI+I2MJJpzECIGdhRiPf4iPSQH+f
	 K5cUy9fUkxMFlOKNVbJg2kdOAHLStSYk/Iyr77YBFq4uYq64dA+gSVcL1xA73YdtEp
	 XN/iJNc5Jtxt7M8UYq0kMj0NZMaIKMcpXkIcDu3q8zeQv0uR+GH+v8crLlOPnRYruj
	 yy0UBG3SXpjBQ==
Message-ID: <sashiko-outbox-171015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] landlock: Wrap per-layer access masks in struct
 layer_config
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-3-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:32:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D2

