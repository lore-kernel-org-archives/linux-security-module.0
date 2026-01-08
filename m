Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB93D1CAA
	for <linux-security-module@vger.kernel.org>; Thu,  8 Jan 2026 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871818; cv=none; b=WZdC24jZkbcpc39YLx88JdsVucvsEtOJ+xnshK4mqdHL2ETIRdKHMvdmH/ueQ8us50GXVeUGr/nirCGLAOnrfuMVrVtiNK3TbSEiAOL2gm/9qrj2CU1fwPDkFqVCWvCL824vK/LORacP6N2aYbrjk5glzhoAh2tiOSQBTkDRTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871818; c=relaxed/simple;
	bh=Moly6GtMJnTRFeQwFsM2KVbUOKElTrPfqr32dbajSys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ61DxnGiK+EQXtiqwoJVq2m1UjYmLPqRZsOG4CK0wNpq1QRPIGt5s+VEhabonJ8Q5Voww6nu39V2yBJ/wKprDnacOZPCFmXceuvsngcud4ZKASsbSPaT7nW+f2vAShepxF5YpHy6abhmxuqKCPBaUiWLfMz7lvY7RhVn517mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=e3VcWrxP; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="e3VcWrxP"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dn2Nm0FgCzpF;
	Thu,  8 Jan 2026 12:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1767870871;
	bh=s95m8BRIXxPPL9x6ob2pjucpUbxmBpRymZiOprntk7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3VcWrxPA2n5khecardYeD2P84Agz3+3UwQqjkchB6vMU7bOVK4M5aysVINbfxxfU
	 DA7sOfg6u3XJWLaynnRQBY2ijd0qsbKjKK6SkX95Ly0EH0BHsQVrSqG1y3b8E+3yVz
	 Wrj4xetzmKPdz8U0ob1tMIsYOUBedKRMMIHFtNvU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dn2Nl0cMGzJhj;
	Thu,  8 Jan 2026 12:14:31 +0100 (CET)
Date: Thu, 8 Jan 2026 12:14:24 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, 
	Tingmao Wang <m@maowtm.org>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org, Justin Suess <utilityemal77@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>, 
	Jann Horn <jannh@google.com>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260108.ahyiez5eeQua@digikod.net>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <61a6be66-a9bd-4d68-98ed-29aac65b7dfb@gmail.com>
 <73c5509a-5daa-4ea5-ab9f-e24a59786f6d@maowtm.org>
 <1d36b2ee-b967-42d7-a6c2-e5b1602a512f@gmail.com>
 <20260102.93e0d7b9c9b5@gnoack.org>
 <20260102.ae35fcc3c4d8@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102.ae35fcc3c4d8@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Jan 02, 2026 at 11:25:38AM +0100, Günther Noack wrote:
> On Fri, Jan 02, 2026 at 11:16:33AM +0100, Günther Noack wrote:
> > Regarding the un-restrictable operations, Tingmao's pointers are
> > correct.  In the warning box in the documentation, the missing
> > operations that I am aware of are (a) the Unix socket connect()
> > operation, and (b) the symlink lookup which happens implicitly during
> > path traversal and which Landlock and other LSMs can not control
> > through LSM hooks at the moment.  (A symlink always gets implicitly
> > resolved during path lookup even when you do not have directory read
> > permissions on the directory where the symlink is.)
> 
> I forgot to mention - the error codes returned by Landlock make it
> possible to probe for the presence of files, even when all available

It is not specifically the error codes but the inability to restrict
path resolution.

> FS access rights are denied on a directory.  Attempting to open a file
> for reading will return EEXIST if it is missing, but will return
> EACCES if it is denied by Landlock.
> 
> gnoack:/tmp/xxx$ ls
> foobar.txt
> gnoack:/tmp/xxx$ landlock-restrict -rofiles /proc /usr /bin /etc/ -- /bin/cat foobar.txt
> cat: foobar.txt: Permission denied
> gnoack:/tmp/xxx$ landlock-restrict -rofiles /proc /usr /bin /etc/ -- /bin/cat nonexistent.txt
> cat: nonexistent.txt: No such file or directory
> gnoack:/tmp/xxx$ landlock-restrict -rofiles /proc /usr /bin /etc/ -- /bin/ls
> ls: cannot open directory '.': Permission denied

FYI, there are several ways to infer file presence, and this also work
with other LSMs such as AppArmor and Tomoyo.  It is a limitation of
path-based hooks, see https://github.com/landlock-lsm/linux/issues/52

As Tingmao noted, this is part of Landlock's documentation, but it could
be improved.
