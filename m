Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991299;
	b=RX+hGO8tSCMxwrnl5/hR4Ey0xc+DAKx/+wkq2/otxXkmaD2iSxBsLo5JNS+1dCOlFLP3
	 Ha60XJ3IY0iMBGDEzjBbUBvhTu9YNJ9IahqvLeRs1vbhZXXdB3qlIHAKKPzZMSnQVsa8t
	 lkUc33W7GJhORkcHAvx3p0ddSYlG9r4+A2/ZnpDpMjBhVskmnNOASi6tkuIs3paKccPeA
	 ZuHrwIc8yP3oCGGmR+VXaSltFbLeesV4ZsCkXcAaSQnaNI/0INZm9FTRGgrWHc8f2koLF
	 h2bfcR7sQGOHtQu2Wnfi2AYxL8zQT/psQKXjNMKmFE+Uw44X2Gfblzge1NF/+ctFWAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991299;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m0dm+CSEYXw13XYwLxlYftAcj6aX82i1r4MU3q8Jj90=;
	b=vxE0HaB74zY07uq5oIDelPC6LV87nNswTreAiMDymq8U0BotHQcU6ffSi9VkJskPU88K
	 N9BNUstotrSkfgfItbxlXdaN8e5Sviw9/bv8Fb8fvUgDIX2UdEnxq8Jja50xKm69VYKb3
	 jEbAvi2eYzbh3VazBJitKZf1suZGekBOB6E1AsBLeYWK2Noz1tq8rMvKAR+UshW4/K8oM
	 iLvg7adwRd3QNX1yB4PQ4cNCzGwgMfoIgo+k8dBFo9s6MMcOAXkniKFUbIZmSWfritv59
	 zZyLgiKuCYRDN2g8HUOZTL1pih29DKX6Ecsfx7UHfCdiogpDGNwuVaJ8KcVd08Q65kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lqon/DOo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706D606A31C;
	Wed, 18 Nov 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lqon/DOo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0E41F000C5;
	Wed, 18 Nov 2026 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991299;
	bh=m0dm+CSEYXw13XYwLxlYftAcj6aX82i1r4MU3q8Jj90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lqon/DOoEGihxibrk2nv2sDab71kMbvl7RxazRsJLXC1EdH3aI5S8zl1pWf39HM1K
	 iN0aNwD7i+YEgvaXRbAkpxNQeZfmpqex8NM9WG3MpxzEkxKUxK8DMR0PotkbLlUbjk
	 gGV1YStiefQ3HKXMoq79ulVRigoCPqOl0bWiKVybiOZfYj//+0DLWZ80WOkgXjFUGz
	 EwH471T28LqbK9vvXT9ILGCyMHRWkpbfOr2gWXBGEc3C+Ry3TwK3ytlSVt+IelVBhW
	 ti6eTmiB5vJGyD3ubP4ZSlMXoVuqvh7T4yPaXGOojVqssJqAJsyB6iMrrgqGlQTh63
	 H37yD1n2QGFLA==
Date: Wed, 18 Nov 2026 09:41:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Serge Hallyn <serge@hallyn.com>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: security: Inform LSMs of capability check during
 userns creation
Message-ID: <20261118-vorkommen-achtzehn-abonnement-6e7e8a08c9cc@brauner>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev>
 <aveDlb6PlPSVoLD9@hallyn.com>
 <4A0D804A-1199-4402-91EE-E37E8D6EA9E7@linux.dev>
 <0c403a09-38cf-4953-a73a-ee57837b3799@hallyn.com>
 <20261117-brennen-tastatur-ekelhaft-22ee93d5200a@brauner>
 <69BA4071-048F-4D90-9936-4B4856AABDF7@linux.dev>
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
In-Reply-To: <69BA4071-048F-4D90-9936-4B4856AABDF7@linux.dev>

On Tue, Nov 17, 2026 at 04:36:54PM +0000, Bradley Morgan wrote:
> On 17 November 2026 16:31:16 GMT, Christian Brauner <brauner@kernel.org>
> wrote:
> >On Sat, Nov 14, 2026 at 08:34:07AM -0600, Serge Hallyn wrote:
> >> Nov 13, 2026 15:54:37 Bradley Morgan <bradley.morgan@linux.dev>:
> >> 
> >> > On 13 November 2026 21:39:33 GMT, "Serge E. Hallyn" <serge@hallyn.com>
> >> > wrote:
> >> >> On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
> >> >>> Right now security_capable() gets called in create_user_ns() to
> >snapshot
> >> >>> whether the parent could setfcap, but the LSM gets zero context on
> >where
> >> >>> the check actually came from. It is the same story as setid: without
> >a
> >> >>> dedicated flag, security modules cannot tell this apart from regular
> >> >>> capability checks.
> >> >>>
> >> >>> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().
> >> >>
> >> >> This should be patch 1/N in a set that introduces a user of it
> >> >> in some lsm.
> >> >
> >> > hmm. Did you read Christians suggestion?
> >> 
> >> I did, when he first sent it. Actually it seems to me that what the
> >> lsm would really like to know is that this is not for an immediate use
> >> of setfcap, but possible future use. But that doesn't really matter. I
> >> wasn't judging the patch. I was just going by what i believe is
> >> general lsm subsystem policy.
> >
> >My main point is this: right now security_capable() doesn't actually
> >specify what specific action it denies. I think we would be much better
> >served if we had an enum that would allow us to annotate places where it
> >matters what specific action is checked. I would make use of this in bpf
> >lsms.
> 
> Does this patch look okay to you? Would you like any improvements? (Except
> from adding a user) :)

I think it's fine but Serge has more expertise in this area. So I'd like
hear back from him again.
