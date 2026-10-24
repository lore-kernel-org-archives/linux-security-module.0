Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792805904;
	b=SwbXCw1BJH4Un2URRcomgD/wfVxGZSz0Jed2FKZmI47eepiffq+goUUMc3TDWQOhgVPm
	 1pdoaKbmzb8a/bv0YOxBpkloW3+sdO5yQXks2OZOO/OnAtU7k4dcpkIQOwEb8csui5Hew
	 fd7k+Rf7ZAvK91NSi97iyOoH7EdgGcQZXRr2G+jHkAs4VET/ccTp1EmeODG0J5De33tOM
	 nNHzNw++jMrDVpX4O2L/vY28Oj0SkDgU1g4SA405Lk3qQUUrZQIgBadr93/xgicP9BBMP
	 avwhE6pURVrLsbPunfuf64LmodATHIbl+Qn55O+BpCF2rg7GB8Ho8iM2FwR+u1jfDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792805904;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GE6+U0BYl/gxLk+WhH0myEBpK899UvVfGxeXSmRPFeE=;
	b=DsWcVNRYsZ3dnsqJ3nXpSgYOp+Ir8XSy4tpEO1bceOay557gG9Pfeo9GDpG3xVUKzITz
	 kZt00KHiCLue6bdVRLC4XhEK83OiPN7PsXiBs21M/ARvvKgau02ES5bOCeH2qk9sdjGIG
	 95VAThqE8RacUK5Xqa0E+ogW0k466I3vrZdPNFrKLwZ1BLZxoAQLPkTJrOMomxWjDUd3H
	 3jx1xWl5liuRIh1G+Qw73DB5cTsRcsISvYHv73jNTHSR/nqUdJJizhn1rGHbEOqbsTWWT
	 do/ho5KH4N4Y4XJGJ+g20aGfe47lMY5BVrLP0nsRgSozif7nTV0nBliG3hFpJOhB4Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AIKpU5dv;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B1606A31A;
	Sat, 24 Oct 2026 01:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2B1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AIKpU5dv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GE6+U0BYl/gxLk+WhH0myEBpK899UvVfGxeXSmRPFeE=; b=AIKpU5dvniKr+gypfihPgMduE6
	Om1oE2fGwFAIpMss8ydzwLlHqa71TuDNbq18vehkMcX2FDxOhkpY5AfhtsHWOgLGBDlsAWOWxK82x
	9FQ38pI8Z1I93H1Pk+tMqe+4gMHQWuxQuLRxH4alFABrDUe+HTCIm952EEtFuU9VrY+kwDIHc6Hh7
	GQDtWWKz6tAi6YTlbxjT4OD/bplhN8niHtIo8pb41QfMS6WORtMNLbtV4sVJ8h6qs96erCPsqB2sX
	t///ifBCNG29TDhwjgmEF4UhSw55bKOx3eJNCCV3gxjz7/7yOxIfdUJkuKWqHCTop6+1E+sNjXjuq
	DmOapaJg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKQi9-0000000HJtS-0EiF;
	Sat, 24 Oct 2026 01:38:17 +0000
Message-ID: <40c69814-f9eb-40d6-b735-98eec67898a0@infradead.org>
Date: Fri, 23 Oct 2026 18:38:15 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] loadpin: allow untoggleable enforcement on
 filesystems which don't appear to be read-only
To: Amelia Crate <acrate@waldn.net>, Kees Cook <kees@kernel.org>,
 linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261023171508.3460300-1-acrate@waldn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261023171508.3460300-1-acrate@waldn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/23/26 10:15 AM, Amelia Crate wrote:
