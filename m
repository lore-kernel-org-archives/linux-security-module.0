Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048242C11FA
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174612; cv=none; b=bzzkgylSBqwUakQthgwFVwR1hFVYXCsMmpoZRPyDOFlKnyufEjzSKvqNYODcQplBF+WNTxd8jlAvll29lBJ+wj4TSNf3Y1AwgfZAwQLUwUYbpQb9tbM92yjMOMXleEL/q2lLQp2/T1ZsHPp2OrCqB12+vvhlGr5JdO4PX+LCHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174612; c=relaxed/simple;
	bh=GWY8aYWhNeSJBn1xDUJnUsRFAhOBaXiD1sXJ0m3yf20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkPL+VwkGqbe7Zs4sls/j09pIsEw6zyOHEzFumSXTyIUniueEXLdSeGOFcMvRiWtzFap6JhrMbFO6wKQBLyDSpiyICKH8APr+wCOseZGE3ZnfORMelrMF7sF1grnHxBlipIH1xM5bUYgnuhuk/XsvJAjuBLEm3vlxaZw29zeG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PBjJTQrz; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PBjJTQrz"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fw57L2cTczNZH;
	Tue, 14 Apr 2026 15:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1776174158;
	bh=Hheu6xMRjCuyZb7FDJGhjQIfajggJ44e+hm+U0MAzAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBjJTQrz9VeBlQCMxWieLRVLPcACE+xhGWjiAPsTOxQ4L+IYEWjk/4p2uXnXgm0Yi
	 z3IWuizAHuzP+Ga/qMuIWIMWgnWRUntxKtLKPKfHf4rgO1JNPg8DD9NnQxrJsnjwiS
	 SfsqtTYpowwVNgOabPZLfAASxjZ3wLaesWUm69Gg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fw57K5c1Nzfp5;
	Tue, 14 Apr 2026 15:42:37 +0200 (CEST)
Date: Tue, 14 Apr 2026 15:42:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <20260414.gailoogieGh0@digikod.net>
References: <adUBCQXrt7kmgqJT@google.com>
 <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
 <20260409-entbrennen-turnschuh-54af9b45610e@brauner>
 <adoIGHwgMJSuRfE5@google.com>
 <CAJfpegv6GDFZjdGrQ=0Jahvz5mSgfJr+GvjVwws=SFX-yirpSg@mail.gmail.com>
 <adzgKVIhRj5t3GqM@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adzgKVIhRj5t3GqM@google.com>
X-Infomaniak-Routing: alpha

On Mon, Apr 13, 2026 at 02:23:05PM +0200, Günther Noack wrote:
> On Mon, Apr 13, 2026 at 12:18:08PM +0200, Miklos Szeredi wrote:
> > On Sat, 11 Apr 2026 at 10:36, Günther Noack <gnoack@google.com> wrote:
> > > I also don't currently see how an attacker would abuse this, but I still see
> > > this as a violation of Landlock's security model if we can create a policy that
> > > denies the creation of character device directory entries, and then we still
> > > have a way to make them appear there where we previously had a different file.
> > 
> > Look: a whiteout is a whiteout, NOT a character device.  Don't let the
> > fact that it's represented by "c 0 0" fool you, this is a completely
> > different beast.  See commit a3c751a50fe6 ("vfs: allow unprivileged
> > whiteout creation").
> > 
> > Does this beast need special handling by LSMs?  I have no idea, but
> > treating them the same as char devs sounds like a bad idea.
> 
> Thanks for the pointer to that commit.  I was under the impression
> that creation of the whiteout objects required CAP_MKNOD, but it seems
> you have dropped that requirement in that commit.
> 
> (FWIW, I was mislead by the rename(2) man page[1], which is apparently
> not up to date and where it explicitly says:
> 
>     RENAME_WHITEOUT requires the same privileges as creating a
>     device node (i.e., the CAP_MKNOD capability).
> 
> So with that assumption, it seemed natural that this should have
> extended equivalently into a Landlock policy.)

I agree with Miklos and also pointed out to this commit:
https://lore.kernel.org/all/20260408.beu1Eing5aFo@digikod.net/

> 
> So if the "c 0 0" whiteout device is indeed a different kind of file,
> maybe we would need to treat it with a separate Landlock access right
> after all then.  I'll ponder it.

What is sure is that we should not treat it like character devices,
which required special capabilities/permissions because they are a door
to a driver interface.

> 
> FWIW, besides introducing a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
> access right and adding more special cases to the Landlock API,

> another possible option might be to just forbid creating whiteout
> objects altogether, when under a Landlock policy.

This doesn't feel right.  Mount operations restriction are there because
Landlock currently cannot properly control mount operations yet (see
https://github.com/landlock-lsm/linux/issues/14).

> As the man page
> also notes, "This operation makes sense only for overlay/union
> filesystem implementations",

The man pages contain at least one important error wrt this feature, so
we should only trust the kernel code.  Anyway, anyone can create a
whiteout with mknod, so let's consider that there are other use cases.

> and since these likely can't use Landlock
> anyway due to mounting, I think there would be no use case left where
> anyone would want to perform such an operation within a Landlock
> domain -- I don't think this would break anyone.  Mickaël, do you have
> an opinion on that idea?

The LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right makes sense wrt other MAKE_*
rights (i.e. per file type).  See may detailed reply here:
https://lore.kernel.org/r/20260414.Lae5ida1eeGh@digikod.net

BTW, I don't understand why only the renameat2(2) syscall can
(indirectly) create this file type; why not also unlink(2) or rmdir(2)?

> 
> —Günther
> 
> P.S. Initial patch set from Saturday is at [2], but this still uses
> the LANDLOCK_ACCESS_FS_MAKE_CHAR right.
> 
> [1] https://man7.org/linux/man-pages/man2/rename.2.html
> [2] https://lore.kernel.org/all/20260411090944.3131168-2-gnoack@google.com/
> 
