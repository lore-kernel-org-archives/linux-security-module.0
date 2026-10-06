Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803E48D89A
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298702; cv=none; b=RKgy8ZKINmLMx448tH5ZiI7dfDS4NxKkF9y8TlTL+rkFysSNSrfQX2XCz8Cf/Am68VldHbcQh1CVuKdgci36D9gQlAmIq3odvVIqo9o8AmzdPf8DAz+z435hMH2ja8RXXPGjSshyiJI9mfKVvAhjxrSW2YZECUaFlUFvNuzdtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298702; c=relaxed/simple;
	bh=rC3FgFtHopZe9bkYKYGHaMtLlbqNScHvoCGayOGsaLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpPE/ttpI1bvrpz2mx6Kr5x2BPe0W7GPJD4MJ8FX9wMqe8OvpNE+X9SaCu6zRSeHaNwjrXPLs+YezTGTxxYr62er8L5QcHxOtEYwqGdDfcgWjB6E+5XONB72zFy1DEnaAYxWzRy5mxTd5W4x59aMq/zz8p9dq0toZjAaSKwhaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv+NiSWT; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv+NiSWT"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-677b5148acaso836267d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791298699; x=1791903499; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VNKYt0wTzE6E0GOCR28wscOUy/GatbkKqCnu23L+CJY=;
        b=Sv+NiSWTV7oxkEWoaimiCDTTbmNNQAbchaLogZFbboPDmMTeb9nmr9y2OrD2pSWHBN
         OuSJfcdL6YMrSMqIUZDa1ggz/eH/c3pz0HNYfWkRnJmlHj1M5whXKkgZDG5sASw6ETGB
         qjhkns644fcLcnGTpSkIAPXhITwklbL0T8aVniG54/XFW5wgsNwMMIh4EySGQWhm9KHy
         uiJ4dbfkqRa4oELObGMVqnREaU46HrFW9hB6UKu8Objhd06WdG4woO9AiBDQYZjdu9tq
         M5Zxt+yMmte2kdrva0zYvDgsUpgXBFyUJvydSxsHQNQZ7KmGAevVT+eolamDkfqyo7tR
         BwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298699; x=1791903499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VNKYt0wTzE6E0GOCR28wscOUy/GatbkKqCnu23L+CJY=;
        b=pywduVyabAMUQwyUavRVO8nq/d3jPn3GE+EwcchAPVJbO1ZPchuzg3bJxLrQqSgfOy
         fAZtA3GhObRIkcnI8tOrtTPClSAJyRtm+faQFPTKgWReaPHee3DpGbnUFlO6uMdPsmlc
         b8pJIS3v9MO/IvGh7SK2M/kTaIa2xsAimX3JWwjD8ZMFoD36nWw2ETya1IasROwKxzLH
         1QPLnenUJcc5HnK95vz8GFWd4aIvMyeFFKRo6GlI1HmByWf9Xw0aHCCYX054BV9lGk54
         hbrOgFMZAlqY85tCMHolea/4S7xlr/YAvd0dIP+UwJrIVQAEQE3DtQ8iij1jtdxZUZrG
         Wxzg==
X-Gm-Message-State: AFq9FYLLHHq5YT8MRUYNvmDA/SRgEoopAIyrnf88uVYEct4ykaI9Y7lD
	w9vuU3CPlxcOaTLOW8qpAUe7VegFnfaJluSdXjuqjRumdeu8UGBMC+SY
