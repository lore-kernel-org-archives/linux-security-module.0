Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87F3A4539;
	Mon, 16 Mar 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675249; cv=none; b=SQQuSokKV96owoOdhaZgKqO/ou8/DyRioVCg6xOs2ygtkSOWShnjSlp9G4DFF34uwDR4+IeYifnlqBXIIMVoCdiZtEcSSZBSxfKV4MiV3wyw2XEtm158o1mWJ+0tB3VFTB3/xQcin7rhd15T2lkzejaWLXT79Ev5vnX8+x1BfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675249; c=relaxed/simple;
	bh=E5y5oJyTASlanfUCdlYVfycltKAYvehU/T8znkBuxPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CISuV7t9Jwk0/H48ljm+Cwho91Ezal/2gZM50rWEyuKvHLQHl+HIJla/i8Sum216hGrr4x0AOUzhZjXFKm85ioJtYnoRus+LdqJ+/hKQYCRRjwXkh/qtjEQCFNrDeh6TBDDZXBJLa60ufOMd1aoXHncSrpkFQi5+2GSPEhbXpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=B7ZtIzgS; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="B7ZtIzgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1773674829; bh=E5y5oJyTASlanfUCdlYVfycltKAYvehU/T8znkBuxPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7ZtIzgSoK3VkQ3BbTUOFahZYAOQQVmuVEEjL1zGmlL3aIYBDczBrbbwaAe9L22uZ
	 rdwLaL+ZjoDv/CCMs/OX3fchR052GcBwbXqeBQS3tEGl924aeutrPFNR93CI/C5XYm
	 Ck2I7yGAAYF8QVJf45zPLe933SfdlvSQUyahDoTUvSP1hw75/qOz85pcj3sJQe29WS
	 4H2ZWTgafGAYEmwH999GFxORnZ6sbaoRjDyjmGZI1h1a+8gbRJXl/uSo6lj508Y0qh
	 nB19jG7YBpROeNgv085JXfIgbNZSLTuncLwYbjjYrM17jq/D4NUKWFFUv0nhU7s3FR
	 aQmadGyiVuGkQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 4B73EEBD; Mon, 16 Mar 2026 10:27:09 -0500 (CDT)
Date: Mon, 16 Mar 2026 10:27:09 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: hide unused get_loaddata_common_ref() function
Message-ID: <abghTTr2xuOMMxzL@mail.hallyn.com>
References: <20260316135935.3321551-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316135935.3321551-1-arnd@kernel.org>

On Mon, Mar 16, 2026 at 02:59:31PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly introduced function is only used in an #ifdef block,
> which causes a harmless warning:
> 
> security/apparmor/apparmorfs.c:177:28: error: 'get_loaddata_common_ref' defined but not used [-Werror=unused-function]
>   177 | static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> 
> Move the definition next to the user to avoid the warning.
> 
> Fixes: 8e135b8aee5a ("apparmor: fix race between freeing data and fs accessing it")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> Alternatively, the #ifdef checks could be replaced with an
> 'if(IS_ENABLED(CONFIG_SECURITY_APPARMOR_EXPORT_BINARY) return;'
> check in __aa_fs_create_rawdata(), relying on the compiler's
> dead code elimination.
> ---
>  security/apparmor/apparmorfs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index ededaf46f3ca..f762b101d682 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -174,14 +174,6 @@ static struct aa_proxy *get_proxy_common_ref(struct aa_common_ref *ref)
>  	return NULL;
>  }
>  
> -static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> -{
> -	if (ref)
> -		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
> -						      count));
> -	return NULL;
> -}
> -
>  static void aa_put_common_ref(struct aa_common_ref *ref)
>  {
>  	if (!ref)
> @@ -1318,6 +1310,14 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
>  	.release	= seq_rawdata_release,				      \
>  }									      \
>  
> +static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
> +{
> +	if (ref)
> +		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
> +						      count));
> +	return NULL;
> +}
> +
>  static int seq_rawdata_open(struct inode *inode, struct file *file,
>  			    int (*show)(struct seq_file *, void *))
>  {
> -- 
> 2.39.5
