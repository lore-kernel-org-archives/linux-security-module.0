Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976D3EC2E3
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697304; cv=none; b=Uek77XCKGwp30sfFPvMp4UIB/YAmJGSKfojeCYHFXlPg5OdP2i5tjBoQZAQq2IfEy09ZGl+22XT7YBh8mTb9WDilxVHHi0ptaUfS7e5kxaUG9SRLJWdu/dZ2lTNhZ0Zi2V7ds5g+XXBfIMxQwfNw6TAM5DSrlKz3APMOFlOBB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697304; c=relaxed/simple;
	bh=mv8ykqF0mqU1tvvIiC41TlZ25RAXE0n36/mXsAGuwq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8iczhVNoAwftqRvVaPise47N5YaHo7JQM2mm7pLx/cSyq8D2fRsDtKUVXsR6a6NmIDaR4yoRqeIpvYatoZqZ3k3AN32UY7akKjxd/ppSn2Q6JKmYCmyCxpao/y8NOzDa6PEEkMO9wSxkyLWb66SYOvrraQXtlcehB5Qvx+t0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hd/8CNdv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hd/8CNdv"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69583ca0499so593415a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781697301; x=1782302101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RMazHyxAaWShCblmA4ypYbvu76XmyiurG8invBtAkKM=;
        b=hd/8CNdv7EHMw1EUOPKRwgbrtWJlXCU3Z0EC0pieamuD1E3x7z/v61vuHY76JX4k3Z
         DH1KDAiUTgolsDZaOyRrzGM1IdBcxcr1GtwmCTyi+eKBSMl46QqaO66k7rTA6Iy89hwF
         1dpgs0bEvp9IcrrwHpR445B5xzAjJO3B5B73g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697301; x=1782302101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMazHyxAaWShCblmA4ypYbvu76XmyiurG8invBtAkKM=;
        b=tVmphwlltthwNodkucAAsGMzSTY9PzBJKUB0MIO0JGQXqIClV246SxyvOjR9Tu1JWq
         U4vpxdFUV8OotRXYfEjtt6aDlhYRcliXv1yOBLtPuLuE9uMzT8wb9amLu3Weg1lKgefX
         CBKCggs5PEpr5x77Ig8t0m070hjPQJHWWPXn1XoDJWAGF01pb0Smu0HIxBl4kczctGbn
         EFdFIqn8vdu8fy1yAqXznqOD7J6lpHjCVNv5QrGtpim0dfxRKtQg7xoj+NJgPXAwF8Kv
         GRkaa4066SxFfnLg0GwAraRcLf6IT+RgzOf9XpkOZ4NkE1oheRLfpFPLv550zgsOHw4b
         93Iw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q4QHQkpVDOxk4mdPr98sAGuVSZGc4S1/YIYewxz11CSJOl9+bXz67KR5UEt1EelLG7Xu10AoBLUuwkLiBogdV8qHg0jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4rpBGd3BQ08mIgqkbCt1Qzf5zngYz1k9aCy07t4mz8fDs+md
	hKS9rzoUZZzw6/agrDUdi458S7gJEk4P478d5yb0RUB5FjLJFpEOYvLhFivq+5hWJ8950Bu6YtR
	gosy0HR6VsA==
X-Gm-Gg: AfdE7clvv6vQyeJFTltLqq7yn2bQLv8CKZ6ej+bxwsdZ4xLqh1ZZpETJz3Ski/9nWIB
	Srz/Gthml2L5708P24bu621KJP9H2qgO4N2Y56ZBXUEFBz12Z7qj7zvIVsbPc+JbtYIaNkn0pQO
	OxZTZs/1Gn7tKWfBB3FSONHrKZRjhrc4OsAeeczolQRhZPDNIiKfBo5Wap8bVl7BI/BWVsscqMV
	ZdL/BL1ai93Y0mhUPPnjiscCbLIqSrp5F1+ZhhtDPslMIezfkDVoR+xJsO1XN/jxi5kwU/39bYh
	iYsVSoGR428jc1uvFUVYOcNY1Z3O5CO9nRhR9cTNlAwrVlMVRUjfY6QxtGvLLjNkVSu6txn8HiM
	GjJgb0ljfwwX1HPRMKE+ZUs+rxP7GzEsqBVs7x0lofECeDNakE7XVWBnEhipJoonsIsYLAXLwWr
	R0NaaG1KqfPd759Z3KpTXYIYEPWjS+Q5KNMYaMybkH5dEA7M9rCX+5SXacnEKMMg==
X-Received: by 2002:a05:6402:500f:b0:66e:abe5:ab22 with SMTP id 4fb4d7f45d1cf-69547598f75mr1886599a12.5.1781697301433;
        Wed, 17 Jun 2026 04:55:01 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-695647013acsm726994a12.11.2026.06.17.04.55.00
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:55:00 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso1124741966b.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 04:55:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/UwDXl9c1lBjn1nNNQ2CDfBGe9932V66DlMxJ+4tVTFfwKiRJSMBCsTj3XNXIKmV9XNwmKzldBv+TirGt79krzUlOaZfs=@vger.kernel.org
X-Received: by 2002:a17:907:75d1:b0:bf1:b3cf:3db with SMTP id
 a640c23a62f3a-c05d1f42003mr125365766b.7.1781697299891; Wed, 17 Jun 2026
 04:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
In-Reply-To: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jun 2026 12:54:44 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjBF1ZXNRRqnA+KDFzqxZaXPgmDc8=Ly3+RdxUXWuve9Q@mail.gmail.com>
X-Gm-Features: AVVi8CdvOdxJvH7A_0DHzsgSpHGK2ub8f7SzoeDFn_m4WAIuYfwVRS5xnQfNhAg
Message-ID: <CAHk-=wjBF1ZXNRRqnA+KDFzqxZaXPgmDc8=Ly3+RdxUXWuve9Q@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20260615
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 at 03:55, Paul Moore <paul@paul-moore.com> wrote:
>
> - Avoid nontransitive comparisons comparisons in our sorting code
>
> Done to prevent unexpected sorting results due to overflow.  Qualys
> documented a similar issue with glibc:
> https://www.qualys.com/2024/01/30/qsort.txt

So this is clearly worth fixing in the selinux code regardless, but
did anybody check whether our sorting routines in lib/sort.c actually
have any overflow issues with non-transitive comparison functions?

Strange sort order may be confusing but tends to be largely harmless
(the confusion might then obviously cause other issues)

 The whole "confuses the sort function enough to result in bad
accesses" might be worth fixing in lib/sort.c if somebody looked into
it...

                 Linus
