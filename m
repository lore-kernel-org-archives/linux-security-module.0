Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED897F7C7
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117275; cv=none; b=XdDaxlZmEpGuu2xFtlmFvmZg71Xs7prjHl6qFE5pZDCsSFXMyW81SvV6y2qOobfMAtkvsBNaEtKa1/IMHMMziOLSYwQa5DElf3Z6JksTm3c6z9rM0Cak2J5ZMfwDVAmvRoD8TJ4EoOx5M1XBrsAsVPoON5yf66h10EPqgX48GDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117275; c=relaxed/simple;
	bh=z6BjyMQCnB/4rQCdDjotQhHRjXz7UoU01MQEf+XrLlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaBjE3Vt8QH++ftEbcKePo7Ip6T7tOrL2PCCcbWJPHOb+N8Pu/85TjDg+TLo5bYA4d6bsbjNs9VZ2vktsBaD8TADNUpPGk0+C7Aoy0O3zKwfTa4rO/tr2cwN2OT1fOQRbvIAS0/x5FvSdtQPqnaQAfITxyxuZby5lcebNGFpxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SvGXjCdW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvGXjCdW"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a310f4b3597so100251166b.3
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706117271; x=1706722071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTlbGsImqxn7RX+/XBkYgj6lDq/Avh2rTF8zOkCv5JM=;
        b=SvGXjCdWQ583KEVmiYYexUS3zEIYuWQ4wPEPRQhydsb2+08ONPZqteuABDBSVeB9aU
         dIQbevDGSW2O6AHiAezGooZEAgVzm8YuDTC7blChWGde0dRCM2EIc39b67mLjwXF+jMP
         IqFpwja29nj6xc50P9fJ5UiosHhGFgiUFQUgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117271; x=1706722071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTlbGsImqxn7RX+/XBkYgj6lDq/Avh2rTF8zOkCv5JM=;
        b=jAt4YJ/7V/uSY9JvVXqtP3SoCxP5lZOGHK5GjVDHII0/fDly7wvKpS5axcuCdYxIPY
         p3HxX/JwZeskJ/2pEF1whohxAK2knRpVSz9nFlvSbgohfQMZLpjnZpkg+HGNNc/heT1i
         gReRSKtfCZ0DzTFkZvQ3H6+fmtItSwugGdpFk999eV4mFxxJ1Gw0xD0Z9BPlWR/Mb7mt
         Q2I31c766KiDjOd6sg8IH4PUYwcUDiLD+V0PFEE+zBsOufRrYy07LO/80aZRW4CquFQQ
         HnvmicdvFDER+Dl66+Lb8OWILavQUOEEcoxRbtQ+wSrMkV2MwQ2WL+CsL/Z8nVrzpj0k
         oJJA==
X-Gm-Message-State: AOJu0Ywl4q98+Sqa1mtHNO6Dp3mQyBU9DBcpJguxTdZl4zjZKYKlIoh/
	qhUh3QFwDmTI0MhfWkl2fH3bzcmkmNTQqmrpgl0vHdlqxyWkhBGzGfPn9RqXcG9kqgqaX+KRoJG
	PTCko4Q==
X-Google-Smtp-Source: AGHT+IGtVlLykvX9DNKTcowLsyXua4D03N8ShCXvcimGVViOeYYAA99ZNgU90CX0Z6qp4EP9dLA3ig==
X-Received: by 2002:a17:907:1b8a:b0:a2f:6139:c4df with SMTP id mz10-20020a1709071b8a00b00a2f6139c4dfmr707793ejc.142.1706117271502;
        Wed, 24 Jan 2024 09:27:51 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090624da00b00a26ac037ff3sm93268ejb.132.2024.01.24.09.27.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:27:50 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso6489280a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 09:27:50 -0800 (PST)
X-Received: by 2002:a05:6402:34d4:b0:55c:7444:153f with SMTP id
 w20-20020a05640234d400b0055c7444153fmr2637292edc.60.1706117270433; Wed, 24
 Jan 2024 09:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com> <202401240916.044E6A6A7A@keescook>
In-Reply-To: <202401240916.044E6A6A7A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 09:27:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
Message-ID: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 09:21, Kees Cook <keescook@chromium.org> wrote:
>
> I opted to tie "current->in_execve" lifetime to bprm lifetime just to
> have a clean boundary (i.e. strictly in alloc/free_bprm()).

Honestly, the less uinnecessary churn that horrible flag causes, the better.

IOW, I think the goal here should be "minimal fix" followed by "remove
that horrendous thing".

              Linus
