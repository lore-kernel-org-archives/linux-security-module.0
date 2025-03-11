Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35978F5D
	for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700260; cv=none; b=QE6rAw6//pWCQUtySYcOHZ+QctmX3w2YkCSEBcvQoLDO0nfLdWMLaUw0Jc+4Uy8NIvgy964TLTfXmLQUc/PHVom/GFHrSrjzqZtcAD9uncmCLX/MVTpWBdeWSo0Ivbv1WBeSWSOaxAZJVTpeZR0EgjZkn0hF8RiI5KsggBfC8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700260; c=relaxed/simple;
	bh=Fv9bgoCj8T1HxxYViA2cy8fyVV76Oxipu9JiKde52II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PE07zxl/ERNZcegRPHbtx83Kji9b0bmQTL2PNRnuWwZ1jzwRlO9unJlPbUQNv3SVqNTgriTKzm3Z06XxsUfp9S1l1A4oQrzXAvDzftsD3pPnxLBwHSHhjFRKqFdSzXcCLkLwxbAKpGiBM60+cnHKwaIylI0YrLGIthwbHUx8h/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BzbxxUSY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BzbxxUSY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso32720785e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741700257; x=1742305057; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qLMXMTwOhKieWEK80byf0Odi49jjdtVmyVqKoQf3GM=;
        b=BzbxxUSYSUmdIkiO3hE/W4w7/6gj7nY00+KonJs7Y5Z3oRQ95RkoEhuBus/I9B58yn
         SPJaV+jYARBV4MVi6+OtOqa2WTMa66Jas49pXHblsymQDcLDA6ejl8MN/Ml3Q/1ukHAd
         5JGkTFCGl3qUJyr/JpWO8XATbfSnmq9e6bg4KMj8qOvsf1onOUNPEH60bMfHqgBfTQIU
         XbpJLHDru8weALQMN57aJi/t/ZNJ9dLsn00WJATQz3vqMzd+M/jA68CwUI9ZLcZU0HtE
         +JupquyaKhHiSA6i1BO8oqbqW1C8BgCWVD/CwXKPtVE3H9/XlRrsLWHA4QiyXulqJ+Vj
         BDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700257; x=1742305057;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qLMXMTwOhKieWEK80byf0Odi49jjdtVmyVqKoQf3GM=;
        b=O+Aic1jp3iyboQRdtVmuboeKB42yEVoQ0oIod+t04RdVekyfunkdxEt9Zsl3wC1zzf
         Y35oC4WRiPN5GvPWcy+crpqRrlUjIwSHWQfHk+e0xUunCi5dYzfODpQrSddg8y2m6iUh
         8c+5fiD5vE9WxebZSaA52HonsQvQXZdiCAy1Lrt5/mgpbXqNKolCbarZy7n3A7/Sl0rY
         0alVZqNMmpZOHWE/TrMRZJtWlHiQ3NL2MYv8oHNb2i/XfjghoIR9JlsohH6RNlaWUpzm
         TSfezixQFkCKKYqav04m8udMG1+9rJdnQpWq4D5nSKMhlJCda8XckIglKAdLJ40GzWZK
         vnfA==
X-Forwarded-Encrypted: i=1; AJvYcCXKs5qxxTgcMKBiasBuN4I4EozTDyb9XQFVj5SoERZ5MJL2+Vtgkp2efk2BuCvTehv+x+0WB9HeWqsrA7MhqZMdLnPXISI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUIqvOQshwkUS6oqKK6RXLtUCaF44V3rbGeATAU/GCnQpuGxl
	LF+0p+xvP1Eq9hU5KVKbE7MeI+hgrpVoNhxgFD5OIVCK67Ba2Klw6MyAL6y4uKauLw9G63jiDtK
	i
X-Gm-Gg: ASbGncu0+InaeIgiPmVu7eS6Jl213dYpqkE5EpMI8jIAzGuw4G41jKligK02QKIKkky
	lHli+hvO+AzYojQMSyaXLT3dm/GxHy8xCGoJpUhWNKUOg6lrA5p/t+HYMcIZyOaFnW7aFTHPGmK
	PT40H4FwbTJGG4zCVM8SW9ue9ixEc0XeE9gqRDWrM1yHuH2UucCplX/EIK40iqYLjoT1+NbDKUG
	op6Lfcp/e/i0Se5Qi1Rg75os6kNzpd9IUoEaKypW9ZN6g11aW/nl8DfQwvEiiqTfTmQW/tUCbAh
	1qkZJMTeLC9Y6ufZoJ8vIaxI3Nv7NSUYyg4t
X-Google-Smtp-Source: AGHT+IHnMSDX5ZaXtJ2dFla7HDmAssBc1J7kBf27eQZe4BxrcsGOSqTZlUY9mpGYXqZde/4Zg6VzWA==
X-Received: by 2002:a05:6000:402a:b0:391:2c0c:126b with SMTP id ffacd0b85a97d-39132d531c3mr15248738f8f.23.1741700256551;
        Tue, 11 Mar 2025 06:37:36 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c348esm9560597a12.45.2025.03.11.06.37.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:37:36 -0700 (PDT)
Date: Tue, 11 Mar 2025 21:37:31 +0800
From: joeyli <jlee@suse.com>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, bp@alien8.de, sfr@canb.auug.org.au,
	peterz@infradead.org, nathan@kernel.org,
	Jiri Kosina <JKosina@suse.cz>, Michal Suchanek <msuchanek@suse.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
Message-ID: <20250311133731.GB17395@linux-l9pv.suse>
References: <20240801171747.3155893-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801171747.3155893-1-kpsingh@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi KP,

On Thu, Aug 01, 2024 at 07:17:47PM +0200, KP Singh wrote:
> With LSMs using static calls, early_lsm_init needs to wait for setup_arch
> for architecture specific functionality which includes jump tables and
> static calls to be initialized.
> 
> This only affects "early LSMs" i.e. only lockdown when
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is set.
> 
> Fixes: 2732ad5ecd5b ("lsm: replace indirect LSM hook calls with static calls")
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I have tested acpi table override function by
CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD option. As this patch
description, the early LSM can NOT lockdown acpi table override in early
boot stage now. 

Do you have any plan to fix the early lockdown LSM? Or I missed any fix
patch in kernel mailing list?

Thanks a lot!
Joey Lee
