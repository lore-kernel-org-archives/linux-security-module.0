Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AB1CD205
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670365; cv=none; b=WK43o8Bh8+ZLa6f4Fj55d7/DW1nilDL1XloaaYKsQ2YrYhh1ZIA1VtRmaxSPPzDNFvsksbRHkPCpGxWNDrBJndRM2GmKovLLzKfx9x5Nmx8XV+TwkYFSNnPPvCk2uXM3d24FgQvzqCmO/LB1vRHirkRHsyz8E7QaaAuWkdd7XMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670365; c=relaxed/simple;
	bh=lD38cjIIC2f0GcuGheqvXr3JDxRkjWqKszbEGxKbTGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ5kWRTjSN7fsnUVBcJjMUlmhTN/anHo8E06aWO0cLhCxNrVbAqayfdMMG8uz9sB03N1ET2k6fefV+07qvS78TilGYPJzuNAv+xaqOEmuGQCRixvCLvZ/ga1bga/jIwWSX/8Lhf6Y0X06qeNeUTFd5zHWu6i8zYRwN60XipU1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hD3un2SU; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hD3un2SU"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YfFKq39rNz82l;
	Thu, 23 Jan 2025 23:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737669743;
	bh=OOo/iZRA0jwYW9R1r2jVMN1tlv9EQe7cLPquGYnLUCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hD3un2SUISSbea7t4MGCbxO5mLZgff1OUdAH1l1QSV27x+7cDuF6lwcv37Fc8hgPH
	 ifAyMarlLBMe4LUKfigL48F9OMXE2re5Gf7JdPC02M9O8xoSsd2KoFQ5T5qI1SbZe3
	 oi8mayp/PFYqCduAVE8Ldwvvb2fJmR5RFkwP6oT4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YfFKp01DmzJYd;
	Thu, 23 Jan 2025 23:02:21 +0100 (CET)
Date: Thu, 23 Jan 2025 23:02:21 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shervin Oloumi <enlightened@chromium.org>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, gnoack@google.com, shuah@kernel.org, jorgelo@chromium.org, 
	allenwebb@chromium.org
Subject: Re: [PATCH v3 2/2] landlock: add support for private bind mount
Message-ID: <20250123.teij3Yungaha@digikod.net>
References: <20250110021008.2704246-1-enlightened@chromium.org>
 <20250110021008.2704246-2-enlightened@chromium.org>
 <20250123.Eevilae6oolo@digikod.net>
 <20250123.eSh0aipetesh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123.eSh0aipetesh@digikod.net>
X-Infomaniak-Routing: alpha

On Thu, Jan 23, 2025 at 10:08:30PM +0100, Mickaël Salaün wrote:
> On Thu, Jan 23, 2025 at 09:34:50PM +0100, Mickaël Salaün wrote:
> > On Thu, Jan 09, 2025 at 06:10:08PM -0800, Shervin Oloumi wrote:
> 
> > > Finally, any existing mounts or bind mounts before the process enters a
> > > LandLock domain remain as they are. Such mounts can be of the shared
> > > propagation type, and they would continue to share updates with the rest
> > > of their peer group. While this is an existing behavior, after this
> > > patch
> > 
> > > such mounts can also be remounted as private,
> > 
> > OK
> > 
> > > or be unmounted after the process enters the sandbox.
> > 
> > As Christian pointed out, being able to unmount pre-sandbox mount points
> > could give access to previously-hidden files.  For unmounts, we should
> > have a dedicated LANDLOCK_ACCESS_FS_UNMOUNT right and highlight in the
> > documentation the risk of unveiling hidden files.
> 
> Instead of a new access right, a better approach would be to require the
> LANDLOCK_ACCESS_FS_MOUNT and that the mount point was created by the
> task trying to unmount it (or one with less privileges).  This could be
> done by recording the mount task's credential in struct
> landlock_superblock_security and then checking that the task requesting
> the unmount can ptrace this (mount) credential.

The superblock cannot be used here, we'll need a new security blob,
probably in struct vfsmount.

Christian, would that be OK with you?

> 
> > 
> > > Existing mounts are outside the
> > > scope of LandLock and should be considered before entering the sandbox.
