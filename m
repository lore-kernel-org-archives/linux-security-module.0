Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AB5383D0
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181552; cv=none; b=VYaFKUsq+nlQcl9bVxZegwUAydguKFxBDGodK3d2hl5P7FOl9/RFqM6aMosTy1VswSke05Xv+UZoU5af5pQiisMpfhnTreVvXZb/GIUsB1qDBMRouGOb5GceXZ3O4JZduJFVnGp+D8xTrJ4tT5o5ujp+wTF9aJG3o6n+9kHBrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181552; c=relaxed/simple;
	bh=Cj8r5uKCMcvAoIdnRIRAXiSFuEpXBlg5O7TIVnrKOjU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OxZyAZ8pMisw9dPd4PXmPVAPN7Ksc+eVtGVnem+fRl3V0ZrefzYMuruIZB/jQXgHrshYSmefjSFmoFFkkwArmXCW9mJwEfqQYkk2QdrKbx6jqWATpneAgaLHe7616VeHifM86VuPXJIbBtu5eNara/JK2uuCHkd6oM7j31uno7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDBJSz5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDBJSz5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F101F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181542;
	bh=JSUyur5ikzJB/rZUaZSdok/5rcH9mFEAKzy2oClHCd0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PDBJSz5EAEuF/A7MjlYNtnlc3tYOwawjGKExraTprCxRV9yu5LYbtjWlmhW7h81ee
	 62P03BpQVNO691UNBpn8xlG2CxG7KBs/mTcJMDKptQtqUkhN7xoun/Q3RqK0rJplOJ
	 MThXoMkklETWb3H1rwvPHyCTFYYyk0puT1L3F//vEGRIx54zaAtmR9c/JgxlphXezZ
	 ScnkF0jGQ8WHnqwgUdDVDA5yaF1oOuLeY2RcdJtWW4TH53HXmqUYtGO8MrgSbTsMK1
	 OPqqwP2ewM3FYN1YEHzMyZiE++pvbsOB2EhIEkvllDr9Brjnjeu3A2RyLltB3LMyOj
	 D7ybrcGAae9rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] docs: landlock: clarify TTY signal scoping
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260923163321.79770-2-clusk@northecho.dev>
References: <20260923163321.79770-1-clusk@northecho.dev>
 <20260923163321.79770-2-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:39:02 +0000
Message-Id: <20260923163902.87F101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> LANDLOCK_SCOPE_SIGNAL limits signals sent to arbitrary processes outside
> a domain.  A PTY master differs because its holder controls attached
> processes through input and signal injection.
>=20
> Clarify this boundary in the userspace guide and narrow the UAPI
> description to arbitrary target processes.
>=20
> Built the userspace-api docs; no new warnings.
>=20
> Link: https://lore.kernel.org/r/20260916152336.1589383-1-clusk@northecho.=
dev
> Suggested-by: G=C3=BCnther Noack <gnoack@google.com>
> Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923163321.7977=
0-1-clusk@northecho.dev?part=3D1

