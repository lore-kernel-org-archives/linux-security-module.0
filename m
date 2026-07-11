Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A27E0FF
	for <linux-security-module@vger.kernel.org>; Sat, 11 Jul 2026 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783789225; cv=none; b=av6byJejCkcW8WDLQI5xXYPjvpsl1IYGzD4R9M0YGUgROJbnmaAmJVjezrG87tIxbOhIzYXjRURkUgzMFSanYWT6Y4KM1Wy22gccXRLxTf+gQO34nKYmY3xDUz/KF2FWe6BC5Ru2vRWeIzPzNYECSB2wlswhKCX+vBar/JR6dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783789225; c=relaxed/simple;
	bh=SrfSHOODJUNj8BTYgylg0bxjOcqh/GzFa7Hc7vCucRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p72u6h4j/NU4JRtAKNYsRm7AqVOqpv12R0M8h1epuYe77cqmos5izDCbZ1kL82qHv0Ga1hDEyCl8dez9H96W4/vHSiN6lLxxRiintfX7MZnphX9yUzxTs3BWChgz2PjhVic3JwuVPaXIjQ1Kzt5NSFb/l13/NIiPuFZYuCVL0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e40v4pGH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e40v4pGH"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ff20870ac7so13789656d6.1
        for <linux-security-module@vger.kernel.org>; Sat, 11 Jul 2026 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783789223; x=1784394023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nGFH011s4Tb4tCMP2jcxwxWz+vaN5/S0KxUXL/HUq8=;
        b=e40v4pGHS2sKbPnCnqv6y0NVMzaENBuEar2bAv+u64fNHl7o94yuTU0AvyoeQmrG7/
         EM+taTHfSdDcFnUAAR2HVElzWvb089aFwMMB6ks4PSqfEnzm8yGZfUC/8CHfKQcEBwC8
         tCFrPLkYYc3KoVYorCs3XegrOe/GLQ9SH60l4lIZfqVH64gIjzReWrTYI5HMyBghRN4h
         9wYPniyKJg9JhWA1LpCNuNDmb+YgTlSuGMp8W/GJSDx5tNnqsFvueDZtATqDvsO4NoOQ
         SrF/AzF438OpU96Vt1W8SpnhEjA7s09zoZls3oB1uA21jL0SuTvpXG0zS0MjE5l1PVop
         9Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783789223; x=1784394023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8nGFH011s4Tb4tCMP2jcxwxWz+vaN5/S0KxUXL/HUq8=;
        b=OivQC4IgYo4Z87te7YdSx8poNvfCdKlVd6guhJ+5OowvDAmIWcBBRQcWfXhn2VmCwr
         053QvEpEdzbBPXZ684FIgsisEV2pLOpU8xK+xAndXw20uBahmxh8TL7FkN6hb0M4Ri9c
         oeYvI44VxBcPuIlRh5rixWAKcR6FVsp7S3E/IOyaUfWgOauxCSY8jko538UWSextnXzx
         A/4QqhKpxS/Ew+WD6EprJQzz5ThKzSNs6FVAYnKVLLMkfh6Hx7KOBYZnDs21Q0XLEEo3
         IVpSNVhw8wNSn8qWjTyPM6r16iQuuYFy3sDCFMSpR0JWgcZDhJMtxB8zCrOoG5Xini1R
         FKRg==
X-Forwarded-Encrypted: i=1; AHgh+Rrmgh86aYV9eCpHI2dKMBnKErGZtM49vwd4wj1G9KAsmsEIuzdrx119R2i7oeukkw/cevRkPpxVBhkwC28dlmw2VDIZ9hI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9YsLNqN59N8zooQLlX7++JVa3bkWeZQtySjmW++VRjBtsqOm
	3xZEDvzqAokgRnEHZXyjWkaVlLfWI9HdTztJy2VlVbyPxQB9leWB7zWm
X-Gm-Gg: AfdE7ckHbM7Gj7hP2/J8PG5P8teJ6SPFepKtnNrUbzHL6WY1O0IZCulPXqYe9HDdLlS
	8kZUic7Zud2VMZuQ4qeengdtaoYAZmYUXt+uY6OMXTkOv/bnfx8cwX0B/RPJK8s7LjePeUZocg/
	o87hg67ByPxm72m+ExvkWKK992BWPb/k5jH0+v03kAwReiDIAPUDzdyj/9pjJdq4ZEJ1ybMRqJp
	99W7/2HfaUvS7T2I1MIY8gZZXGE21Kf2j01KFJBeFClIljQD928wgFBLPcIdgOnfISlMhrZ/tiy
	UMGR65iU34+qAa7ZD+04B4TqUJ/t+K+9Xky5lWz+vreEd1XzVxDezjgQrZGshr8Km/+tGGx1GfC
	jyBmYNhFSg6wyQDafAIHLqK0SqNsLCfjj32lFvaNNIowwzrceM5yte3C/z6XucggfXkhEyRxTXT
	8cp1XR0hjx0hleHcMf1/2jTIPOlQRyhnOsEWpjQzNh0FM=
