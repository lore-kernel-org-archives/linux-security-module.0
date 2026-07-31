Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646535EDBD
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537786; cv=none; b=GqfRLlp1tV6FsXHu6oMikFoaLcXBSrI/YO8XCDuvpW5KKA4c46OuFRv41gbcdSLzuzzXFxloxTge9R+vR0mhxrN7IVaqKm1Ex2Xtk1Q+w30e9M9ChIGGMbIi4hYAKU7Oo02ilrBHv58pVD6R5qk01GE/oXKapuOGs0GV/DVi/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537786; c=relaxed/simple;
	bh=C03woqvIExHV5h/UIaI3n1K1sZHQlqLq5pH70aDBmGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j54Kh0O2ee1UxvwMeiy/zcRzQVyKfhJcetzhBBJEgBaTZoCrM6BsZnUwVkAi24FJYlyVp1hCNES6AlvSjbYrb9ucA1wrEqpSBlvpfY5kE9LJ3wzHBP3T1xWYTN6Ux64JuqMRBYW/j4+DNgnu/OfvmnYY/JQHD9Ch5CrmjRpZIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg/40GrO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg/40GrO"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80814edb536so22018077b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785537783; x=1786142583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1v4UKn/6uG59l71+23NwGAdv04bQ2TdT7TPbWb2jEQo=;
        b=Rg/40GrOvySDSLPMZ/bD1FFsrR/RPcShXa9jNGCBO62IEpO42chXH1A8AJYqq/ntUk
         aZpAkbq2JXowSuYb1riL+k9Ho/chX/aqa+vUmBfshV5W7MamK2YsT5sMMMH41fll2UA3
         QqD06fvTPX2g66mygtwGVv4FWE8XFdyuo6IbbiEbCzynI1duduW5V0mQPJMqgsnUu57S
         2Je/4yMsir6xAYF+7VmsEMXhmcynF9ks4vDDi+0h0gOQKv2pC01VekBXo4gE+fQJY7Hu
         t1scUOJUU1psDl0uBieYP8YsT/iMQPAhGD/D4ZwWaHlbUzoeMsPH5a6rigszHa43QIFh
         4HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785537783; x=1786142583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1v4UKn/6uG59l71+23NwGAdv04bQ2TdT7TPbWb2jEQo=;
        b=IOVoPYhwM+4/JJibtu1BfRG0/nABEX5VGx/MMjWbU2mO6dGepmg6Aqror3DSEfuri6
         OteH3lejWZFPQkC2YT4m0Lk/uOXNUhH2qbeX6hRKfzSOYMFhrSW6gvA+zlZnLEKAfyRn
         JxxuaXPZVMnQNroPCN9NmJWazjPQm3BQWWrJwTBpCghR9Fyi4XPw3JWPAXuSsBRTt7Zy
         NNoQoD+fYGGvK1UnoVZf5qd70NtDuFFGz0M0+cXBgdazR3XNoB/5quPtvZimur4GKkeM
         qxCgO1hUF40rREgJwaCvpy0w8SAn3LAYax+nrxSWeDdK/H7Q096KTEnnwNFX+JsfWCrG
         93pQ==
X-Forwarded-Encrypted: i=1; AHgh+RpptnTGdBANajyYM++JG74SPyg4rSabnNNqHsOMYIDKUGwtH2MJ9v9aOxm7p2k/Z+889qYFNX3MFydSMW9IHw/5K4Vv6Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1iRl9QWA1TlEFSuzHPzr9fzwfM1mvJ0OkSAa2627HNiIHBN5
	OuZY6DqP+gdt1zUcnSgBB7ExtvOl2wtJhXseL4CHATlEh5AMx5nK+USthQEut14W
