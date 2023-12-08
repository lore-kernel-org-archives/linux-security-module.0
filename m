Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8jvXcuV"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E4AD
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 09:36:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d053c45897so21356365ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 09:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056966; x=1702661766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HSNZHOju8hpOrntNygE/eIZPol1N9ffLpPl4Rg7zEI=;
        b=W8jvXcuVbAC1oUPpxfzfrjvOSzglR5lNYEjnlM2rEGVpCQpAD/UTTs6SpbC6aIm029
         Wj/mNifzUZrYp9Q5FHUTybwudRg3gzHyNyjx7pRkHcfpl6P6YKr84V8IrzFon/TzfVp3
         ZAjV10+lfDR4+/h39+RNnvxE0XLbaIP65Z3d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056966; x=1702661766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HSNZHOju8hpOrntNygE/eIZPol1N9ffLpPl4Rg7zEI=;
        b=LTMnaUEsDHYC7iuGdHpHgtX4ZBUaTYh4Gzrl3GET4VX4RVn2liCq0ePAmrvM50uvxP
         vBO/9qJpGIJpQRPwmFIb6n6m5x9ddWCHHdN1Y/Ijx5ZG4VSXEKji7yDb0+AoMoTAs4w7
         1Fkv3PK2lcdRo3I4EB7TNA+5mK6ZvvVom/PErU3VJlYbvhsxgmwTUB7S4/C63+Ezp9s2
         mX0OfKOmsensIg25mumN/7fXcrmI/swt8JeTY51zFn+gGZx1eqtt+UNK/ShAhgg/FJfi
         BA/uXv3mpmutHqshnGjmAAec6Oqf/o7v4X+Nga/dj/sPAJB44GiH3lUs7uQ2ou0d0F+X
         WV0w==
X-Gm-Message-State: AOJu0Ywqbi0QEtbmpAjZCJz0moRQDALahFaKur2JxikkE4SwiTyH5UTe
	JKs8bK1nLQFb0drUiRp3sqkW4A==
X-Google-Smtp-Source: AGHT+IHxQc38xaqFtxteKnGXqtS4Iokq2hriYY7PcPCuC9PkObHcOWIxyx8llEN3YoWlhlGbGPJb4g==
X-Received: by 2002:a17:903:1205:b0:1d0:af43:9354 with SMTP id l5-20020a170903120500b001d0af439354mr377168plh.100.1702056966093;
        Fri, 08 Dec 2023 09:36:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf18-20020a170903269200b001d087d2c42fsm1961961plb.24.2023.12.08.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:36:05 -0800 (PST)
Date: Fri, 8 Dec 2023 09:36:05 -0800
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202312080934.6D172E5@keescook>
References: <20231110222038.1450156-1-kpsingh@kernel.org>
 <20231110222038.1450156-6-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110222038.1450156-6-kpsingh@kernel.org>

On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> [...]
> ---
>  security/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Did something go missing from this patch? I don't see anything depending
on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?)

Regardless, Paul, please take patches 1-4, they bring us measurable
speed-ups across the board.

-Kees

> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 52c9af08ad35..317018dcbc67 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,6 +32,17 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> +config SECURITY_HOOK_LIKELY
> +	bool "LSM hooks are likely to be initialized"
> +	depends on SECURITY && EXPERT
> +	default SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR
> +	help
> +	  This controls the behaviour of the static keys that guard LSM hooks.
> +	  If LSM hooks are likely to be initialized by LSMs, then one gets
> +	  better performance by enabling this option. However, if the system is
> +	  using an LSM where hooks are much likely to be disabled, one gets
> +	  better performance by disabling this config.
> +
>  config SECURITYFS
>  	bool "Enable the securityfs filesystem"
>  	help
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 
Kees Cook
