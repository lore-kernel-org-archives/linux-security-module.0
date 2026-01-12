Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E023ED75
	for <linux-security-module@vger.kernel.org>; Mon, 12 Jan 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234075; cv=none; b=m4iwVmtRFZUC2ksu+SEJoxVBg3pBWYyCpGi06+UW0yrUM5EeVX55Oe2FzWonLikdufDV/ZuzrdaAPwhgYlY5HqrCBxz/XlsxCq0wrPTjW0vpBb8eyUDyV2SBHaIK/EOSGhsE1Qnvzqri3bVVKFJJO9RIOe41QEi2QfYD+LMhYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234075; c=relaxed/simple;
	bh=KU8OBbhFbO9entWbqFCuNKZeWZ/T53ghPDrp2+uEQwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RY+F0D5mtPO+QwcLNxN7hrPSluulEWhl8agxYGBLUAaaAev1ex5fycALF1s0OIdFHGOiUFr+QUDhmITqgP1BAYm5lRnVU+mQ4vx0jGXo05bAKgGnHhBYiyetwvHFFXcWyJEvSAsol4q3at9nOMle+DZrW4Pj4WL5lR80OFCFG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1C3pHKi/; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1C3pHKi/"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqcjM4dSlzkhG;
	Mon, 12 Jan 2026 17:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768234071;
	bh=elcQIY8cjKhtWGIy43YuoKuixXljKq7CaiducGj1JqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1C3pHKi/wDYJQWYKacUp6Jotsr88r1KTn1GJWktgXfxNYhlyTMF/Y2FWEJ71HzYXF
	 dDvqYdyyfhAa5czNxIX3bKA2WQdnihJCesTS36KJWt8k1KINYqEUW5bWxSv3FRVPQJ
	 6vjQqZ1nHdI4cU+WQYNfCRaKAha4KJntjmpDe8Y8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqcjM0xBRzgvg;
	Mon, 12 Jan 2026 17:07:51 +0100 (CET)
Date: Mon, 12 Jan 2026 17:07:50 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Subject: Re: [PATCH] landlock: Clarify documentation for the IOCTL access
 right
Message-ID: <20260112.Eik9che5Gee5@digikod.net>
References: <20260111175203.6545-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111175203.6545-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Jan 11, 2026 at 06:52:04PM +0100, Günther Noack wrote:
> Move the description of the LANDLOCK_ACCESS_FS_IOCTL_DEV access right
> together with the file access rights.
> 
> This group of access rights applies to files (in this case device
> files), and they can be added to file or directory inodes using
> landlock_add_rule(2).  The check for that works the same for all file
> access rights, including LANDLOCK_ACCESS_FS_IOCTL_DEV.
> 
> Invoking ioctl(2) on directory FDs can not currently be restricted
> with Landlock.  Having it grouped separately in the documentation is a
> remnant from earlier revisions of the LANDLOCK_ACCESS_FS_IOCTL_DEV
> patch set.
> 
> Link: https://lore.kernel.org/all/20260108.Thaex5ruach2@digikod.net/
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>

Thanks, applied.

> ---
>  include/uapi/linux/landlock.h | 37 ++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index eac65da687c1..fbd18cf60a88 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -216,6 +216,23 @@ struct landlock_net_port_attr {
>   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
>   *   ``O_TRUNC``.  This access right is available since the third version of the
>   *   Landlock ABI.
> + * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
> + *   character or block device.
> + *
> + *   This access right applies to all `ioctl(2)` commands implemented by device
> + *   drivers.  However, the following common IOCTL commands continue to be
> + *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
> + *
> + *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
> + *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
> + *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
> + *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
> + *   * Some IOCTL commands which do not make sense when used with devices, but
> + *     whose implementations are safe and return the right error codes
> + *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
> + *
> + *   This access right is available since the fifth version of the Landlock
> + *   ABI.
>   *
>   * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
>   * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> @@ -275,26 +292,6 @@ struct landlock_net_port_attr {
>   *   If multiple requirements are not met, the ``EACCES`` error code takes
>   *   precedence over ``EXDEV``.
>   *
> - * The following access right applies both to files and directories:
> - *
> - * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
> - *   character or block device.
> - *
> - *   This access right applies to all `ioctl(2)` commands implemented by device
> - *   drivers.  However, the following common IOCTL commands continue to be
> - *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
> - *
> - *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
> - *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
> - *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
> - *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
> - *   * Some IOCTL commands which do not make sense when used with devices, but
> - *     whose implementations are safe and return the right error codes
> - *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
> - *
> - *   This access right is available since the fifth version of the Landlock
> - *   ABI.
> - *
>   * .. warning::
>   *
>   *   It is currently not possible to restrict some file-related actions
> -- 
> 2.52.0
> 
> 
