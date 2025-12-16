Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349D31A7F8;
	Tue, 16 Dec 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874250; cv=none; b=g9ka8ctFhLEn11jirmfnt2MacjCVrYSoGUrNYDNeR8fktu2iR8eH0eM1/723gHu9GKBZU5FzEYzfM+n1qV2a7r+A/szTGwkkdqFzyX+/LkrXnhkQrXiMM7INoZmI77nEy4prBxjX7ed25utubPJdxkR22QUFxldgp4mAYcUvhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874250; c=relaxed/simple;
	bh=THzcQoJcnqcyvdFkSf8BaDNgnnbDTqbHuMYfj++iayQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDwsgd1drfBtt7GjbWhA8M2KzxLFzZ0UKh+vjM3J4N8ilm3G+Qmo8tQ6JAYPwnEl4Tsi2J5TRswQourQlqRYge1HRZOdCzvVtJEp3Ius+yUrfnLzFhuewNmJ1vvNVicYciKIxv+1QZ3WE4VvnbGDZ8zubxIaXtGrCKeCVoYTaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJihB42D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJihB42D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CED3C4CEF1;
	Tue, 16 Dec 2025 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765874250;
	bh=THzcQoJcnqcyvdFkSf8BaDNgnnbDTqbHuMYfj++iayQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJihB42DaGOLxVAXnOyCAMRdY8BliIZG4TBwlplohLnUvJXEX9w7YlO0kw10F3dod
	 qUXePozOvCgYLCr7tvTj+4Ogo+tv2bR6jZ+1PS2LBwimlfHWu5356Bb9B/3t/M+Jl4
	 Hi+OzBSgzq/W7tmFIpThIXLpHmx+WOd+J6rKzWPWB3ohKuxLq1DtTDu+yHhffeOGe4
	 yctGEaP1UNwHSFqwlw/OZrbYq29KEAu1oPoc8FWZiBqcBWC6idJcGY+TDWr9xWRgTu
	 5HL1gY2MPN24UdwL4C+2Fig62Uuw/WA0mAFoj1y6+m5ApC1B2s7fKQ9U7ObcnifArH
	 MIHMK8yHR/mlw==
Date: Tue, 16 Dec 2025 00:37:29 -0800
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loadpin: Implement custom proc_handler for enforce
Message-ID: <202512160028.8F11A5D19@keescook>
References: <20251215-jag-const_loadpin-v1-1-6842775f4e90@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-jag-const_loadpin-v1-1-6842775f4e90@kernel.org>

On Mon, Dec 15, 2025 at 04:43:48PM +0100, Joel Granados wrote:
> The new proc_handler_loadpin returns -EINVAL when is_loadpin_writable is
> false and the kernel var (enforce) is being written. Move
> loadpin_sysctl_table to .rodata (by const qualifying it) as there is no
> need to change the value of the extra1 entry.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> Const qualifying ctl tables is part of the hardening effort in the linux
> kernel.

Ah yes, thanks for getting through these "weird" cases! :)

> ---
>  security/loadpin/loadpin.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 273ffbd6defe1324d6688dec5f9fe6c9401283ed..f049c81b82a78265b6ae358bb2a814265cec9f16 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -53,18 +53,29 @@ static bool deny_reading_verity_digests;
>  #endif
>  
>  #ifdef CONFIG_SYSCTL
> -static struct ctl_table loadpin_sysctl_table[] = {
> +static bool is_loadpin_writable;

I would rather that load_root_writable were declared external to
loadpin_check(), and then we could remove set_sysctl() entirely, instead
using load_root_writable as the thing to check in proc_handler_loadpin().

And also rename load_root_writable to "loadpin_root_writable", just to
make it a bit more clear.

-Kees

-- 
Kees Cook
