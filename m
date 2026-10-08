Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8E4B8269
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470017; cv=none; b=n56slHeHBN/B8UpTAKr+LJcWeWB+nwAhgDw6NjCQ0vejZde5sjTl+vThSL5mbw3Hsy9wnrSQ/7lb9lKzWvkUfnlhbbHTRwqaRXHFsu/0B9y927aDsbjA06blqjCNkaB9WqlM/RGKWobimJxvsJWEKm+91JbeOISreAhutspS4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470017; c=relaxed/simple;
	bh=JP2KKUM+wIBlWhmOhZV3Aa1DxeEkMdRVjzRNtFrGyiY=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Q9xOYrvg/dE63beqKPfF/kFT/X88nJhRSW9Xtleat+w6CkumCrFH3Rt9kYsWPtPVBsmgyqJAST2IGtK96soqx36bF8jXp9WEgNFQvZ1qFyp4fpQfj0vLP8lqnOfNzRHfjqbsahNicbzsWKfkvdVbm3fhAawtlhB8A5rYSFgrFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJokIPsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJokIPsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7387D1F00893
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470015;
	bh=Hr8vwmPFN226nUHE6rpLuxFXKM1LMG+Ps/5FdS4pO80=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aJokIPsw0WW8HRMEZYeVJfGCCQy9rwpq9hMO1kmhnPY7txwAXRCM1q+9xky7Vfb0x
	 1vh6gQNTiOtWvpOIuydqxY8OJbMrY8M6G+RYSO1GgQ9zEMn9e2v9Zn5oMLyDGwjtq5
	 ThFjUma3p6KgGneboNLiMl5fW0MHMZzzqonwDyWHcmwaNXBCC6aUcs+wb9lRaMYbE4
	 6IGAoSK+nlhGnBLodxjLKy/xhl+MkVnSVekz0uVf9MXfCJqaS6+fZ4u9aJNexjRw9o
	 g8k7ozrUEzWm++ixWFjWT6PyXzKZG+Nq9OGHS+I+nF1ROaJNESzBpruizzA9cQnrPS
	 Au3K5JigbcYXA==
Message-ID: <sashiko-outbox-164295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/27] selftests/landlock: Fix the openat() success
 check in fs_bench
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-7-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-7-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:35 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> fs_bench expects openat() to be denied when Landlock is enabled, but
> only treats a returned FD of 0 as success.  Any other valid FD falls
> through to the errno check, which then reports a stale errno value.
>=20
> Check for any non-negative FD instead.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D5

