Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0261C5D66
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782321; cv=none; b=dM+9foEvFIt6UQC4FzCLDKu6eSOYOEnTu/pB1KhoZrT/mGfb2b9I9EGkEfNjruRkJNU4XQmMrX5/ddb9MlSPbUneX/YGrIHJDuUYYU1KN2cCkzxqYoISir4OKTmzdpa4F3CzNqN+YeklxTikuMzjzXKZzW9nG/H/M4ri/NfjRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782321; c=relaxed/simple;
	bh=mvpUKblQy8XIPdlWHCLH8X7FWaiWEVy9c2RgcGTYsnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CE9WVDnmObm962jvwFTLXe5wTMF9wFjj6hpuNNS9zIrjUxmOo3e+D9gwG7KgYP9Ykfo9yUPV/Gn4u4kPM0hJyON4hvdgQrd5z1/OravZfv2KB2gY1JGnb1kaFMAepohwweLD1VW9Huiow8F/VwcY5UwDaFqvt0QReKviDVensFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHjLo5cX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHjLo5cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736782318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZj62Px2ZKn8iOzamvEwo+3QljL+SdLMxOZ/y0XMPLY=;
	b=IHjLo5cXfDxA0mIFvar6rgAstWjrm2N04PflT/cwv8qOkSgGWCsmyBkKkSzxsEX2WnBwMG
	li9Le3wvOYoskYH7lwh9W6weHCo2ce6UJPm+X/TqaSHPomep29RINjsXYoCPkCD664b5s8
	31LVq2zpRf0wNW3inl0KLlNjNBXQRAo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-h2FG-1E5PfmvqvSWEcXPsA-1; Mon, 13 Jan 2025 10:31:55 -0500
X-MC-Unique: h2FG-1E5PfmvqvSWEcXPsA-1
X-Mimecast-MFC-AGG-ID: h2FG-1E5PfmvqvSWEcXPsA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aaf8396f65fso435991366b.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 07:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782314; x=1737387114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZj62Px2ZKn8iOzamvEwo+3QljL+SdLMxOZ/y0XMPLY=;
        b=ccGhjKXE3NiunEHPd2XsLJRKJXYU1eLPJNpL2iFcEVyP5HEgpe0zrg5zDuYcC8AqGJ
         v0/M7hTQgv0rEWVDdq3cgfOV5zFfni5QP3B8de4YUyGVNpH2sjij2NcUSepC/ThBJG3k
         y+FrNdCwk+9SouFRXcQvNZMlgfnZztq/H363CcqPDwUxbLWPulVxlwF1RYHTnf8s1lAZ
         WuQBXmje2geRfTKfKZq3QlPcf1PDaXRsBWJL22ItFp+HtQEp/RUxg1ZSjbqaNrpurExh
         3U38FAqh7SD66V9tLR9DQFr5ERLJ6/wn/cWu5Gk8FCUdtXsFiPn87oDZVUrcRcvL1L+E
         OB8A==
X-Forwarded-Encrypted: i=1; AJvYcCXvc6xWxel5+AqXuJyLl0dh9KalpTagh0IOsZd80lTg8q00D8c6aD5nQ4kgBLAvqIQD+Pl+nkT8wC/eHlUxXVZLvGk/lts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTA/Vhsqwl5M+TeDqVKt6av5GBtNhWxOQdpP+YaQQXddYbTmP
	C1yzC7emvsSu+uVSSFJ7ucRFssG+T48CchAuySRoYyy9eMidvpgQgvg/HXRyNLZTNHEGaN2XfgP
	hUYXpaf5gJ/HE8M1uiFEjpcNW4JwXRVB+VRY5DGQOfajIMwsAAdjeCTPR0xOPbj+VmKx6h1cO
X-Gm-Gg: ASbGnct0CE3gzHO2GPFn4SskaLX0vrUjw2BFM14GestQaRNKcASMEJkaHDwWsLjkAML
	a2CWLU0w2Dmq0cAWPSPnhcL1XY88e7etbvHmAkHW2d9shiyV+OtBbULmb/Jr85/i/N9j0xrTB17
	aH1r0Or0lPiQKh+uoHg8TOOUa+tCWQZnR7BUYuKsHdJvFbz4eeCeCTFpzXZaKA3/cNH9RvHK2zX
	JW/iUdS6wLxV+f80P5v6A4J0j9oDdSXeV6pHGyYYO4wDEF8gzt6GnIBn6T/DfrLtDk4j1Ga10sp
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-ab2ab6f3455mr1962694066b.27.1736782313726;
        Mon, 13 Jan 2025 07:31:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN9M8ywOrQBK6gF/5ntK43MmcNBbwRSFgySYURvnN/eomPTMHRMQ8vdhj//eDu8N4Cy9JGfg==
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-ab2ab6f3455mr1962689566b.27.1736782313218;
        Mon, 13 Jan 2025 07:31:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060b9dsm516473166b.4.2025.01.13.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:31:52 -0800 (PST)