> Some filesystems, such as composefs created from layers which are entirely
> read-only, can't be easily detected as a read-only file system. In addition to
> filesystems which are read-only without having a backing read-only block device
> I believe this is also useful for cases where immutability of the filesystem is
> enforced by the hypervisor or the host, such as 9p shares or virtiofs.
> 
> It is still desirable to enforce LoadPin and disallow toggling enforcement in these cases.
> This patch gives system administrators a way to disallow toggling LoadPin enforcement even
> when the immutability of a filesystem is unclear.
> 
> Signed-off-by: Amelia Crate <acrate@waldn.net>
> Assisted-by: Codex:gpt-6
> ---
>  Documentation/admin-guide/LSM/LoadPin.rst     |  8 +++++++-
>  .../admin-guide/kernel-parameters.txt         |  7 +++++++
>  security/loadpin/loadpin.c                    | 20 ++++++++++++++++++-
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/LoadPin.rst b/Documentation/admin-guide/LSM/LoadPin.rst
> index a90fd9dac960..f1e8825d0fe8 100644
> --- a/Documentation/admin-guide/LSM/LoadPin.rst
> +++ b/Documentation/admin-guide/LSM/LoadPin.rst
> @@ -16,10 +16,16 @@ boot ("``loadpin.enforce=0``").
>  
>  LoadPin starts pinning when it sees the first file loaded. If the
>  block device backing the filesystem is not read-only, a sysctl is
> -created to toggle pinning: ``/proc/sys/kernel/loadpin/enabled``. (Having
> +created to toggle pinning: ``/proc/sys/kernel/loadpin/enforce``. (Having

Ah. The sysctl documentation had the incorrect name there.

Would it be possible to put all of these command line parameters / sysctls
in the same place instead of having one of them in LoadPin.rst and
another one in kernel-parameters.txt ?

Thanks.

>  a mutable filesystem means pinning is mutable too, but having the
>  sysctl allows for easy testing on systems with a mutable filesystem.)
>  
> +Some filesystems may appear to be mutable, but are in fact read-only.
> +In this case, ``loadpin.force_enforce=1`` can be set to require enforcement
> +of LoadPin on all filesystems. When LoadPin is enabled,
> +``/proc/sys/kernel/loadpin/force_enforce`` reports the state of this option.
> +This option is independent of whether LoadPin is enabled.
> +
>  It's also possible to exclude specific file types from LoadPin using kernel
>  command line option "``loadpin.exclude``". By default, all files are
>  included, but they can be excluded using kernel command line option such
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1b2ae71def21..df8c145cc63d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3540,6 +3540,13 @@ Kernel parameters
>  			Enable Live Update Orchestrator (LUO).
>  			Default: off.
>  
> +	loadpin.force_enforce= [SECURITY]
> +			Format: <bool>
> +			Force LoadPin enforcement until reboot, even when the
> +			pinned filesystem is not backed by a read-only block
> +			device. Requires LoadPin to be enabled in the active LSM list.
> +			Default: off.
> +
>  	lockd.nlm_grace_period=P  [NFS] Assign grace period.
>  			Format: <integer>
>  
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index f71861f98e1a..b260ad299a2c 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -45,6 +45,7 @@ static void report_load(const char *origin, struct file *file, char *operation)
>  }
>  
>  static int enforce = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
> +static bool force_enforce __ro_after_init;
>  static char *exclude_read_files[READING_MAX_ID];
>  static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
>  static struct super_block *pinned_root;
> @@ -60,11 +61,19 @@ static bool loadpin_root_writable;
>  static int proc_handler_loadpin(const struct ctl_table *table, int dir,
>  				void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	if (!loadpin_root_writable && SYSCTL_USER_TO_KERN(dir))
> +	if ((force_enforce || !loadpin_root_writable) && SYSCTL_USER_TO_KERN(dir))
>  		return -EINVAL;
>  	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
>  }
>  
> +static int proc_handler_force_enforce(const struct ctl_table *table, int dir,
> +				      void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	if (SYSCTL_USER_TO_KERN(dir))
> +		return -EPERM;
> +	return proc_dobool(table, dir, buffer, lenp, ppos);
> +}
> +
>  static const struct ctl_table loadpin_sysctl_table[] = {
>  	{
>  		.procname       = "enforce",
> @@ -75,6 +84,13 @@ static const struct ctl_table loadpin_sysctl_table[] = {
>  		.extra1         = SYSCTL_ZERO,
>  		.extra2         = SYSCTL_ONE,
>  	},
> +	{
> +		.procname       = "force_enforce",
> +		.data           = &force_enforce,
> +		.maxlen         = sizeof(force_enforce),
> +		.mode           = 0444,
> +		.proc_handler   = proc_handler_force_enforce,
> +	},
>  };
>  #endif
>  
> @@ -436,6 +452,8 @@ DEFINE_LSM(loadpin) = {
>  };
>  
>  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
> +module_param(force_enforce, bool, 0);
> +MODULE_PARM_DESC(force_enforce, "Always enforce module/firmware pinning");
>  module_param(enforce, int, 0);
>  MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
>  module_param_array_named(exclude, exclude_read_files, charp, NULL, 0);

-- 
~Randy

