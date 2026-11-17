Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933081;
	b=NOWfGnDdxgF3JE2h+x5rKwZ/YhQ6cSauc54oZMWPEPWuN6BGpKIfLx9u8w4afSHlKtAA
	 CElUUjXIwTW23nTY05vIM1enojSDpDYBbQq5G+/oh0ItkbDvc3cj89xPSumkip+Nbvw6m
	 HVamt/I6YjOMldhf3U2USautboNIXPA6R62mxwBLmUn45j+mBXUyfZppLu7RTnckAOhuP
	 98V+5mDwYyLu7TILgEzx8fyG/UdUnOnJJg9+ZteFfKZgTwMm0/0upsFB0PM/hsltQ1Rn0
	 BeuXV+R7ug+UPrptOvUn+9p9q5b6Jb04ZZ5oQxBZCZlgCyZsYziqN6ST2c1DtAQM2gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933081;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FBpqPZK5ApZJywy86jfnlfsnrvgnjO7xAJFJKAKJr0M=;
	b=rIuYP57VTp7JqWdCoyobN3KfscZDsNRPGA/z7iMmAZJzZOgygMYV9NKf4I26ErIdweqo
	 86cv1EChSh/Stea25rm44xO1zk9jT1BdwrbVes91k5heQWDkXAAbBRurvEN38BhpAibKl
	 MtAJn2bQIy49u97cmhN/KGT4bsuVV8u1KO6vylwKmTefhWo56VEYruS0Zgu7HnMyXmx3/
	 vsEevu2kygXFHQ2kNe8vPyM5LDabXpYDbHOoOX8k1rtnBZ4PixIHpf0ZVQxjnd0/HZUYg
	 Wzzi8mYMZMtVP9/SA5G86kNwC1ctwRUSiA8FGZdKIwShbVIcsCNjB7k6ZrxvhtQAilQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbvd210F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D4606A33A;
	Tue, 17 Nov 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbvd210F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD01F000C4;
	Tue, 17 Nov 2026 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933080;
	bh=FBpqPZK5ApZJywy86jfnlfsnrvgnjO7xAJFJKAKJr0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cbvd210FQstWSpHd11grqvdOWT7zHb4lr+1AkKIO9WEvT7tOwMAP+6EcM9jxuDwvP
	 Wx4z+ieHQvNOhWaYvOap9W3mv5nu27CRw3EUeOqOMGVvZP02pqOWUd4e0MZ8omS+XE
	 zquZ7oomRrIpXDmqxTrnL9Mw/mJ6aHOk20H0qnaN/YtDF0aE/+D3Wax0Bz9+20FDIN
	 F5RUh0iqXnkDReYsy8NXNOZm09UMdf79l+6Q2Dzxz0iQghAVTsc8EpacBm5Ik4c/HD
	 R1zXuV3DDMV2MnNWG8pJBV0w7s3Pc/ew3r8Kt+wqdA+AcPUC6LW60xu95DQPSR4xDT
	 jdT849HTFCjJw==
Date: Tue, 17 Nov 2026 17:31:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Serge Hallyn <serge@hallyn.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: security: Inform LSMs of capability check during
 userns creation
Message-ID: <20261117-brennen-tastatur-ekelhaft-22ee93d5200a@brauner>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev>
 <aveDlb6PlPSVoLD9@hallyn.com>
 <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev>
 <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>

On Sat, Nov 14, 2026 at 08:34:07AM -0600, Serge Hallyn wrote:
> Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
> 
> > On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
> > wrote:
> >> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
> >>> Right now security_capable() gets called in create_user_ns() to snapshot
> >>> whether the parent could setfcap, but the LSM gets zero context on where
> >>> the check actually came from. It is the same story as setid: without a
> >>> dedicated flag, security modules cannot tell this apart from regular
> >>> capability checks.
> >>>
> >>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
> >>
> >> This should be patch 1/N in a set that introduces a user of it
> >> in some lsm.
> >
> > hmm. Did you read Christians suggestion?
> 
> I did, when he first sent it. Actually it seems to me that what the
> lsm would really like to know is that this is not for an immediate use
> of setfcap, but possible future use. But that doesn't really matter. I
> wasn't judging the patch. I was just going by what i believe is
> general lsm subsystem policy.

My main point is this: right now security_capable() doesn't actually
specify what specific action it denies. I think we would be much better
served if we had an enum that would allow us to annotate places where it
matters what specific action is checked. I would make use of this in bpf
lsms.
