Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792671545;
	b=2kt6eeIJTtEMw+1YkMilwFnPxBxeY0L8HsYhZ7rp4+nCtiPsIa4PWXaYYdDSGssS5nNr
	 JzwWhid7k1DMbHUyiHA9ZJduRN+x02NuDwn+atszx4G44NIHT/ij4MTTajE74QwlyjLCy
	 fR1TCWUX5VZn9OnSRvhnAjOzYLFIXUEsFq16Qja5DfMH3qRpShgT6wuSby9V9kntGhICo
	 mpU6ZfF56+8dbMGCh+4lC4Bcz9p1V3SEdQxES4xdAs8zjsQ6JAYwVmgV3VEHUOwQRJrz9
	 Pgy4r7dv9qKnaiqm8VBNagMLc1ShJsxXge6FhXpfo7Xxxm2eVwIQhYHVMUjDZBEBT1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O7MzFnbIsObJkz1l1H1RrtjwBzWrndW2u4bvc7jCYf8=;
	b=bH4gXuVX4W3C1ItiEX9J3Ta/H6fsTwmkZsQc2ae50XBtrCzgYBG+iJXCzXaNnY1POLg3
	 9mYd5aUjctgOZ0HJQnNP0WxpHyTZ4PRcFJpejSDnCMLQgc22+jdM9dCwp3N+p/1i9ZYID
	 6ou+TWwZuP/xtuyQL6iLGIb3zPMfoAuseY+BhMOHk1oIEGnwLoIEUKAhcyXt1uNCBnzpZ
	 YIc73VdOhXqrzVxsEDEgX7K40CueffO/pweAAdS9dVI+stFLJTZTad80KsB/MpUYbh5qF
	 hSo+wVz0Sedv7UQD3f/SjUYmMAenF3ILNd6eU78u7N4O+O5eeqcchrELEDgykn83+Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20251104.gappssmtp.com header.i=@armoriq-io.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YLUPMQVJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED414606A319
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 12:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED414606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=armoriq-io.20251104.gappssmtp.com header.i=@armoriq-io.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YLUPMQVJ
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-843a4ca671eso948981a34.2
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 05:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792671539; cv=none;
        d=google.com; s=arc-20260327;
        b=IauGl0WPE24BJHBaIdoxUjWmY5cEhZdgtXjCdvOKKfbwv4isPNcnyvUehLaEV7VKtc
         zZvPTJN6YlolVd1MZSePczc6aEDHUnLjotSxxRBMQnOgTWUTFhdArq2W1/D8EW1xJpQq
         HE/Fq9zGn4NloysneorYGS2dyUEwpzUl0aDHQFOJF8lgHHG6fzjyp/4wrocRy170HL8V
         OVpo4tU7KdfK9+jUt/C71JHP8xbHHmeXG+ErqZG8mS7sPyMhFxCPBtpoJKpzYoGjA/oD
         4910sl7MPo03qcC275q5t0ySxkK9h41tAdSo98XK+UJVxP8uHt31ieliphi8U/eEKkvS
         4ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7MzFnbIsObJkz1l1H1RrtjwBzWrndW2u4bvc7jCYf8=;
        fh=/e44P84JVBUtHsaN5EUaTRwPmJc9eBfBUuMtRZm/wY8=;
        b=M8W6/0kjl5QqOfUCz4SpibVgaklGOmA7g5nw3J5BNotUVYy7ZFqguCQJeQ4hvtcZqF
         qXo81FuAgSJu37OhFA8lED2+g4xJjL3ixBSwjt+S+1HTrORH1lq1WLLvcaWIGOcXL1cB
         H4JKbfnd7P5cnmY+7rUROlh90lZNY0KOXzC6+8KDJjngkrYiw/lOxvGxmuFKwXe6woIP
         8EQQMLSSxQqS9lprsp1D7i5e/gcgXFigRKdmpUre0QXlSlNTL0ARb32Z1m+5z7yiqbV7
         YKZanDKOG9lADKn0i4r6vd3X9ZvT5s7VMaid4F1Z5JlGS5MtO7EOBe0xTylxhpbJLdxJ
         jIjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20251104.gappssmtp.com; s=20251104; t=1792671539; x=1793276339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7MzFnbIsObJkz1l1H1RrtjwBzWrndW2u4bvc7jCYf8=;
        b=YLUPMQVJF8HRVC8z0/+XrEs6ev066K/XYVa52+Bkail+lf49nY6jJTtmqI88eqqqsS
         JyqLtxXkZBgpqap7OKLLgfKTDdkw7sXaj2F0wki4fj815GI8j0FU3WPvBZrpoPt010jG
         a2eKGzf31l4WZyISy7N2Q9j+tM9WRaZCyHibHUXQ7x2AV10lfY5j4oXlH6Lm0KDXNPTg
         u4ey+rSbQxYeOt+0Z8HBA+BXKpNpfApwmejs/QWWkARyoKd/k0ifAy3jIR5OPv85JDDu
         3sVPwOid7UjGYaFQBECFXSA4rQLg1L8OKtRadkaLUwkT+FuuEXmEPh3CQJ3uW1kN25Et
         daYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671539; x=1793276339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7MzFnbIsObJkz1l1H1RrtjwBzWrndW2u4bvc7jCYf8=;
        b=BPxGqKctUhbJZtFUD6jbOPK/IazkS0YUp5QVH28lc2/Bqu+ISg5fc8tXdoNAGoDY19
         zW3GEugJ+Vgje8fWAvqz8VRKZiv7990e0lZzkXZSQ+dojuF2DiriULi09c+jRohABd+t
         UfP+AQ8ooFXksiLuZbbJadG5z5NKzWBF5pLj3LPlnm4DGwSB0JXhYsPrrlzwphEDmo6W
         Csso5mIiKuLfMdpl3IqpfXXeqPs0GnghZmn8ePCCvIswFFeFlTZgQ+vXtxjw3ms3mRtn
         4hFR0DsuIwelo2UQ+R1Qet44nwHHnAn6GkQSNoWwjIGu6p+1aITMJu/3ZI7GHluSn6hY
         cMhw==
