Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6579236453;
	Tue,  6 Oct 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246654; cv=none; b=oFSF2M8mP5fNLtcMFLwFoZkVVN23gLE98h1MZ8AIcaX44mNsCN1ksu7XPbWBfAuHAgYHc26l+r56NbZZuknyiFHk6PFxx352q/aOdTcxghi5dAxyQZVS5sqmIpsAyboHK7RcF/DljpgZcEaVyyCOFlwGEvvUpVfUvQ8qgmVRlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246654; c=relaxed/simple;
	bh=peaKXlBQYsttONvHvhfaJczDSd66fHeLgYOga/DRXjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/Qq/XVuwnBFlTVzJynkJB8oHkVhS6pSJPHe5ZoYwFOO+2985KftFUl/SzY0l1nRSSTD/z81fQh8MhtTSXrqweojntX+oHIdh9tAFh3lDPbswTGTMvnypFRrtYRAh+cpGsvILzDIL2wkX1eeJ4q2BDG78YgUGPnmrjjSGgeC3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl/QlOK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl/QlOK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C65C1F000FF;
	Tue,  6 Oct 2026 00:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246653;
	bh=kpr3oMC8kT/cWh3M7z5CTUW+3QLwpLTIcBZd+X8L9Q0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kl/QlOK1cQXF+f6niUKvLpQI0CTLJVM6mZLH2217p1k0yZwNsUCavYqdVaUdX6XtA
	 73TVIX5gvyOmufSlD5z8yMn9uirPSqdZkyolBKMq3DCRax9SiygKVT9nHZ8EtMcNfR
	 FH68pR0yiAqAG7HsO8mi/PrbNVAh85DEkmcjpDvelQp0ZYcmkbrGUFiZuWzQoNAR2Z
	 eV/0qDxED6LC7jusTMXacon5LPkMKgeIfC8rBch+EldNLL25A23PAjkSUK4LFuvOvs
	 P5ORDzGrL64O98XRNgd+TgGIqwxBYIRrcdFfKRWWnSps1dngukeMVPfih3KmOCKUKH
	 twiouAavF0qcQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 02/12] namei: add vfs_walk_ancestors()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261006002020.2890858-3-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:30:52 +0000
Message-Id: <20261006003053.1C65C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add a callback-based walk over a path and its ancestors, built on
> __path_walk_parent(): the kernel owns the loop and the callback must
> not sleep, so an rcu-walk engine can be added later without changing
> the API.
>=20
> Disconnected root dentries are reported to the callback instead of
> terminating the walk; continuing over one resumes at the root of its
> mount.  A disconnected mountpoint landed on by a mount crossing - the
> one position this walk visits that a dget_parent()/follow_up() loop
> never does - is additionally flagged VFS_WALK_POS_MOUNTPOINT, so
> security callers can reproduce their pre-conversion evaluation
> sequence exactly.
>=20
> Suggested-by: NeilBrown <neil@brown.name>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D2

