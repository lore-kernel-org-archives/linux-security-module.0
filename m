Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5827260D;
	Wed, 15 Apr 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221518; cv=none; b=mVePo/AnBjn6ov9AQDdsNY+woIby0sIk+FBBNGohDOO0pHsvFb/MdaoSMFZUp0HcdI1sP7yQK+eHq6pop0FIYXfJHrx48bAddOGAPat05yUQqHzy9wlYYFeFBBbsUEr5IZQeb2lliIXX/VkX+OpNNkFaokzCHaAu5eL9z5hy0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221518; c=relaxed/simple;
	bh=FP4uYRqqGpMfGEpUOJdJ1/1iwS+HByZ/zZqTBiey/WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otqgcPVAvxO2w13yKg9cIYqJwCG6LuojKI+/1gabZyBZHnfE5RLmxWG49uPojtBUs4wEu1KaaJZG2E8ufU1ZErB7Dx+ceNxq1zMK4iK7xlY6LxowdIxTQ4z1vHDTZtlE0RNoIjXBBhpsMsTGIgjFkTyCAuG851jRcPbqeEJgFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9MmDPYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9MmDPYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4598C19425;
	Wed, 15 Apr 2026 02:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776221518;
	bh=FP4uYRqqGpMfGEpUOJdJ1/1iwS+HByZ/zZqTBiey/WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9MmDPYMKu6PVLOuoIqqMgq/TLYzdbgiqdIjmwW5MCV3+kSUT8reocwfKeER2zpsa
	 +UDDlEeZoClEo0xWFHloafoU7H4SjAJ8zr71MYTiuQ7zLrR2pBdk1afXmhc3Otx6i6
	 fpKLzKyDaVsfAmZ6kgeZLpEgroyNQ0pODYbOUyboWRSPPO4c2vpQgcRpE4WR7l9Sno
	 RbhRyxDIpomjiGAOaj2wlk/3jb3QL6yFoy9U+yBURu2wJcOrfD6UqGX1KiMSVA56/O
	 PStZujSfxQlI9/CX0KCnekY6SEQf3G5X7II+b4hwJQGr7N7zK/BboUVbbVJMyr9STV
	 WjDRPK/LvN9YQ==
Date: Wed, 15 Apr 2026 05:51:54 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com>
Subject: Re: [syzbot] Monthly lsm report (Apr 2026)
Message-ID: <ad79SvH3IzIFDOpJ@kernel.org>
References: <69dde155.050a0220.3030df.004d.GAE@google.com>
 <CAHC9VhS2AaRwAQw1hNcpuGdFSOL7Li9PavKtU7eW-w8eMOFuKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS2AaRwAQw1hNcpuGdFSOL7Li9PavKtU7eW-w8eMOFuKA@mail.gmail.com>

On Tue, Apr 14, 2026 at 10:02:13AM -0400, Paul Moore wrote:
> On Tue, Apr 14, 2026 at 2:48 AM syzbot
> <syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com> wrote:
> >
> > Hello lsm maintainers/developers,
> >
> > This is a 31-day syzbot report for the lsm subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/lsm
> >
> > During the period, 0 new issues were detected and 0 were fixed.
> > In total, 3 issues are still open and 45 have already been fixed.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 95      Yes   INFO: task hung in process_measurement (3)
> >                   https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
> > <2> 68      Yes   possible deadlock in keyring_clear (3)
> >                   https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
> 
> Jarkko, David,
> 
> Do we have a fix for the keyring_clear() issue, or is it not a real problem?

I'll take analyzing this to my todo list for next week (post first PR).

BR, Jarkko
