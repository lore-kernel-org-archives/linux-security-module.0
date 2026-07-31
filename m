Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E20403AFA
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503615; cv=none; b=DwHN3zultkrmd1tlBAL7fcRXzMQy4gyq51EdIAYTf2vzG1SGDD+tFSTYhUkQtDDkgHZV7U7O1tu8fqpKp0kwqZXjQqdxNRdQno0p7GmH/9netdIwwiFU6+Jga2NfY159KnQ4tMHKFGn9NExhWnXhK/PpMBl3+fyS0Hd3YnKUpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503615; c=relaxed/simple;
	bh=FlJEL9/xJssOOxVhQ83IxWodhrw8NIZbo+j1rcXS9qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc2SqGYVAOEKFZniWn0Et1BepaMSFJ8yLCmgSFeiEn/31uC+KVIRY6Wun/kec2O+AaE2yXcloEWZHi2RhTM/ko4tMmAfOH3IzrnWvAVKuHDYNQRwc5v0l13HyamVCu0Dnx0LGVoLNbQJ3ktTo5ii1zMstocy5rybDIPF04aBtwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Tj0MEYAp; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Tj0MEYAp"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBRMt1wkBzpds;
	Fri, 31 Jul 2026 15:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785503610;
	bh=/Ik0g7hBDvZGrPHFGj2apDy3azY7HlidIDrjnDKTkDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tj0MEYAp9Dy4qaI9mpBW60teIBdht0OUTtGLLmcrmmrEoQ3t9cWuXOj9oh0JlAjwM
	 Z6TeBtG0jInvz8uOrK8a5NJsb7gM5EFvcfuMgsCqF1QADEEus+LhaqEorxJezOmpgz
	 P8aRV3AKH56eOhf4UVjHe93L5xP10jPhzMka7ePY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBRMs2Mbszbvy;
	Fri, 31 Jul 2026 15:13:29 +0200 (CEST)
Date: Fri, 31 Jul 2026 15:13:24 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260731.xieh7eiR8ooD@digikod.net>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724161004.2360749-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 24, 2026 at 06:10:01PM +0200, Günther Noack wrote:
> Whiteout files are used in the upper layer of an Overlayfs to indicate
> that the file with this name does not exist in the unified view, even
> if it is present in one of the lower layer file systems.
> 
> For userspace implementations of Overlay file systems (fuse-overlayfs),
> whiteout files can be created from userspace as well:
> 
> * mknod(2) with S_IFCHR and makedev(0, 0)
> * renameat2(2) with RENAME_WHITEOUT,
>   creating the whiteout in the old place of the moved file.
> 
> This commit guards whiteout creation in both of these cases with
> LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout files are *not* considered
> character devices and are not bound to a driver.
> 
> Before this commit, renameat2(2) with RENAME_WHITEOUT would create a
> directory entry even when all LANDLOCK_ACCESS_FS_MAKE_* rights are
> denied.
> 
> This does not affect normal renames within layered OverlayFS mounts:
> When doing a regular rename() on a mounted fuse-overlayfs, it is the
> fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITEOUT,
> and only the Landlock domain of that daemon is checked there.
> 
> This also adds a Landlock erratum for that case.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Mickaël Salaün <mic@digikod.net>

Cc: stable@vger.kernel.org

> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")

Depends-on: 49c9e09d9610 ("landlock: Fix handling of disconnected directories")
Depends-on: fe72ce6710cb ("landlock: Add errata documentation section")

> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h    |  1 +
>  security/landlock/errata/abi-1.h | 26 ++++++++++++++++++++++++++
>  security/landlock/fs.c           | 31 ++++++++++++++++++++++++-------
>  3 files changed, 51 insertions(+), 7 deletions(-)
