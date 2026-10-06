Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B38231829;
	Tue,  6 Oct 2026 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246467; cv=none; b=RjE9+CjeAD1scFgUNj8kobLNe8y/0KSRM0Wl9fyr66RQr2I4CMb4g5VNerdmGpJs3Z1OMExFV37G1f8KHBJ6Sy7c9QPyb9ppSk8JrytwQNwIdcuW7JmJuv0llnoUyv/qzI8Smz9fQQ74TFTS5XQW8SrE9rT5obaukR4nqwZwpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246467; c=relaxed/simple;
	bh=342BOUPMMY6rvvDMI7PlCRbszGKaNGII6epuP6m3x88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ekXX9iXxmEG2FBSDhh7AMZtWsANb3THJFcQVXGUVd6h4uatqSRBeyzI/MTYOHzQthZNjA4Kcxgv35zYJRWjfd/9OFP4fUgGc/LLvgsJwIcbcvq2BfGJa4/2O0xGArqStMbz7DPMkiGTX6oGCBJdJQ+xP0uN4IR1P1nJ+cRcMHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5wJpJj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5wJpJj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B421F000FF;
	Tue,  6 Oct 2026 00:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246465;
	bh=hfGXv8LXJ6rdswj/VrE75QTRt+5msbMwwL+FB5GeZ5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5wJpJj1PkZWCXJqH0KiDY6vykRriqLeQ52Lc/QLwCdgOa6mFuzuGK9xXiK9R7dY6
	 zZMHTzYzm2KpUIUH12Hq/G+qqDaHL/D1s3Zz0lGenog3hAw7WOXRUJQfwhUJUeHNY8
	 PaU+H+kHmWHZv5580SxO7YKKzvIAZTv+RVaPxGG/fEG1H+VYImP1vEagOU8U2gW5xf
	 mQTwaHDQ2Q1Alw+tX2gvC8CQYtPZ4LF7pJ50CRSM9emyTJF3qpun7cm3VA1A47BGem
	 s/CQAvxkUyEjcSbfIKPx5xDBHlVQLXrrWqNbidH1A9z4yNGEhnOzD/Uwtd/mV2NVWO
	 VsQR9UxYdHuJw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 03/12] landlock: convert ancestor walk to
 vfs_walk_ancestors()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261006002020.2890858-4-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-4-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:27:44 +0000
Message-Id: <20261006002745.44B421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Replace the open-coded jump_up/follow_up loop of
> is_access_to_paths_allowed() with one vfs_walk_ancestors() call, moving
> the loop state into a struct passed to the callback.
>=20
> follow_up() ignores the mount's disappearance, so a concurrent umount
> could make the walk operate on an unaccounted mount.  The walker steps
> with choose_mountpoint(), which revalidates against mount_lock.  The
> disconnected-directory handling is otherwise preserved: MNT_INTERNAL
> roots allow and stop, other disconnected roots resume at their mount
> root.  Rule evaluation is preserved exactly: disconnected roots that
> were positions of the old loop (the walk's start, the parent of a
> disconnected subtree) keep being matched against rules, while the
> disconnected mountpoints the walker newly visits on a mount crossing
> are skipped via VFS_WALK_POS_MOUNTPOINT, as the old loop never
> consulted them.
>=20
> Co-developed-by: Song Liu <song@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Closes: https://lore.kernel.org/r/20250529231018.GP2023217@ZenIV
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D3

