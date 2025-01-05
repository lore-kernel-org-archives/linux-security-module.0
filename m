Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801179C4
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736046281; cv=none; b=lPRNGUJru2veTlWk6gIX8gAnfNuvXi7bUMSXGktzCRFiGG70l4mld8NGGjFypedCnDOnABRFJYmXOyP+zXubQCOSjHca3PYB7A638AUcF+0yg8h0H9/H/96Pmx8+gcaWWYfozb9TdwLQlgRloZmQ8go8H9fhit3pa/Df/dKdyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736046281; c=relaxed/simple;
	bh=hd892KwPVoDKj6L3O0TAWNjNiGEbhmwOjdXoOj1Tbl0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=PjdpbRj7iL2dMvSW2QHY1kuFhQu0W1P2DVQanSBv9FtiZMV/MBzjvIvQ4KFYx41wafNYpUGglD3pC7QubeS6854CK9Gerub8PARJ4LmvaROeSpOCSkzqA3VTITpDxOqutokGNnltPm+39Pck+rSeL1XP5VPUI7YwbdepNlVcLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KZBwIk2S; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KZBwIk2S"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4678cce3d60so134134561cf.2
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 19:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736046278; x=1736651078; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/ypkJniTy2sqyoish9hOsiaKAFlmo543f6O+rUVzGs=;
        b=KZBwIk2Sy2ppB72Re6JHFjKKsoAKVX/umSTsVx/vLpO0b7mBw6aXmQRrUGwzzqEdxx
         mHP6HRZ1CNEmX+X+Ui2vOR1cT0HYkskxMn+Wae8ZN/hJG56ScEcuRaJ2YRLYcRooBSZz
         aTVN4ZQo0mA+CIXXTn51g9heaIawdLW12B1qFC9JeroqMrKrUGIXm5Vc2OrpfqgrA1be
         Q0qE2+hw8pJ3LsbYBNd0jYk6MbWKWMJZN2isjX5UKdGdUBIgG75xfiJeDPdun3nTac3y
         Kfn1fppU9LScLB0s0fAg9Tg9Y7vrEe5gfDuJRzJb3AfqTN4Wa+44N964IOj8zkOFk+DA
         OBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736046278; x=1736651078;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/ypkJniTy2sqyoish9hOsiaKAFlmo543f6O+rUVzGs=;
        b=UwcvsJZ4yjwSLA7nQOiG+q+dN+tz4JEQtft/7/p9exS8g5WCyY9e5m1qZ1CSmTwqct
         kCYhDsX5oQEFCer4KMg8kTXyVYPM7efRa0mXLrCok7AbaCm0TqW8+JE7RV2BYrYCIQGK
         tHVaGONmCb58sLXe8WjINzE25Xvomk+TfnZ7pA6chHP4aaEYmtVoKLhIeBf9u2Dum5wZ
         pUYBUC63xgdRBM35TJyw5sTq6QnlR7eSzDduayL+FX9m4lFBV8Bog2rCOgG/j32jt2PW
         YHpAUJQgpPAUDmjFwkgFABM12CWZafjMUWxDcifLNgWSDI1q4PHrQVc+9I8GdDXQsXya
         vZnA==
X-Forwarded-Encrypted: i=1; AJvYcCUcchOwcM8XLJpwxfBTc839SFH3DsWl9HWvbDM38tqTnS4Petgn2nNGh3DrJDYapcUGkvccwmciFRfW+5Ge3xi12C244Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvpaeQhLxz00eswyMoMET1Hu8os11GoaIPZywPKQiNjy3ZfrN
	X+hM212Exm5GNCx8vKUnbIaw3P7GhMy1dsi8Fa7H45X4FOfNA9Jh3DgfRGdBU9FzLP2+sLgassB
	UYw==
X-Gm-Gg: ASbGncvWYIhCKvYfUw6d3WiHLJt4a0WflNSMLU9IBVP5HTPpR5Jaq7KCQW1bw+xXbkn
	ypTYJ5/2XgzEtn5BfNBlGzyiK0cSNpm1pxGOJYLdR048gZSZp26nVyab7l/D5yk0yU3UHvWxqsa
	CAKMtbRNHC6KAfKwueuqB3tT3XdjzrJilZrLE4o5azFiC7K7TYnZgsqJmz1saNxKYHMJNr/J7Ue
	WayanbQ4SpEBRWpIkiE4CuyQZw2PkvcAFCnp9FxzNqrZhX/FlA=
X-Google-Smtp-Source: AGHT+IHRKFmN9qbAXkzpX87dy3tF+Dit0bfAJ4XWTifWGarIFaNZroIWRSMyGGq4nY0LZqvSdLQhSA==
X-Received: by 2002:a05:622a:11d6:b0:467:b625:b37f with SMTP id d75a77b69052e-46a4a9e2d94mr1094866931cf.56.1736046277895;
        Sat, 04 Jan 2025 19:04:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb16ca0sm161329711cf.65.2025.01.04.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 19:04:37 -0800 (PST)
Date: Sat, 04 Jan 2025 22:04:37 -0500
Message-ID: <a5fc0502242733d15612435ead352396@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] lsm: constify function parameters
References: <20241125105926.47141-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241125105926.47141-2-cgoettsche@seltendoof.de>

On Nov 25, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The functions print_ipv4_addr() and print_ipv6_addr() are called with
> string literals and do not modify these parameters internally.
> 
> Reported by clang:
> 
>     security/lsm_audit.c:324:7: warning: passing 'const char[6]' to parameter of type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
>       324 |                                                 "laddr", "lport");
>           |                                                 ^~~~~~~
>     security/lsm_audit.c:183:27: note: passing argument to parameter 'name1' here
>       183 |                                    __be16 port, char *name1, char *name2)
>           |                                                       ^
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/lsm_audit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
