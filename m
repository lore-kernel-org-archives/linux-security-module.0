Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E741A56A
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985219; cv=none; b=IrabSR5bvwijKC9qT0YuPsRssfgvKjyfJBGiwuNEjb+PWVXoV9c8Gu5jeIvO8OPfYOsQ3ciiMn56ZvoerfgD7zCYPyXlMmCUFxrYb1WwgHHg4t72fMsSkZtSUqT6hTUnS/IxhhmneT72CKh6R19OIdjA1rIWRHGVR9hpee3t8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985219; c=relaxed/simple;
	bh=9jw50TickrTaZQXgt5lOY+a4WpEkiifrBIEHCEFDnmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilH5MYkmWM/98G1pg1xMFI5kNJmHfD7ejqgAvSH+kxPTsRZlObdd2K8ACcHw02D8KlTVy7q/tvUv7lc936TdarWwcbilbwaZkwGWxJAVeyqsM15sIr0aWWsIljO00adwVU2ijW9vaPCr1Yd710NUPD4rosdnLWGgpAWEtKdkP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NktLe6PE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NktLe6PE"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-878ed0f17bfso44782297b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788985213; x=1789590013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N8UCfmj+BAmm+9KzmB0PX4qemdmhN7ZLk+S/oBX8ZU0=;
        b=NktLe6PEfo9VLJqPjt9OInn2zHhCM6DYzZwkX1imzBBVHl9Y2ZMtsE5ahTdRFsMiGE
         j9+PVsvNYl/Qpo8WY2lLohGaOGMLSBdnRxLTTBnWMok5ndj9zfMncKXxV84TmYgm8yVc
         qA4lOw9QdPhM+C8Az1zdB3l/FVgDKa5Ll0QJYhK5WydkPezmGEtNFEKUJ4RBei9DcbCf
         UJU3uuevT4Aa4VfmLjCT6UF2RlHVbG4wgACzUCOLOyA61GzrYvJLOPeVC5DYkUhoKkUy
         3mGSM7/AHmOKIUkywNguJuoVnq+wd8vo1ZIi5LDl35t8dldYLkX3/wCSqvbp0haLwh9L
         aSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788985213; x=1789590013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N8UCfmj+BAmm+9KzmB0PX4qemdmhN7ZLk+S/oBX8ZU0=;
        b=o65lDc98mZkoZdkB1vwMv4xheq2i+dUL9L6uULP8Mg4m9azPDardT4a668SrEN/2SH
         jVgzoTuBEnByMhqkvs2U/MBy/sjeD23ot3enq/XggtpfNKfwIv2yAAzYcTRg41gKsZQY
         MHQIvY3vND+fUk4hi5aMf7Qv2jUXO1FZw3N/jVwNyeUY4cRR5kOVWmJsivuqmEppDrAQ
         6GbyNthO+JoqLPEa43hxpSHRBOT/3NcKaibNJsUh8f+08BcRBCyDWEhC+BAaWqBRVG2T
         JjdUmXH/g4Of4kXuExUeCrcZpa3j+wF5ngMlPthku07/v8Rag6kxw+WEZx+MTzg5gV0H
         JlEw==
X-Forwarded-Encrypted: i=1; AKwUvBxdGTvaRjdRTs4XV1N0lMxbHqEu09ys7sZYQ+btBW423ZdG3pwuYEtq9WXzMI4c5WtgxChywBLTBB2UezI1PkWk2I/Jd6w=@vger.kernel.org
X-Gm-Message-State: AFuF++mWc0MEc+sbg6yb2Li8QcckmP01yR3ejDcwjJ58kFvlhBNbBPDX
	l9ID2V/bo92OBFiQc2VfiLc1GHHjhOlp/6E2nB/czgFRF/7//b5t5N8m
