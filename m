Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA9152162
	for <linux-security-module@vger.kernel.org>; Wed,  3 Apr 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163597; cv=none; b=bxb3RI2iDpjluuSJOtsgm8v27/hsFtuR0LCqKLJe4o9h6MsFGyUi89J90nvTkcXPJ31L2wQYM58uJ9HQdY8lj16LNmcnmW12ZES78p8w2yZWrNHiEU+ZN/DY43Uz9JYu6LHL4SVIt72+4tDjtfvtmvoc7YW6hghgJBfQJgrF7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163597; c=relaxed/simple;
	bh=1QHEDPpqFRVTaMitRFRECKns1ULA3ceFkMwOdLkg8FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbVLwFrAVaYzGDJB23Wx3+2QfOtHp23hfkD1M8m8GeUePtCGTeK3nxyE5CPGRViLx0Eqsd8QwCQjTfVx5Brxti2OHfM1glnz6DIFnobTMWhbZ2IIc72J247ImiU1R1Ijofk5gAfZv0F4OAo1DxrNlLXWe8IXaSldLJ6voT7aqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TCCp6BSw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TCCp6BSw"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2159197a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712163593; x=1712768393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=TCCp6BSwTIKImCa6ejUZOPRl8RsaJEURQMAwwU7IHez/VMYlGRhnn9pSN9ctNafl5+
         6iHtQuJA4ZXkg4Ce42HjQ660rSmAhMRbGLX1VBWYeMrG/P9SYdN7TXCF970dSrzMsUPd
         a2WRC79HWKBeNYRUnQL8ddgSmlswDktck7p7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163593; x=1712768393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=jDkcBjCokwvwaeOMmpruUxZBPBk2hz8LKrvBKm50FkB3aPEmVzL9DrgNA2GyKcURrt
         WBabwi5uacqlUHuL/eYyzGcKEvh6xD8lrhJV59RieVWzNNTWA5DJTJK7L0yOvg8SRscB
         Mqeub/DNhyse4BAVVsUCKD2P9o6Jg+b96nmjAY7sXiS19614S5n55sQxBGzpvR8gBnSV
         LLD37JaVD4VXRdXVjbQkiXo4a2wa6SbGh+dTEH80WHvwWrcieneqhB2PEbv7/NttQ16l
         xZdyiewi/tSO+i5EV16MsDZo2Glqo31YesnM20coYbCvWyt4saagc+DaqM1gn2/z3QuR
         0o4g==
X-Forwarded-Encrypted: i=1; AJvYcCWg+aJZR0HulXuHKMLIpjMWfd57FnICQ3ps5BlfIiiDeOMq8WCXFUFdmD/hWUJJlDB0fYmqARTnF+zkxNS8ve3w8pkSwkh4gcD5vEOiGmypYY6EzFmw
X-Gm-Message-State: AOJu0YyModZB/Y3Y4cNCTEX8/ivH+D4tD6nJZQrNhbzmLCDlOgtL4U8n
	LOOlOl0A7QJQBo2ZvlySfC1jJTIQW7y8D0ZIzWKCuQCSKDxtF7gYcKWKTwFNqA+ohUVHT2Fc02P
	EyECiOw==
X-Google-Smtp-Source: AGHT+IF7TKh9Wo9xa+6mz0/gMNJt1NzI0dS6QB2YDiYX7epxtxSrBKW/tazV1PSQM+w8NYqlOYd8uw==
X-Received: by 2002:a17:906:bc95:b0:a4e:5a1a:9077 with SMTP id lv21-20020a170906bc9500b00a4e5a1a9077mr201839ejb.16.1712163593454;
        Wed, 03 Apr 2024 09:59:53 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090663ca00b00a4e8991cfbfsm2207859ejk.127.2024.04.03.09.59.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2159146a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIu5CnlZRqNicNjmelCV98ydL+umIIUvUQZMPnq0pIhBjx8zVz73zQseBzEhFhW52F+EIIDAswZE6HnTkoxXUp7TCCs7rFtR2ry5K+qm3q3zI946gL
X-Received: by 2002:a17:906:4f0f:b0:a47:3afd:4739 with SMTP id
 t15-20020a1709064f0f00b00a473afd4739mr2945922eju.6.1712163592316; Wed, 03 Apr
 2024 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 09:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, pc@manguebit.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 02:10, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.

Thanks, applied,

              Linus
