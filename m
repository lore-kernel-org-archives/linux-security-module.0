Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93A49641
	for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823535; cv=none; b=a6r3izn5+ZvRbyeD4wqnMUpaN0MBJBh56/q6uB/Apsdabh2hl4F6JepEcrHfBEErRVW5yEFwGx6c+bTvN42UB0HJurS6+NRqQBhjpggjQ0QR3wKm7f3ofzrW5geIqxkwROsxxVekiddbdWiwjGhXTCwWdTLogYQ54niiR3grAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823535; c=relaxed/simple;
	bh=H7r5FWPMCUc5oEJXU463isRkAlGFvMt935cX3Au7iYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxiGg2qVIkz3/3v1rn/uPCBYQ6yYcLyyXAuAw65N3/5PblOincRIdF5kh2IX2Fi5XHvxnohQKmF2ZxdO6JIm6ZVsodBEs1aqfeSnRteNLN2qtncnuhhkthnVgvUHm9XOpp/JTw+KvlwllYVYeXVRG8yp6lxJuXo4EYNnGGvQQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qW0QMJZG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qW0QMJZG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so3903382b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Aug 2024 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724823533; x=1725428333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLyQ3qAoevQekgQ8bOf6mV7MxVHUVUaI8Mf3zMNoquw=;
        b=qW0QMJZG07f5cSxi72jChQSDvhj638MnQI9Y/w33mD0vk6xnPqPGL/2GIlyTNJDKGB
         n3yGkAfCcpfe6P0LXGvIPVLYBgaujAF7KGDZgvjMZkjTF3OyUPAlTEYXbstAsIXSNRsn
         ECunKF3Q8F856lOFks17EvCiSujaxKGE+30qOQIvSnkF56jVE+YYYrpnIe2bu0kly+G7
         dCC44pLQly4AnqQQ8jRRL0lSIMB9FQmlFVBVO0kHT2h2OAyYJAkCkaKGoSDxIUIP1dJ5
         KYWhQxFWZMw5q98gzcIEDlCAp/2SysYRK0RNahHhtSmRJlsLJoriHkRY+xWKddz3Ls5m
         EPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724823533; x=1725428333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLyQ3qAoevQekgQ8bOf6mV7MxVHUVUaI8Mf3zMNoquw=;
        b=JYj6Xs9KeEKBIxrVNalHu7aUkYx9hEEkfoS51ArTt0t+S6LAnROqqUCVre+Ve0+DRZ
         1hxBVt8IPTyhODc4eTtllqPw9lre2eAxM+SQD5Z3Eaqz8B+xvZMPiAnRRYUY1GXgYZKb
         tK8tgj0nO5vGi0fCtGTiiJ63YiANE62dmG+qx3jxt5reC0NVWNA7NKNIfWnVasiUjZGU
         x91tRu/3mLCAZaYRuTTUmTqVG8t9Z2YBKTIFisR145x5SalDARWVe6QRR0zrfxb5i111
         YLyKkE6azxOL61KY3MS+n2V5UgWFyhA3tCEP8vhNODRTi6opX9WQITPkGicXBBLaotGx
         0TmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8CXRztdK3jH0Xwd9xcR5em4wee8Yk6asprTdRtj/44rxuAkI3uLEtVAR94vAuiZnzzvNnJpBhxNIaoLsQzCnAB5Pdifc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINpJtM9WiVwmCZe2YgfO27ckzFmbxO3GHvGLUz96PkCAZr+Kg
	MxQL0USwAWFM659f8T1MLgaA0Q50/M2xRpJtLLY7i89PyiE38ZOTaua9W0cXB4I=
X-Google-Smtp-Source: AGHT+IGnfrz84P242OWlhNyx4D+U0UOVTCtjZYAQTtzwoKNYvjlYe88Io15LFksyT1cciS1kK+Z7Hg==
X-Received: by 2002:a05:6a21:3318:b0:1c4:7d53:bf76 with SMTP id adf61e73a8af0-1cc89ee965emr16298432637.38.1724823532717;
        Tue, 27 Aug 2024 22:38:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445f8dabsm632412a91.13.2024.08.27.22.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:38:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjBOL-00FOUt-2i;
	Wed, 28 Aug 2024 15:38:49 +1000
