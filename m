Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846734FF62
	for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506510; cv=none; b=Osyzem6eTgBRXo1hQR4LxquKknsHKYk1H3gxE8W8bPQl1Mr44fUrbxEC5CCmwNvgNfizdWOpYSQNYstfrSC1zFf8G68MHv6X1ixTC/9ySu+0QSmdj1o3jEaAyJ+/rftDf1Q94yHLCuZGnq+zJMR6cWFaNbh4M0FjZ8VpdsLzfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506510; c=relaxed/simple;
	bh=OVt7rF2uYXd5FqrcxZJpOUDanDLfPylOQanuOssiHlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt8qmNC8JLvTSq1t0lTYv13EVCh/1ZaEE5fND72DhgVo+pvqL0CK3wr11BvzQpudXdX/FRbEKUHuc3R7jXvxVoxKNpyK/YSJHf6Eet6cjp+JK6QkgeP2AMsDYmRNVI2Xf5IlvLfgJTjffhdfTTpqTYAHaDeKYqBCkBoUGl3W6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T+O0YTZv; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T+O0YTZv"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f1dso138932fac.0
        for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789506508; x=1790111308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ZAGGN3eayfShEQqBKliqu7mRVw6xYFjSDe0eN2CZjA=;
        b=T+O0YTZv/scLmh99eR7Qpp2zdQv83w8txdifPfjRGkSBLYbD+P7eDNE6aOMuYDkLtL
         ZOjzOWftGiF7Aiu4zdADCezcUGPKD3sxfD0BoFhPGqSB2y51h8PJL/xj0Ry77lisCZVH
         XEHR2J1nt0dslheQPFK1q2A79VnxXvl/pGesnFpPlimkj3cPpcxHaVY/wrmT+8AifDBP
         DQXb4TnZ9nLWnRxfgFjWPYCFBPd/uBvMUUaSD7/aTW8JkGtD8+mZz+4vjTB6E7TCy85i
         ychwv7G2lLL4Af1ivG0zt4PlKKrheiMi66NY4TLSFeiF1OtlZ5nW9cJsaJYaTlvQ0U3v
         LduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506508; x=1790111308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZAGGN3eayfShEQqBKliqu7mRVw6xYFjSDe0eN2CZjA=;
        b=eKoNOBCs+GE3EfKsBH8jVjvjaYTI1jCXCiqOwvkPf/cyjVgktg+OJYxwEcAOp44tZp
         X6uloxOqtgf45U3TJXyl5P5exwd3HnErQFtS91RT3WxMmEcIWv8cxsZlfVwvKNclQ1J1
         6wp41Kt0eBprzja5ViacV6vT3YW3bSB4InU+jsOYYpCe44qewXUbQi2VlwMKMIevJfob
         Cij4nQ4vf3TXM/Hx7MSq5JNgMASHj8iM3smqFFbDTM6vClKLnImclfdHgfbuU+//Ckmx
         KlHRGXasJE4kxsS3pHoo/4nuLb7M79Nu76gxruVxKax2Sh6d90luWrLshkaFhZL1RsmW
         C7rQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMXaId+adAw5/9zkNJUJTHemOkFoyqGrNYwNC7yw8RTZCAFNUeDC4tHHojeFdzXayZ6y8hUNgF+0rjkX22m6fXt/MvKoQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nr8PhyqkJOvu1cvXG0msRbSau64qKZV7D0t5QWkz4yMuSk5p6b
	XynLuELVfBo3Mgz1pARHjdPmkiHgXP9YMV1BplVZGAVkJbG0OxToE21DohJB10fB2Lk=
X-Gm-Gg: AYBFou0X8JSPlpA1az/fDuy80/welyP6wNAvWT3oNaueasYwKBIYYljh4tGlYakrzUX
	ffOdniKy27bQrMCtagedMAj/mNVSkzqcwqLABISrDiru2p17KfesdNXyHt9srBS4vr/DIKtgEIQ
	yQJg8cQTWQzE6NmEzZ0JcWbzIuzEiuVOGFMAjKgFANGZL/xexA481e8FDXqEDLFVOPKFXrQo6xB
	YM2I8dDkTnGrrWgCRioUHcxhBS0VerEyzQfHimRykUYgF2OxbIjpcT8COu/9hNs5XsMWPhd4Koa
	J5wbzIczSu1GFR6uIQvWX6qFMNtQXUeEcYG6a2d8pjcy8IMl/AxOJeNoYnM+AaIX1InRlUiD0JL
	S/s+wmcBQpGwF38OSNUuOQ1YJeChA1nHHMN+gaHBCoeH/Fm2IVfqEnrnl1X7qV2GjOO1Yu/45IX
	aN8/oTuNHwAyrZvD3yrX7v14g5Ik416/IDarUbSxB1sP2tbBwI0fsD
X-Received: by 2002:a05:6870:e0c7:b0:470:e96b:43e3 with SMTP id 586e51a60fabf-482e56fb3d1mr3685772fac.15.1789506508396;
        Tue, 15 Sep 2026 14:08:28 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:1800::264:ac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48429a91b9asm997942fac.6.2026.09.15.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:08:27 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:08:23 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/3] integrity: Replace all uses of
 integrity_audit_msg() with integrity_audit_message()
Message-ID: <ykq6awewbz2f4ckgwrwnubcprlta2trm24by6bw3z2q6u6mr43@gn6ajl46tc6r>
References: <20260727-report-hash-error-v2-0-30e394f524fc@cloudflare.com>
 <20260727-report-hash-error-v2-1-30e394f524fc@cloudflare.com>
 <1214eed319ccb441ba0cd26ce168a0383a3e41c6.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1214eed319ccb441ba0cd26ce168a0383a3e41c6.camel@linux.ibm.com>

Hi Mimi,

On Tue, Sep 15, 2026 at 04:00:34PM -0400, Mimi Zohar wrote:
> On Mon, 2026-07-27 at 17:21 -0500, Frederick Lawler wrote:
> > integrity_audit_msg() wraps integrity_audit_message() such that
> > error codes are hidden by passing an additional parameter to
> > integrity_audit_message(). Since this is a wrapper, we can replace
> > this function with integrity_audit_message() introduced in commit
> > 2f845882ecd2 ("integrity: Add errno field in audit message")
> > 
> > No functional change intended.
> 
> There's an unintentional change in ima_write_policy(), which replaces the
> existing '1' with result.

Oof. Good catch. That was intended for the later patch.

> 
> > 
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> Is renaming integrity_audit_msg() to integrity_audit_message() actually the
> right approach here?  integrity_audit_message() currently has only 2 callers vs.
> ~20+ for integrity_audit_msg(), and the rename forces re-wrapping of every
> multi-line call site since integrity_audit_message is 4 chars longer, bloating
> the first patch.
> 
> Why not simply add errno to the integrity_audit_msg() definition and callers.  
> 

I can switch that around. I assumed we'd want to keep _message() since
that was wrapped by _msg(). And not dealing with the line-wrapping is
better.

Best,
Fred
