Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0744E055
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945409; cv=none; b=OgSyohASJ25PXxWeWGMAFdu0ekVreE0Y9BUZtAZ+mYZZCopdyGSuW4yW4CVlBoSMHfgk5HHXD05FM2ZF9YdxY8f2Uc98abjTYp59amlxHh2Njr6o9/W+sQzwtk5IwNSUrguaJ2OPC/5eMXv4pNT+lMgsIVbooozmvuYgU/r3XW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945409; c=relaxed/simple;
	bh=pR8S9U3EVGGvjXDhESzjRdpjUOSuatEee3BOATy7lk0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bmzb0RvETDsOYZiOOsXBQqH3yMbEoPt04YduIeJncm9Zb6x975P6FolA5OO3jWzRrbvuqznhwGGev6ma+QNnUzv/xusRAoPZLigIHijMKlmBBHcm0e9BfvZA+M7g0cYo0Sz4HEJDFZ+52Y/+48b6x+xDYKKv9Zu/0Z5I6sef8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkpU8mIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkpU8mIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03151F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945407;
	bh=vto3lah5dojpAo8HTuNteVWeNwjxltR+emXW4BXp3Io=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QkpU8mIUVhZbAE8Pwqt9p2EiasUSKredAnGXQ7gW9GrhVK4oYyoQ9JYxj9gUi6HQz
	 Yx35Q+YoSFqzpqBLgJB9fnqnOnPxS5N3NIQVWIP1BG7d0KfXzH1kMv0t95LPoE9+LE
	 UJn9OM0jRKo133Y3dq7rLRhsha+xKz8MMT71EflPPPsEO+Gp/OYbHFdKCNmdifyIjt
	 NFlLidXwHxNikN2o/jIm1RuZuub3TFs0bierrm+Q5njp2G4qSHTIEgDG97AXCcsbGY
	 47RyM8bsX0Kjyn5/m7tRmXkw6WkcamNU6xK+13T/7qU9txlFKrkbulguanWHchVl+U
	 1qu0uqjQMmQKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] landlock: Rename quiet_masks to quiet_access
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-2-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:50:07 +0000
Message-Id: <20261002125007.B03151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The base stores the fs/net/scope quiet bitmasks in a struct access_masks
> field named quiet_masks.  A following commit adds the sibling struct
> permission_masks field quiet_permission for capabilities and namespaces.
> quiet_masks drops the access category and keeps the type half ("masks"),
> while quiet_permission keeps the category and drops the type half, so
> the two read as an inconsistent pair.
>=20
> Rename the base field to quiet_access, giving the symmetric,
> category-named pair quiet_access/quiet_permission that also matches the
> UAPI handled_access_*/quiet_access_* naming.  This is a
> no-functional-change rename.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Reviewed-by: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D1

