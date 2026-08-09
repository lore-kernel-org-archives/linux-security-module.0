Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418951AF0BB
	for <linux-security-module@vger.kernel.org>; Sun,  9 Aug 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786304742; cv=none; b=rNqqK5aTSGQF84J6Aei3hDvvY4DgYsOrdzrFNRfTaPo3a49lRQ42yjopPvhq9XKcikcWm1Y49pLh383uP4a3tSNWejtkJYVdbnlcxujJhdZdmGGmAC8AE3O9VgavOcCtt8an5A8VQWSqMT2FUKV455qMKg264zpe4jcAg8EeiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786304742; c=relaxed/simple;
	bh=RVGUM0WYTCFClckbUJgugww8sjAPTKFJ1PLp/BXRsGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gllr2dOYUnp7WsomiDj3QI18v3B8urgJa/Covpo7i9hHkCVha2lCHUKsPfbO8EpIap5w8wx9LHzaY4uCmP3rdDJ36Z8t7QujJRX2t9l5LWI4arBkNa6nRNL9wSbub4rvzpdiJpUR4KnFHFY3MNgQBtpzh2cAYznutLMVOEwXOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS2Ktk34; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS2Ktk34"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66804667af2so569867d50.0
        for <linux-security-module@vger.kernel.org>; Sun, 09 Aug 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786304740; x=1786909540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFh4T/eci2S2m52SXQx8h3/5mJOanNN0NOcYi2YD+Z4=;
        b=jS2Ktk34ovI1gNLfQHm8CdYBmPll6y/uOnOv0/4YdvgYwgfjempUw/1/9LrLPnrOl3
         Us8rqLyBZpVBVd3fnfTe7wJaXwgMjMMG508agLl3XV2ZYjEYqfpb0vGp0jXnetnYZNcY
         2teMeGh7e5ZtB9SmkUUQtZI6GANKYAFy+7QLOhqtbdxplBESQD0Zxd1Ctzj4KRLIrfD0
         eIrMyxGfIy/Zm6GnFyaOh6EJC9n50p3UUzVuhlO02PTbKArsPZw+25ZG92sij3cm41K2
         NMojoNc5VcQkbigSzNlz13Nrd8Ls1sFiNoRntc1OKQZCGUFqOHDKCLMjsr2FqPtrekb9
         tYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786304740; x=1786909540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AFh4T/eci2S2m52SXQx8h3/5mJOanNN0NOcYi2YD+Z4=;
        b=DRx7FSV6TtLA4qgmEGuqqM5nq4/+q5ZxaIEhkYcCDYdUetAOOIHzbNuNsOMhQcFvJO
         cDN0DxdzssoKc8LqRAOpzGN4hCRYsZkZB2rza6I/wbMPQtIzV038vkPIy8sic/vIV3Ls
         oJUe6lXE0jG2wszmb+7MwPKkIKWgmksJnxFrKuNSPzqqKFkbbreDXjJrp9Q1z/FJNAva
         g5kAXBVbpKfT2MC/xHzSc05L0cV1LYJCYN/faAiN11Hlnwv0pRoG88e48IEod6i3h2Uk
         mIeN2uLIk2MquwC2ufw2t0jHQnZzIN2q40BSMcZ3+VJ9BOEJIIYeANaZxiSpW37DS1R3
         Jl+w==
X-Forwarded-Encrypted: i=1; AHgh+RowvPSBMHP/5uwOj/qjUiPGkacxcO8KbcuT8yltHz8zBh5lvZTrezhiSi23Cebi0mC7SZlWOvDnlKIyRSJf2bNh9F31R0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2eB9rChCMAu0C6nLdV4AzVM949ZTw3LxlnP5un2dryWUmXgpT
	vjrv1Hv15Wb24HhhgGquWfYRbLHiws/5PVAVbkEM6gKDQQAgNmPwba/S