X-Received: by 2002:a05:6214:3c8b:b0:8f2:fbb1:cec4 with SMTP id 6a1803df08f44-903ff04ab42mr46479466d6.19.1783789222403;
        Sat, 11 Jul 2026 10:00:22 -0700 (PDT)
Received: from suesslenovo ([65.215.34.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm70924476d6.6.2026.07.11.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 10:00:21 -0700 (PDT)
Date: Sat, 11 Jul 2026 13:00:20 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Simon McVittie <smcv@collabora.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, gnoack@google.com
Subject: Re: [PATCH 0/3] Implement LANDLOCK_RESTRICT_SELF_NNP_ON_EXEC
Message-ID: <alJwpLRgqpKXAutX@suesslenovo>
References: <20260708133928.852999-1-utilityemal77@gmail.com>
 <20260709.Eaphooyoh6sh@digikod.net>
 <ak-EgMPeFtH8MAQP@descent>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak-EgMPeFtH8MAQP@descent>

On Thu, Jul 09, 2026 at 12:22:40PM +0100, Simon McVittie wrote:
> On Thu, 09 Jul 2026 at 12:09:25 +0200, Mickaël Salaün wrote:
> > On Wed, Jul 08, 2026 at 09:39:24AM -0400, Justin Suess wrote:
> > > Consider a sandbox launcher that depends on a set-user-ID helper, such
> > > as launching applications through bubblewrap on distributions where
> > > unprivileged user namespaces are disabled and bwrap is installed
> > > set-user-ID root.
> 
> It's perhaps worth noting that the current version 0.11.2 of bubblewrap
> deprecates this mode of use (it will refuse to run while setuid unless
> that was explicitly enabled at compile-time), and the next release 0.12.0
> will also remove the ability to enable it at compile-time.
> 
> When bubblewrap was first written, having it be setuid was a necessary
> workaround for kernels/distros not letting it do its sandboxing job any
> other way; but now that unprivileged user namespaces are more widespread,
> its maintainers have come to the conclusion that when it's setuid,
> the risk of vulnerabilities that allow a root privilege escalation
> (CVE-2020-5291, CVE-2026-41163) is unacceptably high, so being able to
> make it setuid is no longer a good trade-off.
> 
> > > This flag also closes a gap for CAP_SYS_ADMIN callers of
> > > landlock_restrict_self(2) itself.  The no_new_privs/CAP_SYS_ADMIN
> > > requirement exists to keep set-user-ID programs from running confused
> > > inside a sandbox they do not expect.  However, a privileged process
> > > that enforces a domain without setting no_new_privs leaves that hole
> > > open for all of its descendants
> > 
> > In a nutshell, not setting NNP might be risky, even when not strictly
> > needed.  We might want to update the Landlock doc with that.
> 
> If the CAP_SYS_ADMIN caller is setuid or setcap, then it has been
> granted special privileges by the sysadmin or distro, and part of
> the "contract" between the sysadmin/distro and the setuid program is
> that setuid/setcap must only be set on executables that have taken
> responsibility for ensuring that they can't create insecure situations
> (for example bubblewrap always sets PR_SET_NO_NEW_PRIVS, unconditionally,
> for this reason).
> 
> A large part of why bubblewrap no longer supports being setuid is that
> its maintainers don't want it to have this heavy responsibility.
>
Understandable. I guess my usecase proposed was narrower than thought.
And we probably want to avoid creating risky confused deputy scenarios.

So now I'm leaning towards the LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS path,
dropping the "ON_EXEC" part as Mickaël proposed.

But I'm struggling to see where the value is added over the prctl call.
Sure atomic enforcement with the ruleset is nice, but not a huge value added
on it's own.

Perhaps the setting of this bit with a -1 ruleset_fd could enable auditing
of the (failed or successful) privilege acquisition for the domain via the
fcaps/suid/guid methods w/o setting NNP? (otherwise this would be no
different from a Landlock specific prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)
call).

And setting it with a non -1 ruleset_fd would set NNP *and* enable the
same auditing.

That way we are making this a "value-added" flag instead of just a landlock-flavored
prctl call.

This would work well with the LANDLOCK_PERM_CAPABILITY_USE proposal,
which allows us to audit both methods of acquiring new capabilities.
(the clone/unshare path, and the fcaps/setuid/setgid path).

What do you think Mickaël?

Justin
>     smcv
