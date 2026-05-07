Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C673AB29D
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176141; cv=none; b=b5xw2A+ztRxJ9kyhGgAY6pfXTEiRQtPGQWlXYnr39VtS4WNqZocYHdmdCsUfSUDvUifC1KaQcUDiuwtauTDnotMR9T0lvTev+kHV4z/N5C724+Z1+Q5gwY6XjujxL2Q0ob0n1FEVm/MXeeRWLcEdNkbZh4tb+8BWP+Tn1VEgvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176141; c=relaxed/simple;
	bh=+yhCKkDhTRq5UvkZju/hDLmtsgvLzV4xT/dhjcb4K24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nseVRok0kHeV5nvwPV+2Je7fpODSYfJJE+B5k7FGtLjoViQzBRT4Gvid70a1xDLWkpII9n5NAocll4Lt8fMfyfVcI33k+p1hPQVu5I3nwjxjfT0MvWWG8ujZztPclep3niFrGpi3SLnoFkwH4aHUOniLl7Rbxfch3U5qMaYo4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9Yp4Q1x; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9Yp4Q1x"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso9664316d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2026 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778176138; x=1778780938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8TO9J4dxC97mJ5QE3irWD5VbDhFfwCl7TheGBIaLYY=;
        b=m9Yp4Q1xMmBQKeaeMoQW8bvRDX71MezluthOf4DHrYoG6N4l4vfq3IW+0B3x0dkjnO
         c4UOgkELPIX4iz/UerKh31qsmLhYv/fWoxtLY1DOc4D2GpOQt6e59Tc9QhT4JqgygPdu
         kz3HXrHjL5t6ebbKCk1mjIsx5j53VhHzVFiXgSbP+s7UAyTCncMQBx/HG6+eIxVV420F
         JZTSm2ttJmw/tF1FnF+LCsghWWyWbqJTAsE2kw9DlluL+wkBCTjspoC3yC9mNieA74zN
         vDaZDwKyd7O9r9U/3V/cC1CGFZtktjEo+TYjAJ1XqQKRvNyMThR1YMa7ia9Q9VtXJejt
         9hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778176138; x=1778780938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8TO9J4dxC97mJ5QE3irWD5VbDhFfwCl7TheGBIaLYY=;
        b=ZoettvorFjki580wGU+f3XJKEKGxSZ8BF8BEJWZf2elDWeaEhFC+0UgJyHLnS8+x+q
         76ty+PgaM/UNDEkZESZRDYTqVaOZWLJCoaIDi6be3R0XD2jATPOJKJQmL4Q9Bfy7mEvT
         S3Ct79zHdOOjc5/2Q/rkvoEIxZcwr2QfGUUCvtNSQKdo0A6AkSMzoK5RlzjMQOqZEg4h
         zcPB91W8gV22Yi0l57GG2ICeAfabE5/l3WWNTvnVva4pKkgZDbmJ9I+We2ZVZy5wMq+W
         8RSe7nDT2MFFcw35a+f1lhiDqKd2lFoofqQ8Hm3JSZxmjrIa8oyIF+EpwaMeppduRJTm
         2U8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8FY7KMzZyT/8B9W3xqb/FXMDvtXXu1ZT9wfkZ0/tRtd7fetVepbaSPBWgpO1IQ8TwbI3rXH88MY43ZlmRj/9G0A0bMUe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMueQahypXVUCHy3PFUaYosMRQo4Pacf84X4UYChNloKjfMHn
	8cR0XXuKgAhTI4ES8bsTOEKUf6u41pGRuwYkRZc4NqfFqgHpdXxLTR58
X-Gm-Gg: AeBDies2Wv/jbE918bxm0wokeJZG2c8uh879lTNEhlabRYL40CQHT00RxDfqe5+8wc2
	pKxx8etS0/gh8SnWKG37KsCR9ZuN15CSRrj1gmdYLaSlftLskbqI4tmTknCgQ40ji0MjtonB0du
	Au8izOv6eYwufqCAIHRvfy3KhqAmXiPAlkzLIVuriPQ71tLevvwm1mlnhkCF0trX7TGHdaJeLYR
	iBbpEeu2bztxGQkVlVMufFr4t2qgxO8yYigAp9Wrz92GNN3y5s3QRHlkyCwHhOkEAwizcJzgzvw
	1Q/uJTeZeJNRHDFPvUt7M52SjALipKDBRZhkA3gLu1/wiXg5GXgzs4FQ1qmANHfjZ0Kp2UIbZVT
	uzx64sK1PQgFmgLJ4A7UdpV8D+dX6HE2zgS3nbwQEDnK9nVj9U5QvTd6T1SXbleIkKjxdisCsUn
	yHfmwv666F1rU=
X-Received: by 2002:ad4:5bee:0:b0:8bd:76db:1596 with SMTP id 6a1803df08f44-8bd76db162bmr85511126d6.1.1778176137896;
        Thu, 07 May 2026 10:48:57 -0700 (PDT)
Received: from gmail.com ([216.165.113.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5394d1894sm218419696d6.15.2026.05.07.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:48:57 -0700 (PDT)
Date: Thu, 7 May 2026 13:48:55 -0400
From: John Doe <drapl0n.kernel@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix typo and formattting in
 security/credentials.rst
Message-ID: <afzQVIv4-Up24VNM@gmail.com>
References: <20260506225925.271163-1-drapl0n.kernel@gmail.com>
 <cbe6e145-9d2f-47bb-8d22-1599cfd1a9d4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbe6e145-9d2f-47bb-8d22-1599cfd1a9d4@infradead.org>

On Wed, May 06, 2026 at 05:36:53PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 5/6/26 3:59 PM, Mayank Gite wrote:
> > - Fixes a typo in "Keys and keyrings" section. Replaces "keying" with
> >   "keyring".
> > - Updates formatting of keyring types.
> > 
> > Signed-off-by: Mayank Gite <drapl0n.kernel@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> > ---
> In the future, right here, after that "---" line, it should say
> something like
> 
> v2: use 'git send-email' so that that patch isn't corrupted
> 
> and in the Subject: it should say
> [PATCH v2] ...
> 
> Thanks.
> 
> >  Documentation/security/credentials.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> > index d0191c8b8060..4996838491b1 100644
> > --- a/Documentation/security/credentials.rst
> > +++ b/Documentation/security/credentials.rst
> > @@ -189,9 +189,9 @@ The Linux kernel supports the following types of credentials:
> >       be searched for the desired key.  Each process may subscribe to a number
> >       of keyrings:
> >  
> > -	Per-thread keying
> > -	Per-process keyring
> > -	Per-session keyring
> > +	- Per-thread keyring
> > +	- Per-process keyring
> > +	- Per-session keyring
> >  
> >       When a process accesses a key, if not already present, it will normally be
> >       cached on one of these keyrings for future accesses to find.
> 
> -- 
> ~Randy

Hi,

Thank you for the feedback and acknowledgment. I thought that since my
earlier patch was invalid/corrupted, I should submit a new one rather than
version 2.

I understand the procedure now and will ensure that future revisions follow
the guidelines.

Thanks.
