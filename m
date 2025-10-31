Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48B28C035;
	Fri, 31 Oct 2025 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953894; cv=none; b=ipPtPdbXe6PU4rFhdgrNvI4dRYYd/DFx+Bpf9xvOO85QqUUJqrBOZPIX91a/CL3CRL1rEFA+kXMn+bEHqyDGBPl4GuLMuOU60Q411a8IIHQDuEAceNY4KW/aorpjmmfZl/ov0lZ3ZwgnNfHoXArVnOQWQQsJhXuLckksDCYrUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953894; c=relaxed/simple;
	bh=ZZBwwZAqyH37jixgU+9Ikj79If/LNQFAF0IsdYlO+Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbZFGIFj3kLZlPiHmMZCDESepa1Pp2+BRluEn5318F0TJmkEqi2XsrN5u0lDtkAiGBd8V2g0BA4mfjUMIysIxsyGjbOqvNRk+nbrwNPP/tDBzPO2+8cKW29k9+yaTtx1jBMh38nrHLvQiX+Uy6hWMZyuBPlybR5NSX5XBHxGz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 30158C8C; Fri, 31 Oct 2025 18:38:08 -0500 (CDT)
Date: Fri, 31 Oct 2025 18:38:08 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] device_cgroup: Refactor devcgroup_seq_show to use
 seq_put* helpers
Message-ID: <aQVIYI2vwvln2CJN@mail.hallyn.com>
References: <20251031213915.211046-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031213915.211046-1-thorsten.blum@linux.dev>

On Fri, Oct 31, 2025 at 10:39:14PM +0100, Thorsten Blum wrote:
> Replace set_access(), set_majmin(), and type_to_char() with new helpers
> seq_putaccess(), seq_puttype(), and seq_putversion() that write directly
> to 'seq_file'.
> 
> Simplify devcgroup_seq_show() by hard-coding "a *:* rwm", and use the
> new seq_put* helper functions to list the exceptions otherwise.
> 
> This allows us to remove the intermediate string buffers while
> maintaining the same functionality, including wildcard handling.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thank you, that is much  nicer.

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
> Changes in v2:
> - Add setq_put* helpers to modify seq_file directly (David)
> - Update patch subject and description
> - Link to v1: https://lore.kernel.org/lkml/20251031110647.102728-2-thorsten.blum@linux.dev/
> ---
>  security/device_cgroup.c | 56 ++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index dc4df7475081..7fec575d32d6 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -244,45 +244,40 @@ static void devcgroup_css_free(struct cgroup_subsys_state *css)
>  #define DEVCG_DENY 2
>  #define DEVCG_LIST 3
>  
> -#define MAJMINLEN 13
> -#define ACCLEN 4
> -
> -static void set_access(char *acc, short access)
> +static void seq_putaccess(struct seq_file *m, short access)
>  {
> -	int idx = 0;
> -	memset(acc, 0, ACCLEN);
>  	if (access & DEVCG_ACC_READ)
> -		acc[idx++] = 'r';
> +		seq_putc(m, 'r');
>  	if (access & DEVCG_ACC_WRITE)
> -		acc[idx++] = 'w';
> +		seq_putc(m, 'w');
>  	if (access & DEVCG_ACC_MKNOD)
> -		acc[idx++] = 'm';
> +		seq_putc(m, 'm');
>  }
>  
> -static char type_to_char(short type)
> +static void seq_puttype(struct seq_file *m, short type)
>  {
>  	if (type == DEVCG_DEV_ALL)

I do think a switch would be easier to read here, but that's
personal preference...

> -		return 'a';
> -	if (type == DEVCG_DEV_CHAR)
> -		return 'c';
> -	if (type == DEVCG_DEV_BLOCK)
> -		return 'b';
> -	return 'X';
> +		seq_putc(m, 'a');
> +	else if (type == DEVCG_DEV_CHAR)
> +		seq_putc(m, 'c');
> +	else if (type == DEVCG_DEV_BLOCK)
> +		seq_putc(m, 'b');
> +	else
> +		seq_putc(m, 'X');
>  }
>  
> -static void set_majmin(char *str, unsigned m)
> +static void seq_putversion(struct seq_file *m, unsigned int version)
>  {
> -	if (m == ~0)
> -		strcpy(str, "*");
> +	if (version == ~0)
> +		seq_putc(m, '*');
>  	else
> -		sprintf(str, "%u", m);
> +		seq_printf(m, "%u", version);
>  }
>  
>  static int devcgroup_seq_show(struct seq_file *m, void *v)
>  {
>  	struct dev_cgroup *devcgroup = css_to_devcgroup(seq_css(m));
>  	struct dev_exception_item *ex;
> -	char maj[MAJMINLEN], min[MAJMINLEN], acc[ACCLEN];
>  
>  	rcu_read_lock();
>  	/*
> @@ -292,18 +287,17 @@ static int devcgroup_seq_show(struct seq_file *m, void *v)
>  	 * This way, the file remains as a "whitelist of devices"
>  	 */
>  	if (devcgroup->behavior == DEVCG_DEFAULT_ALLOW) {
> -		set_access(acc, DEVCG_ACC_MASK);
> -		set_majmin(maj, ~0);
> -		set_majmin(min, ~0);
> -		seq_printf(m, "%c %s:%s %s\n", type_to_char(DEVCG_DEV_ALL),
> -			   maj, min, acc);
> +		seq_puts(m, "a *:* rwm\n");
>  	} else {
>  		list_for_each_entry_rcu(ex, &devcgroup->exceptions, list) {
> -			set_access(acc, ex->access);
> -			set_majmin(maj, ex->major);
> -			set_majmin(min, ex->minor);
> -			seq_printf(m, "%c %s:%s %s\n", type_to_char(ex->type),
> -				   maj, min, acc);
> +			seq_puttype(m, ex->type);
> +			seq_putc(m, ' ');
> +			seq_putversion(m, ex->major);
> +			seq_putc(m, ':');
> +			seq_putversion(m, ex->minor);
> +			seq_putc(m, ' ');
> +			seq_putaccess(m, ex->access);
> +			seq_putc(m, '\n');
>  		}
>  	}
>  	rcu_read_unlock();
> -- 
> 2.51.1
