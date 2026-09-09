Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F056852F;
	Wed,  9 Sep 2026 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986805; cv=none; b=Sb4ZIwHE2W/A8BPRvFrd2gCRlgiQTKH0ukYsRtm7tJw2N45Eifs0DWm47/HIvrHBr7XkE1+lA1itiastZFJmDmEs/tfp0QqASxaLw13QdVCh45V/wuMs7b4fIxY87Yr5EbGIsjvckKacpP522/mBLXQI9ztD4JEpNF8T8gEXQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986805; c=relaxed/simple;
	bh=x4f6LjJ6QZQXi5AqE4wKke+zt3TgKRmL+uFV/uTR5s8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SjlSqoGG2Y+lKP7yp1yW3XRuB/W2o9Q6Ty6/f31RCrjkBlfSJy4+zyQDuB9hxUBxJeS0Le4U9sVtJgZeapxoUknWYHereB0oElTI+Wx+1sNfD5zEpBQ0wg73ABZHbrqWUtWg7z96DrWnjjS6ZhhVg6YUEK7QxVIeBqjrwyMeLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH2AkY9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH2AkY9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B61F00893;
	Wed,  9 Sep 2026 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986787;
	bh=1epzB8vscZVJ9Sgxonnoz1rY8+FpqWx9g7BewLijZaI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TH2AkY9WlKdn/bHZU2SXskTw32nl+v406Q6SvxfcNjAC/7G4ZAjAQp/c4kwMspgql
	 hSgveQ6vaW93+VezyKQtkfsdsmSRpP2LnqT+tf5rkXQcUtjzx3KR5pRGsonnSS97ef
	 r+ssAdN/0lyvf9DpGes0ow8rg/CBFgtQXeaCaYIOKyQqKzoKc/tFplFfUKI1gm2PAK
	 II+KgBa4m1hXg4M1/QnDRaQCGAl48EZn+OsZrrmlqaz59heMB1g1TCAumuWUjF0KMX
	 eW9cUKX+ppYD0TCmJp/LzhbubQ0k5N3KBvzuTrkQLzdz9qICtPMkGxfYY4IoXih73H
	 WUgw6KVDIkqNA==
Content-Type: multipart/mixed; boundary="===============0772387365718359304=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e6ef0d3fdf6d830cea306c9547312ad33593c979764afabc5f37765d5206183@mail.kernel.org>
In-Reply-To: <20260909193719.518517-6-utilityemal77@gmail.com>
References: <20260909193719.518517-6-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/15] lsm: Add the bpf_lsm_policy_from_fd kfunc
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:46:25 +0000 (UTC)

--===============0772387365718359304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
> index e1190215d477..988dcd6f4dd9 100644
> --- a/security/bpf_lsm_kfuncs.c
> +++ b/security/bpf_lsm_kfuncs.c

[ ... ]

> @@ -14,11 +14,50 @@
>
>  __bpf_kfunc_start_defs();
>
> +/**
> + * bpf_lsm_policy_from_fd - Get an LSM policy object from a fd
> + * @fd: file descriptor referring to a policy object, resolved in the
> + *      file descriptor table of the task running the program
> + * @flags: reserved for future use, must be 0
> + *
> + * Translate @fd, as set up through the owning LSM's own userspace
> + * interface, into a referenced policy object.  The fd identifies the
> + * LSM asked to translate it: each LSM recognizes its own fds and
> + * declines every other.  Only syscall programs may call this kfunc:
> + * they run in the context of the task invoking them, where the fd is
> + * meaningful.  The reference must be released with
> + * bpf_lsm_policy_release().
> + *
> + * Return: A referenced policy object, or NULL if @flags is not 0, if
> + * no enabled LSM recognizes @fd as one of its policy objects, or if
> + * the recognizing LSM fails to translate it.
> + */
> +__bpf_kfunc struct lsm_policy_object *bpf_lsm_policy_from_fd(int fd, u32 flags)
> +{
> +	struct lsm_static_call *scall;
> +	struct lsm_policy_object *object;
> +	int err;
> +
> +	if (flags)
> +		return NULL;
> +
> +	lsm_for_each_hook(scall, policy_object_from_fd) {
> +		err = scall->hl->hook.policy_object_from_fd(fd, &object);
> +		if (err == -EOPNOTSUPP)
> +			/* Not this LSM's fd: let another claim it. */
> +			continue;
> +		if (err)
> +			return NULL;
> +		return object;
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * bpf_lsm_policy_release - Release a policy object reference
>   * @object: policy object to release
>   *
> - * Release an acquired reference on a policy object.
> + * Release a reference acquired with bpf_lsm_policy_from_fd().
>   */

This isn't a bug, but would keeping the more general wording here
('Release an acquired reference on a policy object') age better than
listing the acquiring kfuncs? A reference can also come out of a map kptr
field via bpf_kptr_xchg(), so the comment might need amending again when
other acquiring kfuncs are added.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============0772387365718359304==--
