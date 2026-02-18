Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829633E37C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408624; cv=none; b=KPfC1dLbg19QSvhMpjAH73oNvXlhMjAKpRpYdu+IqW7IwnndylN0bqpgd6N1MTXylPkAuCW1SANIr7Umrxf1uVGmScqz1gxv7i0DgpP/ltZJ0m6F7Cea95riU+edAvTT4DJhJUZZOmlTAXksOjn5+RXXiW5610jYM4kPM6yvldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408624; c=relaxed/simple;
	bh=50pHd/Lyq7OL4aRqEA1dp7XqbXwMb9YRIsuFE/XQ5Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7QJeADwdL+OikHtvL5NakQigeXjEwKKNVuWV1MIztEc8DCB4b8AUqABwP7CuKQ0y3SqeuJ7WYsOLODgzN28XeAWCBhEuBNmdBDfcWJ6/dHAOPuBzn8CBIX4UByUa3m8WORuU2fz/bA+FSLQxZzP8khd94Tj2uxVKEGJET8Cz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LMBurl8v; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LMBurl8v"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fGBHx24NkzDkd;
	Wed, 18 Feb 2026 10:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771407453;
	bh=CWV9OZrJ9t2I3kN8783d0Xc/+Vl63CdGgUSEr/mMOEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMBurl8vQJRMYiw2XjhN7W+3/wZiBeHpi8dzFjk9+ozidnQ9mjJ4VJ8E/ivcWlund
	 ew2jTIUOhDLS2O1ZvSPlxgWZFCyAqxN7KYw6OMb14bCxzfqJOtimXL490ngA4EscPl
	 FJasSLunQoAB7+wSmkUTy1E46Rj2nAUTrVTY6GZc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fGBHw5Hr5zlqN;
	Wed, 18 Feb 2026 10:37:32 +0100 (CET)
Date: Wed, 18 Feb 2026 10:37:31 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 3/9] samples/landlock: Add support for named UNIX
 domain socket restrictions
Message-ID: <20260218.ufao5Vaefa2u@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260215105158.28132-4-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Feb 15, 2026 at 11:51:51AM +0100, Günther Noack wrote:
> The access right for UNIX domain socket lookups is grouped with the
> read-write rights in the sample tool.  Rationale: In the general case,
> any operations are possible through a UNIX domain socket, including
> data-mutating operations.
> 
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  samples/landlock/sandboxer.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e7af02f98208..0bbbc5c9ead6 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -111,7 +111,8 @@ static int parse_path(char *env_path, const char ***const path_list)
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>  
>  /* clang-format on */
>  
> @@ -295,11 +296,12 @@ static bool check_ruleset_scope(const char *const env_var,
>  	LANDLOCK_ACCESS_FS_MAKE_SYM | \
>  	LANDLOCK_ACCESS_FS_REFER | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 7
> +#define LANDLOCK_ABI_LAST 9
>  
>  #define XSTR(s) #s
>  #define STR(s) XSTR(s)
> @@ -444,6 +446,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			"provided by ABI version %d (instead of %d).\n",
>  			LANDLOCK_ABI_LAST, abi);
>  		__attribute__((fallthrough));
> +	case 7:
> +		__attribute__((fallthrough));

The current code should print the hint when ABI <= 7.  Please send a
dedicated patch to fix the TSYNC-related changes.

> +	case 8:
> +		/* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
> +		ruleset_attr.handled_access_fs &=
> +			~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
> +		__attribute__((fallthrough));
>  	case LANDLOCK_ABI_LAST:
>  		break;
>  	default:
> -- 
> 2.52.0
> 
> 
