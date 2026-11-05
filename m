Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913414;
	b=wG4gqQKMVN+DtPA8N3V8Ki/wU0PRx5MEpR5WOKIOw2AEjnw0fj3/eRh+EtDg4oLlUEM3
	 r9Zq2RwOozrEH7DRFahLT9TEZzCgO37tKA0J+Cx6s1YbKyLGJzuk2UclbxFa5k3Y2oSTG
	 qICadbXIjHLmd/pzNE7yvnEj4wwfzLZeJ9gGPhQWR28Q/O+HwVKhLCRP4+Bv3CMNaKXFB
	 vZbe2cTIo61NPXDSzLNsYGr10CUUOowmNmKmYBwsq5rzKA9oy9qIAk/bPwN+PodQZASvC
	 pLq1nsSV3Wnzmqqk6gayxcwd5iAmvZwdWyrveW9op1V3p++fiSswfx1YSoWfytpTT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913414;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VxizPleZhq8HwEA9+OGD1/wqtPtl9/FGqR/08An4bnA=;
	b=0oiAuUn/fTS+fckEIcwUkdCNKuYRpeXw2oChIu45Fx1ZdCH5QxenG/FZCW3ipMt6enXN
	 V6I87jnc7/qG43pbwcKqGTBO7l0gstQyYklSuUJC64LZQBIzg/ev884f16KoabZjlvGxD
	 o55GSh9hl7MpuB+drRqd4MCe2EOfYKIomKjxGDdbmd8ypkxM/O34iCDfNMbwXj+y/AKoB
	 Mxvo+Y1KVIwahEhm393skhPWmf64QOXaIVg8EQ+YPkB61GLudeoeQC12caoOWJsKJlQf7
	 wr/hmcSJGF0N3xKuZa9pdaPx0nUKBdX7YdGMGayvXSeIgiGWQh7R/jjoAJUxM36bAGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g565L9wk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D060606A31B;
	Thu,  5 Nov 2026 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g565L9wk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0229C1F0089F;
	Thu,  5 Nov 2026 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913413;
	bh=VxizPleZhq8HwEA9+OGD1/wqtPtl9/FGqR/08An4bnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g565L9wkD5iSSuGFWKDuD3r5m/puCbGyJJCo3TJWpw9Qk1mtMlX3Vhu/zaycMuZyG
	 8WIHVCle+3SB5Y13eRo9Q/o/7luBCPOEmo3Ccnjes64p+oDk7jULazfvcBLuq5BP8p
	 ejZYak2vpyWx7teiB/ViaVFVVt4nGpOAS2ngNx9Jp7VKECYVgIb8o7HI8C2fDkaeJh
	 1L+iyjnb+5rRrtkH5nQw1QSEFedeiKX/TPIZiO0SCv3OgZGZZN310wOQ9GXsMclAs+
	 7xgKYiEZJywRJ4oAqp4kOsDiORP6ys9gNtrwp9RMPZcFAkHKvefz1LLsVqo4RSAXPT
	 MFSEB1NF38ycg==
Date: Thu, 5 Nov 2026 22:16:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chen Linxuan <me@black-desk.cn>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pidfd: Add task path ioctls
Message-ID: <20261105-fotokopien-essen-inbegriff-be31e4f3c8a6@brauner>
References: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
 <20261027-pidfd-get-paths-v4-3-e2a6a47e3c95@black-desk.cn>
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
In-Reply-To: <20261027-pidfd-get-paths-v4-3-e2a6a47e3c95@black-desk.cn>

On Tue, Oct 27, 2026 at 04:46:09PM +0800, Chen Linxuan via B4 Relay wrote:
> +	case PIDFD_GET_EXE:
> +	case PIDFD_GET_CWD:
> +	case PIDFD_GET_ROOT:
> +		error = pidfd_get_task_path(pidfd_pid(file), cmd, arg, &path);
> +		if (error)
> +			return error;
> +
> +		return FD_ADD(O_CLOEXEC,
> +			      dentry_open(&path, O_PATH, current_cred()));

So the path we take from the task is a jump target, just like
/proc/<pid>/cwd and /proc/<pid>/root are. So complete_walk() runs
->d_weak_revalidate() on them. Without that a stale dentry on nfs or
overlayfs turns into a valid O_PATH fd.

And failfs relies on ->d_weak_revalidate() to refuse pinning its root. A
task that fchdir()ed into the failfs root can now hand it out through
PIDFD_GET_CWD. Which would be breaking a guarantee we give. So we need
the same check here. I'm just not yet sure how we best do this.
