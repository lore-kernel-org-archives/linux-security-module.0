Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5586479893
	for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464895; cv=none; b=MoJy9TEcBabKVDRsjf/G0O41NmAHK0/xRBkmcNn/PvuzqgVZpW7rbNs164Vbmlwflsh4lmdTXWC7OL2KEEHAup29gKVWV67lH2DKtPmv4AfMD1Zi/XQKPisWJRdvnKZqsbuBVokxVCnxbfZ7wkwzwrfXJWO0LInXwL1nrXwNGc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464895; c=relaxed/simple;
	bh=q0QRyuG6lsn9T5U8tQ9dxS2+j4W8IxB+8Ooa+vPxrnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdPyhUs+aJk2RNmmNvmt7Cml6h9OaDxCvjg/xaNFoHgzsK4O7lipJGXkdnC9ML81oIdjhOU5KcAS3VtkjOFy8YdZLHPALlobhk/dvWGA2dHGvOmTkODDCZLl6R7C8Y1v94f/BqGOKg7xgQ0m6x6K/oDieaKxLuJAwoxgFgOySr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=M+/qnbD1; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="M+/qnbD1"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hkc7N0l7Qz9hD;
	Tue, 15 Sep 2026 11:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789464319;
	bh=c8Ki4Jk4LY6BAwvzS532/rmaZ862RgTRgNqJYa0lkfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+/qnbD1xr3WjdMrykCEJysicA4Kupv9S9JxSiIW4BwifH2sjjBxvQ4Pw8P19VSy9
	 ggsKbcvR6agrKaseNy/yMWq6OcIXCo8HDkBWv2t7AZW6+pHlrHvWe7Am5ASY3Dtuuw
	 /GA5sNgVdDvzgESDpLX+mqBqTrVljDDqO1JK9Ezw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hkc7L09wXzY2p;
	Tue, 15 Sep 2026 11:25:17 +0200 (CEST)
Date: Tue, 15 Sep 2026 11:25:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, matt@bobrowski.net, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
Message-ID: <20260915.ok8eig8Eishi@digikod.net>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
 <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
X-Infomaniak-Routing: alpha

Hi,

On Sat, Sep 12, 2026 at 12:33:13PM -0700, Alexei Starovoitov wrote:
> On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:

[...]

> landlock was designed for unprivileged users. bpf needs CAP_BPF.

Yep, and this series would kind of bridge these two worlds. ;)

> There is a fundamental disconnect. If you can tolerate CAP_BPF then
> just use bpf-lsm and implement whatever policy you need there.
> If bpf-lsm is missing a feature we can fix that.

The question is not if BPF LSM can or cannot do what Landlock does.
Landlock provides a way for userspace to sandbox processes, and that
comes with a well-defined semantic, logs, and an user space ABI, which
are specific and dedicated to Landlock.  Some user space depend on that.

The goal of this patch series is to improve BPF LSM to enable it to
(also) enforce a Landlock security policy defined by user space thanks
to the Landlock syscalls.  The security policy still has the properties
that makes it possible to safely compose different ones (e.g.
monotonicity/stacking enforcement, inheritance, separation of duty, no
cover channel, safe privilege reduction without confused deputy issues).

A process can currently define such security policy, get a file
descriptor referring to it, and pass this FD to another process that
would enforce it.  This helps design secure architectures by splitting
ownership, trust, and privileges (e.g. CAP_BPF).  Being able to use BPF
programs instead of user space programs to enforce (e.g. an already
defined) security policy would make this enforcement more powerful
thanks to the context BPF have access to.  Of course, BPF LSM can (and
should) also enforce other kind of complementary restrictions.
