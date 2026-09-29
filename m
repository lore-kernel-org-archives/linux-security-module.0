Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB951D525
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683974; cv=none; b=In7RMx3JWmNdTv6r2cuUuam9P4R8L8Uk6LMPfKQGo8cdVxepwhYKZOnFir44IugmC9aVcwA7CMhKHUf84zctXQLwFfFGIms55pPpbtLDYorI8ACD4kQ3s/+GAFySpLF+ZPxdBAQVYbhfUsqv1BTh8XEoewEM2Bl6FVOmNEAi0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683974; c=relaxed/simple;
	bh=aOHR2S9JoDTNHa4EinckRR5sM8LP9tsgVirzxTuKr0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RABLvqygCtd48XiFNkx1lJen1hWyMC5aonsJIECCO9mb9vsjtGAqHNgOV57q2idQHA2ERjU5DXUMQWr0n67uiz3/HMdBED3yad+ooQkagA28w9IhPcQaNSwXGpg2Wpx12fO/Pm7it1j6FVjMOxVchIfFgoL6JbcuoLc8pV84zBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bsn3FYPi; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bsn3FYPi"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so32428845e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790683969; x=1791288769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=paQ2/onKT319WLEUhupq6lCWp4YbjzVGMuOnFcHWo94=;
        b=Bsn3FYPiNhIp2HBDQV/+jwpbyP000Xi2mEKEkhMsMnM8swD4yjc/vttTBIclQvIwHT
         2rvOWBKPZgVT1YMjv+XgD5tacsIjNUp2H+6ZMJ75vXTIGrkaRMl+DIjzqMUe6gwPaGs+
         t8hWrrlLb5EKIyvR3AonglQ2WH6k+2BNm60aimiPsoPgV/Mq9puUSJhAsdgXzQaJLrTQ
         NY3UPjbA6SjgoKYK5kqyvr5QZqMSplltvmh/pNTiwfdxt0mtx8yBQJRBi6pRmkhujNwG
         S+kmXuMdgu2jlS4TX/K6ndqUmW8B2TlzQqpcGrez9r+TvVVRIZxi8U7Qz3ykH0bKNVVS
         Z5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683969; x=1791288769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=paQ2/onKT319WLEUhupq6lCWp4YbjzVGMuOnFcHWo94=;
        b=rQIhtiPbz1Oy9PS4c2SgQeeFh1QCOtUAowDb02Kef2013D0EFA7wSpE4kcvwdLiFc0
         jc2zUaD3chdVibaOzPc4VrbOcc31cpuTj88AVvBz1yGHZVrUxrxI1YYTg5bwUAU5+Va9
         mLyUdgyvgpbtnRj0/9Dtrf/kAogVmlHUzgXGmrrbkoKm7GEoJ1tASDKgHR1u5Wa2wZ85
         VuplW0wazfRTsW35wwnJrN73LOp5K+81PhtdAQbDXmM0izYndfFq77p/EYLiHXVacjte
         u0tusp1SDq7kx7381fOo//GilkuKzhYH9YR3lmZQ+uqFckXXf0G2Z1J3bRLdf9MzGd4t
         virQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRWUOhmIYVfA9R2SpwEnKBVo4/daYavyPnJ70CwlHVfIuxgGtMdl1zoC51rH6hJ6KJylD5GRe4ROstfGl68cnj0+ppyDg=@vger.kernel.org
X-Gm-Message-State: AFuF++ktG7Ns4knfpZTr+z5EHMBnj1Rv0vSn7u2Ee9KXwd77/8IU1sO3
	b/EDRMQwVWEbkPGTJUH3+ZrVfc6BFxPDpbkwgtiVhWd/zU931ccEmWtUNIBvF11TMQ==
