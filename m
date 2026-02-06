Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061E2C234B
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364970; cv=none; b=QhchtjD8fzjvjUulN0Iq2z0lOe5/HCmgUNGmPWkpc5x8vXDFarG2IQ5h04n9PUz3c30We5JGxNJ0EDY+DaR6a8gXvDb3zt/03AHPMHrVORfJh6MxdeT8Og9ceMAhECrJ2QOTO4YaycRV5O0TbLz5uwRgn9XJRzFOSMXrHQrMYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364970; c=relaxed/simple;
	bh=4pTYnlr+BC0SlVm5sB+EHAQiXmZUGFMKCSo0MeLjA8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgNaCYXtNLOR5w2IWTeRBIAogL0Ue7JS/6bRWuVcc5Os45I6lTRA3cUg6Wc7GaLA3NlbxovvVS1gelu9VhtPbf+FihC6IwygrsD4GaCSylLqbUGVbHAVPsbR+VRyVsptMWmbO/OoyVf5hqrHikH9nTQ4ySlvpfGzLev8Lq7vgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF+SHdxW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF+SHdxW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so13727395e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770364968; x=1770969768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYm7UlmVFr29gGkQcRu4cYH67yKXqYEHrfHZmd2GZmw=;
        b=RF+SHdxWxg+1HJeWeLEw6rwqSEWqsXGhZKOo3tpOWaJBApO30hexQSYJhSYlgW0D9h
         mx+b1kjFPx9iOCJjQCt+KaS47KGUrODIAz3zze87whPE92qLZLTk76sifo6xxQdXM2t2
         V9LSi6mPB4hCpMuWZ+gfNl5MJ85eiEpgaIBAUJ9Ch0GS+YAr7Pb4fGVYsBHWzkcRUoWV
         GEI74cEGRalaCu1h3aMmD5f9R3CFbqee4kNT41OEgX/nQ/T7QAJOJmg5byI+88fhRB5d
         69sLsb/ZBmX54HvACT9dkxPsnCSTsIhv7lWAdPhqJ776BCfGVHIad7ptAw6Ehr+tNyQT
         fIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770364968; x=1770969768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYm7UlmVFr29gGkQcRu4cYH67yKXqYEHrfHZmd2GZmw=;
        b=ZGdc7slzgJBrUfIynCd4/adOPxYWWaaZ/SAcoYpDDaDNw+pdH0UJBYoFq6gXuuuJiq
         9FfdwzhwChbXnrnUpeLs2JKJu9wgL7vN86Ng54850UpgD59HoYTRTHd+aOjf1jbiaT7r
         EemgtFlv7/gYkA9wdEL9nUhLwoChpn4WgrEk3yi54VmfvFetaD5Lxj/6wh0OOux4zc3l
         J4DRCMu581xPT03crEYw6HNvirxp381ZD+VnKk34vqYHFZPiaaJZ+PUTtYoxHJJZ0MY3
         rsxN71tnsS+gGHyGHWh6Ak4uM0GUMx7lyuMnNF6E9xzgiiUKGYJJwmrTy+krRJ5p6b5g
         Zf4A==
X-Gm-Message-State: AOJu0Yw3mE6UNtVCPNg5I3DQXeyLBChEDp2ddEhatF1VMB4cUgaLgRsw
	nIUAQFbHeSgHl7Ky7j2nWKHgvK0/si3FvAJ2HIAo9zStkaDAleKRGlN3
X-Gm-Gg: AZuq6aLPvGaIRhl1rJl4zSdXpPISQ/xBfXBRYpQF0/pybVNNeMtdsTP0f6hX39kadXV
	X0MvrbQzodT1QfgchV8Pe4jfM4hZVSktW/aC8a0gMUUE6p3LL7ycZMmJAX7KxAIk5D8Ls+KTI9x
	KJxFb5zXtWjFv/UWV257qh/i7TS02WSgVfjDpeRy3epHamU4FbRVV78f2yyNP923ppYsaQ7rYuc
	Fa1WgCa0LTJXsR9KVUn81kzk1ClSntRAPgufzH/glK8y8QJsw0gmhvsEoWycIyhcJZ64QmDqE1Z
	pADn+RbE9Du7m231LZEzIIdE1W15xYkSFq6lmpCQddmil9Z7lO5c8FyUXGO7Q6JwZ6vv1RLfOeX
	ZoKzQmknQHxYPAoWfngLBq3hLJgpOZ2J2s7lyYUzNWpKB+YK8uBXmfeFto1O74OD1Ezo9AAtUez
	zRazoV5+GNWv2noHVC2fV6+eg0o9mqrCpyKdLL