X-Gm-Gg: AR+sD11Eh5aCigQpMa9BWmfcmJOfni+v1CznqqIh6FHwU/6BHstrBci5IZGraF71gR+
	zSwbc1H7JloxoMLLRRFEgRxmaS4sWiSElFn2jMx6X4VppuTRSO9Y2HTH6SPwtAx8PuGC082LPrV
	EN8EDz7sRWHp8YCM+JlEYCuQWDzJHBpMT7rcTFvaJP+qxiP9vtLa/vCcCWCSCRmGOsLcZjKcJCN
	vbb8vGFw3CudR5SnRyae9tGgcQa4r0K0JZCFq67KzsUH2GHgqkeDMheIw3a2O8Jkq0MFJcP+Q8R
	pkf12qzHZ8iCZH/VH9p1YXPQMUaz9D4VPIZjg+L2IKXWmxSLNUPtNhkAtmVp/+6TNBGObzpc5TU
	miy1GDs4jXNV45vrjjtzto9Mg1I0YAMzz/dhS1N/AP3Si8SPs4UWl0Q3oIurHVJF4UzFA0r0bMb
	smsmNlCrYmb63hJX14u1LDDor4IB6qZhBkpx+rD8UbuvNiVclN8EsmoGlvCl9XYQWUkHAdwCSxB
	X24upSbNxbEd99HFF1XDCA=
X-Received: by 2002:a05:690e:484e:b0:667:c09c:4a34 with SMTP id 956f58d0204a3-66ac2e2c8a7mr9546934d50.11.1786304740152;
        Sun, 09 Aug 2026 12:45:40 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4665:53b0:3ac9:3545])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acafd15besm5013964d50.19.2026.08.09.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:45:39 -0700 (PDT)
Date: Sun, 9 Aug 2026 15:45:39 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <anjVVncFmKDSvsBp@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox>
 <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
 <anPAbFzuLOizAhm-@zenbox>
 <CAHC9VhSJ1q59RUtEEMAmiZLLLi92=XO1tkd9z0fr5T7vuhoy8Q@mail.gmail.com>
 <anZIGtlHvTaidOEC@zenbox>
 <CAHC9VhQcysVLosHhuz_FTh+LUH7KSw1hJWmwucmV1G-seSbHHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQcysVLosHhuz_FTh+LUH7KSw1hJWmwucmV1G-seSbHHg@mail.gmail.com>

