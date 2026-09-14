Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815D490BE9
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789406001; cv=none; b=m6gcj1lTJoHpCkyjAoFBgma+nvmtrR+YkOVTcdlkfmg5ErvsU3wApEUAw9obNReq/lXdUSzCA7za3wopRUU11nDkzTDVffoQOeFChzdEqsMT7lJJp+USEgvijYMF6DnjPzzKr9PWYY1a9wnahf/O7e+ehbwFzlaNtWBH7J/Tqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789406001; c=relaxed/simple;
	bh=DWfd+OrYYBBAjoeKGlYddJuwoBUWlcnOVSA19p7gCPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgRYSDAdOhQbH66t6DbCpQEM8k6MoQspkEtsfsQL18qMkalibG9gIr5Evr9WCM7o/cQHZnlMdiKoexKkVDFDW/nQSL/SVCWvjmv4RfDASWscOP0fSjKifHxqAOY8CPW6xR/AuC6zBDndcDckGC7KnjGVj4tLc7CWtYNDAKRHyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFRnhab0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFRnhab0"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso43053945e9.3
        for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789405997; x=1790010797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+lHxHvQW6ptoO5MEGq5MTyGK+6vHvFuZMkZJq4Ndzc=;
        b=MFRnhab0hntRf3ahIUL7wo8NO040OIvRogUEtdFVo5Nwzda2TxxX+GMt2UJpWJmWSu
         Mzvfa2b+TAPy2v3XccD8smBuVpMu3aA8MnscuWlty7Vif266e0Qt2sHReOST2yhq0zBk
         NKJwrOlBWXjWRm/jl7visdu6zMyfwDnPOW/HYfgxWuY+3zbY+EnptwdRNxqQHQCfedVH
         kNkdmetUgF8RBD4bfBInEvRgFOfrK3s0X8MtuZETdqJbbBj5CIi/NNWtS25xK/JIGLno
         VAg65NrBfqvdDs8n7vIxAsMaJdxkay2oAEaGI5sTu8rOJVDMVnWP/HMz2L+QStne0OGg
         PvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789405997; x=1790010797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b+lHxHvQW6ptoO5MEGq5MTyGK+6vHvFuZMkZJq4Ndzc=;
        b=dAqiOeGtE7mn1bHH6TMNp8FuRk/mwzi0y7s5Wyyl+iy7lWcYf4IQU7diP2M3bVbcYD
         MEwd9vh5ToYZlsDMtnn11a6CgKmetqEXZM0jL+LBdZ+AMJvwXHCd2ZmzipB9Ml+25rhZ
         wNWA6K9jzhw/YopxzY/rcDjS127HvQQcvlSmkTZQ5pf9fCoR709ZYPV5f/y5AUMQ6Ams
         dj7kV3GlsCu0gblBI5Nc1Aip6qCkardSn0dpAOnEhFlvyM3d/p5unwMdgrNIWwm6p+Ot
         rPkTKGfFKFOMNDBEQrezl63cqSS0xyUybG4C20kEUa5JI3GcyFlNoiQFNit4OB7X1A3q
         yoKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfWyrsFT0nz6S/H5CG1WfsMj3gEliPTrYjfOIzBUWS1phE1ih31x2AXP69lfIONbohGjOq3c/Djlnhny5e57HW69D429c=@vger.kernel.org
X-Gm-Message-State: AFuF++neTQOCWS99EwtCr9rFE5g6Zd6GGLrw0WQKWDed+Dbgr1qTEtuO
	U23/TE9KGydFNW/QllqoxtjLBL9WfdqO19rkfoJv8K42iFRB2eJeiF96
