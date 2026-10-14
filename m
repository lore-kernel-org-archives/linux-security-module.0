Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125138D686
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011508; cv=none; b=YHDaozUbYL4FFj2K4vdH+IQO8yAoxU7SomzCjSIKlL+AIr2bRFyqoCBOC0TtzElaN5ScLz3mGN+ZoweQjQDb32dTDcOqInTAbmH6XChO8t+QyvPn8hGwRQZ5xTh79ZYs+pVN8vC3ElltlWS3BpHA/jLVk1aBcYrDyuY9RSSYTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011508; c=relaxed/simple;
	bh=VsBsBX9xPiUJyQZ+ZPNy5rj+Via0wDIUXNqN8zRrtxw=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y3/TtAvvFzoZzgPGQEWC8OF3DCRCPUMwKGNvzsxVC7tKGzjx9Q/XX5OViI9tnuCNYMR3SnPjNqSdMo9+OJErEqV8cc6J8NhNZAUC5vODW2l/lNXp7raIO//6V+RldWusNfnIhsAz3UjoVJt76q91OFGYwyShabEUd141kzODCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8Fbe7qD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8Fbe7qD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749651F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011506;
	bh=JXLvgaxQz9PrGd4QuuiWdbbTAwbKugPSeOn1R0QUl/M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=P8Fbe7qDZB/C9n3XGfXmj7rtRzgmOtbx5UNxB/MGtZEY8m6F1Yl8abC5aTqIdHYll
	 18OfblRtT9eO6jqPP/cdHAxFvqw6csDrd9dABxCfihmGapLVdq/FcUXMxm6m897meB
	 5iuf5Xpvrz6KEEMDQnnenYjtvXDygddHaxGrCAShTt3xcrd53VdWuC4sZ5ezC0e5dP
	 slZGkLT4M1bFVBzR2ZfiC0JL7JaaHrLP/dLaE2y4uWz8sTVjCumNHxmklEDsXb0W5e
	 Mswjrcj2rwuzJ6qibJeQOXKXrmY5+V6d4NbTvhcFBHQkYKF//mAHmvjDeuXxHlFVXJ
	 oFfVgAYFQvEWQ==
Message-ID: <sashiko-outbox-171918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014-b4-setfcap-userns-v2-3-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-3-fac4d19281d7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:58:26 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> verify_root_map() looks at the cred that opened the map file: it asks
> whether it has CAP_SETFCAP over the parent, or, for an opener inside the
> namespace, whether the creator had.  Two things are missing.
>=20
> The writer isn't checked.  For every other privileged mapping
> new_idmap_permitted() wants the capability from the opener and from the
> task that calls write(), but a map that consists of the single line
> "0 0 1" takes the unprivileged branch, where only the opener's euid
> counts.  So an open uid_map file is a token for mapping uid 0:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   fd =3D open("/proc/<pid>/uid_map")
>   B gets fd by inheritance
>   or SCM_RIGHTS
>                                     write(fd, "0 0 1")
> [ ... ]
> on, now fail with -EPERM.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-setfcap=
-userns-v2-0-fac4d19281d7@toxicpanda.com?part=3D3