X-Gm-Gg: AR+sD12SGqg+JZlCYhNeDWcv9Qm5alM4eu2SY4dMDc1rAzniXwCAWlSuxfAXDVrBrJc
	u2fpWFhfGNXJwwsr/n6WG3cORj5TmkKyC/IBJ8OXy2A3lq630alrAI/Snyg+dUY4J9dA1uXSM6X
	kkPPbzlDtawony+IQ+9YcX6bDkPigVsj3aP6YhlZQJVCHXQ9XcGm30k553q9M4qi4CqTF1LjKrg
	r+wCg6OcLAunj3W2G7TJ+TIEyY0oeVxx3yRpgd+gJIEAUDGv5J6laAeOAZWjoEA8EaU22MKLeWe
	1ZryWcVDEE0OJASicnImVhcx0Aw7k+GU5LjUNRUef/KElopCUsuzcegoAAf0AUVMdCkN+DRLHsq
	5rPb0vEDDkZKLywesy1rn4MnL2EDFhEnVigbqvk1WzYmrWg2DiFS1BuiBxfhA6XhTe/UZKx4xMx
	Y/GqiUWX5Ow3Kjj0QWJGxk3I/A6Afg6ouLIpsQeivkJsp/zAGfkxKvUMcZUNT3YmhVrtTpPHopW
	4xzOhmcbASppWnMj4+CxA==
X-Received: by 2002:a05:690c:38b:b0:81e:bd02:b02c with SMTP id 00721157ae682-81fd49c6f67mr22166977b3.1.1785537783524;
        Fri, 31 Jul 2026 15:43:03 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d52:64e9:32ac:b832])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccf2cae7sm15549597b3.2.2026.07.31.15.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 15:43:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 18:43:02 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: gnoack3000@gmail.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] landlock: Add LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Message-ID: <am0jI4LruRrmfD6h@zenbox>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
 <20260717220320.1030123-2-utilityemal77@gmail.com>
 <20260731.gagai6she3So@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.gagai6she3So@digikod.net>

On Fri, Jul 31, 2026 at 11:29:28PM +0200, Mickaël Salaün wrote:
> I like this series.
> 
Thanks!

> On Fri, Jul 17, 2026 at 06:03:17PM -0400, Justin Suess wrote:
> > Add a landlock_restrict_self(2) flag to set the no_new_privs attribute
> > of the calling thread atomically with the enforcement of the ruleset:
> 
> It looks atomic from the caller, but really this bit is set iff the
> ruleset enforcement succeed and before the call returns.  Even for user
> space, when we'll have an introspection interface (e.g.  tracepoints),
> user space could see inconsistencies wrt /proc/pid/status showing NNP
> because both operations are not atomic.
>

True, I did not consider the tracepoint perspective. Words mean things,
so "atomic" isn't the best choice of words when it's really an ordering
guarantee. (nnp set if and only if enforcement already succeeded).

I'll send a revised version next week (I don't have any objections to
any of your proposed changes)

Justin

> > no_new_privs is set if and only if the call succeeds.  This removes the
> > need for a prior prctl(2) PR_SET_NO_NEW_PRIVS call and guarantees that a
> > failed enforcement leaves the attribute unchanged.
> > 
> > Because no_new_privs is set by the call itself, the no_new_privs /
> > CAP_SYS_ADMIN requirement of landlock_restrict_self(2) is fulfilled by
> > construction, and the related EPERM check is skipped.  As a consequence,
> > an unprivileged caller passing unknown flags along with this flag gets
> > EINVAL instead of EPERM.
> > 
> > The attribute is only set past the last point of failure, just before
> > committing the new credentials.  When combined with
> > LANDLOCK_RESTRICT_SELF_TSYNC, no_new_privs is set on the sibling threads
> > as well, in their commit phase, with the same atomicity.
> > 
> > Bump the Landlock ABI version to 11.
> > 
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > ---
> >  include/uapi/linux/landlock.h | 13 +++++++++++++
> >  security/landlock/limits.h    |  2 +-
> >  security/landlock/syscalls.c  | 28 +++++++++++++++++++++-------
> >  security/landlock/tsync.c     |  8 ++++++--
> >  security/landlock/tsync.h     |  4 +++-
> >  5 files changed, 44 insertions(+), 11 deletions(-)
