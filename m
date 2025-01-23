Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715083DBB6
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667078; cv=none; b=GDS5GxbhVl0b9zRexgLPTRuRkAZMYWarUpeygAJeHdFj+BGJkKWOWnUkEKT41x0MzewrCHCRadR4GGnnrtilx+t+h0Aqhe9VYEn+3smEDRZdAwk6lnohl4ixf7VhjyhCbRXWcN9GbPAEAyo43yw6lbNkkZNpqhFfy47LT8QY6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667078; c=relaxed/simple;
	bh=HN+nUFxUXAeJAC14J3/BN5cFJC3F1u9ULgXk7wOdo74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwqOmSI773VWHAwnKWMvtR4ufKVFg9XRUBva5jz9UfIr4BG0N3ynundjMVTQUbd3U7rxeKn+70iQKJbJ7qVAK1HbAzCadQg8U9hZRZG17dsyOZK8Gc5CJBNAiGmBh1PoNKR9a76DtqH4nYaK+ylcE4uRwzy1M4RU4UKZtnQ/0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tf5ZKuOz; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tf5ZKuOz"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YfD7f2lx5znCF;
	Thu, 23 Jan 2025 22:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737666510;
	bh=oGUugWjmmm+WTRUA+LefHNPUySpbGi5W1KKikkXpgzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tf5ZKuOzoGKaxoDxmEvZkPNZgXng3N/DbyYPylQA99aUTV7OZIyRPfXxpCXpF34Q/
	 a5QabSRNotF6FteikENh57BCtkHZSyE20J/ayQYMzZq8L6imG80Dx+62RSMLsrPwdr
	 G6YxMpuZpQS+c18/4D2/RCH3H+SWUiV+QH9Rb0Bo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YfD7d3rw9zwMn;
	Thu, 23 Jan 2025 22:08:29 +0100 (CET)
Date: Thu, 23 Jan 2025 22:08:28 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shervin Oloumi <enlightened@chromium.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, gnoack@google.com, 
	shuah@kernel.org, jorgelo@chromium.org, allenwebb@chromium.org
Subject: Re: [PATCH v3 2/2] landlock: add support for private bind mount
Message-ID: <20250123.eSh0aipetesh@digikod.net>
References: <20250110021008.2704246-1-enlightened@chromium.org>
 <20250110021008.2704246-2-enlightened@chromium.org>
 <20250123.Eevilae6oolo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123.Eevilae6oolo@digikod.net>
X-Infomaniak-Routing: alpha

On Thu, Jan 23, 2025 at 09:34:50PM +0100, Mickaël Salaün wrote:
> On Thu, Jan 09, 2025 at 06:10:08PM -0800, Shervin Oloumi wrote:

> > Finally, any existing mounts or bind mounts before the process enters a
> > LandLock domain remain as they are. Such mounts can be of the shared
> > propagation type, and they would continue to share updates with the rest
> > of their peer group. While this is an existing behavior, after this
> > patch
> 
> > such mounts can also be remounted as private,
> 
> OK
> 
> > or be unmounted after the process enters the sandbox.
> 
> As Christian pointed out, being able to unmount pre-sandbox mount points
> could give access to previously-hidden files.  For unmounts, we should
> have a dedicated LANDLOCK_ACCESS_FS_UNMOUNT right and highlight in the
> documentation the risk of unveiling hidden files.

Instead of a new access right, a better approach would be to require the
LANDLOCK_ACCESS_FS_MOUNT and that the mount point was created by the
task trying to unmount it (or one with less privileges).  This could be
done by recording the mount task's credential in struct
landlock_superblock_security and then checking that the task requesting
the unmount can ptrace this (mount) credential.

> 
> > Existing mounts are outside the
> > scope of LandLock and should be considered before entering the sandbox.
