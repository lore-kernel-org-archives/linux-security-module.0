Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C515B971
	for <linux-security-module@vger.kernel.org>; Tue,  2 Apr 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086788; cv=none; b=ljYjzujIQqhlVDKocK7mqOq1zGUv0kS5PafNTn1NMHb+iicDszQ7tTa0qbwhX05YGZOQb/IAXGtAnyIh0SpqWA3YIBgHI0lHNsP2QC7Qv88+xxMlyRLOFzMVSrVT6hKi+GQ/lUEqlivz48xTBBg0HDVFrwUyIf8Pd3Fnl3T1yzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086788; c=relaxed/simple;
	bh=FUitx7MgiMoEaaLuPTTMRh2BBePYzO9uMUChIAgHet4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSI/kl8w9FsQyS4sOYVzpJlJkRrVXrzVRe6IBSKjlBKr0dQXt6zow5XMC5oRzBzJw1M3Qh61Z++52q4p1AWJzRQnFE3YBlQJtvaXgY8vMLbJ2fREl+bB0L2sPdsZKMZKMxyAZYupa+/n+CscOFGFiwiEDaFG5bIUG1B7aVMN6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P7FTA2jL; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P7FTA2jL"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513e89d0816so6573078e87.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712086785; x=1712691585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=P7FTA2jLoXfsCEtkxUDirRllSwd19LRpNYr/iGBO5t318EPrbrZ39u1tsh47t8Ulo2
         jLLSfOpozJBe/dazhfqMaB1G8OpvLowTauwQQ2YFZKFfUiPvepG3XlWsqEcWAfzsx8nu
         FSOKiZGXPGjOb0JnVv0dIIWsYk5w+O1Y38Uic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086785; x=1712691585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=r+bdU8rNjjBdquzn/LO89QdLvvyLmPl0vGhKRH1r5sGufJCEXcy0eeGHt3MvzXp9kj
         YNJQHM+QuT1xEMQcSfGN91Nhph2owx1QimIF05vZXPgO/RmuAGTxIHWjdnePPfS0dh1y
         y7Y8E/38IeFRLOQpclc58fJ9I7Bgyg4cx1bJRFGXVcq9gDSXe9hp07oecEYtmrJ4ab3k
         ipXyah0qtifv/qGUwvrbEN92iXctXXLt5nvLAYzQl0kwK0l6mHGSlVXXm2GTNKZX6GFY
         Cly4gRKMf8/pE/DaRbPd/vkgpV6OS0dbuUOYjPxa+nGTk49wa7XCF8nYJ2tzK+2/BnXF
         6IlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0//lKSSV+NENuWnX3FE+lq4zOG2PNhTBkZFYvik3M+9TqHmiktdFNYZy861jg9BVObJYdjEElXNEvz3y4bnpS9TLA+IN9l69XqXpcoLIeOT/RrBTZ
X-Gm-Message-State: AOJu0YwoD7LggIB8WR0Rv8eyAkGmfFMBkxRpwJI4++/jBNviSNOALGZL
	MlGRQAlB1q2/tQptmBb5BIrhXk0OYK9rn/h25WrdRun6yb8ZKidfiqFfcoyb0A2MwFjhaTunBj9
	DCKc=
X-Google-Smtp-Source: AGHT+IFYeKC5WCvvmdZk07WZXqMiz1XLdmWpfASXVjcmDA/wiO3vFTF9hUb4xnK95SMaDOT2RxK6uA==
X-Received: by 2002:a19:2d08:0:b0:515:9aba:7430 with SMTP id k8-20020a192d08000000b005159aba7430mr8610766lfj.13.1712086784506;
        Tue, 02 Apr 2024 12:39:44 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b00a4673706b4dsm6887889ejs.78.2024.04.02.12.39.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4249616a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTu+p+y2c/kEdKz9creWS6dlohgk/nz16Vkw59rzLBLuXI/CUfDeIlsXZ7VtpUcTbh4yNLlJZvnk020HVaTd6uEAo/ElSmxFDiPnJBstWGTcWsRVgq
X-Received: by 2002:a17:906:2698:b0:a47:4d61:de44 with SMTP id
 t24-20020a170906269800b00a474d61de44mr8673776ejc.55.1712086783205; Tue, 02
 Apr 2024 12:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:39:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 07:12, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> A single bug fix to address a kernel panic in the newly introduced function
> security_path_post_mknod.

So I've pulled from you before, but I still don't have a signature
chain for your key (not that I can even find the key itself, much less
a signature chain).

Last time I pulled, it was after having everybody else just verify the
actual commit.

This time, the commit looks like a valid "avoid NULL", but I have to
say that I also think the security layer code in question is ENTIRELY
WRONG.

IOW, as far as I can tell, the mknod() system call may indeed leave
the dentry unhashed, and rely on anybody who then wants to use the new
special file to just do a "lookup()" to actually use it.

HOWEVER.

That also means that the whole notion of "post_path_mknod() is
complete and utter hoghwash. There is not anything that the security
layer can possibly validly do.

End result: instead of checking the 'inode' for NULL, I think the
right fix is to remove that meaningless security hook. It cannot do
anything sane, since one option is always 'the inode hasn't been
initialized yet".

Put another way: any security hook that checks inode in
security_path_post_mknod() seems simply buggy.

But if we really want to do this ("if mknod creates a positive dentry,
I won't see it in lookup, so I want to appraise it now"), then we
should just deal with this in the generic layer with some hack like
this:

  --- a/security/security.c
  +++ b/security/security.c
  @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
    */
   void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
   {
  -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
  +     struct inode *inode = d_backing_inode(dentry);
  +     if (unlikely(!inode || IS_PRIVATE(inode)))
                return;
        call_void_hook(path_post_mknod, idmap, dentry);
   }

and IMA and EVM would have to do any validation at lookup() time for
the cases where the dentry wasn't hashed by ->mknod.

Anyway, all of this is to say that I don't feel like I can pull this without
 (a) more acks by people
and
 (b) explanations for why the simpler fix to just
security_path_post_mknod() isn't the right fix.

                 Linus