X-Gm-Gg: AYBFou3EMv6Q+NKwmBqY+EuaKXKvcsicAMpEml97koSu1+gw8rOqa4GcBFXhB6+ICco
	vuAkzSV8n9Eb8vGvU+3WZM05aHQqXtydxEBE3F+Z0TR5tA7Nr7yBlEiSEe2sgA0Qocyg4tjQsFf
	Wd7cRLomPJiNwOKhomq89HC1rAsIC6FaVIejm8lR12+kap9B4kYqJwN7mbcQAdycrxBDlF4fyr6
	7+ZibKjyfi6dxdwDLglyaqL3TQCbtEe2TuUHH7Z7RgHY1GNgecgQlin4L9isf74bI81nhAtQkNJ
	2XSzMKufaz5UdVVWERvxPTfRl6owj317hHMjLcM028sP0fdMNqUosfhnLt/F9xtOWe3JLPzismW
	W0spuBKE1CgSr3ku7JQ9GGPhBqEY0LCcMznfHucvLbJZ7SQ1l4eV666GUNYYCnOIwH+v5+EKRWm
	qwkMA83oJaj5kk+qBG0mq3UHcnfQ7BYPs3ghgVeJGx155ri+1aZ3bbM9OK3XhtME6cSrx8ll16s
	opdvKlPzOmGdWa5KDGQ9xFVkaDe3Kp8
X-Received: by 2002:a05:690c:e1e:b0:873:5ddf:d87a with SMTP id 00721157ae682-8735ddfdbd2mr117164447b3.69.1788985213338;
        Wed, 09 Sep 2026 13:20:13 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8821dd9932csm2117017b3.4.2026.09.09.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:20:13 -0700 (PDT)
Date: Wed, 9 Sep 2026 16:20:12 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 07/15] lsm: Add the bpf_lsm_policy_apply_bprm
 kfunc
Message-ID: <aqG7XUBqmUftjyyD@zenbox>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-8-utilityemal77@gmail.com>
 <20260909195500.DA3E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909195500.DA3E31F000FF@smtp.kernel.org>

On Wed, Sep 09, 2026 at 07:55:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The attach-point authorization boundary for `bpf_lsm_policy_apply_bprm` can be bypassed using BPF tail calls.
> --
> 
> commit 7b53e20161b20c35fb85beb1fba538fe85514074
> Author: Justin Suess <utilityemal77@gmail.com>
> Date:   Wed Sep 9 19:37:10 2026 +0000
> 
>     lsm: Add the bpf_lsm_policy_apply_bprm kfunc
>     
> This commit introduces the bpf_lsm_policy_apply_bprm kfunc, allowing sleepable
> LSM BPF programs to restrict credentials prepared in a linux_binprm. It
> restricts this kfunc to specific execution hooks (bprm_creds_for_exec and
> bprm_creds_from_file) to prevent policies from being applied at unsafe points.
> 
> > diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> > index 43a4bf57fd31e..857e9a316d1cc 100644
> > --- a/security/bpf_lsm_kfuncs.c
> > +++ b/security/bpf_lsm_kfuncs.c
> 
> [ ... ]
> 
> > @@ -141,11 +202,18 @@ static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
> >  
> >  	switch (prog->type) {
> >  	case BPF_PROG_TYPE_SYSCALL:
> > +		if (kfunc_id == bpf_lsm_policy_apply_bprm_ids[0])
> > +			return -EACCES;
> >  		return 0;
> >  	case BPF_PROG_TYPE_LSM:
> >  		if (kfunc_id == bpf_lsm_policy_from_fd_ids[0])
> >  			return -EACCES;
> >  
> > +		if (kfunc_id == bpf_lsm_policy_apply_bprm_ids[0] &&
> > +		    !btf_id_set_contains(&bpf_lsm_policy_bprm_hooks,
> > +					 prog->aux->attach_btf_id))
> > +			return -EACCES;
> 
> [Severity: High]
> Can the attach-point authorization boundary be bypassed using BPF tail calls?
> 
> This verification-time check inspects the initial program's attach point,
> but does it account for runtime context switches via tail calls?
> 
> For example, if a privileged user loads Program A attached to
> bprm_creds_for_exec that calls bpf_lsm_policy_apply_bprm(), it passes this
> filter and can be inserted into a PROG_ARRAY map.
> 
> If they then load Program B attached to bprm_check_security and perform a
> bpf_tail_call() into Program A, the tail call is permitted because both
> hooks share identical BTF function prototypes (int (struct linux_binprm *)).
> 
> Does this allow bpf_lsm_policy_apply_bprm() to be executed at
> bprm_check_security, creating a TOCTOU vulnerability since the execution
> can still be rewritten by an interpreter?
>
Yes you can do this, but no it's not a vulnerability. No incorrect state
would be created here (in bprm_check_security, creds are still
uncommitted), so there's no issue in actually just letting a user apply
their policy there...

I'll probably just add bprm_check_security to the allowed hook list.
> > +
> >  		return 0;
> >  	default:
> >  		return -EACCES;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260909193719.518517-1-utilityemal77@gmail.com?part=7
