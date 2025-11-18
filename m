Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F03546E7;
	Tue, 18 Nov 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475423; cv=none; b=dEPr3GPailmoNvW3KWmhUAOcWiJMiwRnmED73F02KYz1Fq53U87cU1Tov61NB51QYnt6JO7ayDa/3elj81W+gu7I4VGLwWiTS07aiHpP0znKm4pYNrb0doDoQMj/JHOhbnCwAUIHRjCusNO2HMVwPR522S8FLoc1J50yyehkkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475423; c=relaxed/simple;
	bh=XFPbK1QualsnUGJsByYYFNsWe9rOHvb4jSlX1SDesFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaIrfX+hsouNj1B6YuWM2/qEsXt3A1TpXcjt05DmjnUvrfYHcA5FG0d/tD/FZQ9N2pbpMGxgoGFgyma0bAd4xieJMjlaud/Lb30JbTA4tOqIgazOCz3p4vBc+LUwOjoT2kJ3+p+pX2n0hpiknl7DANnrJAQ2Wtz6LauNqu7qWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id C1A73758; Tue, 18 Nov 2025 08:16:52 -0600 (CST)
Date: Tue, 18 Nov 2025 08:16:52 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] Clarify the rootid_owns_currentns
Message-ID: <aRx/1MvvBqu5MhKv@mail.hallyn.com>
References: <aRegH8P4cPlzzlX9@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRegH8P4cPlzzlX9@mail.hallyn.com>

On Fri, Nov 14, 2025 at 03:33:19PM -0600, Serge E. Hallyn wrote:
> Split most of the rootid_owns_currentns() functionality
> into a more generic rootid_owns_ns() function which
> will be easier to write tests for.
> 
> Rename the functions and variables to make clear that
> the ids being tested could be any uid.
> 
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> CC: Ryan Foster <foster.ryan.r@gmail.com>
> CC: Christian Brauner <brauner@kernel.org>

Paul, Christian, let me know if you have any objections, else I will
queue this up in caps-next.

Ryan, based on this you would be able to do more useful unit ktests:
you could create some simple user namespaces with mappings which do
or do not have uid 0 in ns mapped to the kuid you are querying.

> ---
>  security/commoncap.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 6bd4adeb4795..8a81fdc12cbe 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -358,17 +358,18 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
>  	return error;
>  }
>  
> -static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
> +/**
> + * kuid_root_in_ns - check whether the given kuid is root in the given ns
> + *
> + * @kuid - the kuid to be tested
> + * @ns - the user namespace to test against
> + *
> + * Returns true if @kuid represents the root user in @ns, false otherwise.
> + */
> +static bool kuid_root_in_ns(kuid_t kuid, struct user_namespace *ns)
>  {
> -	struct user_namespace *ns;
> -	kuid_t kroot;
> -
> -	if (!vfsuid_valid(rootvfsuid))
> -		return false;
> -
> -	kroot = vfsuid_into_kuid(rootvfsuid);
> -	for (ns = current_user_ns();; ns = ns->parent) {
> -		if (from_kuid(ns, kroot) == 0)
> +	for (;; ns = ns->parent) {
> +		if (from_kuid(ns, kuid) == 0)
>  			return true;
>  		if (ns == &init_user_ns)
>  			break;
> @@ -377,6 +378,16 @@ static bool rootid_owns_currentns(vfsuid_t rootvfsuid)
>  	return false;
>  }
>  
> +static bool vfsuid_root_in_currentns(vfsuid_t vfsuid)
> +{
> +	kuid_t kuid;
> +
> +	if (!vfsuid_valid(vfsuid))
> +		return false;
> +	kuid = vfsuid_into_kuid(vfsuid);
> +	return kuid_root_in_ns(kuid, current_user_ns());
> +}
> +
>  static __u32 sansflags(__u32 m)
>  {
>  	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
> @@ -481,7 +492,7 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
>  		goto out_free;
>  	}
>  
> -	if (!rootid_owns_currentns(vfsroot)) {
> +	if (!vfsuid_root_in_currentns(vfsroot)) {
>  		size = -EOVERFLOW;
>  		goto out_free;
>  	}
> @@ -722,7 +733,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  	/* Limit the caps to the mounter of the filesystem
>  	 * or the more limited uid specified in the xattr.
>  	 */
> -	if (!rootid_owns_currentns(rootvfsuid))
> +	if (!vfsuid_root_in_currentns(rootvfsuid))
>  		return -ENODATA;
>  
>  	cpu_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
> -- 
> 2.34.1
> 
