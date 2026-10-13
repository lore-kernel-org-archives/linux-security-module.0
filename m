Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF54F85B0
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910547; cv=none; b=qAqIxE9YjSKb4He9TM7luRyxhWXKJqw1Gek/Bn642jYbWyEX96ydp7ENZaTWs86dUuLqypxdQ8OsWeirWJiH2GkqsE40PAd6O5wY0GFgRJw7WgJnEW011TJQyyTZRU28L0AwT+EOkQgrjCy0zS5UiL+A7Lhss6dX9HaNusAt14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910547; c=relaxed/simple;
	bh=DWegPsDejOTdvJCKoRzwzHV+rYt6+8OYym74+rnMp40=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JlfrLgXIaVJReXZa/qVFi1aFDNTuMjmEGqnb7YBqJqG+mg6xzq1iSOU2nslQL3rtuTG6sraV2dDENAF1ttHekWVRUL74eKWzwWvOMxt/YbExhygIxrV36w9mWEUE6FGWgWwAK0HoIFQDWICLht+t70EexzhI2jqQ5HoNgrOVZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWBDNr2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWBDNr2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97031F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910545;
	bh=2yxa4kpMEgIbwmFRBbfMagKOXuAKqfeqjhkH5xdhM28=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YWBDNr2zBc/F9d7y1h7PW/cpfHDngb5rpySxUgln6wSI2hZS8XspfBQ+5QNCsSnk/
	 rTAQ9arglW952vr4x5RhPwfEHhXI6UE/aH6Xh4726fcvBdDhMyJ2fWWnMXoF7Kggps
	 kZL5rdxh7biywawuQuSr7xIP+l7xX91BgitWYBHFEFDAo2Uoiw/ytPX5WSGnm0YYfe
	 S0jCzv9SW2awaGf2v9/N4RxJHhHmtha0F5IqTxFzBotoWTjtc3ovbror5JE/x+jbZh
	 clsQyBV5rCtJ1OtXsz0z/xlXXta1GWuyWebvrs3xRtK+DNjWL6y5w0Lpzf8LFq5lro
	 pyOqFeK/FWOfg==
Message-ID: <sashiko-outbox-170173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 03/11] landlock: convert ancestor walk to
 vfs_walk_ancestors()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013164800.2906577-4-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <20261013164800.2906577-4-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:55:43 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013164800.2906=
577-1-utilityemal77@gmail.com?part=3D3

