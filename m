Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FD217723
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174080; cv=none; b=DQrvWhCO7CVpQ82vcyKUdkookcRGdh9QFqaahHbVyK+Cc1DgEybP3i7EDe8a4X+tA1Ia1+vJuD4tWJ9ygBPGfVeMiaiTha6GvXJS3rSaE58V1U2U/2Uwj6US4GvRuqQ4FaqYLcaDF+a5BXo4uqZQWXAKFRVGyoSvzS5rBvGlsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174080; c=relaxed/simple;
	bh=KwFN08rCGo730yCyPg6XGv/ZyNBKyJ5YOKNOYZhfr4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdlIz1A73N1FtEHbrI+xg31auZy4g7VNvCng5onw59gfjY8z7dg6SvUbysdQoiNsFOtAgiIavGSG4f9DHzVWW63pFsLda0PDhHsRyUZqPp7EWJog4e6ZS8QpU1rdV7VAQR2k452zudf+2hdxP7nbDhKAK+0VnrGhKmhno6zA/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OJoJKTnl; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OJoJKTnl"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fw55b2YHfz2Tf;
	Tue, 14 Apr 2026 15:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1776174067;
	bh=VGxM23V9y2uxjrCfhg8JQZRmLfzT9sZuky6Ein29IhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJoJKTnlT/D//6Ky+VYQBBr57GTXwKgf9E1lGZu4B9xlt2suq9mOXPVSSj33giiuV
	 2ENoM++xhBgbppDg2CPpAoMEdOW0rl8bse+q1Uo3qV55+jzYZbfT5KEaJtriNc3wqm
	 tYFI08KPD3/USLgTy/MjD3oYJ+tjyJz2ywaMIYQA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fw55Z2D6nzjhv;
	Tue, 14 Apr 2026 15:41:06 +0200 (CEST)
Date: Tue, 14 Apr 2026 15:40:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH 0/3] landlock: Restrict renameat2 with RENAME_WHITEOUT
Message-ID: <20260414.Lae5ida1eeGh@digikod.net>
References: <20260411090944.3131168-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260411090944.3131168-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

Thanks for bringing this up.

By default, creating whiteout files is not privileged e.g.,
mknod whiteout c 0 0 is allowed for unprivileged users.  Landlock should
follow this semantic.  So there are two issues:
1. LANDLOCK_ACCESS_FS_MAKE_CHAR should not apply for whiteouts.
2. Whiteouts creation should be controllable by Landlock (e.g. through
mknod and renameat2).

I see four options:

1. Consider whiteouts as regular files and make them handled by
   LANDLOCK_ACCESS_FS_MAKE_REG.  This would require an erratum and would
   make sense for direct mknod calls, but it would be weird for
   renameat2 calls than move a file and should only require
   LANDLOCK_ACCESS_FS_REMOVE_FILE from the user point of view.

2. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right to handle whitout
   creation (direct and indirect?) and keep LANDLOCK_ACCESS_FS_MAKE_CHAR
   handle direct whiteout creation (and don't backport anything).  It
   looks inconsistent from an access control point of view.

3. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and, when handled,
   make LANDLOCK_ACCESS_FS_MAKE_CHAR not handle whiteout.  This would be
   a bit weird from a kernel point of view but it should work well for
   users while still forbidding direct whiteout creation.

4. Add a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right and make
   LANDLOCK_ACCESS_FS_MAKE_CHAR never handle whiteout (and backport
   MAKE_CHAR fix with an errata).  This would be consistent but backport
   a way to directly create whiteouts (e.g. with mknod).

I think option 3 is the more pragmatic.  Landlock should properly log
the right blocker wrt handled access rights though.


On Sat, Apr 11, 2026 at 11:09:42AM +0200, Günther Noack wrote:
> Hello!
> 
> As discussed in [1], the renameat2() syscall's RENAME_WHITEOUT flag allows
> the creation of chardev directory entries with major=minor=0 as "whiteout
> objects" in the location of the rename source file [2].
> 
> This functionality is available even without having any OverlayFS mounted
> and can be invoked with the regular renameat2(2) syscall [3].
> 
> 
> Motivation
> ==========
> 
> The RENAME_WHITEOUT flag side-steps Landlock's LANDLOCK_ACCESS_FS_MAKE_CHAR
> right, which is designed to restrict the creation of chardev device files.
> 
> This patch set fixes that by adding a check in Landlock's path_rename hook.
> 
> 
> Tradeoffs considered in the implementation
> ==========================================
> 
> Q: Should we guard it with a dedicated LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
>    right?
> 
>    Pros:
>    * This would be the fully backwards compatible solution,
>      and Linux always strives for full backward compatibility.
> 
>    Cons:
>    * Complicates the Landlock API surface for a very minor use case.
> 
>      In Debian Code search, the only use of RENAME_WHITEOUT from userspace
>      seems to be for fuse-overlayfs.  It is used there for the same purpose
>      as in the kernel OverlayFS and it likely does not run in a Landlock
>      domain.
> 
>    The tradeoff does not seem worth it to me.  The chances that we break
>    anyone with this seem very low, and I'm inclined to treat it as a bugfix
>    for the existing LANDLOCK_ACCESS_FS_MAKE_CHAR right.
> 
> 
> Q: Should we add a Landlock erratum for this?
> 
>    I punted on it for now, but we can do it if needed.
> 
> Q: Should the access right check be merged into the longer
>    current_check_refer_path() function?
> 
>    I am leaning towards keeping it as a special case earlier.  This means
>    that we traverse the source path twice, but as we have seen in Debian
>    Code Search, there are apparently no legitimate callers of renameat2()
>    with RENAME_WHITEOUT who are calling this from within a Landlock domain.
>    (fuse-overlayfs is legitimate, but is not landlocked)
> 
>    It doesn't seem worth complicating our common rename code for a corner
>    case that doesn't happen in practice.
> 
> 
> [1] https://lore.kernel.org/all/adUBCQXrt7kmgqJT@google.com/
> [2] https://docs.kernel.org/filesystems/overlayfs.html#whiteouts-and-opaque-directories
> [3] https://man7.org/linux/man-pages/man2/renameat2.2.html#DESCRIPTION
> [4] https://codesearch.debian.net/search?q=rename.*RENAME_WHITEOUT&literal=0
> 
> 
> Günther Noack (3):
>   landlock: Require LANDLOCK_ACCESS_FS_MAKE_CHAR for RENAME_WHITEOUT
>   selftests/landlock: Add test for RENAME_WHITEOUT denial
>   selftests/landlock: Test OverlayFS renames w/o
>     LANDLOCK_ACCESS_FS_MAKE_CHAR
> 
>  security/landlock/fs.c                     | 16 ++++++++
>  tools/testing/selftests/landlock/fs_test.c | 45 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> -- 
> 2.54.0.rc0.605.g598a273b03-goog
> 
> 
