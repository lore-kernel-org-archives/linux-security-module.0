Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACC175A63
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895972; cv=none; b=vGhpQrp5wo4JtVM0rwIQ1VuR2IUOkXbjsQqBKvjs/l9KxfQYd2d0TpuyAvwQk29N4fHdWhwU4M5XrbCcpNHR7WBnv+uTN7IM0f2EAhNNSSdC2fexOMXJS6f8VSdfo7MEfBhsWFO0gcuoZxhStxrefCN7zL67Xy4OLwvle3u60NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895972; c=relaxed/simple;
	bh=8R2MDECoi8pPVX/G+ST+O2YQLa07FysfgMPNEqp82Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei/BHAB1eYWK8swvHV7JAcPk9YlXp8Fu6+yONzX0GGxOz5ljHIB5EIrqSHMZhBinBbYBaTmMoQGh73VrdZVRRbVcl9ja+RsY4jBPFRKPPJGcXRJ2KUMhGLmuEgjgbqSbpML2qD6rCDyH6pQwdl4y6Ci2YIMSy90fyF6Kp1Zu4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoghufNr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoghufNr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so24333005e9.2
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775895969; x=1776500769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZhxvloWveQ8LD4qwNlR10g5RNvzSrmjw6/7waXGSVzU=;
        b=JoghufNr8Sbmlcds2HkNl9iidvzhQPh0OaL9rUf+QYPOh1riWr2KMKZLcAymr8SIVp
         i7QZpyVfBSZbDgyZOO8EJqrL8XZupeSpeMOcGuKIGv7YipGCo7yfvZnt9q1ures10Xzs
         /9VrfaNr+aMSY9A/j7PGPHSScPB/WKktR/oFVKkacfx8jd5zwBH9v/xhKZHPguEzKmwS
         YUMMdyD4IsSkQ0cQAiDVTI5pPcEmv25as++KPKyXq2ZNjVHD8vIIXkaGV62OnBcvLh8z
         IUThB/2iJdzMMwdYRPukJYyJgq1g8WRnw8/SOuB5wuXP7ZWGezvnZwjXoHsVlnfgwbTF
         pWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895969; x=1776500769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhxvloWveQ8LD4qwNlR10g5RNvzSrmjw6/7waXGSVzU=;
        b=o/G4vy/UQbtzQ0hou3sU7Rg3EVz0UzfXWOPaIZW1ubELQEt3kKm0pBuzXanwZL4X+C
         xnYdSj/D5PM8ACf4dGZAjumbFPfFHGPF6X8kaoH9HzLllL9/pAWFZw9+KMfskNssQLiY
         iaNCLJ69LZ5Ei27Q5MnJwp6l/7BjtV47EtP3YPq1QU/XG/H8RWyvLNpku1nCr10O+/Nm
         EDSdwHe2WGiMyDHMd8aBjgR+7Xrk0aZsERUNwEIUvHteOKG/oCjOS7abnfQ/5AHp9vD5
         55R96aQ0ovLJGreimNwZzEL7j5AwDrU6jFhFK6JzJ7XbXOvr8nsEqBh/J841+7B4rJPw
         woig==
X-Forwarded-Encrypted: i=1; AJvYcCWGRYaQ2zCDdAQj6KgeqOudIVUfMiqQgEc/dFV/Ei2JShZuByAIBUrWo6/qsxvTthUdfLHchYPG6K7tV3OsuKbeV6RkPrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TouDid6gSKv887DfJ894RAjI7T9PzsReMxI/zyH+9/uJhR7U
	umEM/JQJ+CidvwhGut20ntcKnNy0ofceFf4bCNTagpyycaAcuPa5qM5GbCJ/s1LV5A==
X-Gm-Gg: AeBDieuvi6RdNpg2DujmjrGn9fV2lGAtZTdYOnUhr0mn6sr3HMQ2ZJJJghQpsd9U1er
	dvHdk1cWGxjX4IJUZqbnemE5pYzegs/B1+/7AcvvcXT4e6zCPbW7Rro6OvfNtG6xUASHU2xJMP8
	elcr3mYtNo/YjiTsKFGpt+VaFaB3aM3R+4bhAGQGxVWmPagcx8WlmIppDWpl01ngOJ/5i8vCeod
	esSyC3fntIz1hfn7WHWciCmmfdbMSGHD+CPd28fhQlXYGHnk8xVbeY93w4WCLAoE0yb+gMPVJK0
	yF6tEOfoBf08Dr8LPWf+ttT9slJuMySxWZQrEeekKBGMNCrBGy5SSewFhkfjTcPLxkuR6xXHznt
	cg1LkI+0+i9/sguz6BgGA+M3yVI62Tj/bxOK0zapqYp3PB/aqDNNfE6TJuF1OJXiVd4FWg3v8qX
	Lx77OJQdrGaKHuFKWw3rlml0GMSzvkgeplNq8nLvGD2GZRcbocqODrC8Xz5p5dHfhs6CLlbS/AQ
	y0=
