Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F92E5B39;
	Fri, 18 Jul 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854124; cv=none; b=m0cN+WinUUQEBaMGMgt7FqGpSsiqpVljQvxpbkveNSAeritYoqGvxk5k1R8UcYPJAU7BhGSvSM5ZkSNJARe2aBU9v29HumRkFZQpVxAUG72UbsF0yjL7s66K4JMZJBFlxs1bk6EF+C+Do2eypnyf11bJ1dHR4zGOOS2bwX4JswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854124; c=relaxed/simple;
	bh=oMNzKsB2XY92yrfus7rKKHcoEEwQLWFmuozJ5D5RVSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/5IUQbLsKdmtZI7EK+Ytat+y8YHl8mLex5uf3txRDqZJbjFaLcRrRaVguHB1rDHjR8LKnlHK1s65TkG8Ra4NrPrq1RjOlZMkHXc16+GHZ5fcGyspz/e79w4vyf3gyPFkFg2Y8Q4lhmkMbL3mXQmh3OqjbZRlZAA9jeAJYnptz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=YQLerONR; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="YQLerONR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hXfRxuOZCkLRqGNU7eHDa27BGpEzNEQbw1BGl3nl2ck=; b=YQLerONRoDepq/KupSFDMJr6yz
	jnM6ZPk3t4EhDxL/SD39WrY/8Nmdtp2Rtpz4RVm025wmA9bmSOu3y96eJt4V7QQancbVMpJKtaWD2
	z7DkWdt8U5T61bwTU/jh9MfSi+upZ1w4JPy9aw8D31t0EXJFD3DqOWLzYelh5H+L5vWwjacE30kTw
	E5rO5zEybssRIveHrTy8o9sLMRqFAKKogrSVzPQKgcNNMW+5TRa8ctT3+TTUFkMQtzy/VBY6dI+NM
	WaScy5OYGdDlI1eOWEs12TGFuQPN7DAkhtOkjZUSSxDsMLdIVI7xWYtPWnPC5naFZgSEPTKcb65S2
	ZghYI1yw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:35152 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ucnQe-0000000EN3v-1PBT;
	Fri, 18 Jul 2025 17:55:20 +0200
Date: Fri, 18 Jul 2025 17:55:15 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
Message-ID: <cehkmvl3y3u6qugobjo2h4yez6h5uw5pffqcr3mfjuki3sb32t@nr7nxkk3bdsg>
References: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
 <CAG48ez23HLtb9GJ-BbSXaWFhdPjXyFNED9fbuyaNP5EXJ_Wv8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez23HLtb9GJ-BbSXaWFhdPjXyFNED9fbuyaNP5EXJ_Wv8w@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Fri, Jul 18, 2025 at 04:52:51PM +0200, Jann Horn wrote:
> On Fri, Jul 18, 2025 at 10:47 AM <nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >
> > Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
> > during the `yama_ptrace_access_check()` LSM hook implementation.
> >
> > In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
> > happens. Thus, yama does not interact properly with the
> > "hidepid=ptraceable" option.
> >
> > hidepid's "ptraceable" option being documented as follow :
> >
> > - hidepid=ptraceable or hidepid=4 means that procfs should only contain
> >   `/proc/<pid>/` directories that the caller can ptrace.
> >
> > This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
> > enable an interaction with "hidepid=ptraceable".
> 
> Please note that PTRACE_MODE_READ_FSCREDS is actually a combination of
> two flags, and the intention is that the PTRACE_MODE_REALCREDS /
> PTRACE_MODE_FSCREDS part of the flags should basically only be used to
> determine where to read the caller's credentials from:
> 
> /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
> #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
> #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
> #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
> #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH |
> PTRACE_MODE_REALCREDS)
> 

Yes my bad, I should have sent the hidepid [1] patch in the same batch.
The idea here is to take "hidepid=ptraceable" into account. Which
already calls yama with `PTRACE_MODE_READ_FSCREDS`.

> > Combined with hidepid=ptraceable, the following behaviors will then
> > happen while reading in `/proc/<pid>`:
> >
> > - "restricted": A process that has a predefined relationship with the
> >   inferior will see the inferior process in `/proc`.
> >
> > - "admin-only": A process that has the CAP_SYS_PTRACE will be able to
> >   see every processes in `/proc`.
> >
> > - "no attach": A process will not see anything but itself in
> >   `/proc/<pid>/`.
> >
> > It is important to note that the combination of "hidepid=ptraceable" and
> > yama "no attach" also makes PIDs invisible to root.
> >
> > No access reports are logged in case of denied access with
> > `PTRACE_MODE_READ_FSCREDS` to avoid flooding kernel logs.
> 
> This seems like a major semantic change; I believe it essentially
> means that commands like "ps" stop working entirely on systems that
> enable hidepid. While that might be desirable in some scenarios, I
> think changing the semantics like this without making it opt-in
> through a new sysctl knob or such would be a bad idea.

Yes, this patch doesn't work alone it needs to be coupled with

[1]: https://lore.kernel.org/all/20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr/.
