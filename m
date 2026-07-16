Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6763164AA
	for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195133; cv=none; b=KglqeOgsPqfKnwuuOZoL4qvcSj2yW5Fi9rEaG9uuAdaXXNoDvOH/XrsprFZZKDCCwXOcWsI6TDCkxddZHONIXUqMDj+U7HeupmYBXMOcb2wfVx5+aavplkqOrqiWTsHI27tgRQuxnq7ZWic7FK5RF8FvsbZOC8AbmYLLGX6I4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195133; c=relaxed/simple;
	bh=p1pPE/hXcZKUmCtVMu6RptU4ysPrKbiUhXFcrbthNwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9/8BmMGf7AToekFNq7SLaBotSv+i9zRrWWAESaDW8ShdhhALDM0swtgzNFBEs6lD8NJI5LvjQz83i7pWT9D3RcKB9iMyYivxSNHPSYE5wwyNtIFXFq2+5tgzMm7HDppKlRBAzb2N0u92Ptf5PdHk2j1WSfPWyDSSeqDNNt1mog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FSYvKgVE; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FSYvKgVE"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h17Hq3fVVzp8x;
	Thu, 16 Jul 2026 11:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784194663;
	bh=W6nIySzRfaoF4uBuUrb2JyD1f2WcDOPGeIAscMQQxwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSYvKgVEDQP0AiqgLVsVZkKxKj6v1+k51tneR6xrv4HRVEcrex8OvaMKVNPJhtaH9
	 R7ZJBONFWFuSnPM/DLFacdCS5BykI/GvG++Uxrh7rwWbm6cuY4OhYcvzwrjUotFZHD
	 0LONsiJo694rDA4WfvAqFr3Ka1bPNkxEyOLlBdK4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h17Hp4hPMzGwh;
	Thu, 16 Jul 2026 11:37:42 +0200 (CEST)
Date: Thu, 16 Jul 2026 11:37:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Ken Grimes <ken@kengrimes.com>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, landlock@lists.linux.dev
Subject: Re: [BUG] Landlock denies LANDLOCK_ACCESS_FS_EXECUTE despite a
 correctly-anchored PathBeneath rule (contradicts selftest layout1.execute)
Message-ID: <20260716.eijohyi0ieZa@digikod.net>
References: <P8RYlSi7C7oum2lk1F3PumYSvaUyd0Sn_VwUYAcWwjbQxSt_Rau30Aa1oLIEnLZ2iafcsFmEG5C4LTeBWCyd9vCx94FYeTX_OJdHoERcWSI=@kengrimes.com>
 <aldGXyfBQz8GsAMn@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aldGXyfBQz8GsAMn@google.com>
X-Infomaniak-Routing: alpha

Hi!

You should also get a look at the audit logs:
https://docs.kernel.org/admin-guide/LSM/landlock.html#audit

 Mickaël

On Wed, Jul 15, 2026 at 10:39:29AM +0200, Günther Noack wrote:
> Hello Ken!
> 
> (Also adding landlock@lists.linux.dev to CC)
> 
> On Tue, Jul 14, 2026 at 09:07:56PM +0000, Ken Grimes wrote:
> > Hey all, this is my first bug report for linux. The issue was discovered 
> > alongside llm-assisted coding on a downstream project. The 
> > investigation/testing of the bug was a mostly manual process so I could 
> > be sure this was something real. Please let me know if I can provide any
> > further details or assistance. Hope this is helpful, thank you for all of your
> > hard work!
> 
> Welcome and thanks for reporting your first issue!
> 
> I believe the issue you are observing is that the /bin/true program you are
> starting is a dynamically linked executable.  As such, executing it requires
> both the LANDLOCK_ACCESS_FS_EXECUTE right on the binary itself and on
> the system's dynamic loader binary, which usually lives in /lib/ld-linux.so.*
> (but there are symlinks and 32/64-bit differences at play as well, which
> influence the actual final location).
> 
> You can try this out with the following experiments:
> 
> (1) Compile a "true" program statically and try using that:
> 
>     $ echo 'int main() { return 0; }' > true.c
>     $ CFLAGS=-static make true
> 
>     This can be started with the test you have,
>     unlike the dynamically linked version.
> 
> (2) Alternatively, add execute permissions for the dynamic loader:
> 
>     Add an additional "path beneath" rule that allow-lists the execution
>     access right on /lib/ld-linux.so.2, /lib64/ld-linux-x86-64.so.2 or
>     wherever else your dynamic loader is.  (You can discover the actual
>     location using "ldd /bin/true".)
> 
> With either one of these two changes, your standalone reproducer program
> starts working again.  Or at least it does on my machine.  If it still doesn't
> work on your end that way, please let us know. :)
> 
> I admit that we should probably point this out in the Landlock documentation
> for the LANDLOCK_ACCESS_FS_EXECUTE right, as dynamic linking is common and it
> is a potential issue that many people might run into.
> 
> For background on the dynamic loading mechanism, see the man page ld.so(8) [1]
> and the LWN article "How programs get run: ELF binaries" [2] (specifically the
> section "Dynamically linked programs").
> 
> —Günther
> 
> 
> [1] https://man7.org/linux/man-pages/man8/ld.so.8.html
> [2] https://lwn.net/Articles/631631/
> 
> 
