Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E90524F;
	Tue, 11 Feb 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234312; cv=none; b=MJU+lFgkBpkWSsU9XuMxLtNGEqTETgO+4AIN/e7aXXGfA/2RKGtkjyoW3oESmnWVE6x9M2iF+AkHNwFwh83a6yp2TTiMZ8QhkruQ4iYCEwTRNIh7Oxnw+U+eOtDKYGOr/iqDPTnhYbHkW48jj0F6v2xHdWC7m85S48W+zvak8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234312; c=relaxed/simple;
	bh=l5h5228hacHyEf2k3kEM82BJkSixoxhycvWdQFU7XB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewo3n1S3eCRf9r/envDVvUdJ36tr2pEGN8fLBZgmaTUmoedP3+Gq7OBVyOMmlkI6+VagglEwzmtxSMO0wnENsVOfUBtGSs1tYl7tFFUkd1gxZ6Kafp+p+bnotcMvJM54ecWGezhf+s6UDwpazYZ2fwV8Fx17UP+Lf3zfN73vsHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ2O00M9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ2O00M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852E2C4CED1;
	Tue, 11 Feb 2025 00:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234312;
	bh=l5h5228hacHyEf2k3kEM82BJkSixoxhycvWdQFU7XB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ2O00M9co3/uXOI5zCyPdrE6h3KRMoK+tjGhbudhd/0jfxol2tJ6c+s2U5XVXWs4
	 EHgkiNCFc6otfWTejUk+42Ie5y8jke8J/S3a3rHn9IkLbUzq0spJaDI0/eaOffx4lO
	 /y7BnrvgP5RQaWRx6tUI/qgXqUFY6CvxvdQJ3RiRigX4iQmby2qn9nTBBwQ6F88Q6p
	 k7lz5jSMxNZJo3tNsPXNlXzi/9BtIO5rmcQp3USUELzrtAzCpvGSfk/+AxspcjgoWG
	 doqIV5+dCWf6XNXiCBnJMuVta6jKw4qSXH3MDatdajmmRX4dPSQOrGqHTtH5upsLUE
	 tP9t1Ql3HPeag==
Date: Mon, 10 Feb 2025 16:38:32 -0800
From: Kees Cook <kees@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 2/2] LoadPin: Make sysctl table const
Message-ID: <202502101638.BE56669918@keescook>
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com>
 <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123-sysctl-kees-v1-2-533359e74d66@suse.com>

On Thu, Jan 23, 2025 at 04:33:35PM -0300, Ricardo B. Marliere wrote:
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows for struct ctl_table to be
> in read-only memory. Move loadpin_sysctl_table to be declared at build
> time, instead of having to be dynamically allocated at boot time.
> 
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>  security/loadpin/loadpin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 68252452b66cb913638abbca2adea26219e77d37..e2d664b7602629c08c86d6d02158a4e9dd189b1a 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -53,7 +53,7 @@ static bool deny_reading_verity_digests;
>  #endif
>  
>  #ifdef CONFIG_SYSCTL
> -static struct ctl_table loadpin_sysctl_table[] = {
> +static const struct ctl_table loadpin_sysctl_table[] = {
>  	{
>  		.procname       = "enforce",
>  		.data           = &enforce,

This can't be done since the table is modified during set_sysctl().

-Kees

-- 
Kees Cook
