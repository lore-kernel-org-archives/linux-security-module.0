Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDE476CFB
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130956; cv=none; b=ZHE/bh3dt/rf00KBnGSSJdm/I3AMk3DrbzTO+mRNN9TjVAi08ygd8mgpvK/1lSOWP+0cBGjs1xH31Izu2b8cKXb5eBa1JWBlTyXsyXbS6Gw4AtpnfuhWzsAxKfAJR0CpQzsecdyP3T3/QZ523qWPbOV1MoIKyBEjsw2DJx6qe4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130956; c=relaxed/simple;
	bh=oAR5xDJ2XC8lQJ+lmic9Di2JTLwtpd8XooNB+yIySGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpJqtGB4GfDo1bj+yeLuuqtNP3NvixQkuMtqz1ZtwVjRQguq3WtlN4XIxJCQZSbrhg2UgVCwfuxtwo1YADkTpURUhcZIX/x7HJLMNc9yV8aGVZNByVwHSHC1PXgFsuwJbNlNXtROr49OydsjjUmL4W1qcp1okPT2TEvNi53Zqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmUkh1ZC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmUkh1ZC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso11581065e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789130936; x=1789735736; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XkvVkwAX1lhPHb7jcnJXE2VFdnB0Q1M6coomVBNxM/0=;
        b=FmUkh1ZCFi1WqeCuU+givKci3lnw/i2P5ItoMLhkZMv5ucNHJhVNKZYu940KcSiRYW
         TZhxDTlaCmVm3h7rgHk/YTjt5iz/L/FPdGKlMNA/c9kJ/Ni1nGF4GrFW/bMOYkiy+pc0
         Vim5MK5ekqsNpPj5C+2YhGG2Vuq+ubCfLkvWY4LIHhnd16UzjCrsVJ2dD4T4G6ZXk41H
         VuXADAJVie0rSUporXk08wzfl7ikzEA/e2zbyiyvA+mLdpMcWiQd3Fx7iyC6h5GtWKZj
         1GiuDiJjPaIhztWK4lh6tcOwxXXY2epx82mORmnwxuzqJ79Dtp679Q7kcJ9+1KmWACDT
         1X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130936; x=1789735736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XkvVkwAX1lhPHb7jcnJXE2VFdnB0Q1M6coomVBNxM/0=;
        b=K7jH4QIEBDnxZUBM4xM6UAkJHXlKeXf/Mm8gMxTDJqhkshefWvdZZ3MgpNnsVFaxOh
         Vcha/dylBo/zpzJ4DScoxTdHc3SjfIY2j1ojG3b7Ifs1B2CXdbiWSTLdk1xTrrZnw3pB
         jQQ3tt0oMh4EsBqpeCP30C5pGNt7TElmAw0zwf+fo8q0h1AiiiKbCtIxunfqrP3ghqKj
         V/LHXHa5lm0vqn2CRFlsKltF4Kd+g8wWJVtsEtp31DwNMLYEEhQGC+AOTqW9KWM2kV7O
         iA3XH8tpT8K9r0oLEciY6QMS37mxtNj/wpHsk3jecHOXJzz1qPHZcyuqxvmaY9heffRS
         EHhA==
X-Gm-Message-State: AFuF++lbrXMeKWZH2Ovhs6odYyGzqc4zshkj1ReZfgyoB/Yj3MAp7IH1
	kTUOtUPogkf0Ua4qk2zQYlwO4mf19VY/19yJ1mckfZ53UB23ub8YNyXjsD8uHG+siDi7sA5Owa9
	Al1unuI9h
X-Gm-Gg: AYBFou0N//htKieQBz3f05kjok5s9+/v5tsQRzB23hkc89othBwpt/hy7V0AILGCUSy
	5m+1bB7Jc5DIHeeno80Qge1KSo7PaHeMVktm1Q7L+kOxLfZq8qYEcXTVSvK/ig0Y2a5TjPxbjbZ
	BhsRVeZnwGGfhlFEoUEZHz3CyUziyhvUus7LHP9byAABkY1ODNwxjWfZ83sywVN8pvE0rX3BkeH
	9e2fjnjmBuet8Q3HTlQQbrLUSIZB7aQ860TKbshwRRLqhDwv6+1ds/SXjD5u6ygSy3jP61RBBIN
	NTjxNkfg3947yingKFyQ01dJ23uFzUM9R8GQ/YAhfOSGxJch3IB8yik/MWK/wWrdHY9c+fpVr7z
	54IMfGeC/Q32bB9JYNj4PeLareUbfhPhrqnXvy/qInHz1/Xu7l2iFug7jfZMkqZC8XxlqNFe65a
	29ltYTdW9vw5FaGBtYwZ4GzfbjZhzks/jdYmJ/WBebKVqED3KJ14h/v4aI2vtawVXvLkZDNhgWF
	6Te5kNpq4hvYtNbtN8bAayIVjV6hrVKVD7fBwMJWg==
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49e6198a3b2mr34332715e9.12.1789130935447;
        Fri, 11 Sep 2026 05:48:55 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d2ad:5013:49af:fe38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60946249sm85191135e9.0.2026.09.11.05.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:48:54 -0700 (PDT)
Date: Fri, 11 Sep 2026 14:48:50 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Fix disconnected variant
 formatting
Message-ID: <aqP4soNCkxyXaZ5q@google.com>
References: <20260907160710.126525-1-mic@digikod.net>
 <20260907160710.126525-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907160710.126525-2-mic@digikod.net>

On Mon, Sep 07, 2026 at 06:07:07PM +0200, Mickaël Salaün wrote:
> The s3d1_s4d1_disconnected_rename_even variant is missing the formatting
> guard used by its neighbors.  This leaves its opening brace attached to
> the FIXTURE_VARIANT_ADD() invocation and its clang-format enable marker
> unmatched.
> 
> Restore the per-variant guard.  End it after the macro header so the
> initializer remains managed by clang-format.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18dbdb99aeba..d0be84e572f5 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -5958,8 +5958,9 @@ FIXTURE_VARIANT_ADD(layout4_disconnected_leafs, s3d1_s4d1_new_parent_create) {
>  	.expected_exchange_result = EXDEV,
>  };
>  
> +/* clang-format off */
>  FIXTURE_VARIANT_ADD(layout4_disconnected_leafs,
> -		    s3d1_s4d1_disconnected_rename_even){
> +		    s3d1_s4d1_disconnected_rename_even) {
>  	/* clang-format on */
>  	.allowed_s3d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
>  	.allowed_s4d1 = LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG,
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