Date: Wed, 28 Aug 2024 15:38:49 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>, jack@suse.cz,
	viro@zeniv.linux.org.uk, gnoack@google.com, mic@digikod.net,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <Zs636Wi+UKAEU2F4@dread.disaster.area>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827171148.GN6043@frogsfrogsfrogs>

On Tue, Aug 27, 2024 at 10:11:48AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 27, 2024 at 11:22:17AM +0200, Christian Brauner wrote:
> > On Mon, Aug 26, 2024 at 10:37:12PM GMT, Darrick J. Wong wrote:
> > > On Tue, Aug 27, 2024 at 10:32:38AM +0800, Hongbo Li wrote:
> > > > 
> > > > 
> > > > On 2024/8/27 10:13, Darrick J. Wong wrote:
> > > > > On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> > > > > > Many mainstream file systems already support the GETVERSION ioctl,
> > > > > > and their implementations are completely the same, essentially
> > > > > > just obtain the value of i_generation. We think this ioctl can be
> > > > > > implemented at the VFS layer, so the file systems do not need to
> > > > > > implement it individually.
> > > > > 
> > > > > What if a filesystem never touches i_generation?  Is it ok to advertise
> > > > > a generation number of zero when that's really meaningless?  Or should
> > > > > we gate the generic ioctl on (say) whether or not the fs implements file
> > > > > handles and/or supports nfs?
> > > > 
> > > > This ioctl mainly returns the i_generation, and whether it has meaning is up
> > > > to the specific file system. Some tools will invoke IOC_GETVERSION, such as
> > > > `lsattr -v`(but if it's lattr, it won't), but users may not necessarily
> > > > actually use this value.
> > > 
> > > That's not how that works.  If the kernel starts exporting a datum,
> > > people will start using it, and then the expectation that it will
> > > *continue* to work becomes ingrained in the userspace ABI forever.
> > > Be careful about establishing new behaviors for vfat.
> > 
> > Is the meaning even the same across all filesystems? And what is the
> > meaning of this anyway? Is this described/defined for userspace
> > anywhere?
> 
> AFAICT there's no manpage so I guess we could return getrandom32() if we
> wanted to. ;)
> 
> But in seriousness, the usual four filesystems return i_generation.

We do? 

I thought we didn't expose it except via bulkstat (which requires
CAP_SYS_ADMIN in the initns).

/me goes looking

Ugh. Well, there you go. I've been living a lie for 20 years.

> That is changed every time an inumber gets reused so that anyone with an
> old file handle cannot accidentally open the wrong file.  In theory one
> could use GETVERSION to construct file handles

Not theory. We've been constructing XFS filehandles in -privileged-
userspace applications since the late 90s. Both DMAPI applications
(HSMs) and xfsdump do this in combination with bulkstat to retreive
the generation to enable full filesystem access without directory
traversal being necessary.

I was completely unaware that FS_IOC_GETVERSION was implemented by
XFS and so this information is available to unprivileged users...

> (if you do, UHLHAND!)

Not familiar with that acronym.

> instead of using name_to_handle_at, which is why it's dangerous to
> implement GETVERSION for everyone without checking if i_generation makes
> sense.

Yup. If you have predictable generation numbers then it's trivial to
guess filehandles once you know the inode number. Exposing
generation numbers to unprivileged users allows them to determine if
the generation numbers are predictable. Determining patterns is
often as simple as a loop doing open(create); get inode number +
generation; unlink().

That's one of the reasons we moved to randomised base generation
numbers in XFS back in 2008 - making NFS filehandles on XFS
filesystems less predictable and less prone to collisions.  Given
that we are actually exposing them to unprivileged users, we
probably also need to get rid of the monotonic increment when the
inode is freed and randomise that as well.

And now I see EXT4_IOC_SETVERSION, and I want to run screaming.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