X-Gm-Gg: AYBFou0XM0YE16L9/mDuJMpaL7yT79PpfokYCudjvx34bGeMjm5zFzF6RiiaSq8t/tb
	CUs2QHfZipW+xjXD+ejwgBHY189PTYHRgck4+z1jS0Vm5X8EyFqOEWQ4nwpzul8p2kRNGF7B+kd
	AiaGI9jcy6CSsg584DVPExOsz96qVBFiFlPloeKI/LaLmlWnWll262n0/WUeMQVaPX/H67AnwQe
	d4iekltq7Z9112BpkxfKsWJM0BwZzcGoZqsQfFSpqt2LBlaVe9j7O0x3AN2ZLq1Td6YvBWE+95U
	QwXJ5h1e+GZvgxJkRM0tFgInWv5RxE60+XnU9PKqqbocKeKS7jegTZIr1e2FYmpkIGMsgaGR24h
	GxX1YP7RwIGiQlSpz6J/4a9BvXtWEZHtldlOnevW8hZtZrXgdV336BhR8Kt7c/4wWlVpB2lPE+G
	DyXr/URWl7qZfbBYtWlw4HrVJJ/KugjHbCJ/11n+PfSTVA0kKiWNruCWt4z151b7H5RNN8fox/p
	4cI/Q6CgcrqEi6sgOatXBEt7+bxzw==
X-Received: by 2002:a05:600c:1d28:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49fe66fc677mr302281505e9.33.1790683968737;
        Tue, 29 Sep 2026 05:12:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:ce20:1d4f:298a:2070])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013b8f6f5sm4087715e9.10.2026.09.29.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:12:48 -0700 (PDT)
Date: Tue, 29 Sep 2026 14:12:42 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Cai Xinchen <caixinchen1@huawei.com>, mic@digikod.net,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dlemoal@kernel.org, hch@lst.de, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	dhowells@redhat.com, code@tyhicks.com, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com,
	hirofumi@mail.parknet.co.jp, cel@kernel.org, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, miklos@szeredi.hu, amir73il@gmail.com,
	senozhatsky@chromium.org, chenxiaosong@chenxiaosong.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com, omosnacek@gmail.com,
	casey@schaufler-ca.com, nanx95726@gmail.com, djwong@kernel.org,
	daniel@iogearbox.net, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, exfat@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	xiujianfeng@huawei.com, lujialin4@huawei.com
Subject: Re: [PATCH RFC -next 00/12] landlock: Add READ_METADATA and
 WRITE_METADATA access rights
Message-ID: <arurOphe6QIx2Zr8@google.com>
References: <20260924104831.1081137-1-caixinchen1@huawei.com>
 <araxO4ze0KZBz756@suesslenovo>
 <20260926.255b951d3013@gnoack.org>
 <arqcbjWLN1CLkL_Y@suesslenovo>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arqcbjWLN1CLkL_Y@suesslenovo>

