Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246673;
	b=BWDFCie1W3lZ0YiEeL0sjriYXRcAS1tuti0w22TpX+lMlOzIPM6JIvbdYC1lt/idtsqd
	 Cy7W/wADNINotAaG3W4fZvDO/ESXIY5RpR3E3yabjwXTJ8o/PkTanQ+NAhWeCrEnyTnt0
	 YjqPkiqk9pT4oPQAff9+MjscphZhjAhBTxweu9Ku95T/GIkoG+LBx8rD9ZocV38sh7rRw
	 +5khM8rnfT0lNa5tmcwThNkxozgkgYZIJdV0Ex0ip3iVRAjnSxRdDfiFEt2/1v64l+Azg
	 x7xvQ+LQ06IWImfo1n2lYI8VFMxZ0whtaNRdWfcbSVs3QOHzp8ezrc9WrH5aluP5HYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=JeHC9buT6jY2RTh/VwQit4Bm1+7sFLgUnVlvsKrwLnc=;
	b=xMT1ASX2UkY3qysQKqRlZYxnM6upHqIDHmjt1QIcgE13nF38ryMdjO+PJtbjtfK/O9HS
	 HGbPgxEtRzSPw0s1+1a5CpnYtWUnGufY+TW5QrUmo+n5qNrgxR4p6Bf7D9aZNNDMeF33p
	 WOLefVJDR1F04lIoUHsQzcxdvCZUpa5bZ+DCe/Jc2TWSK8BOE5fJItMYyBP8ZT45xS+og
	 lo7C06oCnIkufUZosy7k3TQ+TGS4HtJbYx03Cuy51kMD8cILTZw5f1T2CYugZjaEFqIQE
	 lSXHhk+p++f/ATjvChIAAY/3g6fGaJx+SsFtl/4KnlRyR9XFT2Q1DnnOTK50+BDAlCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=rKTzkrX6;
	arc=none smtp.remote-ip=83.166.143.169
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC660A260F
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 17:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACDC660A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=rKTzkrX6
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNclV0lq9zcqn;
	Mon,  9 Nov 2026 18:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794246661;
	bh=JeHC9buT6jY2RTh/VwQit4Bm1+7sFLgUnVlvsKrwLnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKTzkrX65LTV3iie6B18TVpJ9L8iyosumpRUjriXl48xzZlo4vADJYs16J0CxCu7O
	 wqEVOPdMLL5kVGLa9JoayKCYkd1ajBaCK+LxjoJM7ZMWVHzWOFn8GmN/AlOo9376kO
	 xTwh222ORxXpEeJNMF96RI5YFN0MUHMYiWUStfSk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jNclR3WsFzQG2;
	Mon,  9 Nov 2026 18:50:59 +0100 (CET)
Date: Mon, 9 Nov 2026 18:50:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: hannes@cmpxchg.org, surenb@google.com, peterz@infradead.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, cerasuolodomenico@gmail.com, 
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, linux-security-module@vger.kernel.org, didtldms2525@naver.com
Subject: Re: [PATCH] sched/psi: Check CAP_SYS_RESOURCE in the initial user
 namespace
Message-ID: <20261109.iej8biD4ohph@digikod.net>
References: <20261106120004.90041-1-dennylin0707@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106120004.90041-1-dennylin0707@gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 06, 2026 at 12:00:04PM +0000, Hungyu Lin wrote:
> Commit d82caa273565 ("sched/psi: Allow unprivileged polling of N*2s
> period") moved the CAP_SYS_RESOURCE check for psi triggers from the
> open() of the /proc/pressure files to psi_trigger_create(), so that the
> credentials of the opener decide whether a trigger is privileged. In
> doing so it replaced capable(CAP_SYS_RESOURCE) with a direct test of the
> opener's effective capability set:
> 
> 	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
> 
> Unlike capable(), cap_raised() does not check against the initial user
> namespace and does not go through the LSM capable hook. A task that
> creates a user namespace has a full effective set inside it, so an
> unprivileged user gets privileged triggers on /proc/pressure/* and on
> delegated cgroup pressure files: windows that are not a multiple of 2s,
> served by the SCHED_FIFO psimon kthread, which the N*2s rule was meant
> to keep from unprivileged users. LSM policies that deny CAP_SYS_RESOURCE
> are not consulted either.
> 
> Use file_ns_capable(), which checks the opener's credentials against the
> given user namespace through security_capable(). This brings back the
> user namespace and LSM checks of the capable() call it replaced.
> 
> Fixes: d82caa273565 ("sched/psi: Allow unprivileged polling of N*2s period")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

This is directly visible with the new Landlock control of capabilities.

Reviewed-by: Mickaël Salaün <mic@digikod.net>
Tested-by: Mickaël Salaün <mic@digikod.net>

> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7c5381423334..cf2593183b25 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1347,7 +1347,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
>  	 * Checking the privilege here on file->f_cred implies that a privileged user
>  	 * could open the file and delegate the write to an unprivileged one.
>  	 */
> -	privileged = cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
> +	privileged = file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE);
> 
>  	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
>  		state = PSI_IO_SOME + res * 2;
> --
> 2.43.0
