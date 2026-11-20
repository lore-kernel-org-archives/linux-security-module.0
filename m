Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182838;
	b=Dq7wvdmgOUkAmLo8QQ+0CwcWdkvh1LCAuNGrPyOVMZpbatHVcpvOZyALco3BYWgsQFVR
	 W2MMXL73QT7xmoFkFbhqYRQr2QRdIkcAACwTcFqZMZ6vm+qjrzbPrHOCt5Bwhb7vB4R9/
	 kXSHQOifrK8hr3grZzTwCxnQrvJDSyY+xAqDEWZdGiuoZjVkJYe9ZiYRfWLe2P9YqYBzN
	 onK4QKJxi53HD0KouhhjvazuDSCn3gQdYHwZWzypnKdSlLE9h0yUPj8cghKK2PMo2uLrF
	 eKiYi4rims1fkLUO6dpj1kKF+fCAxWDOo2av6Gzl9mJQ5FiajELKxrvmWChjcm2torg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182838;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DpFcKmLeWcNlIWO+vriHC7zRosbcBxousCh6WYeygvs=;
	b=i0QogKTYcr5LIURMtlxHihcFEIPGegjvrWATpS333jyp5MGWEJocVnYi4e75GHf1f3ux
	 pFgotgMquyZuhimYkn75VBUl9ERaP4afy5z3C4mnEL41C5PEp4wMk2NxJGFhy8k0DQuxL
	 mrMdYDNYK8ZsZt8YiDu+RUL0h9iSPJfCucsvRAKBYZl7TgHifKGpjMcbQTCnd+cvMP5z1
	 s6IZKhnOM3QAG60O0E7elGNMWvqCHBropsb+ttOrnzDA+DOgjydtz12EhGlQJbXGFeuE+
	 0h6jSPB3cgEZVXE+ytk8rjnxm2yJRn2N/FY+hetFDVRPD9lE5LVYdpXLfJjRj1oZcoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JllosG2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58D606A320;
	Fri, 20 Nov 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JllosG2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BA41F000C0;
	Fri, 20 Nov 2026 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182838;
	bh=DpFcKmLeWcNlIWO+vriHC7zRosbcBxousCh6WYeygvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JllosG2YopKKAggV+8nxkQItQJgwyK/SH23r7EujPAu9LLeAmE5OsTlP0qwfs1qzs
	 egAqrAFrmET3vEhD6NZPH2L6aV4tacL188jjX0xkuze0uwvbqPNO7c8M2iAgoYcYeq
	 H7ZEaOmrlD1opoFLdFwf15pg8kb+10eV8lpeF4uADYK1q19wUkmB5rJV8qiDux/Yn4
	 hpATfff7Vkp2NHocWtfz7ojkZJZQUjOJAxL6Slx19OLLSKx4ze1EP2GCq5qfyELXpm
	 I4Wp/Gk8JPX+/i43x3SGowq73hPjNZ8FKxqVB3mHDINzvTM6yLGWHdPtvfDCy1nhcC
	 vqb5JvCLcxk4Q==
Date: Fri, 20 Nov 2026 14:53:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, 
	"Andrew G. Morgan" <morgan@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Oleg Nesterov <oleg@redhat.com>, 
	kees@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	paul@paul-moore.com, jmorris@namei.org, shuah@kernel.org, alexjlzheng@tencent.com, 
	jannh@google.com, jaime.saguillo@gmail.com, elver@google.com, blbllhy@gmail.com, 
	bvanassche@acm.org, pjw@kernel.org, broonie@kernel.org, debug@rivosinc.com, 
	tglx@kernel.org, aleksey.oladko@virtuozzo.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
Message-ID: <20261120-bankverbindung-bisher-dorfleben-62a38cf1cc74@brauner>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
 <atjN3JX7sWx9kpQ5@hallyn.com>
 <CACmP8ULW+COA17s6_UUKhQrJaviWmnUCjfite43Y0FgPN30-AQ@mail.gmail.com>
 <avHfxe++P4WLUQxf@hallyn.com>
 <80ff9aea-3a5c-4c92-b713-99c249564008@huawei.com>
 <CACmP8UK=b4Hkivzf77BJ-S_CR94+AgpNs_EfQ4i=CHL3+=0Y6Q@mail.gmail.com>
 <1772fffa-b938-4fa7-bd47-ff7c03552efa@huawei.com>
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
In-Reply-To: <1772fffa-b938-4fa7-bd47-ff7c03552efa@huawei.com>

On Wed, Nov 18, 2026 at 11:15:17AM +0800, Jinjie Ruan wrote:
> Do I need to resubmit RFC v3 based on your suggestion and address the
> sashiko review issues besides sighand?
> 
> Or wait for the results of new discussions?

The signal_struct part has to go. I think this is also what Serge's
question was getting it. And imho it's the real problem in this series.

The caps a task has are described by its struct cred and the whole
kernel relies on a cred being a complete, immutable snapshot of that.
With a pending drop in signal_struct that isn't true anymore.
Anything that stashes creds and uses them later, override_creds(),
io_uring personalities, file->f_cred, LSM hooks, sees a bounding set
the task doesn't actually have.

And every place that looks at the bounding set has to remember to fold
in the signal_struct mask. Any place that forgets is a bypass. That's an
entirely new bug class. So not going to happen, sorry.
