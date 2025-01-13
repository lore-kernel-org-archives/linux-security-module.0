Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7922BAAA;
	Mon, 13 Jan 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780571; cv=none; b=k1MIykRoW2IVto38jFLjYKGOTp+Wk3QEf0Wze7+XhJX9mpfbE5z1s7V7TtS4Nr1pwwYAQp3YAtlUHfftCt33aVP2NDVKb9xMnPjqA1Xh/6XE0JngNzKhD0Z1cmFddlaTyzI9pOFGj6gMYlk69hhjuQlP64al5lL4Oe5KX2K9YwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780571; c=relaxed/simple;
	bh=MaGsxomNBHHrrTHz7LE/zBpGdKbsctMyqqWr9LLnNdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO5LFIFr51gzYykK0lje3pkLW2rM6/ResaMdCf/wFAk3ASy0sHUYY2NfCbl0SB2uzFu5n7LYtrN5zEJ84ypeu+1iVLwcDuAAMZQMpDvCsoxehEZmMsorW/WbO+NPP+kFPvnqW6rkhY0NbcvJ8iYkvTvc4rs6rtCYlUAa5trCitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnjCG0OY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnjCG0OY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E6C4CEE3;
	Mon, 13 Jan 2025 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780571;
	bh=MaGsxomNBHHrrTHz7LE/zBpGdKbsctMyqqWr9LLnNdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnjCG0OYiDS6IdDOwP/ICtkK4ynuIu2NNBu1vJbuzuSdqKJ8OzSXEaI6XJt/xSGwL
	 7SN4/bDAnDcZ3z0nFpTzqk8sfkSYQQZvr/kwKVI/48RizsGfeEExj7OpdyFOZnaMTc
	 occp4oYoJ+E/pVqkKqiS3RB2TnzKqRt3pIpS/0fr2M4JEC+49fZkHXW+SiBJ3hfHVy
	 ScK03+8p6nIbDb9NeViSN8iY+fafF8PJPNTNEMCOTWgCn5GzdIQXeG1+iPTO0EKJ+u
	 6tKvZhP+elz7BObTOwpClyReFJzJELq1ce9fatx8kkAhbrSNADKwEg28m749pBRke9
	 X61LWqoM+xTnw==
Date: Mon, 13 Jan 2025 16:02:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY
 rule type
Message-ID: <20250113-zeitraffer-gewachsen-fa9a69868c70@brauner>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-29-mic@digikod.net>
 <CAG48ez3oTpoVH=en8yAwS2u=kuyh8rKqPQFjDCe_Muh7N9E_Tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3oTpoVH=en8yAwS2u=kuyh8rKqPQFjDCe_Muh7N9E_Tg@mail.gmail.com>

On Mon, Jan 13, 2025 at 03:55:42PM +0100, Jann Horn wrote:
> +Christian and Al Viro to double-check what I'm saying
> 
> On Wed, Jan 8, 2025 at 4:44 PM Mickaël Salaün <mic@digikod.net> wrote:
> > -static const void *get_current_exe(const char **path_str, size_t *path_size)
> > +static const void *get_current_exe(const char **path_str, size_t *path_size,
> > +                                  struct inode **inode)
> >  {
> >         struct mm_struct *mm = current->mm;
> >         struct file *file __free(fput) = NULL;
> > @@ -93,6 +96,8 @@ static const void *get_current_exe(const char **path_str, size_t *path_size)
> >
> >         *path_size = size;
> >         *path_str = path;
> > +       ihold(file_inode(file));
> > +       *inode = file_inode(file);
> >         return no_free_ptr(buffer);
> >  }
> 
> This looks unsafe: Once the reference to the file has been dropped

s/looks/is/g

> (which happens implicitly on return from get_current_exe()), nothing
> holds a reference on the mount point or superblock anymore (the file
> was previously holding a reference to the mount point through
> ->f_path.mnt), and so the superblock can be torn down and freed. But
> the reference to the inode lives longer and is only cleaned up on
> return from the caller get_current_details().
> 
> So I think this code can hit the error check for "Busy inodes after
> unmount" in generic_shutdown_super(), which indicates that in theory,
> use-after-free can occur.

Yep, it sure would.

> 
> For context, here are two older kernel security issues that also
> involved superblock UAF due to assuming that it's possible to just
> hold refcounted references to inodes:
> 
> https://project-zero.issues.chromium.org/42451116
> https://project-zero.issues.chromium.org/379667898
> 
> For fixing this, one option would be to copy the entire "struct path"
> (which holds references on both the mount point and the inode) instead
> of just copying the inode pointer.

path_get() indeed
