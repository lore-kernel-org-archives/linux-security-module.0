Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA72EEE8C;
	Tue,  6 Oct 2026 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249057; cv=none; b=QwgIPXBWTj53XSeHf3RIcGkNg9VXSlkaoFNbLzfBEzh6Av3/GvpC+HR4aUgQygpuhfygNcvZkYmZpzgc094KsMjD2/PmsYZF0EdbV0p+St66CkHSbpwn2eVKiL+Zz6EhF4l9I7ura5M5J2xXUSCg9lbvwQ7tl876ijti+HUzuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249057; c=relaxed/simple;
	bh=UPz6XXs8L1caYYnTt/3pam9SbtP1VWzJgcecjIGUwFc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HrnWP+VJnBqHgwAOwzd8qVCKgKVdzPje+t/vmYcQd+p4Ao6z6p8BpbJimOzATVz3yWiWi2rsm999ysF1XG25mhBF3ovDa+8YPuDn2JTYpWK1CGxoH7W+BRtkIT7sHcF1QykgnlHeGJuG80ZzhMeMmL3kH1IUMFphiq+fZDmjmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRHv9UZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRHv9UZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56481F000FF;
	Tue,  6 Oct 2026 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249055;
	bh=z4L98kjZqFz4OUKJLynXtGXVAt68ZMC12pwh4zwVz7Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gRHv9UZfEz/0Mu3nlHtzv0NeIW5e8pyIHU9WE3JcicRC25ZVRtU5LgumkPrxg/DGO
	 Uo16Gw1q92ZXgHlYupGq/jUwA/mN+cJLY6F+eyOiryYnYIoXc+jegKWMGxgXc1eq6y
	 orNc/pCdESUIsekwE/ENXkzdyuTVGP4na8G4fxob7nsBxA8xekmfgtOdIk+MNIn7Vt
	 9Tlnb8i52LiAOhQ2NhLXRYBSJR16vPYf3mnf8P8hpqTR56UGpVovYCcaIsWttCmzWg
	 md3Qrz1nSnSStDV6plXpIWo2dJU2ziic15V8Ogfx6y11ey7Dsuolro7um580PayzoG
	 yWimfIhO8ZqYQ==
Content-Type: multipart/mixed; boundary="===============0586567639355448720=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f54921e76ba6adb254c27b800dc9b93a07f3f6e2fe472a97773ae1e377c79e7@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-4-utilityemal77@gmail.com>
References: <20261006002020.2890858-4-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 03/12] landlock: convert ancestor walk to vfs_walk_ancestors()
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:10:52 +0000 (UTC)

--===============0586567639355448720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> landlock: convert ancestor walk to vfs_walk_ancestors()

TL;DR: Nit only: a comment in landlock's check_access_path_walk() refers to
"the old loop" that no longer exists; it should say why mountpoints reached on
a mount crossing are skipped.

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index cab43892ec2f..369e2e9c83ad 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c

[ ... ]

> @@ -751,6 +751,107 @@ static void test_is_eacces_with_write(struct kunit *const test)
> +static int check_access_path_walk(const struct path *const ancestor,
> +				  const unsigned int pos_flags,
> +				  void *const data)
> +{
> +	struct landlock_walk_state *const state = data;
> +	struct landlock_id id = {
> +		.type = LANDLOCK_KEY_INODE,
> +	};
> +
> +	if (unlikely(pos_flags & VFS_WALK_POS_DISCONNECTED)) {

[ ... ]

> +		/*
> +		 * The old loop never visited the mountpoints a mount
> +		 * crossing lands on: don't match them against rules.  Other
> +		 * disconnected roots keep being matched below, as before.
> +		 */
> +		if (pos_flags & VFS_WALK_POS_MOUNTPOINT)
> +			return VFS_WALK_CONTINUE;
> +	}

This isn't a bug, but could this comment say why mountpoints reached on a
mount crossing are skipped (they are hidden under the mount above them)?

As written it refers to "The old loop" and to "as before", and once this
patch is applied there is no old loop left in the tree for a reader of
check_access_path_walk() to compare against.

The removed code stated the reason directly:

-				/* Ignores hidden mount points. */
-				goto jump_up;

The history of the conversion is already covered by the commit message.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============0586567639355448720==--