X-Forwarded-Encrypted: i=1; AKwUvByIIQPobecuYWer5w+w+boP9Vy5DesL8+B1ybeagP/Fc8cQlC4aOZQntSHQua+5An3WVQrLIt8CaOtORB7g5uKF5jTJ2gY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpp+BHy5PxfQb5bjANeaoCphvDzaeXhabgpqd7TUgmS1KmIG/x
	kNanI5cMiwDBkknC7+Zfgb8rcuK/fE24dCZ2359JwLgPdQDGlhhn2E3xVvqkopSej58wqHgNsuM
	LNJzYVCw6NzXbudO93dHIqtlc53AYdojR0yjSYiifaio=
X-Gm-Gg: AYBFou2YaWAlj2W006sg+Q2D0vF6rzfzWUnicNuXVKoMZD8mz8ukX0R08eCTc0kQTxt
	xGgLo43Vaf1gqvInyiy/G9gXAYNQVOCMevCW/2iH8+4Zzte2n2Rp2jufIBoDhdJXGKUcUTNyUsh
	yQRFwcul/iEhT69JnFYENLTnqFlsoeuJXR1IuzAgndPcC/lzCQ2uM8bM1bum/d7GRvfXw4yAve3
	eEvlMKP2CUi9z6WgfYPi2Iwc5t7ZMV8Q2zwLyWoTbV41pAA2EDzCba02XQNl7Fmy9yFZnxU/EXX
	j6o/87etXO+VUtgHv8V1yTp6OoNkA3FXkYFtyBVtVEWMHuTIY0Lhe9zDTzjbuEAx/g3LvjBLLcI
	MtYQ3S8New/GDoUIWVo3qKsklVGx+jdRq8ndT6VAgMnZQTsfm6tdmAYaGnassssau5/gqxQKVFH
	ATQtt0NFxcmIQzf1baWtBoKm3Y6q73R8HyRWwt3Tn6xTtpJpsd+knibWE=
X-Received: by 2002:a05:6830:6f85:b0:81c:ebf4:9ff8 with SMTP id
 46e09a7af769-84d09218548mr4176798a34.30.1792671538755; Thu, 22 Oct 2026
 05:18:58 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021165748.19304-1-ketan@armoriq.io> <db4e46a6-1788-44a3-a3ab-4fded03591d7@infradead.org>
In-Reply-To: <db4e46a6-1788-44a3-a3ab-4fded03591d7@infradead.org>
From: Harihara Sudhan <harisudhan@armoriq.io>
Date: Thu, 22 Oct 2026 17:48:48 +0530
X-Gm-Features: AclHuK9VMJQ9vVvn-lB4Iuv5LF_25cVG0XxJiOkPXcZoQJDfSKiJzf7VWJduKT4
Message-ID: <CAGhg=-NJjXPqeAFMnYVRnbZWQwoGiPqhyhxH_c7zhL-=Jc+qzw@mail.gmail.com>
Subject: Re: [RFC PATCH] docs: security: Describe the Kernel Assurance Plane design
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Ketan Bhardwaj <ketan@armoriq.io>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:11=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> I wondered what this index entry was for and then running
> 'make htmldocs' complained:
>
> Documentation/admin-guide/LSM/index.rst:48: WARNING: toctree contains ref=
erence to nonexisting document 'admin-guide/LSM/kap' [toc.not_readable]

Thanks Randy. That entry should not be there: the document lives only
under Documentation/security and there is no admin-guide page for KAP.
We'll drop the admin-guide/LSM/index.rst hunk in v2.

Thanks,
Hari
