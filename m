Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171690;
	b=4poTYpSLFDPvv0kObSTPWJzI8YVnGlscUja5HgGmb9PtFXNLvzO0HW3zA5IHgIatKSM/
	 LsT8QycATb49zWuY6ucyc6Ca0nQxMt+GCVL+/P1dLtW6CmZ1vrsBZbqZg1Xu+El12rMS4
	 lAFEE05bfplcTQiT6JaTo3iA1KXZTjRxknS7mArXnesR0N0QrBqILh7P5959SdpJ8Mz4M
	 55zjUultGv8tmCo5EJ9/qNlKhbvjPBvrV76bfKgcDYueKiiE4892Oy9OMv0DeeCNZvkK7
	 N9z3+Uqxpmsmg8cJhZa9wM/4PEGRh9h/WDd9lNSq+HqGazZ+vTWh1Q4wIL1wtC8EJbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CYt4mkD07TthFoDLoT7iz7ABzYxYY421TOxaCilveTc=;
	b=RBdrKAyD8jyIY2Jceft5ZJXVSKc1ADJbbzavC6axtz8I6Z6Oaae0w655fqmy2oexTosc
	 Y+OhshRBQ9xxlgDE9CdmxFCb0DCwv2t08OMDCgBtdNPwgoNd+skpi9r6dCJIb45Ilw21I
	 oMVDMQaKNwoFwuLMogle1qkG164wWRGqPBxKkPBqybBLsecY2hSRhJ0NSnIqd9ykTRujQ
	 TjYVgOqty+W7mUqSrgsjEa28L6SzMqKbGtDjs6eGuXrhvDF7FEYiWBn9bEtDiyVNXNUzR
	 YKZZLAlQFx5j66XgZzlqMU8cAN8DsnDuhVwNx9trAPZwocUygV2PbUfZeRhwuF/JTBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEVmymUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EF606A337;
	Fri, 20 Nov 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEVmymUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BB81F000C0;
	Fri, 20 Nov 2026 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171689;
	bh=CYt4mkD07TthFoDLoT7iz7ABzYxYY421TOxaCilveTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEVmymUFKPHO6A12XyIRrWNvbVhf8KvyqScZjWjDxh6KmXBu9SvdoQCj8HA6QJAAh
	 8Z0hw8hUgC5dLFtAMbqpN0vi7/w9LyirVTpT7sZ3ALJqfyCgkYJshp7Xd9fpvZ0/Hf
	 OZDE++yASq5wO/fiyqQvZ5dvlnDn3FxhAOqPQNM69xxVg0LoZVyfQLuSBYPEE81VrI
	 6ZT5ZWxLH2oM7fKqG4q+FSQnEeEdlZ3yzwHROMedR6/UReyt8AeEaO4gwz/3POPX3h
	 6EezT3MJorO6IJT6biPab2SIg48ryMR2ohDpXD3t2hxwQMkwPEKoom9+QvDRdooD+3
	 QDnKHYthhq+iQ==
Date: Fri, 20 Nov 2026 11:48:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Shi Lecun <shilc2025@mail.sustech.edu.cn>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Seth Arnold <seth.arnold@canonical.com>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Jan Kara <jack@suse.cz>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fengwei Zhang <zhangfw@sustech.edu.cn>
Subject: Re: [RFC PATCH 2/2] fcntl: recheck signal permissions before falling
 back to SIGIO
Message-ID: <20261120-appetit-undankbar-bankraub-d2f1994e97b3@brauner>
References: <20261107154928.3519030-1-shilc2025@mail.sustech.edu.cn>
 <4C916018FDDAFB60+20261107154928.3519030-3-shilc2025@mail.sustech.edu.cn>
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
In-Reply-To: <4C916018FDDAFB60+20261107154928.3519030-3-shilc2025@mail.sustech.edu.cn>

On Sat, Nov 07, 2026 at 11:49:28PM +0800, Shi Lecun wrote:
> F_SETSIG allows a file owner to request a signal other than SIGIO.
> send_sigio_to_task() checks permission for the configured signal, but
> if queuing fails, it falls back to SIGIO without checking permission
> for the fallback. Permission for the configured signal does not imply
> permission for SIGIO.

Yes, we should check the signal we actually send. Without your aa patch
selinux, smack and landlock treat a realtime signal and SIGIO the same.
So only a bpf lsm program attached to file_send_sigiotask would notice.
So please move this to the front of the series.

Acked-by: Christian Brauner <brauner@kernel.org>
