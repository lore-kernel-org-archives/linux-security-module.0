Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A19441020
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910335; cv=none; b=I4PLE2u8HXWPaTiq8Dq1vUKMe8wP4+JmUG9JzGd2iZSq84NF/LdIUEdb5hOQSvlPEZ4HcVmX+Qi/Y040ZDjALp6eLD/MwtRpUaRMvUwTxW1YPdU1yMO8mfn3BamEMQS+P2fUTvB1t90bYp2EwxsQpiSOALLdvC2iiOg9iWo/Fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910335; c=relaxed/simple;
	bh=BTxdh5Md4jN0jz0/EPLsTIHwavSFz+o4g37ScCPnc78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1tf0gADD0tu6LCmyl28Ldgg8Y7er1TZpFEeShR6eDQcreYox1BuNDZV0vSw188Zuw2aLN1jj1SR0ZxBcAGumja2xifTcQF0npRJLHtUM3aEpkplpqJmpcdnM2A6se7x5jEBgziLZ8jOh3CWYQONw8gdrogbkI/5pGmS8zA79rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC7VMtCr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC7VMtCr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80e4455ba39so5076157b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910333; x=1783515133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KRa8dFyzV2cMAE0LM92Xv2fevBdHI3119BxUOXFBzuQ=;
        b=bC7VMtCr8/2507aMhR4dtgz72pvM9eVkOpxunMCdK/jyC4Xq25OoWBUXPAHL9D8ilv
         51HSvwEZ9Px6mZ+ScdbJ6UPyiwvvH7jXot7uYbBHi/b7n7VzmEgXu0uMX1Ex7FnOdtv8
         JEVvlVNqz6GCen38JQI31Q2YQz0vIi7qkzdWz0/MHVIJj/28fpuAEcTJ8/54rbtQlMoN
         NhJio3GBTCrnipjQ2PS3h1BST1PU8f0k72Jtk7WyXU8HfSc5TZNYAtA+To6C4W3UmUK+
         m5BwaNzMcwWkUtTDizpEu6AMxpLB+c53Fvm4z2makUovuIHoQeqzx+j4M0PQqqD2vvLt
         SC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910333; x=1783515133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRa8dFyzV2cMAE0LM92Xv2fevBdHI3119BxUOXFBzuQ=;
        b=g3Qw1K8lskaIzH7pdhsAVgHJilIyFPSsHXm74wYIhXN3JLhqtqggookfpi45538rJ7
         v/lwkltHbyiMYxDzfyjmrjpByQt8Q43hlguzp1O/TS3qIh7BeI+kx3G0f19Tg5o+riwA
         4ibHqrPzdpDlkKY/n1QyDNI8mljU0bxC7OvNPmITEe2DZahE/GAHUecxx7eyYr3x6zrG
         rA18LwFFLkAxQNAFHSD6Bj8q+yWDnnC+dws2SU2qt2k0zAypE5UxMO5gHAmgw3q6C1GW
         sV45iv8/k5mxUiWGxtVSpM2z97uDH75pw3It47o0WQt95uP6WXMTaXY48apCtuERJCzp
         /Y0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpa02mX0KJL19+j4JfNe9xOp/FZlyqs6s7dKNZ0dLsZwEIzgko88ijW0lSlug1+xdGPLpojtWrIGaHLNAg/6TtHeCOilfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tsBZ7rez9ulK4/ITe1HX81T5z8MYj7imX1Qdou7PrmAZydgw
	97L5kl2onkHH1sqmwrpA44rPuIM+FGXaVjY05G/RpPcXfNZt71TRPgep
X-Gm-Gg: AfdE7ckuO5NLE7TkB5lQOigCt7MOoUtpKMAbHQL1AoePwpqJHfgMYktQN7pWFD+/LhU
	LrKDnYe7uyUyk34Fva6ivFOpZGXzNx4JLYPkACOroakIkVmXl2wdFmf63oKvFV6GluZweiRmvaq
	KpBAbLWr3R4zJPa7NJ8fchl9L6WxUVR/proTvsYqUyuL1QEOYj+c16Qas/rcSC2nHq7xGJoZpd0
	ogxCM1VWVNWfbXBjt1fqnSzbIIbCOfjHhUAueEyiBLpTqrJDW6Uh0Jy1iLKED59DvPRzSV9hmYG
	CvyRbiCNCe696wVDiRWxt8nH1UdGKnJm1adjpNqcrUTxaXCkud4/opbHyXp5n6pMpoeHWRcgN6y
	2KpGmv/8xZIOO6iaboD+U6uxyn19lvgqC4sjoz2T0o1kH2fZzTntp3Dr7za0ppd/Gbrvmf2laYa
	sqHvZsYjDrHVOHShPH05txmVbOt2mF+y7TjIBaMNYqG1g7dZY=
X-Received: by 2002:a05:690c:92:b0:7ef:e7ec:b6e7 with SMTP id 00721157ae682-8118107cb17mr55744057b3.27.1782910332829;
        Wed, 01 Jul 2026 05:52:12 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:60e4:f1cd:c4d2:6ac9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ad331d7sm7358117b3.15.2026.07.01.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:52:12 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:52:11 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <akUH13qbsEnJLgQu@zenbox>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>

On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > from accessing unstable internal Landlock fields.
> 
> Generally speaking we don't want to provide APIs, either in-kernel or
> at the userspace/kernel boundary, that are specific to a single LSM,
> see the LSM syscalls or the security_current_getlsmprop_subj()
> function as examples.
>

I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
clear precedence for this. (BPF calling into specific LSM)

Is this also discouraged now?

These IMA BPF functions are also helpers, which are more "permanent"
than the kfuncs like this patch proposes.

Kfuncs are explicitly marked as not being an ABI, and are more
flexible for later changes / deprecation etc. [1]

That was partially why I proposed this as a kfunc, and not a helper.

[1] : https://docs.ebpf.io/linux/concepts/kfuncs/

> Yes, Landlock does have its own syscalls, but those are
> "grandfathered" and not something I want to see emulated across other
> LSMs.  If a BPF program wants to interact with a LSM, it should go
> through a LSM framework API.
>

LSM framework API can mean a lot of things. I assume you are meaning
like a pseudo-filesystem mounted interface that controls LSM? 
Correct me if I'm wrong.

I'm a little unsure how this would work with the BPF model. Generally,
BPF relies on type checking and reference checking. Creating a weakly
typed securityfs / sysfs like interface would be very awkward for BPF to
use. Especially if it requires reading / writing files, or parsing
strings, it would be very hairy. It's the same problem with reading any
file from kernel space, it's almost always inadvisable.

Pseudo-fs is fantastic for userspace, (read and write is as simple as
echo and cat) but not fantastic when you are writing BPF programs.

But maybe this is a false diochotomy, I see no reason why the LSM
framework API couldn't have a strongly typed interface into BPF via
helpers / kfuncs. In that case, wouldn't these kfuncs be exactly that
LSM framework API? And there be some translation layer exposing them to
userspace using BTF type information -> pseudo fs? :)

BTF is not just for BPF!

Justin

> There have been some initial efforts to develop a LSM wide policy API
> for userspace, and while it was put on hold to sort out some namespace
> issues, we could move forward with an in-kernel API now.  We don't
> have strict API stability guarantees for LSM hooks/APIs so we have
> some more freedom to do something now, even if it isn't perfect, and
> refine it at a later date.
> 
> -- 
> paul-moore.com
