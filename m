Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0227BF6E
	for <linux-security-module@vger.kernel.org>; Fri, 11 Apr 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337705; cv=none; b=VbDupYBnjoTPJauwRkIwT/xe5X1aTTZwIgerIuomkGCPjeiu0NTKwfByI/56FoAAjbRJ2OBOEd+laXQVPrulVNLFIR/g7pQlBa4d+NDNrI7kjKP7l1mN9KtjXK6/cmlrjJ62FyIhjqmiNAw1FcF/XfZrvAmBfNmY4qQLeTZXBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337705; c=relaxed/simple;
	bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeJYHcpzG+ea5VXFf/p+dpNON5xk5ubRadP8U6zOQGVFl5mdTSOOkLvLtgNN61Ne8T4iuCb1uZgscPPGIafmSUhrS2VPT1oBk0S2CZm6hHdscKhp1CVUw0XUkhyWj+6viuTsULz5avHgNV6+Bs2lg07t/Ziw+W7EjpDYhXtzgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cEiV/auX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cEiV/auX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff0c9d1761so14877447b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744337703; x=1744942503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
        b=cEiV/auXOeksXq8uT2oTwklewEg6x+g3XUKLCmCSz2IwStRGJ9UP2FP0f4CfSW3lLQ
         gAPe8ogFt2kHwbzdXsSQ+olJe77xhp2/Xc6dtAOGLGyhUlIZ6p2iVWw3Zhp6+1VVJcJA
         9wk+W5PJ+8at9U5H/sKSEsLnQuHsznNTkD/IwenQcTVUf3asKOgejK1clFfWopQr+Of2
         +WnJygW5QivB2vtFSO2gMeMcEXYla7s1PlOSnjSZKDmc7jhz/ajpKXcngNEnVI00BL0n
         c8S2CbpjoybtJydSlC+s8gNoor5CRu8o0PUMSAUzxh20CFE7XEZN7Gz1Qow5PNc4ACfm
         pTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744337703; x=1744942503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgAT8Qc2QoFkFKo9CcaUohfX6BdbfmZhvPmHWJJSwzQ=;
        b=Perbb8q1LRlrhI7C83RhiLO8sGa4KLY/wPAbou5Ub2jE5UbkXIZD0LBg0iotuIYGJN
         SFkxTRlG/jaFoBQk3sm132lwTiaCn6kaK2hCkglMFIaYlwmOAwkb/yVpPkaGE5IOln9A
         u/qjZad/vOIXBpPaIRwC32SEeGFYcwXSMlB9jZ2e7w/wQwqJMYRVUmIplD6k9NTzBo/q
         Wlog4ol2wPn9FdI8i9lmuobFSlXOa3hcb62Vi35c/YoRDpO7imkcy+vxYAsBtBt3yza1
         W3FrXPPOzpuTOeErn40AE8j0ztmRaURXFDGxQ++OGDebonVWxJCy0ua3LXH2sz4c2ixg
         7HmQ==
X-Gm-Message-State: AOJu0Yylp47kw+W5mGwsQZF/2VSWlbVbw9IEtqs9Kb8jGeCB/eZroZ5H
	hPrBEdGQuc7H8BFLNj1HT24M7PDpr8E6e3bJolOipfny6sXrs2A9bh20OqJAZOiBz9uEwpNDryQ
	BA19ndEFHytzTlWxu9N1Sbo2nW5ICxvp8Hry8
X-Gm-Gg: ASbGncu89GudREupA4gSmCYqHhbNoy2ugbu1HUkAhM8ZB21o+740rrtJe1yb25MVzXc
	32G+el0T2YfjhVz4azovXifcunJsH2kb189pYeIb+9Hu0SDGt/ALgnoELigIm4NP8j5KuV4/szp
	MkTmbFJTe2Mg2tj/sNdQYe+A==
X-Google-Smtp-Source: AGHT+IGrM2n2rbgpwcEO5kOc/D9dhDNnGXDOY3TLNKyzkfl2Hg5nNHGBO/S9yZ4DvomKQWEMD32rhbni3kdmuWNZONY=
X-Received: by 2002:a05:690c:6606:b0:6fb:46dc:d9c4 with SMTP id
 00721157ae682-705599c9de6mr21538937b3.12.1744337703320; Thu, 10 Apr 2025
 19:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-40-paul@paul-moore.com>
 <202504091656.21EEF38DCA@keescook> <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
In-Reply-To: <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 22:14:52 -0400
X-Gm-Features: ATxdqUFgbb3sqVMjbtBqdDPWycG5EM8g5SzhjnvXiM3Xmh9QxxHw6T_UWbYo7YI
Message-ID: <CAHC9VhRT_dBRusxjsD+mwAXG=bg7MmwA3L_3W9J3GgtoODqZWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled functions
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Apr 9, 2025 at 8:11=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:

...

> > The simple renamings looks fine, but would be nicer if they got split
> > out.
>
> I can look into doing that, let me try the squashing first.

... and I pulled out the enabled/disable setter/getter functions into
their own patch.

--=20
paul-moore.com
