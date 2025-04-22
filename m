Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5504280A2E
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325321; cv=none; b=VI883ANSfZoh2gdfsl/SUdctd3yFu5AObG9u4k6vG/QKCYnacsUZFrnSRbEwbwnkmFh7b1OeLkAwR9atYsjban4FoD2I8Oaq6P+bX6AUkmYVOxFsrCTBqr+ydUzGuijy9AM0n7IFU6UC2tq2Z7TSzI4D7c4ikIPobusr3o0dgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325321; c=relaxed/simple;
	bh=BndmB68+WTOPz76lUuk2umSP58GYXSUlLi0x/lVTbT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4/AWS5buJxwjxxi6Yg2K2oktZ6idFw/T4iPngvZNp1JShrtTtGstsq5qD/B+ECsV8emd/AZPeq/5iKrSHxObhErRp98R3SnjidNNEh5Pcd512ry6jNACpfux6q/oMWpWCSkzhx9ztERb4NxmxS8s8hbwgylG/EtoVAEMC51eVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SPtgWurB; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SPtgWurB"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZhhJw5mS6zf50;
	Tue, 22 Apr 2025 14:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1745324720;
	bh=TuQI9VlwlZ1zmKAB0H8z02ZGDpIYuqGGocpb7abx7+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPtgWurBT9pgo6SoDu4+z5OhPDY/gJexApxrsD7I+iWYaMRhxkGZRQAXuwKFTs/cZ
	 +Tau1Kzk7U1Aax3g/GZrnHhrEfO2Mi/5oAZBVWfKprRs/Hy0kpQXcD615l+NfUN4oY
	 uULHFghfIoX6R4ULeaTK2m40o7p0VHGbY1CaES6M=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZhhJt3Qnqzh0k;
	Tue, 22 Apr 2025 14:25:18 +0200 (CEST)
Date: Tue, 22 Apr 2025 14:25:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Mark Brown <broonie@kernel.org>, WangYuli <wangyuli@uniontech.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] landlock: Work around randstruct unnamed static
 initializer support
Message-ID: <20250422.eetheiPu6aiH@digikod.net>
References: <20250421000854.work.572-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421000854.work.572-kees@kernel.org>
X-Infomaniak-Routing: alpha

On Sun, Apr 20, 2025 at 05:08:59PM -0700, Kees Cook wrote:
> Unnamed static initializers aren't supported by the randstruct GCC
> plugin. Quoting the plugin, "set up a bogus anonymous struct field
> designed to error out on unnamed struct initializers as gcc provides
> no other way to detect such code". That is exactly what happens
> with the landlock code, so adjust the static initializers for structs
> lsm_ioctlop_audit and landlock_request that contain a randomized structure
> (struct path) to use named variables, which avoids the intentional
> GCC crashes:

This is not a sustainable solution.  Could we fix the plugin instead?
This new Landlock change may be the first to trigger this plugin bug but
it will probably not be the last to use unnamed static initializers.
Forbidding specific C constructs should be documented.

As a temporary solution (not sure if it's worth it, nor a good idea),
could handling of types used in unnamed static initializers be ignored
by this plugin?  I guess [1] is already a temporary solution though.
[1] https://lore.kernel.org/all/20250409151154.work.872-kees@kernel.org/

> 
> security/landlock/fs.c: In function 'hook_file_ioctl_common':
> security/landlock/fs.c:1745:61: internal compiler error: in count_type_elements, at expr.cc:7092
>  1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
>       |                                                             ^
> 
> security/landlock/fs.c: In function 'log_fs_change_topology_path':
> security/landlock/fs.c:1379:65: internal compiler error: in count_type_elements, at expr.cc:7092
>  1379 |         landlock_log_denial(subject, &(struct landlock_request) {
>       |                                                                 ^
> 
> We went 8 years before tripping over this! With this patch landed,
> we can enable COMPILE_TEST builds with the randstruct GCC plugin again.
> 
> Reported-by: "Dr. David Alan Gilbert" <linux@treblig.org>
> Closes: https://lore.kernel.org/lkml/Z_PRaKx7q70MKgCA@gallifrey/
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/
> Reported-by: WangYuli <wangyuli@uniontech.com>
> Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-47f0-93a4-7809355f1381@uniontech.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "Mickaël Salaün" <mic@digikod.net>
> Cc: "Günther Noack" <gnoack@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: <linux-security-module@vger.kernel.org>
> ---
>  security/landlock/fs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..b2818afb0503 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1376,14 +1376,14 @@ static void
>  log_fs_change_topology_path(const struct landlock_cred_security *const subject,
>  			    size_t handle_layer, const struct path *const path)
>  {
> -	landlock_log_denial(subject, &(struct landlock_request) {
> +	struct landlock_request request = {
>  		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
> -		.audit = {
> -			.type = LSM_AUDIT_DATA_PATH,
> -			.u.path = *path,
> -		},
> +		.audit.type = LSM_AUDIT_DATA_PATH,
>  		.layer_plus_one = handle_layer + 1,
> -	});
> +	};
> +	request.audit.u.path = *path;
> +
> +	landlock_log_denial(subject, &request);
>  }
>  
>  static void log_fs_change_topology_dentry(
> @@ -1720,6 +1720,7 @@ static int hook_file_truncate(struct file *const file)
>  static int hook_file_ioctl_common(const struct file *const file,
>  				  const unsigned int cmd, const bool is_compat)
>  {
> +	struct lsm_ioctlop_audit audit_log;
>  	access_mask_t allowed_access = landlock_file(file)->allowed_access;
>  
>  	/*
> @@ -1738,14 +1739,13 @@ static int hook_file_ioctl_common(const struct file *const file,
>  				  is_masked_device_ioctl(cmd))
>  		return 0;
>  
> +	audit_log.path = file->f_path;
> +	audit_log.cmd = cmd;
>  	landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
>  		.type = LANDLOCK_REQUEST_FS_ACCESS,
>  		.audit = {
>  			.type = LSM_AUDIT_DATA_IOCTL_OP,
> -			.u.op = &(struct lsm_ioctlop_audit) {
> -				.path = file->f_path,
> -				.cmd = cmd,
> -			},
> +			.u.op = &audit_log,
>  		},
>  		.all_existing_optional_access = _LANDLOCK_ACCESS_FS_OPTIONAL,
>  		.access = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> -- 
> 2.34.1
> 
> 
