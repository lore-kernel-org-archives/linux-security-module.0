Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202548;
	b=H84nfC6zO6HGnCkyXFTGpvpVztjadLBvkBQ9UBnKiBYw5KLPINMDhZDpPQwZC7sgqT/G
	 TMyLpYdvFf1S0l+YU3rvMKx1uBSFNA8m1U0fqjWHflpaz5h0lQkTN/o3eJPVAFHh79Wda
	 w/k7GkFT5UTq835WWkPWiFxVBb2CgCN4O/6U7yoYXhEOR9pZbqISNEUoJhfamYAG+RAsX
	 abLE9bs1TiyL4encCTf4IDjEZa+CDBX8zd9+ZfsOy7JBEiWCN+lzWilE++xbe+aEwW0FB
	 8kltQvpGE5kopDJPaYqNo9R933GKVGE+pkZcJzf1f3yZuf9cLgDTLY38R9d4FiGSSwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202548;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=U937Qb0/P4HfKcL1UqVVVAG/RUvGr0PvX5tzD52uhbQ=;
	b=Pd0/XNFSQ50DEfJIhkWbY6pLCsX8eIPzkk88pAFfQp96Ce/jOBL7WmX+6qjCj4a0ykKi
	 eeIoof/FyzcERUAS0EJ186yMP57kAe5T6+tfICaxomkFrTX8HSOj+W85aSo31ALD5TMNP
	 qCvjzKoPVpWT7y8Vpo1fdAzRZ3/ykXZR5H3GVnwTxVnBaa6V41jFmc1lJFXzE/FwzWdXv
	 4iOnIS6oxS9kRNOSMQMfoIUCGX+OTVdsFnNPCIXzcqlmu7i+fcf9CIXkwnm1LhRg7/OMv
	 ucbSK3XKjp3p+Fd6HRgKHp3X29i1oGGBe4Yl4mAuVa/EY5c467zoBj9dUi3BVdoHJ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=lxmGaqmt;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99750606A6C9;
	Fri, 20 Nov 2026 19:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99750606A6C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=lxmGaqmt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795202544; bh=oBWWRRfSGFK1b3fXhjlcZYDLOmWBepiHtDJvYGZLiXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxmGaqmt8MhlNfdFX3vbbm30duCyV4m4sY3S7PbQGopWMNqtxAp5LxRNUehFeAo+L
	 tcBKXp/ZjBFmWn7ebaW8CKyIui9ecyyvnm3gS9DpH2Ti13d1t/Uq4tlsLBpFj+7I21
	 CNUfK3oT5nF0qD9NN4zDv1x4Lg+bjMAgKloK+ZNtLKxXMGTYu9FoDWOxBcjD5FiAd4
	 8YMazj1kPszerM0ro7/1oXheFOMwwCffi/7qa4FAJonOBOBx5Kw1tb/iyvNB0DGYYv
	 8aAX/H0AEHMpBWf8UY9hOGFaTaTquzDh0oXhTNuNjf+T2D9gxGex3ioNIHOd6Y5ue+
	 UmLKiTlkCotBg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 72ABC34F; Fri, 20 Nov 2026 13:22:24 -0600 (CST)
Date: Fri, 20 Nov 2026 13:22:24 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Bradley Morgan <bradley.morgan@linux.dev>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: security: Inform LSMs of capability check during
 userns creation
Message-ID: <awCd8Mbd3JpY+18E@hallyn.com>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev>
 <aveDlb6PlPSVoLD9@hallyn.com>
 <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev>
 <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
 <20261117-brennen-tastatur-ekelhaft-22ee93d5200a@brauner>
 <69BA4071-048F-4D90-9936-4B4856AABDF7@linux.dev>
 <20261118-vorkommen-achtzehn-abonnement-6e7e8a08c9cc@brauner>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-vorkommen-achtzehn-abonnement-6e7e8a08c9cc@brauner>

On Wed, Nov 18, 2026 at 09:41:33AM +0100, Christian Brauner wrote:
> On Tue, Nov 17, 2026 at 04:36:54PM +0000, Bradley Morgan wrote:
> > On 17 November 2026 16:31:16 GMT, Christian Brauner <brauner@kernel.org>
> > wrote:
> > >On Sat, Nov 14, 2026 at 08:34:07AM -0600, Serge Hallyn wrote:
> > >> Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
> > >> 
> > >> > On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
> > >> > wrote:
> > >> >> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
> > >> >>> Right now security_capable() gets called in create_user_ns() to
> > >snapshot
> > >> >>> whether the parent could setfcap, but the LSM gets zero context on
> > >where
> > >> >>> the check actually came from. It is the same story as setid: without
> > >a
> > >> >>> dedicated flag, security modules cannot tell this apart from regular
> > >> >>> capability checks.
> > >> >>>
> > >> >>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
> > >> >>
> > >> >> This should be patch 1/N in a set that introduces a user of it
> > >> >> in some lsm.
> > >> >
> > >> > hmm. Did you read Christians suggestion?
> > >> 
> > >> I did, when he first sent it. Actually it seems to me that what the
> > >> lsm would really like to know is that this is not for an immediate use
> > >> of setfcap, but possible future use. But that doesn't really matter. I
> > >> wasn't judging the patch. I was just going by what i believe is
> > >> general lsm subsystem policy.
> > >
> > >My main point is this: right now security_capable() doesn't actually
> > >specify what specific action it denies. I think we would be much better
> > >served if we had an enum that would allow us to annotate places where it
> > >matters what specific action is checked. I would make use of this in bpf
> > >lsms.
> > 
> > Does this patch look okay to you? Would you like any improvements? (Except
> > from adding a user) :)
> 
> I think it's fine but Serge has more expertise in this area. So I'd like
> hear back from him again.

Yup, I'm good with the patch itself, thanks!

-serge