X-Received: by 2002:a05:600c:3509:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-48320214662mr22420965e9.22.1770364968245;
        Fri, 06 Feb 2026 00:02:48 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209e0c4fsm12031345e9.18.2026.02.06.00.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:02:47 -0800 (PST)
Date: Fri, 6 Feb 2026 09:02:46 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260206.4b383e82c131@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <20260128.quaido7ia0Xu@digikod.net>
 <20260129.691d9b85a887@gnoack.org>
 <20260129.xahm6Ue7raL3@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129.xahm6Ue7raL3@digikod.net>

On Thu, Jan 29, 2026 at 05:54:01PM +0100, Mickaël Salaün wrote:
> On Thu, Jan 29, 2026 at 08:56:37AM +0100, Günther Noack wrote:
> > On Wed, Jan 28, 2026 at 10:34:02PM +0100, Mickaël Salaün wrote:
> > > > +	for (int i = ARRAY_SIZE(masks->access) - 1; i >= 0; i--) {
> > > 
> > > size_t i
> > 
> > This is one of the two places where this didn't work.
> > 
> > The loop goes from top to bottom here, and the "i >= 0" check would
> > always be true for a size_t.
> > 
> > If there is a more idiomatic way to write that loop, I can switch to
> > it, but would otherwise lean towards keeping it as it is?
> 
> Indeed.  We can use ssize_t as in get_hierarchy().

Good point, done.


> > > > -static bool
> > > > -scope_to_request(const access_mask_t access_request,
> > > > -		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
> > > > +static bool scope_to_request(const access_mask_t access_request,
> > > > +			     struct layer_access_masks *masks)
> > > >  {
> > > > -	const unsigned long access_req = access_request;
> > > > -	unsigned long access_bit;
> > > > +	bool saw_unfulfilled_access = false;
> > > >  
> > > > -	if (WARN_ON_ONCE(!layer_masks))
> > > > +	if (WARN_ON_ONCE(!masks))
> > > >  		return true;
> > > >  
> > > > -	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
> > > > -		(*layer_masks)[access_bit] = 0;
> > > > -
> > > > -	return is_layer_masks_allowed(layer_masks);
> > > > +	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++) {
> > > > +		masks->access[i] &= access_request;
> > > > +		if (masks->access[i])
> > > 
> > > {
> > > 
> > > > +			saw_unfulfilled_access = true;
> > > 
> > > break;
> > > }
> > 
> > Two lines above, this loop mutates masks->access[...]:
> > 
> >   masks->access[i] &= access_request
> > 
> > If we break the loop early, we would not actually scope it down to the
> > request entirely?  Is this safe?
> 
> You're right, don't add this break.  BTW, would a test catch it?

Yes, the existing tests already catch that; this happens when we break early:

[08:53:12] ================= landlock_fs (7 subtests) =================
[08:53:12] [PASSED] test_no_more_access
[08:53:12] [PASSED] test_scope_to_request_with_exec_none
[08:53:12] # test_scope_to_request_with_exec_some: EXPECTATION FAILED at security/landlock/fs.c:616
[08:53:12] Expected 0 == masks.access[1], but
[08:53:12]     masks.access[1] == 2 (0x2)
[08:53:12] [FAILED] test_scope_to_request_with_exec_some
[08:53:12] [PASSED] test_scope_to_request_without_access
[08:53:12] [PASSED] test_is_eacces_with_none
[08:53:12] [PASSED] test_is_eacces_with_refer
[08:53:12] [PASSED] test_is_eacces_with_write
[08:53:12]     # module: landlock
[08:53:12] # landlock_fs: pass:6 fail:1 skip:0 total:7
[08:53:12] # Totals: pass:6 fail:1 skip:0 total:7

Good coverage!

–Günther