X-Received: by 2002:a05:600c:4443:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488d686c044mr80973515e9.23.1775895968571;
        Sat, 11 Apr 2026 01:26:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:2b66:d8bf:3624:ab43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3c597sm129872815e9.12.2026.04.11.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:26:07 -0700 (PDT)
Date: Sat, 11 Apr 2026 10:26:02 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <adoFms4gbL2YUX5S@google.com>
References: <adUBCQXrt7kmgqJT@google.com>
 <20260408.beu1Eing5aFo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408.beu1Eing5aFo@digikod.net>

On Wed, Apr 08, 2026 at 01:01:28PM +0200, Mickaël Salaün wrote:
> On Tue, Apr 07, 2026 at 03:05:13PM +0200, Günther Noack wrote:
> > Hello Christian, Paul, Mickaël and LSM maintainers!
> > 
> > I discovered the following bug in Landlock, which potentially also
> > affects other LSMs:
> > 
> > With renameat2(2)'s RENAME_WHITEOUT flag, it is possible to create a
> > "whiteout object" at the source of the rename.  Whiteout objects are
> > character devices with major/minor (0, 0) -- these devices are not
> > bound to any driver, so they are harmless, but still, the creation of
> > these files can sidestep the LANDLOCK_ACCESS_FS_MAKE_CHAR access right
> > in Landlock.
> 
> Any way to "write" on the filesystem should properly be controlled.  The
> man page says that RENAME_WHITEOUT requires CAP_MKNOD, however, looking
> at vfs_mknod(), there is an explicit exception to not check CAP_MKNOD
> for whiteout devices. See commit a3c751a50fe6 ("vfs: allow unprivileged
> whiteout creation").

Agreed, it should be possible to restrict it.


> > Option 2: Handle it in security_{path,inode}_rename()
> > 
> > Make Landlock handle it in security_inode_rename() by looking for the
> > RENAME_WHITEOUT flag.
> > 
> > * Con: Operation should only be denied if the file system even
> >   implements RENAME_WHITEOUT, and we would have to maintain a list of
> >   affected filesystems for that.  (That feels like solving it at the
> >   wrong layer of abstraction.)
> 
> Why would we need to maintain such list?  If it's only about the errno,
> well, that would not be perfect be ok with a proper doc.

Yes, it would be only about the errno.  At the time of writing the initial mail,
I was also worried that OverlayFS would get confused if its internal
vfs_rename() call would sometimes work and sometimes be denied, but as it turns
out, since OverlayFS uses its own credentials internally, this is a non-issue.

I'll send a tentative patch for option 2 for discussion.


> I'm mostly worried that there might be other (future) call paths to
> create whiteout devices.
> 
> I think option 2 would be the most practical approach for Landlock, with
> a new LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right.

Given that this only affect immediate renameat2() calls, I would actually argue
that we can probably get away with guarding this with the existing
LANDLOCK_ACCESS_FS_MAKE_CHAR right?

I checked Debian code search for usages:
https://codesearch.debian.net/search?q=rename.*RENAME_WHITEOUT&literal=0

Apart from the usual proliferation of copied-around kernel headers and wrapper
pass-through wrapper libraries around renameat2(), the only actual use I found
for the immediate renameat2() syscall with RENAME_WHITEOUT was in fuse-overlayfs
(for the exact same reason).  Fuse-overlayfs is likely not running under a
Landlock policy given that it doesn't have Landlock support itself and given
that it also has to do a mount(), which is forbidden under Landlock, so users
are also unlikely to wrap it in a Landlock domain.


> I'm also wondering how are the chances that other kind of special file
> type like a whiteout device could come up in the future.  Any guess
> Christian?
> 
> > * Con: Unclear whether other LSMs need a similar fix
> 
> I guess at least AppArmor and Tomoyo would consider that an issue.
> 
> > 
> > 
> > Option 3: Declare that this is working as intended?
> 
> We need to be able to controle any file creation, which is not currently
> the case because of this whiteout exception.

Seconded.  Landlock offers a long list of access rights to restrict the creation
of new directory entries, and this is a way to create a new directory entry
anyway.  Even though it's not immediately clear to me how this can be abused for
an actual attack, it is a violation of the previously defined Landlock policy if
directory entries can be created this way.

—Günther
