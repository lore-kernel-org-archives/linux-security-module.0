Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9231DE8A0
	for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943755; cv=none; b=QKEs+eSLe6EjhQB0EZMrSns5ziM9HqgbGP55A4zMnnOZgGQT39c89+jBlODwI0aaxzht5ToFZbxcVkoVkowf8lpQ1yKVtUtKeIcnoPJ7e6+0NhgOjpaenNjMEyNyJimrp1xMHOmQmYfI0D2rlbpZiPCgBg5zt4j8Nb9R/nKrHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943755; c=relaxed/simple;
	bh=rvtaKCacTd+dMFEwCfsS4KnID/jFXOuQd2z1cHSbJkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBz25SMdETstxJtjkdBLH7xBZbTy0x5FrG0Eq40YkUaWoM7t+daHFyR0Ias+50zgnJMSMB51a9vUjRLhxea5KJD6M2Zz4dlJ+PkJlgHP8LYk06gpGTM4NfqiWSMNPRK5QtrtdXmiXcq9fIVwmTg4wyWhA91rL5djaovo3kn4rHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XpBMVYfS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XpBMVYfS"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so663595a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742943752; x=1743548552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qpbsUEYRhF7ODaqFjujOp9s2YRkxd4ZLPAugypnEK7A=;
        b=XpBMVYfS71SljWlHyNX4qN+MQOCcaZe0ZecCfyhVU4pPVEjlKFE9F/0MC6NG2fdiOM
         /ALHDLvrPoJoFN+FO3w8AqYX/FpmWNYH3kw82Ck1hIFoPo6C9TybY7VkOdVvX4CjV1Nv
         tXLYlRknQvDdE6z9XDy4Egjrczgr+LIzDFPNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943752; x=1743548552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpbsUEYRhF7ODaqFjujOp9s2YRkxd4ZLPAugypnEK7A=;
        b=WTgO9nT5QqzePHnr1k2t2QjOIfhvMsJh0+AdaRY5WjAqdhtS/mnv8LniB0gLoZRApE
         Si4HPFhSa9PytxPKdq61a96Sa06mONS1uyW8qpEwaxrHpBatQteQ5UhX6gXh6RdCMoDk
         m+Hj+21ZZBLHSpY5n0zTu9R3fbQz9Gn610XWz/yZhWUXkRqlnF57CVMB8wgnyoF/6f5g
         rKN9qjU5fBhBzHKcTRH6YyDJvWuK+8t6VI3GKJD6uDlCqsikIG4std9IzeFA1QzIRJQL
         bsi9jcVcLLXCQ7DsabQYdH3TMwXz5sRH/oIDQryiz1b23eW0g5Q2aFm31JrFDDTslrMd
         su8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRMCTOYjCeZuBIc3OogQci836dc0fBEZtfvdfrpy5ZpkyTXE0QwPHBysexmqnVCq5BIhGC2klmW+rw5EAaEeXTwwHryq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1hWTxQn4ENwEbjenvuvcfs5tYKghllrbD9ToS7171xqsaucZ
	mpR/aQKiWLtokNwjTw0f8rWPp+BCMbDzXqaRnj8wElJgHFaT8leRhF/baq0P5CWLBeUERXAzeNj
	kJQrIlQ==
X-Gm-Gg: ASbGncs4M5YuuW+XURGtWJ0jfd3Ajsp0mJWnhsVuWeMZsfcxO++Bot6xVniRJ2I3wAX
	OhjQRjBS5Ya5zs6AoI2nhoqbsZWV7zVy7D2f7hqJwRMe8neCoxZYkOBFwIt+xIBU/SCOVgq6ZOo
	3gMMf/AGruzDl2Cy+FwydPmSHjEhV21g91Up90YaMOyU2aPMqTKwkOt+vO2fIpkZHnOl+KvkE8t
	y8CX65FNYb/OYUypQshgFCRItxRJwwYMeSdDbaxwM4UgouA6/7RRCZqA+ehnQxdp9NMm43QnytY
	CWxPcU/ZzJ5+XmOQImVeYPbQ0osT1RiNdpzhT1YuXCr0eOPW3FzmVNU9iMswiaJlCu7YxMNdIy3
	p1ftk2Mr1kPkCZOWHoK6eM9hmzt83kw==
X-Google-Smtp-Source: AGHT+IF6F5QkXzYuL38d+Z/gh90YPXHtPGuhQtjlbbkhxEDIY9jA9hv7Qmk0wAxF1GXLp/NzIfB8ig==
X-Received: by 2002:a05:6402:350f:b0:5e5:ba77:6f42 with SMTP id 4fb4d7f45d1cf-5ed4349a3b5mr1560491a12.4.1742943751710;
        Tue, 25 Mar 2025 16:02:31 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c7759sm8374131a12.51.2025.03.25.16.02.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:02:30 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac297cbe017so61812066b.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 16:02:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdyh/+Hfi80DrEaeXIA5nDMEvzTbvCCzUIg4+EsjXAbCRW27mY/AWmf8DwhHNoicm3NHRGvPctFE5WuCOcc3iM1xAWXG4=@vger.kernel.org
X-Received: by 2002:a17:906:81d6:b0:ac6:e42a:fb4c with SMTP id
 a640c23a62f3a-ac6e42afbbbmr77412666b.9.1742943749513; Tue, 25 Mar 2025
 16:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
In-Reply-To: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 16:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq6H2w1UwofX9xTNQfWxTgnnyE_4keu9omt7uh5If6fR9mM7-LXzR1V2TI
Message-ID: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Mar 2025 at 12:39, Paul Moore <paul@paul-moore.com> wrote:
>
> - Add additional SELinux access controls for kernel file reads/loads
>
>   The SELinux kernel file read/load access controls were never updated
>   beyond the initial kernel module support, this pull request adds
>   support for firmware, kexec, policies, and x.509 certificates.

Honestly, is there a *reason* for this, or is this just some misguided
"for completeness" issue?

Because dammit, adding more complexity to the security rules isn't a
feature, and isn't security. It's just theater.

And it adds completely pointless extra cases making the different
cases use artificially different code.

The commit message doesn't actually make any mention of *why* any of
this would be a good idea.

I've pulled this, but honestly, I think all those new cases should be
removed, and if people object to us having "LOADING_MODULE" for other
kinds of reads, then I think the fix should be to just rename it to
"KERNEL_LOAD" or whatever.

Because dammit, this "make security interfaces more complicated just
because" needs to STOP.

We are literally wasting enormous amounts of time in the security
layers - I regularly see the lsm and selinux layers spending *more*
time on security than the actual operation takes because the security
people have written random code without taking performance into
account - and I need to see *reasons* for adding more crap in this
area, not "let's expand" with no actual reason given.

So I really think that commit needs to be either reverted or explained
very clearly why user policy _needs_ to care for the difference
between a module load and a firmware image load.

Because I think any such explanation is likely complete BS. The
difference between loading modules and loading firmware usually would
boil down to "different hardware does things differently". There's no
obvious reason why one should be considered different from another
from a security standpoint.

               Linus
