Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541315CD4A
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087870; cv=none; b=mWa1LvY+XDTJBHCxH5osdmK6CbMtQes1WoLj16cwB9QtXGXUtzRR6THeJ/M1Vi71FWWoTYlEQTgrcBU7cibJ0fOBLnYmGXM2Sb/4rpkcsoB9S3Mbdq8teXUMcRjOfpW2fFIlKOBpPALWsb+vFzXEs0ZpxxXQA4k/OzkVRcpM2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087870; c=relaxed/simple;
	bh=dktNbJSE4AMUUSXBqDMDbOSzD2AIdHi/2em6bOnXPak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLV/IfllqhI59XOI03WIRTqk6zmH6Y7+OG7ijEGJR3XJC1c2FljtiTf5xZwcOt3fXD1lSI/vOBTr//UHG32zo7czk1eAI0HPGL9r7iP9fpUHoz3TJ1VcWOmedphCZHTgqAAv/7jAhDB6j7yxKOaNClkXS27qWGMG75RTx0V7QNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LNtqNNSK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LNtqNNSK"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e030624d1so259459a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712087866; x=1712692666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZSMPyJcLDwQQyPD929o3b508jAKY9ueBln0f3F7O4Q=;
        b=LNtqNNSK2bxx5ZBmRwBbbisytbYWfxwNUm4pCONxSDiyQA4x40LNM9pwUOlV9l6SBd
         dq3annfM35j9CkSniihaifFKA/I9XrLJv1LyYi9GqAKPmLaNy4iSI/Xcr8gfRZo5AXsE
         30yfgTyqewyZ1yQ9OivJubpMkTgvXkjWl0ff8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712087866; x=1712692666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZSMPyJcLDwQQyPD929o3b508jAKY9ueBln0f3F7O4Q=;
        b=Uleves3ClcdrX27gXCWF7fa+RXW8yL62rttafo8nQJ07BjTx8RL9kQjPeLdSk3EH3y
         uMYLV72MaU6EMo6pBnxlZBRDcBz237AUAunRZtIT6xtm4rwAP3B1XtZbnEdNf58B22Dd
         8Pes8Oz94DMbLnRfLaQu7wDo4n6Nj6Nsh0PP0K5+mkvHjMMbwL0gX3l3uv/4lRmrJSvo
         9UBH9LTPW26PmodrW0fue/oL+LEY1pgNlqTFAEz4ruqSQ4XXAWd5Qz9Mfk6lQpgXHiPj
         9JOmBL5TBKq1ccMDCWgOpU7qWmA+2yZCKiFbUvOcorAVi2Sxtg8FHJTKlp0+5EMI1WjP
         mNvw==
X-Forwarded-Encrypted: i=1; AJvYcCXAzR6j/YmTeRc7gPNS/dHpoGYsErpGfdvXDUHjKQil71DN8ks+apkP7oHe7rJHg758ClGFXmf7Efg+dN6HgBpQvd6oADJiomPSfr6KbCphflHGu7EA
X-Gm-Message-State: AOJu0YxmMdFitynWaHDWlWjEkbCJMIPFXLZTbn4Bvn80POa63sFMjv/h
	6nqX8Xxmf5HY9ojWFY2rl/a41Gd+tI2LCQBc3NnJi6NlmlFhnQkBk2b3LFOMD38xK3X3aJjgq1Q
	Y/aY=
X-Google-Smtp-Source: AGHT+IGIZHWxNrrnR810INuC/bWIsP5/iggZGN92AwsykjXGHUzNTtxH7/ORIaJTj99AXZfRjNqH0g==
X-Received: by 2002:a50:955b:0:b0:56d:fdb3:bcc0 with SMTP id v27-20020a50955b000000b0056dfdb3bcc0mr404170eda.11.1712087866517;
        Tue, 02 Apr 2024 12:57:46 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id g28-20020a056402321c00b0056c1c2b851esm7130822eda.0.2024.04.02.12.57.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:57:45 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso660221666b.2
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 12:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVacj71+UjtTv79ZBPFReX+aboeyVBNY1Bqqy4JBZPcvYeAyMhy/iS9w+qbCChBEP+xmLj11HwtumfZ7Uess8F3be21r6dubBiIfp0p3FYjDZrF7Vhp
X-Received: by 2002:a17:906:5794:b0:a4e:7b8e:35ae with SMTP id
 k20-20020a170906579400b00a4e7b8e35aemr3749307ejq.38.1712087865212; Tue, 02
 Apr 2024 12:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com> <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
In-Reply-To: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:57:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Message-ID: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 12:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>

>    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>    {
>   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>   +     struct inode *inode = d_backing_inode(dentry);
>   +     if (unlikely(!inode || IS_PRIVATE(inode)))
>                 return;
>         call_void_hook(path_post_mknod, idmap, dentry);

Hmm. We do have other hooks that get called for this case.

For fsnotify_create() we actually have a comment about this:

 * fsnotify_create - 'name' was linked in
 *
 * Caller must make sure that dentry->d_name is stable.
 * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
 * ->d_inode later

and audit_inode_child() ends up having a

        if (inode)
                handle_one(inode);

in it.

So in other cases we do handle the NULL, but it does seem like the
other cases actually do validaly want to deal with this (ie the
fsnotify case will say "the directory that mknod was done in was
changed" even if it doesn't know what the change is.

But for the security case, it really doesn't seem to make much sense
to check a mknod() that you don't know the result of.

I do wonder if that "!inode" test might also be more specific with
"d_unhashed(dentry)". But that would only make sense if we moved this
test from security_path_post_mknod() into the caller itself, ie we
could possibly do something like this instead (or in addition to):

  -     if (error)
  -             goto out2;
  -     security_path_post_mknod(idmap, dentry);
  +     if (!error && !d_unhashed(dentry))
  +             security_path_post_mknod(idmap, dentry);

which might also be sensible.

Al? Anybody?

                Linus