On Mon, Sep 28, 2026 at 01:13:35PM -0400, Justin Suess wrote:
> On Sat, Sep 26, 2026 at 09:56:28AM +0200, Günther Noack wrote:
> > Hello!
> > 
> > On Fri, Sep 25, 2026 at 02:03:05PM -0400, Justin Suess wrote:
> > > On Thu, Sep 24, 2026 at 06:48:19PM +0800, Cai Xinchen wrote:
> > > > This series adds two new Landlock filesystem access rights,
> > > > LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > > > which control access to file and directory metadata such as inode
> > > > attributes (mode, ownership, timestamps), extended attributes and POSIX
> > > > ACLs.  It picks up the work from the "landlock: add chmod and chown
> > > > support" series [1] and follows the coarse-grained grouping discussed in
> > > > that thread [2]: instead of separate chmod/chown rights, metadata
> > > > operations are grouped into one read and one write right.
> > > > 
> > > > Landlock evaluates access rights on a per-path basis, but the metadata
> > > > related LSM hooks (inode_getattr, inode_setattr, inode_setxattr,
> > > > inode_getxattr, inode_listxattr, inode_removexattr, inode_set_acl,
> > > > inode_get_acl, inode_remove_acl) only receive the dentry of the accessed
> > > > object.  Patches 1-7 therefore first pass struct path instead of dentry
> > > > through the metadata-related VFS helpers and LSM hooks.  This is a pure
> > > > refactoring with no behavior change, split so that every patch builds
> > > > and works on its own:
> > > >
> > > I like these patches, but is the ability to read metadata already
> > > sorta controlled by LANDLOCK_ACCESS_FS_READ_DIR on the parent
> > > directory?
> > > 
> > > The one case I see this being different is:
> > > 
> > > 1. if you wanted to grant read access to the file, but not metadata
> > > read access, but I can't think of any usecase for being able to read
> > > the contents of a file, but not the metadata. (see below)
> > > 
> > > 2. If you had the absolute path already and didn't need READ_DIR.
> > > 
> > > I see introducing this READ_METADATA as causing potential
> > > hard-to-diagnose issues.
> > > 
> > > Say you handle READ_METADATA and READ_FILE, but only grant READ_FILE.
> > > 
> > > The program can technically open the file with the READ_FILE permission,
> > > but it may error out because the stat() on it beforehand failed.
> > > It's pretty common for programs to do that kind of thing (stat before
> > > open), like for checking for config files (strace bash and you see it
> > > stat .profile, /etc/profile)
> > > 
> > > There may be other bugs, because being able to set permissions to read
> > > a file *but not read it's metadata* isn't possible currently in posix
> > > acl and userspace may not work well if that assumption no longer holds.
> > >
> * posix acl and linux DAC.
> 
> > > So maybe WRITE_METADATA is good enough?
> > 
> > The existing use cases are the combinations of (a) READ_DIR
> > allowed/denied and (b) READ_METADATA allowed/denied.  Because these
> > two access rights overlap slightly, it seems likely that for a given
> > directory or file, users will want to either grant both, or deny both.
> > 
> > At the moment, where the (not yet existing) READ_METADATA is
> > implicitly always allowed, the problematic case is the one where the
> > Landlock user wants to deny READ_DIR, but where much of the same
> > metadata is still available through stat() and the various
> > get-attribute syscalls.  (c.f. the warning box in the Landlock docs
> > [1])
> > 
> > In my view the READ_METADATA right closes a gap that READ_DIR left
> > open (which is also potentially surprising to callers if they did not
> > read the docs closely).  Also, if its implementation is symmetric to
> > WRITE_METADATA, I feel that it's worth having it in the same patch
> > set.
> > 
> > –Günther
> > 
> > P.S.: I know, even after we can control stat(), there are likely ways
> > to infer the presence of a file by observing Landlock error codes.
> > This would be nice to fix as well, but is harder to do without
> > controlling the path walk itself [2].  But also, the fact that this is
> > currently not controllable is not an excuse for leaving READ_METADATA
> > open IMHO.
> >
> I'm still sort of concerned about the case where read access is allowed,
> but metadata isn't, due to how many applications will not cleanly handle
> such an unexpected condition. You can reproduce this with a seccomp
> policy forbidding stat().
> 
> Would it make sense to have the existing READ rights
> (READ_DIR/READ_FILE) imply READ_METADATA on the files/directories 
> if READ_METADATA is handled? Reading a file's contents should always
> imply that you can read the metadata.

I am wary of situations where the handling of access rights implicity
implies other access rights.  We have discussed such schemes in the
past (e.g. we considered a design for RESOLVE_UNIX where we'd have
both a "scoped" and a "access_fs" right that would interact with each
other), but in the end we always settled for approaches where such
interactions would not be necessary.  One of the concerns was that it
would complicate "best effort" fallback logic in all Landlock
libraries and in the countless places where people use the syscalls
directly.

To throw another option in the mix.  (To be clear, I have only 70%
confidence, so feel free to push back, but it feels like it might
work?):

Is this similar to the "truncate" right?
----------------------------------------

With "truncate", there was an existing common operation (open(2) with
O_TRUNC, a.k.a. creat(2)) which called the truncation hook and checked
for the truncation access right.  But that was in fact OK.  The way we
resolved it at the time was by documenting very loudly that WRITE_FILE
and TRUNCATE access rights should always be requested in lockstep, if
TRUNCATE is handled.

If READ_DIR and READ_FILE do in fact read and return metadata to the
user, maybe the right thing would be to do it the same way here and
*require* that we have READ_METADATA to do these operations?

(READ_METADATA is automatically allowed as long as it's not handled,
so that approach does not break existing programs.  Programs who
consciously start handling READ_METADATA must simply take into account
that reading directories and opening files for reading requires
READ_METADATA.)

(BTW, I can see it for reading directories, but I am not sure I fully
follow the argument why opening files for reading means that you can
read the metadata?  Can't that be guarded on fstat()-like operations?)

—Günther