Date: Mon, 13 Jan 2025 16:31:50 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	monstr@monstr.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, arnd@arndb.de, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <cwz2kun2mm55um3hycrd4mkxrgm43zorty5kdxacksmseo34n3@dc3bd4x6cibd>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hAvFjSqy21azHCVuZ10C8jNvsgmGiqdSXAqstNJ3BPM_1736782314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2025-01-13 12:19:36, Jan Kara wrote:
> On Thu 09-01-25 18:45:40, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory FD and
> > path to the child together with struct fsxattr.
> > 
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open. By having this we can manipulated
> > inode extended attributes not only on normal files but also on
> > special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
> > opening special files returns VFS special inode instead of
> > underlying filesystem one.
> > 
> > This patch adds two new syscalls which allows userspace to set
> > extended inode attributes on special files by using parent directory
> > to open FS inode.
> > 
> > Also, as vfs_fileattr_set() is now will be called on special files
> > too, let's forbid any other attributes except projid and nextents
> > (symlink can have an extent).
> > 
> > CC: linux-api@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Couple of comments below:
> 
> > @@ -2953,3 +2956,105 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >  	return mode & ~S_ISGID;
> >  }
> >  EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr *, fsx, int, at_flags)
> 				       ^^^ at_flags should be probably
> unsigned - at least they seem to be for other syscalls.

sure

> 
> > +{
> > +	struct fd dir;
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	struct inode *inode;
> > +	int error;
> > +
> > +	if (at_flags)
> > +		return -EINVAL;
> 
> Shouldn't we support basic path resolve flags like AT_SYMLINK_NOFOLLOW or
> AT_EMPTY_PATH? I didn't put too much thought to this but intuitively I'd say
> we should follow what path_setxattrat() does.

Hmm, yeah, you are right these two can be passed. I thought about
setting AT_SYMLINK_NOFOLLOW by default (which is also missing here),
but adding allowing passing these seems to be fine.

> 
> > +
> > +	if (!capable(CAP_FOWNER))
> > +		return -EPERM;
> 
> Why? Firstly this does not handle user namespaces at all, secondly it
> doesn't match the check done during ioctl, and thirdly vfs_fileattr_get()
> should do all the needed checks?

Sorry, miss-understood how this works, I will remove this from both
get/set. get*() doesn't need it and set*() checks capabilities in
vfs_fileattr_set(). Thanks!

> 
> > +
> > +	dir = fdget(dfd);
> > +	if (!fd_file(dir))
> > +		return -EBADF;
> > +
> > +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> > +		error = -EBADF;
> > +		goto out;
> > +	}
> > +
> > +	error = user_path_at(dfd, filename, at_flags, &filepath);
> > +	if (error)
> > +		goto out;
> 
> I guess this is OK for now but allowing full flexibility of the "_at"
> syscall (e.g. like setxattrat() does) would be preferred. Mostly so that
> userspace programmer doesn't have to read manpage in detail and think
> whether the particular combination of path arguments is supported by a
> particular syscall. Admittedly VFS could make this a bit simpler. Currently
> the boilerplate code that's needed in path_setxattrat() &
> filename_setxattr() / file_setxattr() is offputting.
> 
> > +
> > +	inode = filepath.dentry->d_inode;
> > +	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
> > +		error = -EBADF;
> > +		goto out_path;
> > +	}
> 
> What's the motivation for this check?

This was one of the comments on the ioctl() patch, that it doesn't
make much sense to allow ioctl() to be called over different
filesystems. But for syscall this is probably make less sense to
restrict it like that. I will drop it.

> 
> > +
> > +	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (error)
> > +		goto out_path;
> > +
> > +	if (copy_fsxattr_to_user(&fa, fsx))
> > +		error = -EFAULT;
> > +
> > +out_path:
> > +	path_put(&filepath);
> > +out:
> > +	fdput(dir);
> > +	return error;
> > +}
> > +
> > +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr *, fsx, int, at_flags)
> > +{
> 
> Same comments as for getfsxattrat() apply here as well.
> 
> > -static int copy_fsxattr_from_user(struct fileattr *fa,
> > -				  struct fsxattr __user *ufa)
> > +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
> >  {
> >  	struct fsxattr xfa;
> >  
> > @@ -574,6 +573,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL(copy_fsxattr_from_user);
> 
> I guess no need to export this function? The code you call it from cannot
> be compiled as a module.

Yes, that's true, I added this because copy_fsxattr_to_user() also
is exported (same as many other functions). I will drop this.

-- 
- Andrey