X-Gm-Gg: AYBFou3xf3rWRY7ZHjHaz7mGC4IBWo9Z11UN8cFel0iZs0Jk0R2bJ1yqvyB11AWyM5k
	oerxYMGSqF/tclbteEwJ7xpOaj2uEO7bhkirdXIU53B4o/8lR5CdzW3qDYYEoJyRhAcOkYGyXo/
	k3CAd4dNr3YnCzNRSXlDFvXbcY8GbziPVf0Qp0kMsLbvT7XMNvHmf5T8BgF3oC8bhxsrqdVkDEG
	ZsWPodZVLR2aRwgkddNJpaXMjFMuxLhucl9y3nf4Th0OcI6+OIZauPYXBR/RFmIz8+NYjXTo3bc
	6sRAtUKGJd1Ob2nuKXRVHsYFXgj2kx0Rcg19/HkT/UOVL/HWj4/738l0d7phXAVGEw/M04/6k1I
	qUulTtclxeVxEVqylGEHhuBie92duSic+efoGO+E3BEowmm5JB74+cwwpBLdyAOWOSDIqWkidF9
	NNjOvyxAax/+k5TeG2aan7564dwWrzI2ME7sGrb0DLIOCHC2HjUAa8EBehWtSi/OAt+YMM6mDKh
	yo=
X-Received: by 2002:a53:ac90:0:b0:677:af43:e268 with SMTP id 956f58d0204a3-678fce62364mr739752d50.113.1791298699090;
        Tue, 06 Oct 2026 07:58:19 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6dc9:4ffd:1851:60b1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b4a383sm4708693d50.7.2026.10.06.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:58:18 -0700 (PDT)
Date: Tue, 6 Oct 2026 10:58:18 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 10/12] bpf: support "__uninit" iterator
 arguments in generic kfuncs
Message-ID: <asUK2i4229DNzXLI@zenbox>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-11-utilityemal77@gmail.com>
 <20261006003716.CC7791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261006003716.CC7791F000FF@smtp.kernel.org>

On Tue, Oct 06, 2026 at 12:37:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: aliased __uninit and __iter arguments bypass verifier initialization checks
> --
> 
> commit e08b0892f34d46a76c048cb46111b4956bcddfe8
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> bpf: support "__uninit" iterator arguments in generic kfuncs
> 
> This commit allows generic kfuncs to initialize iterator arguments by
> recognizing the __uninit suffix. It updates process_iter_arg() to treat
> these marked arguments similarly to how bpf_iter_<type>_new() operates on
> uninitialized iterator state.
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 066c4b838b858..3294b2a431674 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -8363,8 +8386,16 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
> >  	t = btf_type_by_id(meta->btf, btf_id);
> >  	nr_slots = t->size / BPF_REG_SIZE;
> >  
> > -	if (is_iter_new_kfunc(meta)) {
> > -		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
> > +	/*
> > +	 * Whether this argument is the iterator the call initializes, rather
> > +	 * than an initialized one it operates on.
> > +	 */
> > +	init = is_iter_new_kfunc(meta) ||
> > +	       is_kfunc_arg_iter_init(meta, arg,
> > +				      &btf_params(meta->func_proto)[arg]);
> > +
> > +	if (init) {
> > +		/* expects a pointer to uninit iter state */
> 
> [Severity: Medium]
> Is there a risk of bypassing verifier initialization checks if a BPF program
> passes aliased registers for these arguments?
> 
> When check_func_args() evaluates kfunc arguments sequentially, an __uninit
> argument will set init to true here, and process_iter_arg() will immediately
> mark the stack slots as initialized via mark_stack_slots_iter().
> 
> If a subsequent __iter argument to the same kfunc aliases those exact same
> stack slots, its is_iter_reg_valid_init() check will incorrectly pass because
> the previous argument just marked them as initialized. This could allow
> uninitialized stack memory to be passed where an initialized iterator is
> expected.
> 
> While this is mitigated in this patch series because the newly introduced
> kfunc uses different BTF types for its iterators (causing the bypass to fail
> strict BTF ID checks), does this structure need to be fixed to prevent future
> issues when kfuncs use matching iterator types?
> 
> Should state modifications like mark_stack_slots_iter() be deferred until
> all arguments are successfully validated, similar to how
> ARG_PTR_TO_UNINIT_MEM is handled?
>
I can't think of a case where someone would try to make an iter transform 
kfunc like this with the same BTF types for the args. So this is a
theoretical nothingburger bug for a theorectical weird kfunc.

Not actioning this for now.

Justin
> >  		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
> >  			verbose(env, "expected uninitialized iter_%s as %s\n",
> >  				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006002020.2890858-1-utilityemal77@gmail.com?part=10
