Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451452848A7;
	Wed, 15 Apr 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270924; cv=none; b=IsyXVf54GwcW5d1GBXy0pQ9GN03MmSd0o9IQ+ti1x6vOwBMiUY+14R/Evva08lJqjppxT51XoDWsSdHEGdZS+A1VlwEFHue8kBQx7RNqrJstBW626DHB/bC2osk4QNcxcTO1p1Byi5NsbrEj5Vk2yZCGYLiPrnDVZ5BG5XuBBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270924; c=relaxed/simple;
	bh=y/K7Dl0aWRlGBlsg4K57mg7Hk6sFDw9z2HgCzeTpJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfHUgv2TEstIZqaxodzz3TxeZR9rwPlNOtKhCZT/nkY06FrUBZZdoH/t4M9FNNOBKIONVG2Gzwj1NtSg/tO7v6wlpJ3+CL2Bs/T91gem+WHUimvjOs9aJ1bIcEv59BMcssqd9ANQazH1KQhwAu4IA3D4mUkP85MxVuvWBGK4v4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCgyuJO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCgyuJO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E7BC19424;
	Wed, 15 Apr 2026 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776270923;
	bh=y/K7Dl0aWRlGBlsg4K57mg7Hk6sFDw9z2HgCzeTpJeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCgyuJO2L68O6bEy2/p4nJeXBp2GrpTb/+eZVVF9+MpH29CON2auXZXIuXLHCdZB4
	 Ls8Cu8EAJmA6Ah1mEQJKVYaX9sBUV3J6RfYHmj6Vd+S81QSF90/yVMz020w4hL/tkI
	 lp/FL41oopJIJGOIM3w6zoSjoDxFqvsbI0jNjH1kIPJ8Vq7PsSBBtORrOipUR3IjV/
	 KZTjB9liM9hKiHSEEQQZEHVw6FhEKR2lWlpkgDdy/r2WX5k5cp8L5QWZLBsteC6qnR
	 tmfPWSFUuCbqay1od7/SiBhGts2sZME50ExVaZYHhJTfGvOGal/jXGEu7URi2e3KIK
	 7nri1p54oqBFQ==
Date: Wed, 15 Apr 2026 19:35:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com>
Subject: Re: [syzbot] Monthly lsm report (Apr 2026)
Message-ID: <ad--R8KaGgucLxmH@kernel.org>
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

I'm actually doing something to this already: trying to write a
simplified reproducer. But yeah most likely still will take up until
some point next week.

BR, Jarkko
