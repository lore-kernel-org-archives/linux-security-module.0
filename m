Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E023DEAFA
	for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2026 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966601; cv=none; b=lNIXvJ4p5I7FTS0xH6JdULgcrBku7kXsVkTmmkC9em/CUhMtQ3g/Uu02YeFnPwDvtqpTKsDuisU9j+SGq82QDgQ93Z3nIF+8RsEbCIC51RZ9S5R3obzT/1NrblU4IFlBHy64gHvnrnZ7ke8bwRdu5lPTciGig83lnFoIpbTCiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966601; c=relaxed/simple;
	bh=2G8EukvGpvx5Kksh0ypndv7QdvrNfaeHKcAGog1h//Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejk1cZqzIjGewY7plW7a8kJscQgCROeGOUDjsGAkQwLG8OwpBl8CVp3hJ55k+qF/d5at2HH3PTRc9D04hshxpga7xrUrndn6J67lB5oNXQbzuC6+6x/sWWpZ/c9kFZRBin5mwMiWmog7wbYthIXzhUdhgni1mET5vPf2+NDpjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWol0ns6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWol0ns6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81f64e8dfbcso22738327b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2026 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785966599; x=1786571399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rcC/Ynktsu506yMWSubwFtSKyJoN9RzKxppS0dEA8wQ=;
        b=rWol0ns6QNt6Z98Iw7wlt+xas8bQM33SV335o4WahbxpDMb0qaqU+B6wuDRLbTypzZ
         +o6Ov8gQ8dKVHzVbZhaqP5LasTkSuel1lNilq3aCedii8K//DX9jECU5ZGPuRWpCdcbb
         eyXKhmsZ1m4dY7jQuC9gZCFGoP16YBKEYTIBGPi9IGsdKPpCh46DCPuhyk/hpmtjK0Ok
         xk25u798gTMLW3ZACLGWMVrzhzvocpeqibmZk66RGrBZt7FhGagyI7ZlxhTpHzj8wEYU
         Wy4obRowJi8mJkGuczOr7eCKMb91kp4d4E8nZm4pR+AWABEAby3r91btIk6IP4Q5oMCY
         dM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785966599; x=1786571399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rcC/Ynktsu506yMWSubwFtSKyJoN9RzKxppS0dEA8wQ=;
        b=jBQl2fZR5H/Yg2LPxbuigs605cuntcosPq379RW7ENFomEJlmv0G23vfAA1T09RN6B
         sHhBWvEXIP9fyBsOsA8YnzpFz/WqWzcFRs6O5M5huPKIZBg/PHJaB87EQGNWd1XyeoDw
         KylNk4K4G3b93za7U8ZW33Rkdec889/9YlKKH+QACc2OFn2sTOTxUtizRETFNDYmD/me
         nLZTaisqVi475BjTN7GYdQ9TAxPaIKZiEMoG1BoakXG1ntb/D+stnboIaNeAINiaMeGn
         SUQIujuqF41GZbUDnh3wdoF0nGdhw7z2ttyJkyGj9pwSNZvfy8kQyFu2NBOEfwwiPo5F
         1pVg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8+Zm89vw/zeVH4JXgvsddQpzuyAMv0EfukddXyAo8HcHok02WgUUd84am6+ju2tmpgqFWUny9E5g3rGrdCTlb3VmZXec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqgAJtXcR92Z8NQVfbPFf5uRb4jS93OeKuIYt2C+OvX91T2OD
	4dZUESjlQxKIWrlYQn5HEZ02qFZwIZYfBP9WezzpnQu2dsq8ko0mcPKq
X-Gm-Gg: AR+sD10ptszJnNt0DJRepkkP4w1cC6cOs/9BpJdWbyKjUjk3w4Einn6AYTRB0KAqPpe
	IyDtmrvN9Pje8wtdh2O7c4SwgUNcxgm6p2UUsnfhD02o6c/ODpJrDHqV/6uUccc1FnRT9h+C/KL
	Nqz1zSIzpQ22MpzlMpn4nd6H4lS1WYQxIDOoE3IPA1PX0F9jDOKeAPumYh4+KLjVSyIJ7emYo9Q
	S7AwZ2Vjbo4k4nvbIU/mCVaPJyAaPL4AAErys/H/5zD0Yl8yMdTz84ZS2RR73cONZEia0aENJiT
	GtYBwoy5cog0zexjdHg3cznqo+Nuz7VYIp3yZkce0CKBUgwX+6VyxTTQLWUo9EvdDtAKpYRLEfP
	U9p2C1DqdSF+Z73M758184CrsnVqBEf3aJzRiO5TuswHW+QjrbJ7NBhulGpwZRmAx3YVtN7TAiS
	Vmqca3qIxKI9ZidyYIsddSlB0qAsvBLYJg8QLXrjv5FKrse0y5WWaKSle7muIBZGR38Iim7qDpv
	F1lr9VuCBmZVBWShLfw1Gg=
X-Received: by 2002:a05:690c:7106:b0:81e:d656:9909 with SMTP id 00721157ae682-8201f0c1483mr63263087b3.1.1785966598816;
        Wed, 05 Aug 2026 14:49:58 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:7d5b:ac23:cde9:3664])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82013452634sm28729377b3.34.2026.08.05.14.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:49:58 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:49:57 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock
 rulesets
Message-ID: <anOvpFMIuwNqDHfA@zenbox>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anOnaGmBTlBW9xwj@zenbox>

On Wed, Aug 05, 2026 at 05:37:07PM -0400, Justin Suess wrote:
> On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > On Thu, Jul 30, 2026 at 10:21 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > [...]
> > As you may, or may not have seen, there is currently an ongoing debate
> > regarding the location of LSM kfuncs that will impact this patchset.
> > Sadly, we don't appear to be approaching an agreement on this issue
> > which introduces some additional risk to this patchset.  We'll have to
> > see how that ends up, but I just wanted you to be aware of the
> > situation.
> 
> Quick aside question: Would security/bpf/ be a better place for these
> type of kfuncs?
>
*lsm-specific kfuncs, sorry should have been more clear.

Justin
> security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> for kfuncs dealing with lsm-specific types.
> 
> One issue with just security/ is it's not CONFIG_SECURITY_BPF. But
> security/bpf is. Right now security/bpf only has hooks.c so it's free
> real estate.
> 
> That way things are more greppable... (important!) and we can have
> proper MAINTAINERS entries per file so emails get routed properly.
> 
> (linux-security-module, bpf, and whatever lsm list)
> 
> Justin
