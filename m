Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF27EEF0
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627879; cv=none; b=VYQLxTNer3BrX0O+Wghho7tTQjG/mK48CuBmJCMzUEPHbrsvbc4xJY4iLWa6MJmjtynPLY33p5Sf97wVoA2Ulr2wfelfnLBShtjNVhduxWcSgvXMisNi8begNhPD2w83IxrJOiiUQ4/V5WklOachR3LkhJlnl7FX0TpTK94tLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627879; c=relaxed/simple;
	bh=Lwg1fmCknR8Ry1SW3M22oRRlcnp37S8ciED/40rgmkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMnbP+bMw45QkRW79A41NPv2qlfeFO5RtnHk9pMTcQaJTkNU35xmFkTcb1x6oYnOoQqspQwSYcxBtMNPMl5+oD5V2HS9asSrl9UQepdF5uejBQ3nCcjF1uniIo3n6Ar5jZujYx9j2MCf93wRNYTylfDWFUNSLOITn3yLqlvANQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LJzPCpjn; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LJzPCpjn"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V52Sb0bMRzTcl;
	Thu, 28 Mar 2024 13:11:11 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V52SZ09ymzMpnPg;
	Thu, 28 Mar 2024 13:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711627870;
	bh=Lwg1fmCknR8Ry1SW3M22oRRlcnp37S8ciED/40rgmkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJzPCpjnVdtNhC6IGj0hF26ckJqDOwQ78sc27EX27XxPQfii8VKyDbHy7Jj+dWy9+
	 dOl1TJyUXHgDbYb/vQehEMpoyYVHGQ3BPtzWIXG3Lb2rq1luUnHAvdVw7nXDa+LW/0
	 8fdHMmMIxnPEoFSq3CjIAMuZ6Xxe0xGzPSDS9RIE=
Date: Thu, 28 Mar 2024 13:11:09 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
Message-ID: <20240328.ahgh8EiLahpa@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-11-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327131040.158777-11-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, Mar 27, 2024 at 01:10:40PM +0000, Günther Noack wrote:
> Landlock's IOCTL support needs to partially replicate the list of
> IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  fs/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1d5abfdf0f22..661b46125669 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
>   *
>   * When you add any new common ioctls to the switches above and below,
>   * please ensure they have compatible arguments in compat mode.
> + *
> + * The commands which are implemented here should be kept in sync with the IOCTL
> + * security policies in the Landlock LSM.

Suggestion:
"with the Landlock IOCTL security policy defined in security/landlock/fs.c"

>   */
>  static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  			unsigned int cmd, unsigned long arg)
> -- 
> 2.44.0.396.g6e790dbe36-goog
> 
> 
