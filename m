Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A8293C64
	for <linux-security-module@vger.kernel.org>; Tue, 17 Jun 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154614; cv=none; b=gPLB/vewEBeI3siOcNiTpO8UP5IdyxClTUDjgopxVr1wlfLHceAnKI4ls0wv1gccriCRhV0GJElcS6HsuH42coo2y7+gkf+JmzDiMyTW7CPk6Ht602D6SQCoaQ/KCUpXazUUJLGEn9VbkQsnDb8YMFWZPEI9VpBicYbRHOsa+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154614; c=relaxed/simple;
	bh=lH0AB4ywb5+Q5yYtCSfdwgNav/o4cz3s1d8zrgQD2w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiNP2BhhjKL5OEDK5EVePr1Ng7eAKegFpdXcAcB+3OKO5GxZOApqLF6xg8KiyZjSu/+ymehfuwyI3faAg4tatTpOFxIRf2H9YYLFaGvAvobU7wxJbdxNfVZzgZbOhQ4RhP+3DoSilmUkuPHsiEirxX+kRv6WgNoksKHK87/fju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lEQj2kd3; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lEQj2kd3"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bM2WD5tgCzt7Q;
	Tue, 17 Jun 2025 12:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750154600;
	bh=gY40C19e9Rh8BvALJvGH+CavoG+gmHNRY2CE28IQny8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEQj2kd3zmNMJbR3dwUMBeKZXsXR/9sw+VfgYfK+laNOZaJw0+h9JfvKybCT3cF+m
	 RdEyOWNpoAGrUtwSKpKzXCg7Zqq2apbVqv3PuLBq1XEqRN7MoTt96ofVYn6avM5Du8
	 iP5irGtDP3HJlc/PG4YN/Ns2GHUZlGcFtN6KVJJM=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bM2WD21cpzWT;
	Tue, 17 Jun 2025 12:03:20 +0200 (CEST)
Date: Tue, 17 Jun 2025 12:03:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH] landlock: opened file never has a negative dentry
Message-ID: <20250617.Beeth0choo5b@digikod.net>
References: <20250615003011.GD1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250615003011.GD1880847@ZenIV>
X-Infomaniak-Routing: alpha

On Sun, Jun 15, 2025 at 01:30:11AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Mickaël Salaün <mic@digikod.net>

I'm happy to let you carry this patch with the others.  Thanks.

> ---
>  security/landlock/syscalls.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 33eafb71e4f3..0116e9f93ffe 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -303,7 +303,6 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
>  	if ((fd_file(f)->f_op == &ruleset_fops) ||
>  	    (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
>  	    (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
> -	    d_is_negative(fd_file(f)->f_path.dentry) ||
>  	    IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
>  		return -EBADFD;
>  
> -- 
> 2.39.5
> 
> 
