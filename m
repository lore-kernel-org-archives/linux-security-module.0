Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094771A76A8
	for <linux-security-module@vger.kernel.org>; Thu, 29 Aug 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938508; cv=none; b=RM6tEZ18je1BENa1MqKoqfIuai8yRvN5YwR9TbubNeotkI4nee98QntZinmJiLTLZnNfjEnlMVv4fKhts2/frha9ypqzFNVu4iUD5KpVGnb8AwalsiDP0xsGwPUCQ7GB7eojk66y0DGKEly8L6pS3E7yJDzNZgbRLP2f9cgkXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938508; c=relaxed/simple;
	bh=sTMFvNV06/zwz/V10/ORBXRQBHotCy5JRGNXWoNGqAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqBGLf7d0L9jO494zcCuJsDPH2dl55e3y5FoDQTTa8b585QUXNuEZKjIoZppv0TRw4J4mZvvbPU3TamauxH0OeO8DvTOhIh2J2N3OWI1sAojtHrjhO50anEuFzj/ooI8wXCXif+d1PVoqLMW8mF3HHUmAGrr9i7jshpEDyXEDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YafxVHO5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YafxVHO5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567dd6f77fso9865571cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Aug 2024 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724938506; x=1725543306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtISLUO5EP2NsKvBcM5qfQlSfPZqpo47XVjo1uXCz4w=;
        b=YafxVHO5K7aagj5y09Es93Ody0ZYeqxa6f1lBKFvMl5PLZ5TGPXlA/IcvcYCyHWcpV
         8PWJ8l48H6AqIzByq/7tspz0ANnCDNrzZJV6uG0Q2kTQwZxVUDUji11r/MrGBcm05djM
         F3BhFatn92PdUpgV7I3/LjNyowGafmrUqZHTwafiU2o7Xp8dNNyeJPdFPUOgMjsJ/G+u
         hxyGudDSEAmcmEv95x2iClmEhVVFCAXc47QEcxyOesCFFyT2wrniwODM98MHSxwJqahk
         CRhH5ZKgEzMer1XCapuW70kh+mhXGagMgHw1SGrMIJIGg/5Ysz6Q/t4XltQdFHun3Ru1
         0VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938506; x=1725543306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtISLUO5EP2NsKvBcM5qfQlSfPZqpo47XVjo1uXCz4w=;
        b=VSX1EaTj5Hh1eGKuvb+8IlmK3O9K47Tu+ZHIcTiM1m2CVkADTmuA9mV0lLSUBNwMfd
         Vf2NofbUAJM2Reyugh8HpcxYm9mW4x0Aj6xIG9uK7eXiUw42K7C2UQ1gymp0YeqMSxCh
         nlKgWfUTcFy/DEI1iOJLq20DN3KgZnv7bDwK/7jxwm9CB69Pve0zDLIYuMTImmbp7rr1
         M39re79rEkJqS6YEsTOi8P0f/380HsxXHkunqBHnlc6FCH7yjVa45emoFtSduzdl/RJ3
         p+FSqKblqh39Sd0CFNELacVcg1Yn/tpJNKpNurxwAIBjptbeSVicZ7QxCScMSWX7s2Xh
         Li5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMygb0KU7gCQr7dO+D87HkxDcmh2de6VLpRwryfy/0iewCBitY2ty35fBsQq6W7NTJSJ5DLmGVQ/sfhii1oOJXptce+Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPa+CrGkyoQ98t/Zwoee8j6Gm8sZgzkhMzE9zkUWZffCC8mxl6
	OrQF2Pkp5k/CT1elaEztU0kYD7FokbUnD5uH1q6nz4u1siERvIjluWPxrUYDXM2+D9nVnLyXORp
	Z
X-Google-Smtp-Source: AGHT+IHi0ePL4nHYzDmd8C6feL1XGdxlqeggsT/N5P+vvi4GErra6t4ye1NvvsSOEwWgVZFjJ3iRSQ==
X-Received: by 2002:a05:6a00:92a3:b0:714:228d:e9f2 with SMTP id d2e1a72fcca58-715e7819bf4mr3459352b3a.3.1724938493726;
        Thu, 29 Aug 2024 06:34:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bd58asm1212974a12.72.2024.08.29.06.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:34:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjfIY-00GyD7-0H;
	Thu, 29 Aug 2024 23:34:50 +1000
Date: Thu, 29 Aug 2024 23:34:50 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <ZtB4+sMr8Vbcs9VD@dread.disaster.area>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
 <Zs636Wi+UKAEU2F4@dread.disaster.area>
 <20240828155528.77lz5l7pmwj5sgsc@quack3>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828155528.77lz5l7pmwj5sgsc@quack3>

On Wed, Aug 28, 2024 at 05:55:28PM +0200, Jan Kara wrote:
> On Wed 28-08-24 15:38:49, Dave Chinner wrote:
> > > instead of using name_to_handle_at, which is why it's dangerous to
> > > implement GETVERSION for everyone without checking if i_generation makes
> > > sense.
> > 
> > Yup. If you have predictable generation numbers then it's trivial to
> > guess filehandles once you know the inode number. Exposing
> > generation numbers to unprivileged users allows them to determine if
> > the generation numbers are predictable. Determining patterns is
> > often as simple as a loop doing open(create); get inode number +
> > generation; unlink().
> 
> As far as VFS goes, we have always assumed that a valid file handles can be
> easily forged by unpriviledged userspace and hence all syscalls taking file
> handle are gated by CAP_DAC_READ_SEARCH capability check. That means
> userspace can indeed create a valid file handle but unless the process has
> sufficient priviledges to crawl the whole filesystem, VFS will not allow it
> to do anything special with it.

Yup.

The issue that was raised back in ~2008 was to do with rogue
machines on the network being able to trivially spoof NFS
filehandles to bypass directory access permission checks on the
server side. Once the generation numbers are randomised, this sort
of attack is easily detected as the ESTALE counter on the server
side goes through the roof...

> I don't know what XFS interfaces use file handles and what are the
> permission requirements there but effectively relying on a 32-bit cookie
> value for security seems like a rather weak security these days to me...

It's always been CAP_SYS_ADMIN for local filehandle interfaces.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
