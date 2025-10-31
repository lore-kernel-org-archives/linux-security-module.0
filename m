Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBE343D72;
	Fri, 31 Oct 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915774; cv=none; b=BFEX8uGnnzwaBUGkEAn5dVhwJAzNRgeZeWNIxksGv6bGcsvkf8SzML4nvphxD6r/3938Qw1owj1fJHeyhC4/N7WiIKYf0seQZfQZW7oExplMkt1Zo4BsdfIpo3+2bUKVJr4OfDMhS4nqyCTDzpkbFP5XM/nhVtB+sTscTPkBqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915774; c=relaxed/simple;
	bh=mklZt5beKYaXRJNTJk+YPWnwUtm8oIDoquLhqk3ZCpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM6prQEiJ5Iv/ibFKyYyrgAvkAs3oB3+poWOO485YIhPMg3EwvJ9/kHQ1ajTcn05XFcFN8VlB8u7NX1N/J5Z5iPj3ZsnpHJFpY+8YMQ2IhJZcFFpBrxNrsHkyec8jdDLyKTqL5gmYqlbhvj9DaDKPJsepp8M47tzT36WjXww2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id ABBBE54B; Fri, 31 Oct 2025 08:02:42 -0500 (CDT)
Date: Fri, 31 Oct 2025 08:02:42 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
Message-ID: <aQSzcp852yz/Ourm@mail.hallyn.com>
References: <20251031110647.102728-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031110647.102728-2-thorsten.blum@linux.dev>

On Fri, Oct 31, 2025 at 12:06:47PM +0100, Thorsten Blum wrote:
> strcpy() is deprecated and sprintf() does not perform bounds checking
> either. While the current code works correctly, strscpy() and snprintf()
> are safer alternatives that follow secure coding best practices.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  security/device_cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index dc4df7475081..a41f558f6fdd 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -273,9 +273,9 @@ static char type_to_char(short type)
>  static void set_majmin(char *str, unsigned m)
>  {
>  	if (m == ~0)
> -		strcpy(str, "*");
> +		strscpy(str, "*", MAJMINLEN);

I dunno, I'm not saying I would say no to this, but it does look
a little ridiculous.  If it used some macro version which computes
the length of str instead of typing in MAJMINLEN, that might be
better.  But we're just as likely here to get MAJMINLEN out of
sync with the length of strscpy as anything else happening, and
all to copy over two bytes.

>  	else
> -		sprintf(str, "%u", m);
> +		snprintf(str, MAJMINLEN, "%u", m);

Here, to me it always looks suspect to use snprintf without
checking its return value, and in this case, if snprintf cuts
off the value it is in fact a potential security issue, one
which did not exist before this.

So make up your mind: is it worth doing the length check or
not?  If not, then this switch is uncalled for.  If so, then
you should check the return value, else one day I may be able
to whitelist a device which the admin didn't allow.

>  }
>  
>  static int devcgroup_seq_show(struct seq_file *m, void *v)
> -- 
> 2.51.1
