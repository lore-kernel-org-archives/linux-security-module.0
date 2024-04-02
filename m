Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948C15AAA7
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093768; cv=none; b=HGjnLYbzxdUXfmCHOqxH5ZQycnffKBGtV8+DZqfBIkXjXiyN3Q9an8UpvjfJ7+cirmPXM0B3njzSh65hz/ozSvo9MaYNr3RJrbLYnaSIfrT62qPdkWRP9y4R3jQpjgV+c0gA74qud44WQvKEQZM+wVqpgsaSPmw4kdVV6Gee5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093768; c=relaxed/simple;
	bh=A+i2scP1i3n04ntHseA7vuTsn6YdwPi7luBLLidTYoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQC4Db8ErPDHIs5B0K/cb+vuIbF/eAHD1+B8pdFo+Tnm8ZH3nl+4yI4FDke8iXB42Db8/+92zyURVtglgGWQY88jtbcatXNONbI/6YgbfqqApfQwauVnDqsXyk9IayIDqfA195BfbgORyG4wsV0jXjlHpvS8jDumSNAh8SadCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OYSBwejq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OYSBwejq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e39f5030dso569753066b.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712093764; x=1712698564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P45Bu4wHn5RquDWpNCud3aZNlC5obFSwexJqgolasMk=;
        b=OYSBwejqUZSJatrUYwPEm5e8aXr1KKX1f4eM0m5EkMhAJGXumLRkdluegK0Snm5Ygu
         ciE9jICnlWSZmNV4MECoE2A8oBtEBktFme39CPNrRKoqgZTcyWywWo7ttQBowdD54+/I
         4gKWCirpXTcLXispnYV0PxICMRWz5MJfeb9Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093764; x=1712698564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P45Bu4wHn5RquDWpNCud3aZNlC5obFSwexJqgolasMk=;
        b=H/4U3Rh48+/IQjCEJE5g1oGUd4PbHiJ7ve8Idv1h3VL0WeoYqo3WmzHRBh/gzZH5P9
         kVLNiTUP9fPIjHbFtQUR+LrVAF+dLdv/tBpVcsZUrQnmkbaG/4QXehLty0e/paK6Y+pT
         T8ZTUj4dphZI+OF2GicpzKKxe4WpvzxrkzHh6jdAXti4ohZF4OUJvPpPoOzFJ2iZkOKR
         AgYXMT6pbEZz4QSO6aFSw9PCXVNJ+OR6h02uQ7foXhGDJfQLoMCX6khXjflgUuJzJbdp
         W8lfLY4otHczoevWxqx0g9GQTMmBv/y03JzmHET6bQ8UV46dr2YCjmr+3HxWJ9Gy0t9q
         MbQw==
X-Forwarded-Encrypted: i=1; AJvYcCUAx1zZPG1kJZUIWPGwlYohu2PSCM6oU2T5x0vQDH8xkmzP80XKCBGVJKQs4GJqH7GhA1mF+TSSWe6J/zRjTy1AiNZZV3ifAx6/Xzb4PGwx5K/i5FMg
X-Gm-Message-State: AOJu0YyanyUL0CNsxQsiTVvaXYxq/XKBtg1nPNXFHSr/Fzd5dsaOlpVn
	jQbd6OZuVXDGzB32Qe8fZvIPO2Acp2kaJ26W0xfwWEyUup2+ud0d3l/XHblaGu3tSF7nAWw6aiO
	PUTk=
X-Google-Smtp-Source: AGHT+IGLpO0UAmGl7KsuhjeLbZbcTPeCUIXlBMfRzQM45aDMYhlX0TzPlT5yDmf1rApXS/YAE6n0jA==
X-Received: by 2002:a17:906:f155:b0:a4e:62b4:97ec with SMTP id gw21-20020a170906f15500b00a4e62b497ecmr6495597ejb.35.1712093764276;
        Tue, 02 Apr 2024 14:36:04 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id wg8-20020a17090705c800b00a4722439646sm6896837ejb.117.2024.04.02.14.36.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 14:36:03 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso668716366b.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 14:36:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNCGM6daADXFbTGLn3WetP6Jj0m1FBvT7Rza64NhhShVwtV6GeMM6Ab4deoTFovvHgUTiWpXFr2YPZSgusf5oQ4N7xQOIYMzHEgQaE/4XydxETmDXU
X-Received: by 2002:a17:907:944a:b0:a4e:48d6:b9d7 with SMTP id
 dl10-20020a170907944a00b00a4e48d6b9d7mr11214699ejc.56.1712093763393; Tue, 02
 Apr 2024 14:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com> <20240402210035.GI538574@ZenIV>
In-Reply-To: <20240402210035.GI538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 14:35:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikLJEzBT1_7K5CMfc6DjNNevuYR8z-CfKgYLgwwDLVDA@mail.gmail.com>
Message-ID: <CAHk-=wikLJEzBT1_7K5CMfc6DjNNevuYR8z-CfKgYLgwwDLVDA@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 14:00, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         1) location of that hook is wrong.  It's really "how do we catch
> file creation that does not come through open() - yes, you can use
> mknod(2) for that".  It should've been after the call of vfs_create(),
> not the entire switch.  LSM folks have a disturbing fondness of inserting
> hooks in various places, but IMO this one has no business being where
> they'd placed it.  Bikeshedding regarding the name/arguments/etc. for
> that thing is, IMO, not interesting...

Hmm. I guess that's right - for a non-file node, there's nothing that
the security layer can really check after-the-fact anyway.

It's not like you can attest the contents of a character device or whatever...

>         2) the only ->mknod() instance in the tree that tries to leave
> dentry unhashed negative on success is CIFS (and only one case in it).
> From conversation with CIFS folks it's actually cheaper to instantiate
> in that case as well - leaving instantiation to the next lookup will
> cost several extra roundtrips for no good reason.

Ack.

>         3) documentation (in vfs.rst) is way too vague.  The actual
> rules are
>         * ->create() must instantiate on success
>         * ->mkdir() is allowed to return unhashed negative on success and
> it might be forced to do so in some cases.  If a caller of vfs_mkdir()
> wants the damn thing positive, it should account for such possibility and do
> a lookup.  Normal callers don't care; see e.g. nfsd and overlayfs for example
> of those that do.
>         * ->mknod() is interesting - historically it had been "may leave
> unhashed negative", but e.g. unix_bind() expected that it won't do so;
> the reason it didn't blow up for CIFS is that this case (SFU) of their mknod()
> does not support FIFOs and sockets anyway.  Considering how few instances
> try to make use of that option and how it doesn't actually save them
> anything, I would prefer to declare that ->mknod() should act as ->create().
>         * ->symlink() - not sure; there are instances that make use of that
> option (coda and hostfs).  OTOH, the only callers of vfs_symlink() that
> care either way are nfsd and overlayfs, and neither is usable with coda
> or hostfs...  Could go either way, but we need to say it clearly in the
> docs, whichever way we choose.

Fair enough.

Anyway, it does sound like maybe the minimal fix would be just that
"move it into the
                case 0: case S_IFREG:
path".

Although if somebody already has the cifs patch to just do the
d_instantiate() for mknod, that might be even better.

I will leave this in more competent hands for now.

Let the bike-shedding commence,

               Linus
