Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AE49626;
	Thu,  1 Aug 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497666; cv=none; b=sG4JVWrvnkoar6ERklXCoLX2Avgk5pJnZMM+zqZa/ILin9xjZHzdVdc4t/qAn6zBOQURONVcM/nNW6hDUVxrMSJ/2gjCPRacfpbJs9oq5UcKpO5eDoxKpHFLCflYAvyiZXwyaKJmuneRgb2Fjg3rOi5iMWGzXQnfxW908Ami+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497666; c=relaxed/simple;
	bh=0YwQJ5ThTZNAVt0ddJBrt23yhEWYjACirqP1N7cQOXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAR8JQTzmVR79fJOhlh3o8mJD5PNEwgobewL89tJ6nANAcZYQ2+zlYsVM36HL76zEZn2wR+924y6ZXaBZw7ieCJsB8D1K+Z7nUESuLbq69bi85HDlhSI6dnjMdMJUiTmXDzERRf0BS0LyUlOBuRZordyDdR71W4/892MuugCsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YKPSPer6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YKPSPer6"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3FC9740E01A2;
	Thu,  1 Aug 2024 07:34:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9G9iyM70FQaN; Thu,  1 Aug 2024 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722497658; bh=MuU0oaXSSlkWAyimXIs19Uqw04sE/qBAdKEgaL6rnxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKPSPer62OwiBMhvW11IigfgpFOKM58FX7qtrzXR9N8LOw8/UhtOisYzPKK06ZMgz
	 0c1NAq4EY54UA7r1R6VJkiHjcDMM0JzuyOKajQi+bKIFRIMk5vA3NLAWcPKrlnDCl5
	 IsCFaG4VmEzdEeXLHs58ZufSUlOmVTa9lUPhAKuWMcyo9YphPXHVLVA4PLcPZ39zs1
	 dolyh5hfaa9h+bno0rig15rBHz2KC8o5uuxFgoJh/JTemotfC0+r0Gu0pwEFLOpcVi
	 SYhOJ4c9rmMtTz+2FzykbnkHYmmf+30srT+CyQMD0l+Xns4xId1cefjeC72W6JJ5Uq
	 vSM3Hul5BHErDJcv85hqUVtfg54nibJ0oqlAMLUlm7UkCREShjEZh1k8xLGOkXtOot
	 ZClGa4ceRIszdaJ2i9HfZoH5kqRFx12XmUbuPOlsyjAAVRygaOUg3q7eKyg5Pbe+Rq
	 cmwSuzgqBmJ1OiAWqzKrpsjo54mzB9eXednZL8b7MvGvy7JxRAqH3Fb7GWHzUcHzwj
	 7BQJHxgNtMYbskuxUOu5f3lY5CeIvVoXqYZcoMZhEf1H4fIEBU9Gq2VhHCVtC7t1pc
	 WeFVNvpJE5GmFUiAjpfgfzLsfCckuFsrMY+iQDvlqmbZGEHneMEBONEr3MXYE0gi9T
	 DOCg5hvDC2uJPjNbfZWyA+5k=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0102240E026B;
	Thu,  1 Aug 2024 07:34:12 +0000 (UTC)
Date: Thu, 1 Aug 2024 09:34:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, sfr@canb.auug.org.au
Subject: Re: [PATCH] init/main.c: Do jump_label_init before
 early_security_init
Message-ID: <20240801073406.GAZqs6biPeFEG-0wPF@fat_crate.local>
References: <20240731213429.2244234-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731213429.2244234-1-kpsingh@kernel.org>

On Wed, Jul 31, 2024 at 11:34:29PM +0200, KP Singh wrote:
> LSM indirect calls being are now replaced by static calls, this requires
> a jumpt_table_init before early_security_init where LSM hooks and their
> static calls and keys are initialized.
> 
> Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  init/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 206acdde51f5..5bd45af7a49e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -922,6 +922,8 @@ void start_kernel(void)
>  	boot_cpu_init();
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
> +	/* LSM and command line parameters use static keys */
> +	jump_label_init();
>  	early_security_init();
>  	setup_arch(&command_line);
>  	setup_boot_config();
> @@ -933,8 +935,6 @@ void start_kernel(void)
>  	boot_cpu_hotplug_init();
>  
>  	pr_notice("Kernel command line: %s\n", saved_command_line);
> -	/* parameters may set static keys */
> -	jump_label_init();
>  	parse_early_param();
>  	after_dashes = parse_args("Booting kernel",
>  				  static_command_line, __start___param,
> -- 

I was gonna be very surprised if you could simply change the boot ordering
like that and it would simply work. The early boot order is a nightmare so
without proper audit of what uses which facilities when, you won't be really
successful, I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
