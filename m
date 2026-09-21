Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251724534A8;
	Mon, 21 Sep 2026 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986426; cv=none; b=BbZLE25shZDt4EMIX46BeQkAhxZK0YRmVwl6cw/CmdxMYc5MDsippY4FT4XV3N03z9I9c8DkJ9/kj0NYKlMWyqVTyaygNikBEz2Yzt9PFF+rtKvSbv58x4fxATHz5wZehsNkO7kWiRmIApNPnWCFmNSKY0sRB6aa6f8R+GXXUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986426; c=relaxed/simple;
	bh=GDchxKKZCB8dPOXGuFgRz6aewbulIm/EZRQQ2m32cXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jLXUOyJrci7QVvW35kE5AwbHWCyHP1ZBGCkDz7RqVeaqwqbfkwiWMyYbzFRXOjnkI/GeTNzFgCeT24ULF0r/KyCIKrPtYfyiq8feqeSixZKhlqo13eixIV1o5325GlPSe4x83yaQ3VPFwiTVpRxtBVhvdNv165mpx0KbWKTv6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8qvI7HX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8qvI7HX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8820D1F000FF;
	Mon, 21 Sep 2026 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986424;
	bh=+dc7LBA8dxKbDSxVCVSqCx/OWKdpJPImIH2bnv1k29A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8qvI7HXWF+1S7DXIHh7GZPpHe1E82wgGThTTM2K/K7jGA6txvmnn+sBXXrvjiREP
	 vhRvv/DXO0pKv0Z30AnTig7qmZbnpc6AgrLBHG1hGEA4hpxw1UnS9W2+BAVibPHNw5
	 Yxw3rToWSPAm1uHKVS8hJ40FC7Nb8sz4lRw6HIZiH2gYiFfLtTptlbdE/9gh5pXEvf
	 DJ6vN5jK9+jeRLqiVeYmLif8KaCkirq1bdh9I4/J95TTzR8cvajfWpdg2UW9vhktwp
	 mL30jzlwfAz8EEYV7HhUWrBu+CIvSLluGYDfpjc9HFot8JpnOhWqgiBfKwmcOHxTW0
	 kBM3EPUj87inQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/15] tracing/fgraph: convert process/thread
 iterator to for_each_process_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-12-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-12-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:27:04 +0000
Message-Id: <20260921102704.8820D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] trace/fgraph: mixed goto-based error handling with scope-based clea=
nup
--

commit 6422a16035934ad7c858389b51cb5a7d9fecc15f
Author: Ye Liu <liuye@kylinos.cn>
tracing/fgraph: convert process/thread iterator to for_each_process_thread_=
rculock

This commit converts the manual rcu_read_lock() and rcu_read_unlock() pair
around the for_each_process_thread() loop in alloc_retstack_tasklist() to u=
se
the for_each_process_thread_rculock() macro. This scopes the RCU read lock =
to
the loop body using a scoped guard, and removes the manual unlock label in =
the
error handling path.

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 40d373d65f9b9..f797ce1192233 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1057,11 +1057,10 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>  		}
>  	}
> =20
> -	rcu_read_lock();
> -	for_each_process_thread(g, t) {
> +	for_each_process_thread_rculock(g, t) {
>  		if (start =3D=3D end) {
>  			ret =3D -EAGAIN;
> -			goto unlock;
> +			goto free;

[Severity: Low]
This doesn't cause a direct runtime bug here, but does this change mix
goto-based cleanup with scope-based cleanup?

The for_each_process_thread_rculock() macro initializes a scope-based RCU
guard via scoped_guard(rcu). By using goto free; to jump out of the
scoped guard to a manual cleanup label, this explicitly violates the
strict kernel cleanup rule in include/linux/cleanup.h meant to prevent
double-free and resource leak bugs. That rule states that goto-based
cleanup and scope-based cleanup must never be mixed in the same function.

While jumping out of scoped_guard() here triggers the RCU unlock safely
before executing the manual free label, should alloc_retstack_tasklist()
be fully converted to use scope-based cleanup for the ret_stack_list
allocations as well, or should it stick to manual RCU locks to avoid
mixing paradigms?

>  		}
> =20
>  		if (t->ret_stack =3D=3D NULL) {

[ ... ]

> @@ -1074,9 +1073,6 @@ static int alloc_retstack_tasklist(unsigned long **=
ret_stack_list)
>  			t->ret_stack =3D ret_stack_list[start++];
>  		}
>  	}
> -
> -unlock:
> -	rcu_read_unlock();
>  free:
>  	for (i =3D start; i < end; i++)
>  		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D11