On Sun, Aug 09, 2026 at 03:18:21PM -0400, Paul Moore wrote:
> On Fri, Aug 7, 2026 at 6:00 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > On Fri, Aug 07, 2026 at 04:36:20PM -0400, Paul Moore wrote:
> > > On Wed, Aug 5, 2026 at 8:32 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > On Wed, Aug 05, 2026 at 06:51:56PM -0400, Paul Moore wrote:
> > > > > On Wed, Aug 5, 2026 at 5:37 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > > On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > > > > > > On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > > > > > [...]
> > > > > > > As you may, or may not have seen, there is currently an ongoing debate
> > > > > > > regarding the location of LSM kfuncs that will impact this patchset.
> > > > > > > Sadly, we don't appear to be approaching an agreement on this issue
> > > > > > > which introduces some additional risk to this patchset.  We'll have to
> > > > > > > see how that ends up, but I just wanted you to be aware of the
> > > > > > > situation.
> > > > > >
> > > > > > Quick aside question: Would security/bpf/ be a better place for these
> > > > > > type of kfuncs?
> > > > > >
> > > > > > security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> > > > > > and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> > > > > > for kfuncs dealing with lsm-specific types.
> > > > >
> > > > > This gets back to the other issue in the patchset that we've
> > > > > discussed: general LSM interfaces vs Landlock specific interfaces.
> > > > > There are plenty of reasons why we don't support the kernel calling
> > > > > directly into individual LSMs, and from my perspective this is another
> > > >
> > > > I'm 100% on board with the no calling directly into individual LSMs part.
> > > >
> > > > > instance of that.  Here it just happens to be that the kernel caller
> > > > > was written in BPF and not C (or Rust for that matter).
> > > >
> > > > The intention is the opposite. The point of the separate directory is
> > > > that the kfuncs can never call into an individual LSM, they only get
> > > > the LSM framework API in <linux/security.h>.
> > > >
> > > > Every kfunc is a thin wrapper over the generic policy kptr hooks:
> > > >
> > > >     bpf_landlock_get_ruleset_from_fd()
> > > >       -> security_policy_kptr_from_fd(LSM_ID_LANDLOCK, ...)
> > > >         -> Landlock's hook implementation
> > > >
> > > > So kfunc -> generic lsm hook -> individual LSM, same as any other
> > > > caller in the kernel.
> > >
> > > Not exactly.  That "bpf_*landlock*_XXX" kfuncs are a move away from an
> > > LSM agnostic API and not something we currently do in the kernel.
> > > Some will, and have, argued that this is more akin to the Landlock
> > > syscalls, but I see (at least) two problems with that comparison: the
> > > kfuncs being presented aren't syscalls, they are cross-subsystem
> > > kernel function calls; the Landlock syscalls were created in a
> > I see the argument for normal in-tree kernel interfaces.
> >
> > Unlike normal kernel interfaces, kfuncs:
> >
> > 1. Can exist without in-tree callers.
> 
> Yes, although I'm not sure how relevant that is to our discussion.  I
> can say that it isn't relevant to my decisions.
> 
> > 2. Are explicitly allowed to change or be removed at any time [1].
> 
> FWIW, the LSM hooks can be changed or removed at any time as well.
> For obvious reasons we try to avoid churn where possible, but there
> are plenty of cases where hooks have been modified, removed,
> relocated, etc. (some without our explicit permission, but that's
> another issue for another time).
> 
> > 3. Can't break builds or other in-tree subsystems when they do.
> 
> Of course.  Rule #1 of any kernel subsystem is don't break the build :)
> 
> > This isn't hypothetical: the entire KF_KPTR_GET class
> > (bpf_task_kptr_get(), bpf_cgroup_kptr_get(), the flag itself) was
> > removed and replaced with a better abstraction within about a year
> > of introduction.
> >
> > If Landlock (or any LSM) dies, there's zero uapi/in-tree cost to
> > removing the kfuncs, unlike syscalls which are burned into the uapi
> > forever, or ones with in-tree callers where we can break builds.
> >
> > I argue that the transient, low-commitment nature of kfuncs mitigates
> > maintainability issues that arise from lsm-specific interfaces with
> > in-tree callers. (which we are both opposed to).
> 
> Sadly, the current situation between the BPF and LSM devs is not good,
> which means any discussion around LSM kfuncs has a good chance of
> turning ugly and something that should be relatively easy to maintain
> is likely to turn into a significant headache.  To be clear, this
> doesn't mean I'm opposed to LSM kfuncs, I just don't agree that they
> are "low-commitment" at this point in time or in the foreseeable
> future.
> 
> > To avoid strawman style arguments, I ask what you would see as
> > an alternative interface?
> 
> As I've mentioned a couple of times now, you need to grant me the time
> to properly review your existing patches before I can comment in
> detail on the interface.  You've been quick to post with new thoughts,
> ideas, arguments, etc., which is fine, but replying to them steals my
> time away from the very patchset you want me to review ;)
> 
> It's up to you how you want to handle things, but my suggestion would
> be to pause some of these thoughts until I've had a chance to review
> your patchset in detail; then we can have a better discussion.
>
Apologies! I appreciate the engagement thus far, it's been helpful even
if it's not 100% agreement. (wouldn't be interesting if I don't learn
anything, or go back to drawing board).

Especially with merge window upcoming I am sure everyone is busy.

Justin
> -- 
> paul-moore.com
