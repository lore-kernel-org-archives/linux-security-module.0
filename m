Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEA34D3BE
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344855; cv=none; b=B9YcPVWK0M69T/dnxWgRSX6Z3GT7iyDwzetrfSD7QYmlSahmSWQ/eeS13rZru8RTmXavqb44OAebnevl2piacm1D9nwHqm/PHEY6VqRh8HUnQ8EDYLzvCFxJvKqnPZhpbD8OABKhbQnGrQAIWhEXqksZoDdn/rvfMSf6E98Dyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344855; c=relaxed/simple;
	bh=G6wXAUosA7PuOUxuYvK0rdkH7w7PlVd0Sq5wXv4dH6g=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eb1G0AFMWOcgmZQZVyCvb+6hsblCoPBiU1zePm6qDaq1Qbgf/jdGw/lfT6cpFlzxYis1xtug3xS98DY8lzwP1sfosGWsXNbelBwj/kgEttwkYgRvEfPEkEC8kDwKVPQAlInXqof0XjExelgKYktf0PPYhNA/SH/P016UHs3ETTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToV1lCYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToV1lCYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF41D1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344854;
	bh=G6wXAUosA7PuOUxuYvK0rdkH7w7PlVd0Sq5wXv4dH6g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ToV1lCYm0ocIZtjiYf7IpYMjbBtj5cmXtBi8IZ3Rk7CcNc83CL79rJWqkZo4rj8+c
	 xGbXrQWKZ+1lHW/+BHrHJ+G59WIZUOthNxjwvKrtiQvs/Dok/+AIQ6+VvU1Ybdc3ry
	 j/80XtcftKDlGIhN7NIQDM2AWAOIGJqfgQ2fP06PIelZUapH2Tebo6X1dg3FqseYId
	 wg6c1TB3NpFsPsp9u/aZ8Dyz6FLD60bAJ+ooFqHi7R630efQOVaXqi9+M/WEw/KFIg
	 /ERXKrs/P1qxsV0Ir+MPeC/dRv2XyW2HCzgo7xxokZrrvEBpDUk1tNg2suBdOsQFXK
	 UqyCJBuWQX7Ug==
Message-ID: <sashiko-outbox-176319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] sys: use cred_ids_allow_control() for prlimit()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-8-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-8-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:13 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> check_prlimit_permission() wants the real uid and gid of the caller to be
> all three of the uids and gids of the target. Use the library.
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D8