X-Gm-Gg: AYBFou0NIBJGeS1CqmZb5D5wJdDA45BwukLvGs5qERNbVBT9eixXkzLOrGqC7Do3NEx
	39AFtTqG2/pN2b2KYe9D6bltC2v0weEEdqeMK6cFaMJAe89Mw/vd7q6r6xaC8zZ7Z/IUYSFwjXH
	ZwAmnwjDvXSHYeHY2hBZuac2o0hdx3+kX023AJWUYdH75SdMeGTqx+dQdhYVZm2JWKZl4R+FaJ6
	djCcCGWWbAtlkxNZ6BAOtJCZm8EzFCuvwuNvmvwb3WITM7EaCZ+PrU2RxUmbJD8uiSei+yxzcnn
	kXTIr6t4PMzLp/Z7ZRjnrbRMoazsIyFHEjqquUoRMAEyK9gdiZZzYhctDicTqYBCF8FkLsbi36v
	DUGk4bkZdwuknhO2rqsab6AkokXs4JukGr5pOSKWCULrSPTFWcbMnInfMGPcoKbo0SXZ9dNlTQ9
	fGBOhcub+plUkCMiC9BO6F71siCdVH524+GxH1e5o+4Q9rsSXoQX9AGhfxMKg23Ila/gGlaNHJc
	VQOc2o4APwOPCWfVVeJOaM+
X-Received: by 2002:a05:600c:3585:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49e7a64b723mr52892565e9.10.1789405996936;
        Mon, 14 Sep 2026 10:13:16 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d675a50sm6040645e9.9.2026.09.14.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 10:13:16 -0700 (PDT)
Date: Mon, 14 Sep 2026 19:13:15 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Oleg Nesterov <oleg@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Landlock signal scope and TIOCSIG
Message-ID: <20260914.239dc75285d2@gnoack.org>
References: <20260913221958.839429-1-clusk@northecho.dev>
 <20260914.b8a029f9abb8@gnoack.org>
 <20260914134013.1457130-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914134013.1457130-1-clusk@northecho.dev>

Hello!

On Mon, Sep 14, 2026 at 09:40:13AM -0400, Christopher Lusk wrote:
> Your capability framing convinces me.  Controlling who may attach to (or
> open a master for) the PTY is the right layer, and the master FD is best
> thought of as the capability, the same way socketpair() is.
> 
> You are also right that the series is incomplete as a fix: the same three
> signals arrive through the n_tty control-character path (Ctrl-C / Ctrl-\ /
> Ctrl-Z) that my patch does not touch, and PTYs additionally raise SIGWINCH,
> SIGHUP and SIGCONT.  That reinforces your point rather than mine.  Chasing
> individual signal-delivery paths inside the TTY layer is the wrong layer,
> and a per-ioctl hook would only paper over one entry into a mechanism that
> is working as designed.
>
> One question, mostly so I have the line right in my own notes rather than
> to relitigate: how do you see this relative to the SIGIO/fowner path that
> 4b80320ca7ed brought under SCOPE_SIGNAL?  My read of the distinction is
> that in the SIGIO case the sandboxed process unilaterally selects the target
> by arming the owner, whereas here the recipients have voluntarily attached
> to the terminal and the TTY driver delivers job-control signals over that
> attachment.  If that is the intended boundary, it is a clean one, and I am
> happy to treat TTY-driven signals as outside the guarantee.

Yes, that is the difference why SIGIO had to be protected -- in the
SIGIO case, it was the already landlocked process which could itself
select the signal recipients through fcntl(fd, F_SETOWN, ...).

In the terminal case, it is the TTY-client-side processes that select
which processes are attached to the terminal.  With the PTY master FD
alone, it is not possible to signal processes that aren't already
attached to the terminal.


> If it is useful, I would be glad to send a small documentation patch making
> that explicit: a note in the SCOPE_SIGNAL / IPC-scoping section of
> landlock.rst that TTY-driver signal delivery (TIOCSIG and the
> control-character path) is not mediated by SCOPE_SIGNAL, with the practical
> guidance to control PTY attachment instead.  I will drop the task_kill
> approach.

Thank you, I would appreciate that!

Thanks,
–Günther
