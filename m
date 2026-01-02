Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796625BF13
	for <linux-security-module@vger.kernel.org>; Fri,  2 Jan 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349544; cv=none; b=oiBNsfnkPNdPzvGuStq1avjUt3CjxMR4xTJsHMS2m28wPySh7fyqNN6rUwvUT7tB2xL38wjN9xPLm/oRApmm7hcN4Rp0oZe+MU7XkQw3g50zIXAFKAa95o8WI2qH7Jm/0Pxv4IQnzkAsSHGe0poxLqa1n6L6jP7f6Egn46u3eAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349544; c=relaxed/simple;
	bh=Z9FmMTVELt7B55OEpjfXJsN79SxBjOUSuqxnyu5rCwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc6MhvFVh17Rax9q3WNdg89ti08ahetvFzqqll0AWFYwV8C80LNAr6E4iW08GFuwYfJO5RatyqYad8UsK+AcpTEkLqVxW7vRot/DNpDNqOMDvtB8N8j69UaAo9Z7oSazAB2InH56dt3U7Jm8NlY+9E9yFW+Crn3oGrBM9nDw5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfiA/F5C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfiA/F5C"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so16553822a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jan 2026 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767349540; x=1767954340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0Qe2hbfMn9pfd89XC4dow9GC62kIt5NByEEZzabThs=;
        b=hfiA/F5CyWycoOYCD5P2t/HsUSPeYot/6cdUB/clnoQT3S1LyTi2rhIq+u/+schpzU
         zBjXIc1As5CO3Dcr5SiJDBFLwGpCYUFBm1NCNqSR0ptpqr4vqxaCMmonMEawGi6xMyBW
         CO7Ga4kgGcdArlp/17PhHIhnpmA02gaF3KIn3ramaYCcoDhp8zxy1Wj6igvKGZ+HLRSa
         i94XVyx0UL5Mdu90lu29mLdU2maUu1J+Jk+oRWP+dNsWQrfXazfoVqV0jvDsrpXBRk4M
         PWAwaQoVdzlOi0ufnpUXJukfjnO07fpy3muUCTDarnSJfkG0cY7gTU3USZA61zr82gPf
         vzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767349540; x=1767954340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0Qe2hbfMn9pfd89XC4dow9GC62kIt5NByEEZzabThs=;
        b=ZJSeafvK+9YrUM1fQLFALXUk8mO3K8ubfDo18A5czz79Ft01ZvC8em+RnFhx8E0UqP
         d+ZVjbSO87d601HhDomYVgBIaEPE+myovgxqzpIEjJtBwA8iGqdAHQ/9IWG0aduOjD38
         A/xG59dOU5rGIwJ03Ryu47EG+6YQ9Dg+nuHVkiJcluJkRSU9Z9CNZfbT6XEa2gtQFUp1
         IpF9XfpjUauh/wfMifL1f2OoodPNV5DllUOXsbPKAPMV9/93BitofH7+KONwcjf1mvpI
         bxy91/3+bSraJkj6ULrsnuo0xp+a4f9bsx1zF0A596KWuKi8JnkZzde5obaICltjLjlw
         Hijw==
X-Forwarded-Encrypted: i=1; AJvYcCXcgf4q5Q7XZ6/BoJtiPDql5voGsCK4IMQZ40JK82V8mNWi/Nr52kMQ1rkpPlfntzFUmlH46QhdhDEtiW6K+763zKoEtMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQmjxRE9qoMsqOMZ2cf6Vjj96WFgJ+UwJ5JJWaN+5erFuNxmc
	SdTMqnpApsMWYeCQUH0Ve9GZx7NPGNIWk8yy3YZmtNPy1xSWbLnSxlVc
X-Gm-Gg: AY/fxX5V1URs66lBMdNlSJUa9c5M76IHQ0wsd3X3LNAsl8eNDPF/fFmFJYwYErj1cBV
	YQYOSUbrxMvhSRODaBa71l+GERfSHhu7X0OXxzqiNjbYfdkO2scxlYSmLIkQghAu8GvqqWDjjTR
	0Tdj5b1i/zSmeG4KGMlM/l6Ec806Ijvi4nErAeDA+/iJlYAHgzY2ZmbxtaPiz5HydVpl/punq3X
	fJKsj6hP5ipAEwT/h45zPqJe50+JbErYiFWTVHfmLsGHYQxp9gcNJo0r34F9D5qG8oC4FQx/oJb
	LDnzjAmjTg1vbRszqmlU4c43v53oERM7QvOtFTuDekaJakoKqufeTbRLASYRP7sgFCNlwZAv8zc
	UkCbet0VwBi4VEd2ioXrFQgXQfSymuoKtzv5WZdFsDsJGP52zqIdpyRXADtSTKnis2WGLIbVQ7x
	JoFphCxOexySAu/Sl/B2tqNaBsah8BD22JIoA+
X-Google-Smtp-Source: AGHT+IEKUmqBP3VS80hSsC64eU5EgBedDpwMWzKRFBLUXerDDqZnH3P/RAhztktqt4PMVAdqtkh4NQ==
X-Received: by 2002:a17:907:3fa5:b0:b75:7b39:90c9 with SMTP id a640c23a62f3a-b803718390fmr4789268366b.51.1767349540344;
        Fri, 02 Jan 2026 02:25:40 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a62973sm4589071466b.6.2026.01.02.02.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 02:25:40 -0800 (PST)
Date: Fri, 2 Jan 2026 11:25:38 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Tingmao Wang <m@maowtm.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260102.ae35fcc3c4d8@gnoack.org>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
 <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
 <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>
 <20260102.93e0d7b9c9b5@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102.93e0d7b9c9b5@gnoack.org>

On Fri, Jan 02, 2026 at 11:16:33AM +0100, Günther Noack wrote:
> Regarding the un-restrictable operations, Tingmao's pointers are
> correct.  In the warning box in the documentation, the missing
> operations that I am aware of are (a) the Unix socket connect()
> operation, and (b) the symlink lookup which happens implicitly during
> path traversal and which Landlock and other LSMs can not control
> through LSM hooks at the moment.  (A symlink always gets implicitly
> resolved during path lookup even when you do not have directory read
> permissions on the directory where the symlink is.)

I forgot to mention - the error codes returned by Landlock make it
possible to probe for the presence of files, even when all available
FS access rights are denied on a directory.  Attempting to open a file
for reading will return EEXIST if it is missing, but will return
EACCES if it is denied by Landlock.

gnoack:/tmp/xxx$ ls
foobar.txt
gnoack:/tmp/xxx$ landlock-restrict -rofiles /proc /usr /bin /etc/ -- /bin/cat foobar.txt
cat: foobar.txt: Permission denied
gnoack:/tmp/xxx$ landlock-restrict -rofiles /proc /usr /bin /etc/ -- /bin/cat nonexistent.txt
cat: nonexistent.txt: No such file or directory
gnoack:/tmp/xxx$ landlock-restrict -rofiles /proc /usr /bin /etc/ -- /bin/ls
ls: cannot open directory '.': Permission denied

–Günther
