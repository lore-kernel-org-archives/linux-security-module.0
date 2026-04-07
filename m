Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22058242D89
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582115; cv=none; b=PsuwhLsn1XhDFryy8rNM6oi4TGilnUMfyJ67K8OxsNhALvtSZzVL9zJnKFtK48FfYXqkYyFih5b6WHusA7VO9BpmslrakEEG6nUs94XyLP5jbPYnRQk8n7hJSWwGc94zR5RjlCLkrjp5Y8Kgf3uhMKyIoLJioXnXbAAZmCnsajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582115; c=relaxed/simple;
	bh=ZoiuaxvRMnnvMQ94KYGxiZVLxEX4KuCYeoIZ0YeAXzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WyuN0DYbbpcl7hNaWbYZJzQ7Fe6H7QPISL5vQSzTo0ULupNHlwRdbrAdylb+1Jtu15ZCCulVxZXXuOTiL1IHmOWmUO1Tsw47DYgNlp4GUO27BNwy77sU+dOMlYjb5Y+MudypViTHormVzaLkbbiHcEfvRqQZ8mZvWdD3hVEKhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=QozEMSx+; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="QozEMSx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1775582105; bh=ZoiuaxvRMnnvMQ94KYGxiZVLxEX4KuCYeoIZ0YeAXzY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QozEMSx+0h2qgkTfI0tM7vIlGcfU7fyBiTz6guGbM9blWHf8L+5TkRC38xKvAWjNr
	 pniNEHyTdRHVDBEFsnnVLmLgKeritm0omZL7jUsno7F0eQH99jbY+fIZhFAWsoZs+6
	 jAu8ESCo0xRWG+qoHHVnDgLdJUCHJwNtrv/yK8WXefcsxD7meiug14wxZhimCJoc92
	 CA/tILh/kPVub1JzJV91zUbFVrKPHLYgZZ7BlJKjhq82sW/3cjZsbtwUTNG0fY8B8l
	 JIsjXKmDeybAQgp7ojaqLaNDlNmUHp4WvBGMWeMVw5LLW/yMhcDc0ktA1sDBtyPgD0
	 0g76e2jDU9Rlg==
Received: from dummy.faircode.eu (96-8-138-239.block0.gvtc.com [96.8.138.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 5E5D078C;
	Tue,  7 Apr 2026 12:15:04 -0500 (CDT)
Date: Tue, 7 Apr 2026 12:15:00 -0500
From: Serge Hallyn <serge@hallyn.com>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Message-ID: <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
In-Reply-To: <adUBCQXrt7kmgqJT@google.com>
References: <adUBCQXrt7kmgqJT@google.com>
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>

Apr 7, 2026 08:05:43 G=C3=BCnther Noack <gnoack@google.com>:

> Hello Christian, Paul, Micka=C3=ABl and LSM maintainers!
>
> I discovered the following bug in Landlock, which potentially also
> affects other LSMs:
>
> With renameat2(2)'s RENAME_WHITEOUT flag, it is possible to create a
> "whiteout object" at the source of the rename.=C2=A0 Whiteout objects are
> character devices with major/minor (0, 0) -- these devices are not
> bound to any driver, so they are harmless, but still, the creation of
> these files can sidestep the LANDLOCK_ACCESS_FS_MAKE_CHAR access right
> in Landlock.
>
>
> I am unconvinced which is the right fix here -- do you have an opinion
> on this from the VFS/LSM side?
>
>
> Option 1: Make filesystems call security_path_mknod() during RENAME_WHITE=
OUT?
>
> Do it in the VFS rename hook.
>
> * Pro: Fixes it for all LSMs
> * Con: Call would have to be done in multiple filesystems
>
>
> Option 2: Handle it in security_{path,inode}_rename()
>
> Make Landlock handle it in security_inode_rename() by looking for the
> RENAME_WHITEOUT flag.
>
> * Con: Operation should only be denied if the file system even
> =C2=A0 implements RENAME_WHITEOUT, and we would have to maintain a list o=
f
> =C2=A0 affected filesystems for that.=C2=A0 (That feels like solving it a=
t the
> =C2=A0 wrong layer of abstraction.)
> * Con: Unclear whether other LSMs need a similar fix
>
>
> Option 3: Declare that this is working as intended?

Option 3 has my vote.


> * Pro: (0, 0) is not a "real" character device
>
>
> In cases 1 and 2, we'd likely need to double check that we are not
> breaking existing scenarios involving OverlayFS, by suddenly requiring
> a more lax policy for creating character devices on these directories.
>
> Please let me know what you think.=C2=A0 I'm specifically interested in:
>
> 1. Christian: What is the appropriate way to do this VFS wise?
> 2. LSM maintainers: Is this a bug that affects other LSMs as well?
>
> Thanks,
> =E2=80=94G=C3=BCnther
>
> P.S.: For full transparency, I found this bug by pointing Google
> Gemini at the Landlock codebase.

